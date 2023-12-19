# -*- coding: utf-8 -*-

import logging
import base64
import json
from datetime import datetime
from odoo import http

_logger = logging.getLogger(__name__)

class TtnImport(http.Controller):
    @http.route('/ttn/uplink', auth="public", website=True, type="json", methods=["POST"], csrf=False)
    def index(self, **kw):
        input = http.request.httprequest.get_data()
        _logger.debug(input)
        try:
            data = json.loads(input)

            # the date has too many decimals for fromisoformat to grok
            date_str = data['received_at']
            split_date = date_str.split(".")
            trimmed_date = split_date[0] + "." + split_date[1][:6] + '+00:00'
            recvAt = datetime.fromisoformat(trimmed_date)
            recvAt = recvAt.replace(tzinfo=None)

            decoded = data["uplink_message"]["decoded_payload"]

            # Fix up Steve's sensors, which do not send version_ids yet.
            if "version_ids" not in data["uplink_message"] and "ADC_CH0V" in decoded:
                data["uplink_message"]["version_ids"] = {
                    "brand_id": "dragino",
                    "model_id": "LSN50",
                }

            selectors = http.request.env["ttn.measurement.config"].sudo().search([
                ('brand', '=', data["uplink_message"]["version_ids"]["brand_id"]),
                ('model', '=', data["uplink_message"]["version_ids"]["model_id"]),
                ('enabled', '=', True)
            ])
            matched = False
            for s in selectors:
                res = s.extract(
                    data["end_device_ids"]["device_id"],
                    recvAt,
                    decoded,
                )
                if res:
                    matched = res

            if not matched:
                x = {
                    'device': data["end_device_ids"]["device_id"],
                    'application': data["end_device_ids"]["application_ids"]["application_id"],
                    'received_at': recvAt,
                    'received_by': data["uplink_message"]["rx_metadata"][0]["gateway_ids"]["gateway_id"],
                    'rssi': data["uplink_message"]["rx_metadata"][0]["rssi"],
                    'f_port': int(data["uplink_message"]["f_port"]),
                    'f_cnt': int(data["uplink_message"]["f_cnt"]),
                    'payload': data["uplink_message"]["frm_payload"],
                    'decoded': json.dumps(data["uplink_message"]["decoded_payload"]),
                    'brand': data["uplink_message"]["version_ids"]["brand_id"],
                    'model': data["uplink_message"]["version_ids"]["model_id"]
                }
                http.request.env["ttn.unmatched"].sudo().create(x)
        except json.JSONDecodeError:
            _logger.error("bad json")
            return "bad json\n"
        except KeyError as e:
            out = f"missing key {e}\n"
            _logger.error(out)
            return out
        return "ok\n"


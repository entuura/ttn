# -*- coding: utf-8 -*-

import logging
import base64
import json
from datetime import datetime
import traceback
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
            if "version_ids" not in data["uplink_message"]:
                if all([k in decoded for k in ["ADC_CH0V", "BatV", "Digital_IStatus", "Door_status",
                                               "EXTI_Trigger", "Hum_SHT", "TempC1", "TempC_SHT", "Work_mode"]]):
                    data["uplink_message"]["version_ids"] = {
                        "brand_id": "dragino",
                        "model_id": "LSN50-S31",
                    }
                elif all([k in decoded for k in ["ALARM_status", "BatV", "Temp_Black", "Temp_Red",
                                                 "Temp_White", "Work_mode"]]):
                    data["uplink_message"]["version_ids"] = {
                        "brand_id": "dragino",
                        "model_id": "LSN50-D22",
                    }
                elif all([k in decoded for k in ['batState', 'batV_V', 'intHum_pct', 'intTemp_C']]):
                    data["uplink_message"]["version_ids"] = {
                        "brand_id": "dragino",
                        "model_id": "LHT65S-E5",
                    }
                else:
                    raise NameError("could not fix missing version_ids")

            selectors = http.request.env["ttn.measurement.config"].sudo().search([
                ('brand', '=', data["uplink_message"]
                 ["version_ids"]["brand_id"]),
                ('model', '=', data["uplink_message"]
                 ["version_ids"]["model_id"]),
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
                    'received_by': ", ".join([rx["gateway_ids"]["gateway_id"] for rx in data["uplink_message"]["rx_metadata"]]),
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

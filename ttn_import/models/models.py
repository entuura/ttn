# -*- coding: utf-8 -*-

from odoo import models, fields
import logging, json

_logger = logging.getLogger(__name__)

class ThingsUnmatched(models.Model):
    _name = 'ttn.unmatched'
    _description = 'Incoming data from TTN'
    _order = "received_at DESC"

    device = fields.Char('Device Name', readonly=True)
    application = fields.Char('Application Name', readonly=True)
    received_at = fields.Datetime('Received at', readonly=True)
    received_by = fields.Char('Received by GW', readonly=True)
    rssi = fields.Integer('Received signal strength', readonly=True)
    f_port = fields.Integer('Frame port', readonly=True)
    f_cnt = fields.Integer('Frame counter', readonly=True)
    payload = fields.Binary('Payload, raw bytes', readonly=True)
    decoded = fields.Text('Payload decoded, JSON', readonly=True)
    brand = fields.Char('Brand of the sensor', readonly=True)
    model = fields.Char('Model of the sensor', readonly=True)

    # this is called from the Actions menu of the unmatched list view
    # to let people test/debug their selectors.
    def tryExtract(self):
        selectors = self.env["ttn.measurement.config"].search([
                ('brand', '=', self.brand),
                ('model', '=', self.model),
                ('enabled', '=', True)
            ])
        for s in selectors:
            s.extract(
                self.device,
                self.received_at,
                json.loads(self.decoded),
            )

class ThingMeasureConfig(models.Model):
    _name = 'ttn.measurement.config'
    _description = 'Specify which measurement to extract for a given brand/model pair.'

    enabled = fields.Boolean('Enabled?', required=True, default=True)
    brand = fields.Char('Brand of the sensor', required=True)
    model = fields.Char('Model of the sensor', required=True)
    f_port = fields.Integer('The port to match', required=True)
    key = fields.Char('The key to extract from the payload.', required=True)
    what = fields.Char('The name of the measurement.', required=True)

    # extract is called by the webhook, for each matching selector
    # It must find the data and pass it the the target model/method. For
    # now that's hardcoded to "add a row to ttn.measurement".
    # extract returns true if it recorded the data.
    def extract(self, device_name, when, decoded):
        if self.key in decoded:
            try:
                howmuch = float(decoded[self.key])
                x = {
                    "who": device_name,
                    "what": self.what,
                    "when": when,
                    "howmuch": howmuch,
                }
                self.env["ttn.measurement"].sudo().create(x)
                return True
            except ValueError:
                _logger.info(f"For selector {self.what}, could not convert {decoded[self.key]} to float.")
        else:
            _logger.info(f"For selector {self.what}, key {self.key} not found.")
        return False
            
class ThingMeasurement(models.Model):
    _name = 'ttn.measurement'
    _description = 'The measurements sent in by sensors and extracted by selectors.'
    _log_access = False

    who = fields.Char('Device Name', readonly=True)
    what = fields.Char('Quantity', readonly=True)
    when = fields.Datetime('Received at', readonly=True)
    howmuch = fields.Float('Measurement', group_operator='avg', readonly=True)
# -*- coding: utf-8 -*-
{
    'name': "TTN Import",

    'summary': """
        A module for archiving and extracting data from The Things Network (TTN).""",

    'description': """
        This module exposes a webhook, which can import data from The Things Network.
        It then matches the incoming data point against a configurable list of
        selectors. For each match, it extracts the corresponding piece of data, calling
        a configurable action on it. It provides an example graphing action.
    """,

    'author': "Jeff R. Allen <jra@entuura.org>",
    'website': "https://www.entuura.com",

    # Categories can be used to filter modules in modules listing
    # Check https://github.com/odoo/odoo/blob/14.0/odoo/addons/base/data/ir_module_category_data.xml
    # for the full list
    'category': 'Productivity',
    'version': '0.1',

    # any module necessary for this one to work correctly
    'depends': ['base', 'mail'],

    # always loaded
    'data': [
        'security/ir.model.access.csv',
        'views/views.xml',
        'views/templates.xml',
    ],
    # only loaded in demonstration mode
    'demo': [
        'demo/demo.xml',
    ],
}

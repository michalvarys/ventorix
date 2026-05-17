{
    'name': 'Ventorix RFQ to CRM',
    'version': '18.0.1.0.0',
    'category': 'Website',
    'summary': 'Creates CRM leads from website RFQ form submissions',
    'depends': ['website', 'crm', 'mail'],
    'data': [
        'data/crm_data.xml',
    ],
    'installable': True,
    'auto_install': False,
    'license': 'LGPL-3',
}

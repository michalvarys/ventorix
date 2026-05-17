{
    'name': 'Ventorix Website Settings',
    'description': 'Activates Czech language and configures bilingual website for Ventorix.',
    'category': 'Website',
    'version': '18.0.1.0.0',
    'author': 'Ventorix Global Trade',
    'license': 'LGPL-3',
    'depends': ['website', 'theme_ventorix'],
    'data': [
        'data/website_config_data.xml',
    ],
    'post_init_hook': '_post_init_hook',
    'application': False,
    'auto_install': False,
    'installable': True,
}

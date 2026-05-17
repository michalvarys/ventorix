from odoo import models


class ThemeVentorix(models.AbstractModel):
    _inherit = 'theme.utils'

    def _theme_ventorix_post_copy(self, mod):
        self.disable_view('website.template_header_default')
        self.disable_view('website.footer_custom')
        self.enable_view('theme_ventorix.vx_header')
        self.enable_view('theme_ventorix.vx_footer')

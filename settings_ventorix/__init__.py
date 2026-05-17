def _post_init_hook(env):
    env.cr.execute("""
        UPDATE theme_ir_ui_view SET active = true
        WHERE key IN ('theme_ventorix.vx_header', 'theme_ventorix.vx_footer')
          AND active = false
    """)
    env.cr.execute("""
        UPDATE ir_ui_view SET active = true
        WHERE key IN ('theme_ventorix.vx_header', 'theme_ventorix.vx_footer')
          AND website_id IS NOT NULL
          AND active = false
    """)
    env.cr.execute("""
        UPDATE website_page SET is_published = true
        WHERE url = '/'
          AND website_id IS NOT NULL
          AND is_published = false
    """)

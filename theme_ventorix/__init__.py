from . import models


def _post_init_hook(env):
    from .models.theme_ventorix import _apply_thankyou_and_translations
    _apply_thankyou_and_translations(env)

import json
import logging

from odoo import models

_logger = logging.getLogger(__name__)

THANKYOU_EN = '''<t name="Thanks (Contact us)" t-name="website.contactus_thanks">
    <t t-call="website.layout">
        <div id="wrap" class="oe_structure">
            <section class="o_cc o_cc5 position-relative overflow-hidden" style="background-color: #0A1628;">
                <div class="position-absolute w-100 h-100" style="top: 0; left: 0; background-image: url(/theme_ventorix/static/src/img/warehouse.jpg); background-size: cover; background-position: center; opacity: 0.08;"/>
                <div class="position-absolute" style="bottom: 0; left: 0; right: 0; height: 1px; background: linear-gradient(90deg, transparent, #2E86DE, transparent); opacity: 0.3;"/>
                <div class="container position-relative text-center" style="z-index: 2; padding: 5rem 1rem 4rem;">
                    <div class="mx-auto mb-4 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px; border-radius: 50%; background: linear-gradient(135deg, #2E86DE, #00D4FF); box-shadow: 0 0 30px rgba(46,134,222,0.3);">
                        <i class="fa fa-check fa-2x" style="color: #fff;"/>
                    </div>
                    <h1 style="font-family: Montserrat, sans-serif; font-weight: 900; color: #fff; font-size: 2.75rem; text-transform: uppercase; letter-spacing: 0.02em; margin-bottom: 1rem;">Thank You</h1>
                    <p style="color: rgba(255,255,255,0.6); font-size: 1.1rem; max-width: 500px; margin: 0 auto 2rem; line-height: 1.8;">Your request for quotation has been received. Our team will review your specifications and respond within <strong style="color: #2E86DE;">48 hours</strong>.</p>
                    <div class="row g-4 justify-content-center mt-3" style="max-width: 800px; margin-left: auto; margin-right: auto;">
                        <div class="col-md-4"><div style="border: 1px solid rgba(46,134,222,0.2); border-radius: 4px; padding: 1.5rem 1rem; background: rgba(46,134,222,0.05);"><div class="mb-2" style="color: #2E86DE; font-size: 1.5rem; font-weight: 900;">01</div><h6 style="color: #fff; font-weight: 700; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px;">Review</h6><p style="color: rgba(255,255,255,0.45); font-size: 0.8rem; margin: 0; line-height: 1.6;">We analyze your technical requirements and specifications.</p></div></div>
                        <div class="col-md-4"><div style="border: 1px solid rgba(46,134,222,0.2); border-radius: 4px; padding: 1.5rem 1rem; background: rgba(46,134,222,0.05);"><div class="mb-2" style="color: #2E86DE; font-size: 1.5rem; font-weight: 900;">02</div><h6 style="color: #fff; font-weight: 700; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px;">Quotation</h6><p style="color: rgba(255,255,255,0.45); font-size: 0.8rem; margin: 0; line-height: 1.6;">Competitive pricing with delivery timeline and certifications.</p></div></div>
                        <div class="col-md-4"><div style="border: 1px solid rgba(46,134,222,0.2); border-radius: 4px; padding: 1.5rem 1rem; background: rgba(46,134,222,0.05);"><div class="mb-2" style="color: #2E86DE; font-size: 1.5rem; font-weight: 900;">03</div><h6 style="color: #fff; font-weight: 700; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px;">Confirmation</h6><p style="color: rgba(255,255,255,0.45); font-size: 0.8rem; margin: 0; line-height: 1.6;">Order confirmation with production schedule and QC plan.</p></div></div>
                    </div>
                    <div class="mt-5"><a href="/" class="btn px-5 py-3" style="background: linear-gradient(135deg, #2E86DE, #00D4FF); color: #fff; font-weight: 700; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px; border: none; border-radius: 2px;"><i class="fa fa-arrow-left me-2"/>Back to Homepage</a></div>
                </div>
            </section>
        </div>
    </t>
</t>'''

THANKYOU_CS = THANKYOU_EN.replace(
    'Thank You', 'Děkujeme'
).replace(
    'Your request for quotation has been received. Our team will review your specifications and respond within',
    'Vaše poptávka byla přijata. Náš tým posoudí vaše specifikace a odpoví do'
).replace(
    '48 hours', '48 hodin'
).replace(
    'Review', 'Posouzení'
).replace(
    'We analyze your technical requirements and specifications.',
    'Analyzujeme vaše technické požadavky a specifikace.'
).replace(
    'Quotation', 'Nabídka'
).replace(
    'Competitive pricing with delivery timeline and certifications.',
    'Konkurenční ceny s termínem dodání a certifikacemi.'
).replace(
    'Confirmation', 'Potvrzení'
).replace(
    'Order confirmation with production schedule and QC plan.',
    'Potvrzení objednávky s harmonogramem výroby a plánem kontroly kvality.'
).replace(
    'Back to Homepage', 'Zpět na hlavní stránku'
)

TRANSLATIONS = [
    ('Industrial Piping', 'Průmyslové potrubí'),
    ('Materials Supplier', 'Dodavatel materiálů'),
    ('Direct sourcing from certified manufacturers', 'Přímý nákup od certifikovaných výrobců'),
    ('European quality standards', 'Evropské standardy kvality'),
    ('on-site oversight in China', 'osobní dohled v Číně'),
    ('Request Quote', 'Žádost o nabídku'),
    ('Explore Products', 'Prohlédnout produkty'),
    ('Our Products', 'Naše produkty'),
    ('Product Categories', 'Kategorie produktů'),
    ('Flanges', 'Příruby'),
    ('Pipes &amp; Tubes', 'Trubky &amp; profily'),
    ('Fittings', 'Tvarovky'),
    ('Valves', 'Ventily'),
    ('Industrial Materials', 'Průmyslové materiály'),
    ('Weld neck, slip-on, blind, socket weld', 'Přivařovací, nástrčné, zaslepovací'),
    ('Seamless and welded pipes', 'Bezešvé a svařované trubky'),
    ('Elbows, tees, reducers, couplings', 'Kolena, T-kusy, redukce, spojky'),
    ('Gate, globe, check, ball valves', 'Šoupátkové, kulové, zpětné ventily'),
    ('Gaskets, bolts, studs, special alloys', 'Těsnění, šrouby, svorníky, speciální slitiny'),
    ('View Details', 'Zobrazit detail'),
    ('About Ventorix', 'O společnosti Ventorix'),
    ('Who We Are', 'Kdo jsme'),
    ('About Us', 'O nás'),
    ('years of experience', 'let zkušeností'),
    ('Your Trusted Partner', 'Váš spolehlivý partner'),
    ('in Industrial Piping', 'v průmyslovém potrubí'),
    ('Quality Assurance', 'Zajištění kvality'),
    ('How We Work', 'Jak pracujeme'),
    ('Our Process', 'Náš proces'),
    ('Specification', 'Specifikace'),
    ('Share your technical requirements', 'Sdílejte vaše technické požadavky'),
    ('Sourcing', 'Zajištění'),
    ('We source from certified manufacturers', 'Zajistíme materiál od certifikovaných výrobců'),
    ('Quality Control', 'Kontrola kvality'),
    ('On-site inspection and testing', 'Inspekce a testování na místě'),
    ('Delivery', 'Dodání'),
    ('Logistics and documentation', 'Logistika a dokumentace'),
    ('China Manufacturing', 'Výroba v Číně'),
    ('Partner Network', 'Partnerská síť'),
    ('On-Site Oversight', 'Osobní dohled na místě'),
    ('Certifications', 'Certifikace'),
    ('Quality Standards', 'Standardy kvality'),
    ('International Standards', 'Mezinárodní standardy'),
    ('Get a Quote', 'Získejte nabídku'),
    ('Ready to Order?', 'Připraveni objednat?'),
    ('Contact us with your specifications', 'Kontaktujte nás s vašimi specifikacemi'),
    ('competitive pricing within 48 hours', 'konkurenční ceny do 48 hodin'),
    ('Contact', 'Kontakt'),
    ('Request a Quote', 'Žádost o nabídku'),
    ('Your Name', 'Vaše jméno'),
    ('Company', 'Společnost'),
    ('Phone', 'Telefon'),
    ('E-mail', 'E-mail'),
    ('Subject', 'Předmět'),
    ('Product Type', 'Typ produktu'),
    ('Select product type', 'Vyberte typ produktu'),
    ('Material Grade', 'Materiál'),
    ('Standard', 'Norma'),
    ('Size', 'Rozměr'),
    ('Pressure Class', 'Tlaková třída'),
    ('Quantity', 'Množství'),
    ('Delivery Country', 'Země dodání'),
    ('Delivery Date', 'Datum dodání'),
    ('Technical Requirements', 'Technické požadavky'),
    ('Describe your requirements', 'Popište vaše požadavky'),
    ('Attach File', 'Přiložit soubor'),
    ('Submit Request', 'Odeslat poptávku'),
    ('Navigation', 'Navigace'),
    ('Home', 'Úvod'),
    ('Products', 'Produkty'),
    ('Headquarters', 'Sídlo'),
    ('Czech Republic, EU', 'Česká republika, EU'),
    ('Privacy Policy', 'Ochrana soukromí'),
    ('Terms of Service', 'Obchodní podmínky'),
    ('All rights reserved.', 'Všechna práva vyhrazena.'),
    ('Your trusted partner for industrial piping materials.', 'Váš spolehlivý partner pro průmyslové potrubní materiály.'),
    ('Direct sourcing from certified manufacturers with', 'Přímý nákup od certifikovaných výrobců s'),
    ('European quality standards and on-site oversight.', 'evropskými standardy kvality a osobním dohledem.'),
    ('Catalog', 'Katalog'),
    ('Full range of industrial piping materials, certified to international standards.', 'Kompletní sortiment průmyslových potrubních materiálů certifikovaných dle mezinárodních standardů.'),
    ('Our Commitment', 'Náš závazek'),
    ('Quality is Our Priority', 'Kvalita je naší prioritou'),
]


class ThemeVentorix(models.AbstractModel):
    _inherit = 'theme.utils'

    def _theme_ventorix_post_copy(self, mod):
        self.disable_view('website.template_header_default')
        self.disable_view('website.footer_custom')
        self.enable_view('theme_ventorix.vx_header')
        self.enable_view('theme_ventorix.vx_footer')
        self._update_contactus_thanks()
        self._apply_cs_translations()

    def _update_contactus_thanks(self):
        view = self.env['ir.ui.view'].search(
            [('key', '=', 'website.contactus_thanks')], limit=1,
        )
        if not view:
            return
        arch = view.arch_db
        if isinstance(arch, str):
            try:
                arch = json.loads(arch)
            except Exception:
                arch = {'en_US': arch}
        arch['en_US'] = THANKYOU_EN
        arch['cs_CZ'] = THANKYOU_CS
        self.env.cr.execute(
            "UPDATE ir_ui_view SET arch_db = %s::jsonb WHERE id = %s",
            [json.dumps(arch), view.id],
        )
        _logger.info("Updated contactus_thanks page with Ventorix design")

    def _apply_cs_translations(self):
        views = self.env['ir.ui.view'].search([
            ('key', 'like', 'theme_ventorix.%'),
            ('website_id', '!=', False),
        ])
        if not views:
            views = self.env['ir.ui.view'].search([
                ('key', 'like', 'theme_ventorix.%'),
            ])
        count = 0
        for view in views:
            arch = view.arch_db
            if isinstance(arch, str):
                try:
                    arch = json.loads(arch)
                except Exception:
                    continue
            cs = arch.get('cs_CZ', arch.get('en_US', ''))
            if not cs:
                continue
            changed = False
            for en, cs_val in TRANSLATIONS:
                if en in cs:
                    cs = cs.replace(en, cs_val)
                    changed = True
            if changed:
                arch['cs_CZ'] = cs
                self.env.cr.execute(
                    "UPDATE ir_ui_view SET arch_db = %s::jsonb WHERE id = %s",
                    [json.dumps(arch), view.id],
                )
                count += 1
        # Also translate theme_ir_ui_view master records
        self.env.cr.execute(
            "SELECT id, arch FROM theme_ir_ui_view WHERE key LIKE 'theme_ventorix.%%'"
        )
        for row in self.env.cr.fetchall():
            arch = row[1]
            if isinstance(arch, str):
                try:
                    arch = json.loads(arch)
                except Exception:
                    continue
            cs = arch.get('cs_CZ', arch.get('en_US', ''))
            if not cs:
                continue
            changed = False
            for en, cs_val in TRANSLATIONS:
                if en in cs:
                    cs = cs.replace(en, cs_val)
                    changed = True
            if changed:
                arch['cs_CZ'] = cs
                self.env.cr.execute(
                    "UPDATE theme_ir_ui_view SET arch = %s::jsonb WHERE id = %s",
                    [json.dumps(arch), row[0]],
                )
                count += 1
        _logger.info("Applied Czech translations to %d views", count)


def _apply_thankyou_and_translations(env):
    cr = env.cr
    # Update thank-you page
    cr.execute(
        "SELECT id, arch_db FROM ir_ui_view WHERE key = 'website.contactus_thanks' LIMIT 1"
    )
    row = cr.fetchone()
    if row:
        arch = row[1]
        if isinstance(arch, str):
            try:
                arch = json.loads(arch)
            except Exception:
                arch = {'en_US': arch}
        arch['en_US'] = THANKYOU_EN
        arch['cs_CZ'] = THANKYOU_CS
        cr.execute(
            "UPDATE ir_ui_view SET arch_db = %s::jsonb WHERE id = %s",
            [json.dumps(arch), row[0]],
        )
        _logger.info("Updated contactus_thanks page with Ventorix design")

    # Apply Czech translations to all theme views
    count = 0
    cr.execute(
        "SELECT id, arch_db FROM ir_ui_view WHERE key LIKE 'theme_ventorix.%%'"
    )
    for vid, arch in cr.fetchall():
        if isinstance(arch, str):
            try:
                arch = json.loads(arch)
            except Exception:
                continue
        cs = arch.get('cs_CZ', arch.get('en_US', ''))
        if not cs:
            continue
        changed = False
        for en, cs_val in TRANSLATIONS:
            if en in cs:
                cs = cs.replace(en, cs_val)
                changed = True
        if changed:
            arch['cs_CZ'] = cs
            cr.execute(
                "UPDATE ir_ui_view SET arch_db = %s::jsonb WHERE id = %s",
                [json.dumps(arch), vid],
            )
            count += 1
    # Also translate theme_ir_ui_view master records
    cr.execute(
        "SELECT id, arch FROM theme_ir_ui_view WHERE key LIKE 'theme_ventorix.%%'"
    )
    for tid, arch in cr.fetchall():
        if isinstance(arch, str):
            try:
                arch = json.loads(arch)
            except Exception:
                continue
        cs = arch.get('cs_CZ', arch.get('en_US', ''))
        if not cs:
            continue
        changed = False
        for en, cs_val in TRANSLATIONS:
            if en in cs:
                cs = cs.replace(en, cs_val)
                changed = True
        if changed:
            arch['cs_CZ'] = cs
            cr.execute(
                "UPDATE theme_ir_ui_view SET arch = %s::jsonb WHERE id = %s",
                [json.dumps(arch), tid],
            )
            count += 1
    _logger.info("post_init_hook: Applied Czech translations to %d views", count)

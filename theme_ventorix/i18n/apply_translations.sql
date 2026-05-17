-- =============================================================================
-- Ventorix Theme: Apply Czech translations to theme_ir_ui_view and ir_ui_view
-- =============================================================================
-- Problem: Odoo 18 PO file loading doesn't work for theme.ir.ui.view records.
--          The arch JSONB column has keys en_US and cs_CZ, but cs_CZ contains
--          the English text (identical to en_US). This script replaces English
--          text in cs_CZ with Czech translations from the PO file.
--
-- Usage:   docker compose exec -T db psql -U ventrix -d ventrix -f /path/to/apply_translations.sql
--
-- Generated: 2026-05-17
-- =============================================================================

BEGIN;

-- ═══════════════════════════════════════════════════════════════════════════════
-- PART 1: theme_ir_ui_view (theme master records)
-- ═══════════════════════════════════════════════════════════════════════════════

-- Helper: create a function that applies all replacements for a given text
-- This avoids deeply nested replace() calls in a single UPDATE statement
CREATE OR REPLACE FUNCTION _vx_translate_cs(src text) RETURNS text AS $$
DECLARE
    result text := src;
BEGIN
    -- ═══════════════════════════════════════════════════
    -- IMPORTANT: Longer strings FIRST to avoid partial matches
    -- ═══════════════════════════════════════════════════

    -- ── s_vx_hero ──────────────────────────────────────

    -- Hero title (multi-line with span)
    result := replace(result,
        'Premium Flanges,<br/>
                        Pipes &amp; Pipeline<br/>
                        <span class="vx_gradient_text">Components</span>',
        'Prémiové příruby,<br/>
                        trubky &amp; potrubní<br/>
                        <span class="vx_gradient_text">komponenty</span>');

    -- Hero accent label
    result := replace(result, '>
                            Global Industrial Partner
                        <', '>
                            Globální průmyslový partner
                        <');

    -- Hero subtitle
    result := replace(result,
        'Direct manufacturing oversight in China. DIN/ANSI certified materials.
                        European quality standards at competitive pricing.',
        'Přímý dohled nad výrobou v Číně. Materiály certifikované dle DIN/ANSI.
                        Evropské standardy kvality za konkurenční ceny.');

    -- Hero stats
    result := replace(result, '>Products<', '>Produkty<');
    result := replace(result, '>Countries<', '>Zemí<');
    result := replace(result, '>Support<', '>Podpora<');
    result := replace(result, '>Certified<', '>Certifikováno<');

    -- Hero CTA buttons
    result := replace(result, '>
                            Request Quote
                        <', '>
                            Žádost o nabídku
                        <');
    result := replace(result, '>
                            View Catalog
                        <', '>
                            Zobrazit katalog
                        <');

    -- ── s_vx_categories ────────────────────────────────

    -- Accent label
    result := replace(result, '>
                        Our Products
                    <', '>
                        Naše produkty
                    <');

    -- Heading
    result := replace(result, '>
                    What We Supply
                <', '>
                    Co dodáváme
                <');

    -- Category titles
    result := replace(result, '>Flanges<', '>Příruby<');
    result := replace(result, '>Pipes &amp; Tubes<', '>Trubky &amp; profily<');
    result := replace(result, '>Fittings<', '>Tvarovky<');
    result := replace(result, '>Valves<', '>Ventily<');
    result := replace(result, '>Pipeline Components<', '>Potrubní komponenty<');
    result := replace(result, '>Industrial Materials<', '>Průmyslové materiály<');

    -- Category descriptions
    result := replace(result,
        'Weld neck, slip-on, blind, socket weld, threaded and lap joint.
                            DIN, ANSI/ASME, JIS. PN10-PN400.',
        'Přivařovací, nástrčné, zaslepovací, hrdlové, závitové a překrývací.
                            DIN, ANSI/ASME, JIS. PN10-PN400.');

    result := replace(result,
        'Seamless and welded steel pipes. Carbon, stainless, alloy steel.
                            API 5L, ASTM A106, A53.',
        'Bezešvé a svařované ocelové trubky. Uhlíková, nerezová, legovaná ocel.
                            API 5L, ASTM A106, A53.');

    result := replace(result,
        'Elbows, tees, reducers, caps, couplings. Butt weld and socket weld.
                            ASME B16.9, B16.11.',
        'Kolena, T-kusy, redukce, zátky, spojky. Tupé a hrdlové sváry.
                            ASME B16.9, B16.11.');

    result := replace(result,
        'Gate, globe, check, ball and butterfly valves.
                            Class 150-2500. API 600, API 6D.',
        'Šoupátka, regulační, zpětné, kulové a motýlkové ventily.
                            Class 150-2500. API 600, API 6D.');

    result := replace(result,
        'Gaskets, bolts, studs, expansion joints, strainers.
                            Complete pipeline assembly solutions.',
        'Těsnění, šrouby, svorníky, kompenzátory, filtry.
                            Kompletní řešení pro montáž potrubí.');

    result := replace(result,
        'Steel plates, bars, profiles, sheets.
                            Carbon, stainless, duplex and special alloys.',
        'Ocelové plechy, tyče, profily.
                            Uhlíková, nerezová, duplexní a speciální slitiny.');

    -- Categories CTA buttons
    result := replace(result, '>
                    View Full Catalog
                <', '>
                    Zobrazit celý katalog
                <');

    -- ── s_vx_about ─────────────────────────────────────

    -- Accent label
    result := replace(result, '>
                            About Ventorix
                        <', '>
                            O společnosti Ventorix
                        <');

    -- Heading
    result := replace(result,
        'Reliable Industrial<br/>Supply Since Day One',
        'Spolehlivé průmyslové<br/>dodávky od prvního dne');

    -- Description paragraphs
    result := replace(result,
        'Ventorix Global Trade specializes in high-quality piping materials,
                        flanges, valves, and pipeline components for industrial projects worldwide.
                        We bridge top-tier Chinese manufacturers and European industry.',
        'Ventorix Global Trade se specializuje na vysoce kvalitní potrubní materiály,
                        příruby, ventily a potrubní komponenty pro průmyslové projekty po celém světě.
                        Propojujeme špičkové čínské výrobce s evropským průmyslem.');

    result := replace(result,
        'With a dedicated partner directly in China overseeing production, quality control,
                        packaging and shipment — we guarantee consistent quality and transparent process.',
        'S oddaným partnerem přímo v Číně, který dohlíží na výrobu, kontrolu kvality,
                        balení a expedici — garantujeme konzistentní kvalitu a transparentní proces.');

    -- About features (strong tags)
    result := replace(result, '>DIN/ANSI Standards<', '>Normy DIN/ANSI<');
    result := replace(result, '>Quality Control<', '>Kontrola kvality<');
    result := replace(result, '>Fast Delivery<', '>Rychlé dodání<');
    result := replace(result, '>Competitive Pricing<', '>Konkurenční ceny<');

    -- About feature descriptions
    result := replace(result, '>Full compliance<', '>Plný soulad<');
    result := replace(result, '>On-site in China<', '>Přímo v Číně<');
    result := replace(result, '>Direct logistics<', '>Přímá logistika<');
    result := replace(result, '>Factory-direct<', '>Přímo z výroby<');

    -- Experience badge
    result := replace(result, '>
                                Quality Verified
                            <', '>
                                Ověřená kvalita
                            <');

    -- alt text
    result := replace(result, 'alt="Manufacturing facility"', 'alt="Výrobní závod"');

    -- ── s_vx_process ───────────────────────────────────

    -- Accent label
    result := replace(result, '>
                        How It Works
                    <', '>
                        Jak to funguje
                    <');

    -- Heading
    result := replace(result, '>
                    Cooperation Process
                <', '>
                    Proces spolupráce
                <');

    -- Subtitle
    result := replace(result,
        'From initial inquiry to delivery — transparent, efficient, reliable.',
        'Od prvního dotazu po dodání — transparentní, efektivní, spolehlivý.');

    -- Step titles
    result := replace(result, '>
                            Send Inquiry
                        <', '>
                            Odeslat poptávku
                        <');
    result := replace(result, '>
                            Get Quote
                        <', '>
                            Získat nabídku
                        <');
    result := replace(result, '>
                            Confirm Order
                        <', '>
                            Potvrdit objednávku
                        <');
    result := replace(result, '>
                            Production &amp; QC
                        <', '>
                            Výroba &amp; kontrola kvality
                        <');
    result := replace(result, '>
                            Delivery
                        <', '>
                            Dodání
                        <');

    -- Step descriptions
    result := replace(result,
        'Submit requirements via form, email, or upload PDF/XLS specs.',
        'Zadejte požadavky přes formulář, e-mail nebo nahrajte specifikace v PDF/XLS.');
    result := replace(result,
        'Detailed quotation within 2-3 business days with pricing and lead times.',
        'Podrobná nabídka do 2–3 pracovních dnů s cenami a dodacími lhůtami.');
    result := replace(result,
        'Approve the quote and confirm. We handle all documentation.',
        'Schvalte nabídku a potvrďte. Veškerou dokumentaci zajistíme.');
    result := replace(result,
        'Manufacturing with on-site quality inspection by our China partner.',
        'Výroba s kontrolou kvality přímo na místě naším partnerem v Číně.');
    result := replace(result,
        'Direct shipment to your warehouse. Full tracking included.',
        'Přímá zásilka do vašeho skladu. Včetně kompletního sledování.');

    -- ── s_vx_china_partner ─────────────────────────────

    -- Accent label
    result := replace(result, '>
                            Our Competitive Advantage
                        <', '>
                            Naše konkurenční výhoda
                        <');

    -- Heading
    result := replace(result,
        'Direct Partner<br/>
                        <span style="color: #2E86DE;">in China</span>',
        'Přímý partner<br/>
                        <span style="color: #2E86DE;">v Číně</span>');

    -- Description
    result := replace(result,
        'Unlike typical trading companies, we have a dedicated business partner
                        directly in China who owns and operates their own company.',
        'Na rozdíl od typických obchodních společností máme oddaného obchodního partnera
                        přímo v Číně, který vlastní a provozuje svou vlastní firmu.');

    -- Feature titles
    result := replace(result, '>Production Oversight<', '>Dohled nad výrobou<');
    result := replace(result, '>Quality Inspection<', '>Kontrola kvality<');
    result := replace(result, '>Packaging Control<', '>Kontrola balení<');
    result := replace(result, '>Shipment Coordination<', '>Koordinace přepravy<');

    -- Feature descriptions
    result := replace(result,
        'Physical presence at manufacturing facilities',
        'Fyzická přítomnost ve výrobních závodech');
    result := replace(result,
        'Rigorous quality checks before every shipment',
        'Přísné kontroly kvality před každou zásilkou');
    result := replace(result,
        'Supervised packing for international transport',
        'Kontrolované balení pro mezinárodní přepravu');
    result := replace(result,
        'Direct logistics for optimal delivery',
        'Přímá logistika pro optimální dodání');

    -- Stats
    result := replace(result, '>Quality Verified<', '>Ověřená kvalita<');
    result := replace(result, '>Factory Access<', '>Přístup do výroby<');
    result := replace(result, '>Turnaround<', '>Rychlost dodání<');
    result := replace(result, '>Direct<', '>Přímý<');
    result := replace(result, '>Fast<', '>Rychlý<');

    -- alt text
    result := replace(result, 'alt="Global shipping"', 'alt="Globální přeprava"');

    -- ── s_vx_certifications ────────────────────────────

    -- Accent label
    result := replace(result, '>
                        Quality Assurance
                    <', '>
                        Zajištění kvality
                    <');

    -- Heading
    result := replace(result, '>
                    Certifications &amp; Standards
                <', '>
                    Certifikace &amp; normy
                <');

    -- Subtitle
    result := replace(result,
        'All products comply with international standards and come with full documentation.',
        'Všechny produkty splňují mezinárodní normy a jsou dodávány s kompletní dokumentací.');

    -- Cert descriptions
    result := replace(result, '>Quality Management<', '>Řízení kvality<');
    result := replace(result, '>Material Certificates<', '>Materiálové certifikáty<');
    result := replace(result, '>EU Conformity<', '>Shoda s EU<');
    result := replace(result, '>Industrial Standards<', '>Průmyslové normy<');
    result := replace(result, '>Petroleum Institute<', '>Ropný institut<');
    result := replace(result, '>Material Testing<', '>Testování materiálů<');
    result := replace(result, '>Pressure Equipment<', '>Tlaková zařízení<');
    result := replace(result, '>Environmental<', '>Životní prostředí<');
    result := replace(result, '>CE Marking<', '>Značka CE<');

    -- ── s_vx_cta ───────────────────────────────────────

    -- Accent label
    result := replace(result, '>
                    Start Your Project
                <', '>
                    Zahajte svůj projekt
                <');

    -- Heading
    result := replace(result,
        'Need Industrial Piping<br/>Materials?',
        'Potřebujete průmyslové<br/>potrubní materiály?');

    -- Description
    result := replace(result,
        'Upload your specs, select your materials, and receive a competitive
                quotation within 48 hours. No commitment required.',
        'Nahrajte své specifikace, vyberte materiály a obdržíte konkurenční
                nabídku do 48 hodin. Bez závazků.');

    -- Trust indicators
    result := replace(result, '>MTC 3.1 Included<', '>Včetně MTC 3.1<');
    result := replace(result, '>50+ Countries<', '>50+ zemí<');

    -- CTA buttons
    result := replace(result, '>Get Quotation<', '>Získat nabídku<');
    result := replace(result, '>
                    View Catalog
                <', '>
                    Zobrazit katalog
                <');

    -- ── s_vx_contact ───────────────────────────────────

    -- Accent label
    result := replace(result, '>Request For Quotation<', '>Žádost o nabídku<');

    -- Heading
    result := replace(result, '>
                    Submit Your Inquiry
                <', '>
                    Odešlete svou poptávku
                <');

    -- Description
    result := replace(result,
        'Complete the form below with your technical requirements.
                    Our team will review your specifications and provide a detailed
                    quotation within 2-3 business days.',
        'Vyplňte formulář níže s vašimi technickými požadavky.
                    Náš tým posoudí vaše specifikace a poskytne podrobnou
                    nabídku do 2–3 pracovních dnů.');

    -- Section headers
    result := replace(result, '>Contact Information<', '>Kontaktní údaje<');
    result := replace(result, '>Product Specification<', '>Specifikace produktu<');
    result := replace(result, '>Quantity &amp; Delivery<', '>Množství &amp; dodání<');
    result := replace(result, '>Technical Details<', '>Technické detaily<');

    -- Form labels (within s_website_form_label_content spans)
    result := replace(result, '>Company Name<', '>Název společnosti<');
    result := replace(result, '>Contact Person<', '>Kontaktní osoba<');
    result := replace(result, '>Email<', '>E-mail<');
    result := replace(result, '>Phone<', '>Telefon<');
    result := replace(result, '>Subject / RFQ Title<', '>Předmět / Název poptávky<');
    result := replace(result, '>Product Type<', '>Typ produktu<');
    result := replace(result, '>Material Grade<', '>Jakost materiálu<');
    result := replace(result, '>Standard / Norm<', '>Standard / Norma<');
    result := replace(result, '>Size / Dimensions<', '>Rozměr / Dimenze<');
    result := replace(result, '>Pressure Class<', '>Tlaková třída<');
    result := replace(result, '>Quantity<', '>Množství<');
    result := replace(result, '>Delivery Country<', '>Země dodání<');
    result := replace(result, '>Desired Delivery<', '>Požadované dodání<');
    result := replace(result, '>Technical Requirements<', '>Technické požadavky<');
    result := replace(result, '>Attach Specification / Drawing<', '>Přiložit specifikaci / výkres<');
    result := replace(result, '>Email To<', '>E-mail příjemce<');

    -- Placeholders
    result := replace(result, 'placeholder="Your company name"', 'placeholder="Název vaší společnosti"');
    result := replace(result, 'placeholder="Full name"', 'placeholder="Celé jméno"');
    result := replace(result, 'placeholder="email@company.com"', 'placeholder="email@firma.cz"');
    result := replace(result, 'placeholder="e.g. Flanges DN100 PN16, Carbon Steel A105"', 'placeholder="např. příruby DN100 PN16, uhlíková ocel A105"');
    result := replace(result, 'placeholder="e.g. DN100 / 4&quot; NPS / 114.3mm"', 'placeholder="např. DN100 / 4&quot; NPS / 114.3mm"');
    result := replace(result, 'placeholder="e.g. 50 pcs / 200 meters"', 'placeholder="např. 50 ks / 200 metrů"');
    result := replace(result, 'placeholder="e.g. Germany, Czech Republic"', 'placeholder="např. Německo, Česká republika"');
    result := replace(result, 'placeholder="e.g. Q3 2026 / ASAP / 8 weeks"', 'placeholder="např. Q3 2026 / ASAP / 8 týdnů"');
    result := replace(result,
        'placeholder="Additional specifications, surface finish, coating, testing requirements (HIC/NACE/PMI), documentation needs (MTC 3.1/3.2), special packaging, etc."',
        'placeholder="Další specifikace, povrchová úprava, nátěr, požadavky na testování (HIC/NACE/PMI), požadavky na dokumentaci (MTC 3.1/3.2), speciální balení atd."');

    -- Select dropdowns — Product Type
    result := replace(result, '>Select product...<', '>Vyberte produkt...<');
    -- option display text (not value attributes!)
    result := replace(result, '">Flanges</option>', '">Příruby</option>');
    result := replace(result, '">Pipes &amp; Tubes</option>', '">Trubky &amp; profily</option>');
    result := replace(result, '">Fittings (Butt-weld)</option>', '">Tvarovky (na tupo)</option>');
    result := replace(result, '">Fittings (Socket-weld / Threaded)</option>', '">Tvarovky (hrdlové / závitové)</option>');
    result := replace(result, '">Valves</option>', '">Ventily</option>');
    result := replace(result, '">Gaskets</option>', '">Těsnění</option>');
    result := replace(result, '">Stud Bolts / Fasteners</option>', '">Svorníky / spojovací materiál</option>');
    result := replace(result, '">Pipeline Components</option>', '">Potrubní komponenty</option>');
    result := replace(result, '">Multiple / Other</option>', '">Více položek / Ostatní</option>');

    -- Select dropdowns — Material Grade
    result := replace(result, '>Select material...<', '>Vyberte materiál...<');
    result := replace(result, '">Carbon Steel (A105 / A234 WPB)</option>', '">Uhlíková ocel (A105 / A234 WPB)</option>');
    result := replace(result, '">Stainless Steel 304 / 304L</option>', '">Nerezová ocel 304 / 304L</option>');
    result := replace(result, '">Stainless Steel 316 / 316L</option>', '">Nerezová ocel 316 / 316L</option>');
    result := replace(result, '">Alloy Steel (A182 F11 / F22)</option>', '">Legovaná ocel (A182 F11 / F22)</option>');
    result := replace(result, '">Chrome-Moly (A335 P11 / P22)</option>', '">Chrome-Moly (A335 P11 / P22)</option>');
    result := replace(result, '">Other / Custom</option>', '">Ostatní / Na zakázku</option>');

    -- Select dropdowns — Standard
    result := replace(result, '>Select standard...<', '>Vyberte standard...<');

    -- Select dropdowns — Pressure Class
    result := replace(result, '>Select class...<', '>Vyberte třídu...<');

    -- "Other" option in dropdowns (careful: only match exact option text)
    result := replace(result, '">Other</option>', '">Ostatní</option>');

    -- Why Work With Us section
    result := replace(result, '>
                            Why Work With Us
                        <', '>
                            Proč spolupracovat s námi
                        <');
    result := replace(result, '>Response within 48 hours<', '>Odpověď do 48 hodin<');
    result := replace(result, '>EN, ISO, API, PED certified materials<', '>Materiály certifikované dle EN, ISO, API, PED<');
    result := replace(result, '>Direct sourcing from certified mills<', '>Přímý odběr z certifikovaných hutí<');
    result := replace(result, '>Full MTC 3.1 documentation<', '>Kompletní dokumentace MTC 3.1<');
    result := replace(result, '>Worldwide delivery with tracking<', '>Celosvětové dodání se sledováním<');
    result := replace(result, '>On-site quality oversight in China<', '>Dohled nad kvalitou přímo v Číně<');

    -- Direct Contact section
    result := replace(result, '>
                            Direct Contact
                        <', '>
                            Přímý kontakt
                        <');
    -- "Email" label in contact info (specific context with text-transform)
    result := replace(result, '>Email</span><br', '>E-mail</span><br');
    -- "Phone" label in contact info
    -- (Already handled by '>Phone<' above)
    -- "Headquarters" label
    result := replace(result, '>Headquarters<', '>Sídlo<');
    -- "Czech Republic, EU"
    result := replace(result, '>Czech Republic, EU<', '>Česká republika, EU<');

    -- Tip box
    result := replace(result,
        'You can also send inquiries directly to',
        'Poptávky můžete také zasílat přímo na');
    result := replace(result, 'with PDF/XLS specs attached.', 's přiloženými specifikacemi v PDF/XLS.');

    -- Upload hint
    result := replace(result,
        'PDF, XLS, DOC, DWG, DXF, JPG — max 10 MB',
        'PDF, XLS, DOC, DWG, DXF, JPG — max 10 MB');

    -- Submit button
    result := replace(result, '>Submit RFQ<', '>Odeslat poptávku<');

    -- ── s_vx_catalog ───────────────────────────────────

    -- Category labels
    result := replace(result, '>Category<', '>Kategorie<');

    -- Flanges section
    result := replace(result,
        'Complete range of industrial flanges for piping systems. All types manufactured to DIN, ANSI/ASME, JIS, BS, and GOST standards.',
        'Kompletní sortiment průmyslových přírub pro potrubní systémy. Všechny typy vyráběné dle norem DIN, ANSI/ASME, JIS, BS a GOST.');

    result := replace(result, '>Types<', '>Typy<');
    result := replace(result, '>Materials<', '>Materiály<');
    result := replace(result, '>Standards<', '>Normy<');
    result := replace(result, '>Pressure Ratings<', '>Tlakové třídy<');

    result := replace(result,
        'Slip-on, Weld-Neck, Threaded, Blind, Socket-Weld, Lap Joint, Orifice, Pressure Vessel Nozzles',
        'Nástrčné, přivařovací, závitové, zaslepovací, hrdlové, překrývací, měřicí, hrdla tlakových nádob');

    result := replace(result,
        'Carbon Steel (A105, A350 LF2) | Stainless Steel (F304, F316, F316Ti, F321) |
                                Alloy Steel (F11, F22, F91) | Duplex (F51, F53, F55) |
                                Nickel Alloys (Monel, Inconel, Hastelloy)',
        'Uhlíková ocel (A105, A350 LF2) | Nerezová ocel (F304, F316, F316Ti, F321) |
                                Legovaná ocel (F11, F22, F91) | Duplexní ocel (F51, F53, F55) |
                                Niklové slitiny (Monel, Inconel, Hastelloy)');

    -- Pipes section
    result := replace(result,
        'Cylindrical structures used to transport fluids and gases. Classified by shape, size, material, and manufacturing method — seamless, welded, and spiral-welded.',
        'Válcové konstrukce pro transport kapalin a plynů. Klasifikovány podle tvaru, velikosti, materiálu a výrobní metody — bezešvé, svařované a spirálově svařované.');

    result := replace(result,
        'Seamless Pipes, Welded Pipes, Exhaust Tubes, Square Tubes, Rectangle Tubes, Decorative Tubes',
        'Bezešvé trubky, svařované trubky, výfukové trubky, čtvercové profily, obdélníkové profily, dekorativní trubky');

    result := replace(result,
        'Carbon Steel (ASTM A106, API 5L X42-X70, PSL-1/PSL-2) |
                                Stainless Steel (304, 304L, 316, 316L, 316Ti) |
                                Duplex (2205, 2750) | Alloy Steel (ASTM A335 P11, P12, P22, P91) |
                                Aluminum | Copper Alloy',
        'Uhlíková ocel (ASTM A106, API 5L X42-X70, PSL-1/PSL-2) |
                                Nerezová ocel (304, 304L, 316, 316L, 316Ti) |
                                Duplexní ocel (2205, 2750) | Legovaná ocel (ASTM A335 P11, P12, P22, P91) |
                                Hliník | Měděné slitiny');

    -- Fittings section
    result := replace(result,
        'Full range of piping fittings manufactured to international standards. Available in butt-weld, socket-weld, screwed, and flanged connections.',
        'Kompletní sortiment potrubních tvarovek vyráběných dle mezinárodních norem. Dostupné v provedení na tupo, hrdlové, závitové a přírubové.');

    result := replace(result,
        'Elbow (Long/Short Radius), Tee, Reducer (Concentric/Eccentric), Cap, Coupling, Cross, Nipple, Bushing, Union',
        'Koleno (dlouhý/krátký poloměr), T-kus, redukce (soustředná/výstředná), zátka, spojka, kříž, vsuvka, pouzdro, šroubení');

    result := replace(result,
        'Class 150, Class 300, Class 600, Class 1500, and others',
        'Třída 150, Třída 300, Třída 600, Třída 1500 a další');

    result := replace(result,
        'Carbon Steel (ASTM A234 WPB WPL6, S235JR) |
                                Stainless Steel (A182-F304, F304L, F316, F316Ti, F321) |
                                Duplex (A182-2205, 2507) | Alloy Steel (A182-F11, F22, F91) |
                                Nickel Alloys | Aluminum | Copper Alloy',
        'Uhlíková ocel (ASTM A234 WPB WPL6, S235JR) |
                                Nerezová ocel (A182-F304, F304L, F316, F316Ti, F321) |
                                Duplexní ocel (A182-2205, 2507) | Legovaná ocel (A182-F11, F22, F91) |
                                Niklové slitiny | Hliník | Měděné slitiny');

    -- Valves section
    result := replace(result,
        'Industrial valves meeting international and industry-specific standards. Complete range for flow control, isolation, and safety applications.',
        'Průmyslové ventily splňující mezinárodní a oborové normy. Kompletní sortiment pro řízení průtoku, uzavírání a bezpečnostní aplikace.');

    result := replace(result,
        'Ball Valves, Butterfly Valves, Check Valves, Globe Valves, Gate Valves, Diaphragm Valves, Needle Valves, Plug Valves, Safety Valves, Solenoid Valves',
        'Kulové ventily, motýlkové ventily, zpětné ventily, regulační ventily, šoupátka, membránové ventily, jehličkové ventily, kohoutové ventily, pojistné ventily, elektromagnetické ventily');

    result := replace(result,
        'Carbon Steel (A105, A350 LF2, A234 WPB) |
                                Stainless Steel (A182 F304, F316, F317, F321, F347) |
                                Alloy Steel (A182 F11, F22, F91) |
                                Duplex (A182 F51, F53, F55) |
                                Nickel Alloys (Monel, Inconel, Hastelloy) | Bronze (B62, B61, B584) |
                                Cast Iron (A126, EN 1561)',
        'Uhlíková ocel (A105, A350 LF2, A234 WPB) |
                                Nerezová ocel (A182 F304, F316, F317, F321, F347) |
                                Legovaná ocel (A182 F11, F22, F91) |
                                Duplexní ocel (A182 F51, F53, F55) |
                                Niklové slitiny (Monel, Inconel, Hastelloy) | Bronz (B62, B61, B584) |
                                Litina (A126, EN 1561)');

    -- Industrial Materials section
    result := replace(result,
        'Raw materials for flange manufacturing and industrial applications. Wide variety of steel grades and alloys available according to customer requirements.',
        'Suroviny pro výrobu přírub a průmyslové aplikace. Široký výběr jakostí oceli a slitin dle požadavků zákazníka.');

    result := replace(result, '>Carbon Steel<', '>Uhlíková ocel<');
    result := replace(result, '>Stainless Steel<', '>Nerezová ocel<');
    result := replace(result, '>Duplex Stainless Steel<', '>Duplexní nerezová ocel<');
    result := replace(result, '>Alloy Steel<', '>Legovaná ocel<');
    result := replace(result, '>Ductile Iron<', '>Tvárná litina<');
    result := replace(result, '>Aluminum<', '>Hliník<');
    result := replace(result, '>Copper &amp; Brass<', '>Měď &amp; mosaz<');

    -- CTA strip in catalog
    result := replace(result,
        'Need Custom Specifications?',
        'Potřebujete vlastní specifikace?');
    result := replace(result,
        'We can source materials according to custom specifications and design standards.
                        Send us your requirements for a competitive quote.',
        'Dokážeme zajistit materiály dle vlastních specifikací a konstrukčních norem.
                        Pošlete nám své požadavky pro konkurenční nabídku.');

    -- Catalog alt texts
    result := replace(result,
        'alt="Flange types — weld neck, slip-on, blind, threaded, socket weld, lap joint, orifice, pressure vessel nozzles"',
        'alt="Typy přírub — přivařovací, nástrčné, zaslepovací, závitové, hrdlové, překrývací, měřicí, hrdla tlakových nádob"');
    result := replace(result, 'alt="Industrial flanges"', 'alt="Průmyslové příruby"');
    result := replace(result, 'alt="Steel round bars for flanges"', 'alt="Ocelové kulatiny pro příruby"');
    result := replace(result,
        'alt="Pipe types — seamless, welded, exhaust, square, rectangle, decorative tubes"',
        'alt="Typy trubek — bezešvé, svařované, výfukové, čtvercové, obdélníkové, dekorativní"');
    result := replace(result, 'alt="Steel pipes stack"', 'alt="Stoh ocelových trubek"');
    result := replace(result, 'alt="Steel pipes bundle"', 'alt="Svazek ocelových trubek"');
    result := replace(result,
        'alt="Fitting types — butt-weld, socket-weld, screwed, flanged"',
        'alt="Typy tvarovek — na tupo, hrdlové, závitové, přírubové"');
    result := replace(result, 'alt="Stainless steel elbows"', 'alt="Nerezová kolena"');
    result := replace(result, 'alt="Large pipe fittings"', 'alt="Velké potrubní tvarovky"');
    result := replace(result, 'alt="Pipe reducers and fittings"', 'alt="Potrubní redukce a tvarovky"');
    result := replace(result,
        'alt="Valve types — ball, butterfly, check, globe, gate, diaphragm, needle, plug, safety, solenoid"',
        'alt="Typy ventilů — kulové, motýlkové, zpětné, regulační, šoupátka, membránové, jehličkové, kohoutové, pojistné, elektromagnetické"');
    result := replace(result, 'alt="Ball valve"', 'alt="Kulový ventil"');
    result := replace(result, 'alt="Alloy steel materials for valves"', 'alt="Materiály z legované oceli pro ventily"');
    result := replace(result, 'alt="Steel bars and round stock"', 'alt="Ocelové tyče a kulatiny"');

    -- "Request Quote" button text (used in catalog, categories, hero, footer, etc.)
    result := replace(result, '>Request Quote
                    <', '>Žádost o nabídku
                    <');

    -- ── vx_footer ──────────────────────────────────────

    -- Footer company description
    result := replace(result,
        'Your trusted partner for industrial piping materials.
                                Direct sourcing from certified manufacturers with
                                European quality standards and on-site oversight.',
        'Váš spolehlivý partner pro průmyslové potrubní materiály.
                                Přímý nákup od certifikovaných výrobců
                                s evropskými standardy kvality a dohledem na místě.');

    -- Footer headings
    result := replace(result, '>Navigation<', '>Navigace<');
    -- ">Products<" already handled above
    result := replace(result, '>Contact<', '>Kontakt<');

    -- Footer nav links
    result := replace(result, '>Home<', '>Úvod<');
    result := replace(result, '>About Us<', '>O nás<');
    result := replace(result, '>Certifications<', '>Certifikace<');

    -- Footer contact labels
    -- ">Phone<" already handled
    -- ">Headquarters<" already handled

    -- Footer copyright
    result := replace(result,
        'Ventorix Global Trade s.r.o. All rights reserved.',
        'Ventorix Global Trade s.r.o. Všechna práva vyhrazena.');
    result := replace(result, '>Privacy Policy<', '>Zásady ochrany osobních údajů<');
    result := replace(result, '>Terms of Service<', '>Obchodní podmínky<');

    -- ── vx_header ──────────────────────────────────────
    result := replace(result, 'aria-label="Toggle navigation"', 'aria-label="Přepnout navigaci"');
    result := replace(result, 'aria-label="Close"', 'aria-label="Zavřít"');

    -- ── pages.xml views ────────────────────────────────

    -- Products page
    result := replace(result, '>Our Products<', '>Naše produkty<');
    result := replace(result,
        'Full range of industrial piping materials, certified to international standards.',
        'Kompletní sortiment průmyslových potrubních materiálů certifikovaných dle mezinárodních norem.');
    result := replace(result, '>Catalog<', '>Katalog<');

    -- About page
    result := replace(result, '>About Ventorix<', '>O společnosti Ventorix<');

    -- Certifications page
    result := replace(result, '>Quality Standards<', '>Standardy kvality<');
    result := replace(result, '>Certifications<', '>Certifikace<');
    result := replace(result, '>Our Commitment<', '>Náš závazek<');

    result := replace(result,
        'Quality is Our Priority',
        'Kvalita je naší prioritou');

    result := replace(result,
        'Every product comes with complete material certification
                                and test reports as per EN 10204 3.1. Our on-site quality team in China
                                performs rigorous inspections including:',
        'Každý produkt je dodáván s kompletní materiálovou certifikací
                                a zkušebními protokoly dle EN 10204 3.1. Náš tým kontroly kvality přímo v Číně
                                provádí přísné inspekce zahrnující:');

    result := replace(result, '>Visual and dimensional inspection<', '>Vizuální a rozměrová kontrola<');
    result := replace(result, '>Hydrostatic pressure testing<', '>Hydrostatická tlaková zkouška<');
    result := replace(result, '>Chemical composition analysis<', '>Analýza chemického složení<');
    result := replace(result, '>Mechanical property testing<', '>Testování mechanických vlastností<');
    result := replace(result, '>Non-destructive testing (NDT)<', '>Nedestruktivní testování (NDT)<');
    result := replace(result, '>Surface finish verification<', '>Ověření povrchové úpravy<');

    result := replace(result, 'alt="Quality inspection"', 'alt="Kontrola kvality"');

    -- Contact page
    result := replace(result, '>Request a Quote<', '>Žádost o nabídku<');
    result := replace(result,
        'Provide your technical specifications and our team will prepare a competitive offer with full documentation and delivery details.',
        'Uveďte své technické specifikace a náš tým připraví konkurenční nabídku s kompletní dokumentací a dodacími podmínkami.');

    -- "Who We Are" label on about page
    result := replace(result, '>Who We Are<', '>Kdo jsme<');

    -- "Request For Quotation" label on contact page (already handled above in different context)

    -- Products page CTA
    result := replace(result,
        'Need a Custom Quotation?',
        'Potřebujete individuální nabídku?');
    result := replace(result,
        'Upload your specification sheets and receive detailed pricing
                        with delivery timeline within 48 hours.',
        'Nahrajte své specifikace a obdržíte podrobnou cenovou nabídku
                        s dodacími lhůtami do 48 hodin.');
    result := replace(result, '>Contact Us<', '>Kontaktujte nás<');

    -- Homepage meta
    result := replace(result,
        '>Industrial Piping Materials | Ventorix Global Trade<',
        '>Průmyslové potrubní materiály | Ventorix Global Trade<');
    result := replace(result,
        'Global supplier of flanges, pipes, valves, fittings and pipeline components. Direct manufacturing oversight in China. DIN/ANSI certified.',
        'Globální dodavatel přírub, trubek, ventilů, tvarovek a potrubních komponentů. Přímý dohled nad výrobou v Číně. Certifikace DIN/ANSI.');

    -- Products page meta
    result := replace(result,
        'Browse our full range of industrial piping materials: flanges, pipes, tubes, fittings, valves, and pipeline components.',
        'Prohlédněte si kompletní sortiment průmyslových potrubních materiálů: příruby, trubky, profily, tvarovky, ventily a potrubní komponenty.');

    -- About page meta
    result := replace(result,
        'Learn about Ventorix Global Trade — your trusted partner for industrial piping materials with direct manufacturing oversight in China.',
        'Poznejte Ventorix Global Trade — vašeho spolehlivého partnera pro průmyslové potrubní materiály s přímým dohledem nad výrobou v Číně.');

    -- Certifications page meta
    result := replace(result,
        'ISO 9001, EN 10204 3.1, CE Marking, DIN, ANSI, API, ASTM — all certifications and quality standards we comply with.',
        'ISO 9001, EN 10204 3.1, značka CE, DIN, ANSI, API, ASTM — všechny certifikace a standardy kvality, které splňujeme.');

    -- Contact page meta
    result := replace(result,
        'Request a quote from Ventorix Global Trade. Upload your specifications for industrial piping materials and receive competitive pricing within 48 hours.',
        'Vyžádejte si nabídku od Ventorix Global Trade. Nahrajte specifikace průmyslových potrubních materiálů a obdržíte konkurenční cenovou nabídku do 48 hodin.');

    -- Meta titles & descriptions (inside t-set tags, these are text nodes)
    result := replace(result,
        '>Products | Ventorix Global Trade<',
        '>Produkty | Ventorix Global Trade<');
    result := replace(result,
        '>About Us | Ventorix Global Trade<',
        '>O nás | Ventorix Global Trade<');
    result := replace(result,
        '>Certifications | Ventorix Global Trade<',
        '>Certifikace | Ventorix Global Trade<');
    result := replace(result,
        '>Request a Quote | Ventorix Global Trade<',
        '>Žádost o nabídku | Ventorix Global Trade<');

    -- Footer phone/headquarters labels (with specific footer structure)
    result := replace(result,
        '>Phone</span>
                                    <span',
        '>Telefon</span>
                                    <span');
    result := replace(result,
        '>Headquarters</span>
                                    <span',
        '>Sídlo</span>
                                    <span');

    -- Footer "Czech Republic, EU" in specific footer context
    result := replace(result,
        '>Czech Republic, EU</span>',
        '>Česká republika, EU</span>');

    RETURN result;
END;
$$ LANGUAGE plpgsql;


-- ═══════════════════════════════════════════════════════════════════════════════
-- Apply to theme_ir_ui_view (theme master records)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE theme_ir_ui_view
SET arch = jsonb_set(
    arch,
    '{cs_CZ}',
    to_jsonb(_vx_translate_cs(arch->>'cs_CZ'))
)
WHERE arch ? 'cs_CZ'
  AND arch->>'cs_CZ' IS NOT NULL
  AND arch->>'cs_CZ' != '';

DO $$
BEGIN
    RAISE NOTICE 'theme_ir_ui_view: Updated % rows', (
        SELECT count(*) FROM theme_ir_ui_view
        WHERE arch ? 'cs_CZ' AND arch->>'cs_CZ' IS NOT NULL
    );
END $$;


-- ═══════════════════════════════════════════════════════════════════════════════
-- PART 2: ir_ui_view (per-website copies with website_id IS NOT NULL)
--         Uses arch_db instead of arch
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE ir_ui_view
SET arch_db = jsonb_set(
    arch_db,
    '{cs_CZ}',
    to_jsonb(_vx_translate_cs(arch_db->>'cs_CZ'))
)
WHERE website_id IS NOT NULL
  AND arch_db IS NOT NULL
  AND arch_db ? 'cs_CZ'
  AND arch_db->>'cs_CZ' IS NOT NULL
  AND arch_db->>'cs_CZ' != ''
  AND (
      key LIKE 'theme_ventorix.%'
      OR key LIKE 'website.%'
      OR name LIKE 'Ventorix%'
      OR name LIKE 'theme_ventorix.%'
  );

DO $$
BEGIN
    RAISE NOTICE 'ir_ui_view (website copies): Updated % rows', (
        SELECT count(*) FROM ir_ui_view
        WHERE website_id IS NOT NULL
          AND arch_db IS NOT NULL
          AND arch_db ? 'cs_CZ'
          AND (
              key LIKE 'theme_ventorix.%'
              OR key LIKE 'website.%'
              OR name LIKE 'Ventorix%'
              OR name LIKE 'theme_ventorix.%'
          )
    );
END $$;


-- ═══════════════════════════════════════════════════════════════════════════════
-- Cleanup: drop the helper function
-- ═══════════════════════════════════════════════════════════════════════════════
DROP FUNCTION IF EXISTS _vx_translate_cs(text);


COMMIT;

-- ═══════════════════════════════════════════════════════════════════════════════
-- Verification queries (run after to check results)
-- ═══════════════════════════════════════════════════════════════════════════════

-- Check theme_ir_ui_view: show first 200 chars of cs_CZ for each view
-- SELECT id, name, left(arch->>'cs_CZ', 200) AS cs_preview
-- FROM theme_ir_ui_view
-- WHERE arch ? 'cs_CZ'
-- ORDER BY name;

-- Check if any English text remains in cs_CZ
-- SELECT id, name
-- FROM theme_ir_ui_view
-- WHERE arch ? 'cs_CZ'
--   AND (
--       arch->>'cs_CZ' LIKE '%Submit Your Inquiry%'
--       OR arch->>'cs_CZ' LIKE '%Request For Quotation%'
--       OR arch->>'cs_CZ' LIKE '%What We Supply%'
--       OR arch->>'cs_CZ' LIKE '%How It Works%'
--       OR arch->>'cs_CZ' LIKE '%Our Competitive Advantage%'
--       OR arch->>'cs_CZ' LIKE '%Quality Assurance%'
--       OR arch->>'cs_CZ' LIKE '%Start Your Project%'
--       OR arch->>'cs_CZ' LIKE '%Global Industrial Partner%'
--       OR arch->>'cs_CZ' LIKE '%About Ventorix%'
--       OR arch->>'cs_CZ' LIKE '%Why Work With Us%'
--   )
-- ORDER BY name;

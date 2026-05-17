import base64
import logging

from markupsafe import Markup
from odoo import http
from odoo.http import request

_logger = logging.getLogger(__name__)


class VentorixRFQController(http.Controller):

    @http.route('/ventorix/rfq/submit', type='json', auth='public', website=True, methods=['POST'])
    def rfq_submit(self, **kw):
        values = kw
        company = values.get('company', '')
        name = values.get('name', '')
        email = values.get('email_from', '')
        phone = values.get('phone', '')
        subject = values.get('subject', '')
        product_type = values.get('product_type', '')
        material = values.get('material', '')
        standard = values.get('standard', '')
        size = values.get('size', '')
        pressure = values.get('pressure', '')
        quantity = values.get('quantity', '')
        country = values.get('country', '')
        delivery_date = values.get('delivery_date', '')
        description = values.get('description', '')
        attachment_name = values.get('attachment_name', '')
        attachment_data = values.get('attachment_data', '')

        spec_rows = []
        if product_type:
            spec_rows.append(('Product Type', product_type))
        if material:
            spec_rows.append(('Material Grade', material))
        if standard:
            spec_rows.append(('Standard / Norm', standard))
        if size:
            spec_rows.append(('Size / Dimensions', size))
        if pressure:
            spec_rows.append(('Pressure Class', pressure))
        if quantity:
            spec_rows.append(('Quantity', quantity))
        if country:
            spec_rows.append(('Delivery Country', country))
        if delivery_date:
            spec_rows.append(('Desired Delivery', delivery_date))

        desc_parts = []
        if spec_rows:
            rows_html = ''.join(
                f'<tr><td style="padding:4px 8px;font-weight:bold;white-space:nowrap;">{k}:</td>'
                f'<td style="padding:4px 8px;">{v}</td></tr>'
                for k, v in spec_rows
            )
            desc_parts.append(
                f'<h4>Product Specification</h4>'
                f'<table style="border-collapse:collapse;">{rows_html}</table>'
            )
        if description:
            desc_parts.append(f'<h4>Technical Requirements</h4><p>{description}</p>')
        full_description = '<br/>'.join(desc_parts)

        lead_name = subject or f"RFQ from {company or name or email}"

        # Find or create partner
        Partner = request.env['res.partner'].sudo()
        partner = False
        if email:
            partner = Partner.search([('email', '=ilike', email)], limit=1)
        if not partner and name:
            partner_vals = {
                'name': name,
                'email': email,
                'phone': phone,
                'company_type': 'company' if company else 'person',
            }
            if company:
                parent = Partner.search([('name', '=ilike', company), ('is_company', '=', True)], limit=1)
                if not parent:
                    parent = Partner.create({'name': company, 'is_company': True})
                partner_vals['parent_id'] = parent.id
                partner_vals['company_type'] = 'person'
            partner = Partner.create(partner_vals)

        # Get RFQ team
        team = request.env['crm.team'].sudo().search([('name', '=', 'RFQ')], limit=1)

        lead_vals = {
            'name': lead_name,
            'partner_id': partner.id if partner else False,
            'contact_name': name,
            'partner_name': company,
            'email_from': email,
            'phone': phone,
            'description': full_description,
            'team_id': team.id if team else False,
            'type': 'opportunity',
        }
        lead = request.env['crm.lead'].sudo().create(lead_vals)

        # Attach file to lead
        if attachment_data and attachment_name:
            try:
                file_content = attachment_data.split(',')[1] if ',' in attachment_data else attachment_data
                request.env['ir.attachment'].sudo().create({
                    'name': attachment_name,
                    'datas': file_content,
                    'res_model': 'crm.lead',
                    'res_id': lead.id,
                })
            except Exception:
                _logger.warning("Failed to attach file to lead %s", lead.id, exc_info=True)

        # Send notification email via message_post
        self._send_rfq_notification(lead, spec_rows, description)

        _logger.info("RFQ Lead created: #%s '%s' from %s", lead.id, lead_name, email)
        return {'success': True, 'lead_id': lead.id}

    def _send_rfq_notification(self, lead, spec_rows, tech_requirements):
        rows_html = ''
        for label, val in spec_rows:
            rows_html += (
                f'<tr>'
                f'<td style="padding:8px 12px;border:1px solid #dee2e6;font-weight:bold;width:160px;background:#e9ecef;">{label}</td>'
                f'<td style="padding:8px 12px;border:1px solid #dee2e6;">{val}</td>'
                f'</tr>'
            )

        base_url = request.env['ir.config_parameter'].sudo().get_param('web.base.url', 'http://localhost:8069')
        body = f"""
<div style="font-family:Arial,sans-serif;max-width:600px;margin:0 auto;">
    <div style="background:#0A1628;padding:20px 30px;border-bottom:2px solid #2E86DE;">
        <h2 style="color:#fff;margin:0;font-size:18px;">New RFQ Received</h2>
    </div>
    <div style="padding:25px 30px;background:#f8f9fa;">
        <h3 style="color:#0A1628;margin-top:0;">{lead.name}</h3>
        <table style="width:100%;border-collapse:collapse;margin-bottom:20px;">
            <tr>
                <td style="padding:8px 12px;border:1px solid #dee2e6;font-weight:bold;width:160px;background:#e9ecef;">Company</td>
                <td style="padding:8px 12px;border:1px solid #dee2e6;">{lead.partner_name or '—'}</td>
            </tr>
            <tr>
                <td style="padding:8px 12px;border:1px solid #dee2e6;font-weight:bold;background:#e9ecef;">Contact</td>
                <td style="padding:8px 12px;border:1px solid #dee2e6;">{lead.contact_name or '—'}</td>
            </tr>
            <tr>
                <td style="padding:8px 12px;border:1px solid #dee2e6;font-weight:bold;background:#e9ecef;">Email</td>
                <td style="padding:8px 12px;border:1px solid #dee2e6;">{lead.email_from or '—'}</td>
            </tr>
            <tr>
                <td style="padding:8px 12px;border:1px solid #dee2e6;font-weight:bold;background:#e9ecef;">Phone</td>
                <td style="padding:8px 12px;border:1px solid #dee2e6;">{lead.phone or '—'}</td>
            </tr>
        </table>
        <h4 style="color:#2E86DE;margin-bottom:10px;">Specification</h4>
        <table style="width:100%;border-collapse:collapse;margin-bottom:20px;">
            {rows_html}
        </table>
        <h4 style="color:#2E86DE;margin-bottom:10px;">Technical Requirements</h4>
        <pre style="background:#fff;padding:15px;border:1px solid #dee2e6;border-radius:4px;white-space:pre-wrap;font-size:13px;">{tech_requirements or 'No details provided'}</pre>
        <p style="margin-top:20px;">
            <a href="{base_url}/odoo/crm/{lead.id}"
               style="background:#2E86DE;color:#fff;padding:10px 24px;text-decoration:none;border-radius:4px;display:inline-block;">
                Open in CRM
            </a>
        </p>
    </div>
    <div style="background:#0A1628;padding:12px 30px;text-align:center;">
        <span style="color:rgba(255,255,255,0.4);font-size:12px;">Ventorix Global Trade — Automated RFQ System</span>
    </div>
</div>"""
        lead.sudo().message_post(
            body=Markup(body),
            message_type='notification',
            subtype_xmlid='mail.mt_note',
        )

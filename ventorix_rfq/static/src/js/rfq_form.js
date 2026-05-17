/** @odoo-module **/

import { whenReady } from "@odoo/owl";
import { rpc } from "@web/core/network/rpc";

whenReady(() => {
    const btn = document.querySelector('.vx_rfq_submit');
    if (!btn) return;

    btn.addEventListener('click', async (ev) => {
        ev.preventDefault();
        ev.stopPropagation();

        const form = document.getElementById('vx_rfq_form');
        if (!form) return;

        const resultEl = document.getElementById('s_website_form_result');

        let valid = true;
        form.querySelectorAll('[required]').forEach((input) => {
            if (!input.value.trim()) {
                input.classList.add('is-invalid');
                valid = false;
            } else {
                input.classList.remove('is-invalid');
            }
        });
        if (!valid) {
            if (resultEl) resultEl.innerHTML = '<span class="text-danger mt-2 d-block">Please fill in all required fields.</span>';
            return;
        }

        const origHTML = btn.innerHTML;
        btn.innerHTML = '<i class="fa fa-spinner fa-spin me-2"></i>Sending...';
        btn.classList.add('disabled');
        if (resultEl) resultEl.innerHTML = '';

        let fileName = '';
        let fileData = '';
        const fileInput = form.querySelector('input[type="file"]');
        if (fileInput && fileInput.files.length > 0 && fileInput.files[0].size <= 10 * 1024 * 1024) {
            try {
                fileData = await new Promise((resolve, reject) => {
                    const reader = new FileReader();
                    reader.onload = () => resolve(reader.result);
                    reader.onerror = reject;
                    reader.readAsDataURL(fileInput.files[0]);
                });
                fileName = fileInput.files[0].name;
            } catch (e) {
                console.warn('File read failed', e);
            }
        }

        try {
            const resp = await rpc('/ventorix/rfq/submit', {
                company: form.querySelector('[name="company"]')?.value || '',
                name: form.querySelector('[name="name"]')?.value || '',
                email_from: form.querySelector('[name="email_from"]')?.value || '',
                phone: form.querySelector('[name="phone"]')?.value || '',
                subject: form.querySelector('[name="subject"]')?.value || '',
                product_type: form.querySelector('[name="Product Type"]')?.value || '',
                material: form.querySelector('[name="Material Grade"]')?.value || '',
                standard: form.querySelector('[name="Standard"]')?.value || '',
                size: form.querySelector('[name="Size"]')?.value || '',
                pressure: form.querySelector('[name="Pressure Class"]')?.value || '',
                quantity: form.querySelector('[name="Quantity"]')?.value || '',
                country: form.querySelector('[name="Delivery Country"]')?.value || '',
                delivery_date: form.querySelector('[name="Delivery Date"]')?.value || '',
                description: form.querySelector('[name="description"]')?.value || '',
                attachment_name: fileName,
                attachment_data: fileData,
            });
            if (resp && resp.success) {
                window.location.href = '/contactus-thank-you';
            } else {
                throw new Error('Server returned failure');
            }
        } catch (err) {
            console.error('RFQ submit error:', err);
            btn.innerHTML = origHTML;
            btn.classList.remove('disabled');
            if (resultEl) {
                resultEl.innerHTML = '<span class="text-danger mt-2 d-block">Something went wrong. Please try again.</span>';
            }
        }
    });
});

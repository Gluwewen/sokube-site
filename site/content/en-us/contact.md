---
title: "Contact us"
layout: "form"
description: "Would you like to know more about our offers, services or training? Please complete the form below and we will get back to you as soon as possible."
---

{{< sokube-form
action="https://formspree.io/f/XXXXXXXX"
buttonText="Send message"
>}}

    {{< sokube-form-field
        label="Company"
        name="company"
        required="true"
    >}}

    {{< sokube-form-field
        label="Last name"
        name="lastname"
        required="true"
    >}}

    {{< sokube-form-field
        label="First name"
        name="firstname"
        required="true"
    >}}

    {{< sokube-form-field
        label="Email"
        name="email"
        type="email"
        required="true"
    >}}

    {{< sokube-form-field
        label="Position"
        name="position"
    >}}

    {{< sokube-form-field
        label="Business phone number"
        name="phone"
    >}}

    {{< sokube-form-textarea
        label="Message"
        name="message"
        placeholder="Send us a message"
        required="true"
    >}}

By submitting this form, you consent to SoKube collecting, storing, and processing your personal data for the purposes specified in the Privacy Policy and in accordance with applicable data protection laws.

{{< sokube-form-checkbox name="consent" required="true" >}}
I acknowledge that I have read and understood the [Privacy Policy]({{</* relref "privacy" */>}}) and consent to receiving communications and information from SoKube.
{{< /sokube-form-checkbox >}}

{{< /sokube-form >}}

{{< sokube-map address="Rue Adrien-Lachenal 20, 1207 Genève, Suisse" title="SoKube Geneva Office" >}}
---
title: "Contact us"
layout: "form"
description: "Have a question about NeuroKube? Tell us about your platform and your operational challenges, our team will get back to you quickly."
---

{{< sokube-form
action="https://formspree.io/f/XXXXXXXX"
buttonText="Contact the Sales Team"
>}}

    {{< sokube-form-field
        label="Full name"
        name="name"
        required="true"
    >}}

    {{< sokube-form-field
        label="Business email address"
        name="email"
        type="email"
        required="true"
    >}}

    {{< sokube-form-field
        label="Business phone number"
        name="phone"
    >}}

    {{< sokube-form-field
        label="Company"
        name="company"
    >}}

    {{< sokube-form-textarea
        label="How can we help you?"
        name="message"
        placeholder="Tell us about your platform and your operational challenges"
    >}}

{{< /sokube-form >}}
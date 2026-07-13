---
title: "Request a demonstration"
layout: "form"
description: "Discover how NeuroKube helps platform teams troubleshoot faster and build organizational intelligence."
---

{{< neurokube-form
    action="https://formspree.io/f/XXXXXXXX"
    buttonText="Request a Demo"
>}}

    {{< neurokube-form-field
        label="Full Name"
        name="name"
        required="true"
    >}}

    {{< neurokube-form-field
        label="Business Email"
        name="email"
        type="email"
        required="true"
    >}}

    {{< neurokube-form-field
        label="Business Phone"
        name="phone"
    >}}

    {{< neurokube-form-field
        label="Company"
        name="company"
    >}}

    {{< neurokube-form-textarea
        label="How can we help?"
        name="message"
        placeholder="Tell us about your platform and operational challenges"
    >}}

{{< /neurokube-form >}}
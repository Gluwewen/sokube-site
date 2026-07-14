---
title: "Request a demonstration"
layout: "form"
description: "Discover how NeuroKube helps platform teams troubleshoot faster and build organizational intelligence."
---

{{< sokube-form
    action="https://formspree.io/f/XXXXXXXX"
    buttonText="Request a Demo"
>}}

    {{< sokube-form-field
        label="Full Name"
        name="name"
        required="true"
    >}}

    {{< sokube-form-field
        label="Business Email"
        name="email"
        type="email"
        required="true"
    >}}

    {{< sokube-form-field
        label="Business Phone"
        name="phone"
    >}}

    {{< sokube-form-field
        label="Company"
        name="company"
    >}}

    {{< sokube-form-textarea
        label="How can we help?"
        name="message"
        placeholder="Tell us about your platform and operational challenges"
    >}}

{{< /sokube-form >}}
---
title: "Demandez une démonstration"
layout: "form"
description: "Découvrez comment NeuroKube aide les équipes plateforme à résoudre les incidents plus rapidement et à développer une intelligence organisationnelle."
---

{{< sokube-form
action="https://formspree.io/f/XXXXXXXX"
buttonText="Demander une démonstration"
>}}

    {{< sokube-form-field
        label="Nom complet"
        name="name"
        required="true"
    >}}

    {{< sokube-form-field
        label="Adresse e-mail professionnelle"
        name="email"
        type="email"
        required="true"
    >}}

    {{< sokube-form-field
        label="Téléphone professionnel"
        name="phone"
    >}}

    {{< sokube-form-field
        label="Entreprise"
        name="company"
    >}}

    {{< sokube-form-textarea
        label="Comment pouvons-nous vous aider ?"
        name="message"
        placeholder="Parlez-nous de votre plateforme et de vos défis opérationnels"
    >}}

{{< /sokube-form >}}

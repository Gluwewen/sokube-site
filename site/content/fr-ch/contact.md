---
title: "Contactez-nous"
layout: "form"
description: "Une question sur NeuroKube ? Parlez-nous de votre plateforme et de vos enjeux opérationnels, notre équipe vous répond rapidement."
---

{{< sokube-form
action="https://formspree.io/f/XXXXXXXX"
buttonText="Contacter l'équipe commerciale"
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

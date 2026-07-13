---
title: "Contactez-nous"
layout: "form"
description: "Une question sur NeuroKube ? Parlez-nous de votre plateforme et de vos enjeux opérationnels, notre équipe vous répond rapidement."
---

{{< neurokube-form
action="https://formspree.io/f/XXXXXXXX"
buttonText="Contacter l'équipe commerciale"
>}}

    {{< neurokube-form-field
        label="Nom complet"
        name="name"
        required="true"
    >}}

    {{< neurokube-form-field
        label="Adresse e-mail professionnelle"
        name="email"
        type="email"
        required="true"
    >}}

    {{< neurokube-form-field
        label="Téléphone professionnel"
        name="phone"
    >}}

    {{< neurokube-form-field
        label="Entreprise"
        name="company"
    >}}

    {{< neurokube-form-textarea
        label="Comment pouvons-nous vous aider ?"
        name="message"
        placeholder="Parlez-nous de votre plateforme et de vos défis opérationnels"
    >}}

{{< /neurokube-form >}}

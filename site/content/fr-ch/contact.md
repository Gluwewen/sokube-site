---
title: "Contactez-nous"
layout: "form"
description: "Vous souhaitez en savoir plus sur nos offres, services ou formations ? Merci de compléter le formulaire ci-dessous, notre équipe vous répondra dans les meilleurs délais."
---

{{< sokube-form
action="https://formspree.io/f/XXXXXXXX"
buttonText="Envoyer le message"
>}}

    {{< sokube-form-field
        label="Entreprise"
        name="company"
        required="true"
    >}}

    {{< sokube-form-field
        label="Nom"
        name="lastname"
        required="true"
    >}}

    {{< sokube-form-field
        label="Prénom"
        name="firstname"
        required="true"
    >}}

    {{< sokube-form-field
        label="E-mail"
        name="email"
        type="email"
        required="true"
    >}}

    {{< sokube-form-field
        label="Poste"
        name="position"
    >}}

    {{< sokube-form-field
        label="Téléphone professionnel"
        name="phone"
    >}}

    {{< sokube-form-textarea
        label="Message"
        name="message"
        placeholder="Envoyez-nous un message"
        required="true"
    >}}

En soumettant ce formulaire, vous consentez à ce que SoKube collecte, stocke et traite vos données personnelles aux fins précisées dans la Politique de confidentialité et conformément aux lois applicables en matière de protection des données.

{{< sokube-form-checkbox name="consent" required="true" >}}
J'ai lu et compris la [Politique de confidentialité]({{</* relref "privacy" */>}}) et je consens à recevoir des communications et informations de la part de SoKube.
{{< /sokube-form-checkbox >}}

{{< /sokube-form >}}

{{< sokube-map address="Rue Adrien-Lachenal 20, 1207 Genève, Suisse" title="Bureau de SoKube à Genève" >}}

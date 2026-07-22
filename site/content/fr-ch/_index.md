---
title: Home
client_logos:
  - name: "Customer 1"
    logo: "/images/logos/customer-1.png"
  - name: "Customer 2"
    logo: "/images/logos/customer-2.png"
  - name: "Customer 3"
    logo: "/images/logos/customer-3.png"
  - name: "Customer 4"
    logo: "/images/logos/customer-4.png"
  - name: "Customer 5"
    logo: "/images/logos/customer-5.png"
testimonials:
  - name: "John Smith"
    title: "CTO at TechStartup"
    avatar: "/images/testimonial-1.svg"
    quote: "We built our SaaS website in record time. The performance is incredible, and our users love the modern, clean design."
  - name: "Sarah Johnson"
    title: "Founder at WebFlow"
    avatar: "/images/testimonial-1.svg"
    quote: "The combination of Hugo and TailwindCSS delivers lightning-fast performance. Our website loads instantly, which has significantly improved our conversion rates."
  - name: "Michael Chen"
    title: "Lead Developer at CloudTech"
    avatar: "/images/testimonial-1.svg"
    quote: "This theme made it easy to create a professional SaaS website. The build times are incredibly fast, and the code is clean and maintainable."
---

{{< sokube-hero
    headline="Résoudre tous vos incidents Kubernetes dans un contexte Entreprise"
    sub_headline="L'IA copilote de votre plateforme Kubernetes et DevOps. Elle fait le travail de contexte, du premier signal au correctif vérifié - vous gardez la décision à chaque étape."
    primary_button_text="Demander une démonstration"
    primary_button_url="/demo/"
    secondary_button_text="En savoir plus"
    secondary_button_url="/about/"
    hero_image="/images/company/neurokube-usecase1-light.webp"
>}}

{{< sokube-client-logos animate="true" >}}

{{< sokube-features-section 
    title="Les plateformes modernes génèrent davantage de contexte que les équipes ne peuvent en traiter efficacement"
    description="Les plateformes Kubernetes produisent des données opérationnelles provenant des clusters, des dépôts Git, de l'Infrastructure as Code, des outils d'observabilité et de la documentation interne. NeuroKube transforme ces informations fragmentées en intelligence opérationnelle afin d'aider les équipes à investiguer plus rapidement, réduire les goulots d'étranglement liés aux escalades et diffuser l'expertise à l'échelle de l'organisation."
>}}

{{< sokube-card-grid cols="2" >}}

  {{< sokube-card
    label="Aujourd'hui"
    title="Exploiter des plateformes modernes"
  >}}

- Multiplication des outils isolés
- Investigations manuelles
- Dépendance aux processus d'escalade

  {{< /sokube-card >}}

  {{< sokube-card
    label="Avec NeuroKube"
    title="Intelligence opérationnelle à grande échelle"
  >}}
- Contexte plateforme unifié
- Investigations guidées par l'IA
- Prise de décision accélérée
- Connaissance partagée à l'échelle de l'organisation
- Automatisation sous contrôle humain
  {{< /sokube-card >}}
  
{{< /sokube-card-grid >}}

{{< sokube-feature
    title="Investigation d'incidents assistée par l'IA"
    description="Accélérez la résolution des incidents grâce à la corrélation en temps réel de la télémétrie, du contexte plateforme et des connaissances opérationnelles."
    badge="Investigation"
    badgeTextColor="text-neurokube-600"
    badgeBgColor="bg-neurokube-100"
    image="/images/features/incident-investigation-light.webp"
    buttonText="En savoir plus"
    buttonLink="/features/ai-powered-incident-investigation/"
    showButton="true"
    features="Corrélation multi-plateformes,Analyse contextualisée,Investigations guidées,Réduction du MTTR"
    imagePosition="right"
>}}

{{< sokube-feature
    title="Intelligence d'une plateforme multi-contextes"
    description="Obtenez une vision globale de votre plateforme en reliant Kubernetes, GitOps, l'Infrastructure as Code et les connaissances opérationnelles."
    badge="Intelligence"
    badgeTextColor="text-kube-600"
    badgeBgColor="bg-kube-100"
    image="/images/features/multi-context-intelligence-light.webp"
    buttonText="En savoir plus"
    buttonLink="/features/multi-context-platform-intelligence/"
    showButton="true"
    features="Environnement d'exécution Kubernetes,Dépôts Git,Infrastructure as Code,Bases de connaissances"
    imagePosition="left"
>}}

{{< sokube-feature
    title="Assistance à l'analyse des causes racines"
    description="Allez au-delà des symptômes et identifiez les causes probables grâce à un raisonnement contextuel assisté par l'IA."
    badge="Analyse"
    badgeTextColor="text-hr-600"
    badgeBgColor="bg-hr-100"
    image="/images/features/root-cause-analysis-light.webp"
    buttonText="En savoir plus"
    buttonLink="/features/root-cause-analysis-assistance/"
    showButton="true"
    features="Cartographie des dépendances,Corrélation des anomalies,Enrichissement du contexte,Génération d'hypothèses"
    imagePosition="right"
>}}

{{< sokube-feature
    title="Remédiation assistée par l'IA"
    description="Recevez des recommandations de remédiation exploitables tout en conservant un contrôle total par les ingénieurs."
    badge="Remédiation"
    badgeTextColor="text-neurokube-600"
    badgeBgColor="bg-neurokube-100"
    image="/images/features/ai-assisted-remediation-light.webp"
    buttonText="En savoir plus"
    buttonLink="/features/ai-assisted-remediation/"
    showButton="true"
    features="Actions de rétablissement guidées,Validation humaine,Garde-fous opérationnels,Intégration aux processus existants"
    imagePosition="left"
>}}

{{< sokube-feature
    title="Apprentissage opérationnel continu"
    description="Transformez chaque incident en connaissance organisationnelle réutilisable."
    badge="Apprentissage"
    badgeTextColor="text-kube-600"
    badgeBgColor="bg-kube-100"
    image="/images/features/continuous-operational-learning-light.webp"
    buttonText="En savoir plus"
    buttonLink="/features/continuous-operational-learning/"
    showButton="true"
    features="Connaissances issues des incidents,Procédures opérationnelles (Runbooks),Bonnes pratiques,Expertise collective"
    imagePosition="right"
>}}

{{< sokube-feature
    title="Gouvernance avec validation humaine"
    description="Garantissez la transparence, la traçabilité et la supervision humaine pour chaque recommandation et chaque action."
    badge="Gouvernance"
    badgeTextColor="text-hr-600"
    badgeBgColor="bg-hr-100"
    image="/images/features/human-in-the-loop-light.webp"
    buttonText="En savoir plus"
    buttonLink="/features/human-in-the-loop-governance/"
    showButton="true"
    features="Flux de validation,Traçabilité complète,Application des politiques,Opérations orientées sécurité"
    imagePosition="left"
>}}

{{< sokube-feature
    title="Contexte technique versionné"
    description="Ancrez chaque recommandation dans la version exacte de votre plateforme, grâce à un contexte documentaire et technique toujours à jour."
    badge="Contexte versionné"
    badgeTextColor="text-kube-600"
    badgeBgColor="bg-kube-100"
    image="/images/features/versioned-technical-context.webp"
    buttonText="En savoir plus"
    buttonLink="/features/versioned-technical-context/"
    showButton="true"
    features="Bundle documentaire versionné,MCP versionné,Contexte technique exact,Mise à jour continue"
    imagePosition="right"
>}}

{{< sokube-feature
    title="Processus de résolution éprouvé"
    description="Suivez un fil conducteur unique, de l'alerte à la vérification, calqué sur vos pratiques d'entreprise et entièrement traçable."
    badge="Processus éprouvé"
    badgeTextColor="text-neurokube-600"
    badgeBgColor="bg-neurokube-100"
    image="/images/features/proven-resolution-process-light.webp"
    buttonText="En savoir plus"
    buttonLink="/features/proven-resolution-process/"
    showButton="true"
    features="Fil conducteur unique,Calqué sur vos pratiques,Auditable à chaque étape,Sans disruption DevOps"
    imagePosition="left"
>}}

{{< /sokube-features-section >}}

{{< sokube-cards-section
      id="architecture-agentique"
      title="Une architecture agentique, pas un simple appel à un modèle"
      description="Derrière l'assistant, une vraie ingénierie : orchestration, spécialisation et vérification du travail de l'IA à chaque étape."
>}}

{{< sokube-card-grid cols="2" >}}

  {{< sokube-card
    label="MULTI-CONTEXTE"
    title="Trois sources de contexte réunies"
  >}}
  Runtime et Kubernetes, Git et code, documentation et base de connaissance : réunis dans un même raisonnement.
  {{< /sokube-card >}}

  {{< sokube-card
    label="ORCHESTRATEUR MULTI-AGENTS"
    title="Des agents spécialisés, pas un modèle unique"
  >}}
  Un agent d'investigation, un agent de diagnostic et un agent de remédiation, sous supervision et validation humaine à chaque étape.
  {{< /sokube-card >}}

  {{< sokube-card
    label="ÉVALUATION DES OUTPUTS"
    title="Une qualité mesurée, pas supposée"
  >}}
  Chaque réponse est confrontée à une vérité de référence par un LLM-juge, sur un référentiel de scénarios réels rencontrés par les experts DevOps de SoKube chez leurs clients. Ce cadre valide que nos optimisations n'introduisent pas de régression, et permet de comparer objectivement les différents LLM sur lesquels peuvent s'appuyer les agents.
  {{< /sokube-card >}}

  {{< sokube-card
    label="BASE DE CONNAISSANCE ÉVOLUTIVE"
    title="Chaque incident affine la plateforme"
  >}}
  Les investigations et remédiations capitalisées enrichissent en continu les diagnostics et remédiations futurs.
  {{< /sokube-card >}}

{{< /sokube-card-grid >}}
{{< /sokube-cards-section >}}

{{< sokube-cards-section 
      title="Résultats opérationnels"
      description="Des ordres de grandeur observés par NeuroKube sur des déploiements clients. Ils dépendent du contexte de chaque organisation et ne constituent pas un engagement contractuel."
>}}
  
{{< sokube-card-grid cols="2" >}}

  {{< sokube-card
    label="↓ MTTR"
    title="Un temps de résolution divisé par 3 à 10"
  >}}
  Les incidents courants passent de dizaines de minutes à quelques minutes, grâce à la corrélation de la télémétrie, du contexte d'infrastructure et des connaissances de l'organisation.
  {{< /sokube-card >}}

  {{< sokube-card
    label="↓ Charge cognitive"
    title="Jusqu'à 20 à 50 % de résolution en plus en autonomie"
  >}}
  Les équipes de développement et de support résolvent en autonomie ce qu'elles escaladaient auparavant, avec moins de dépendance aux mêmes experts.
  {{< /sokube-card >}}

  {{< sokube-card
    label="↑ Réutilisation de la connaissance"
    title="Connaissance organisationnelle partagée"
  >}}
  Capitalisez l'expertise opérationnelle et rendez-la réutilisable entre les équipes et les incidents.
  {{< /sokube-card >}}

  {{< sokube-card
    label="Supervision 360"
    title="Automatisation gouvernée par l'humain"
  >}}
  Accélérez les opérations tout en conservant visibilité, contrôle et conformité.
  {{< /sokube-card >}}

{{< /sokube-card-grid >}}
{{< /sokube-cards-section >}}

{{< sokube-testimonials 
    title="Adopté par les équipes DevOps modernes"
    description="Découvrez comment les équipes de Platform Engineering utilisent NeuroKube pour réduire la charge cognitive et accélérer la résolution des incidents."
    animate="true"
    background-color="#f1f5f9"
>}}

{{< sokube-cta >}}

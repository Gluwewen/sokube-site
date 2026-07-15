---
title: "Backstage : reprenez le contrôle de votre plateforme de développement"
date: 2026-06-01
author: "Gaetan Metzger"
description: "Découvrez comment Backstage, le portail interne open source de Spotify, réduit la charge cognitive de vos équipes techniques et redonne de la visibilité là où régnait le chaos, à condition de disposer d'une plateforme pilotée par API."
categories: ["DevOps"]
tags: ["DevOps"]
featured_image: "/images/blog/blog-01/backstage-01.webp"
---

Le platform engineering est une tendance de fond. L'IA a volé la vedette — mais les deux vont de pair : pas de plateforme solide, pas d'IA fiable en production. Si le sujet est nouveau pour vous, [cet article sur le platform engineering](https://www.sokube.io/blog/platform-engineering) en pose les bases.

Mettre en place un Internal Developer Portal, c'est améliorer la collaboration entre les équipes et réduire drastiquement la charge cognitive de vos ingénieurs.

[Backstage](https://backstage.io/) est l'outil open source qui rend cela concret — sans réinventer la roue.

## Le chaos sans portail développeur
Vous connaissez ce scénario.

![Le chaos sans portail développeur](/images/blog/blog-01/backstage-02.webp)

Ce n'est pas un problème de personnes. C'est un problème de **charge cognitive**.

Dans les équipes IT, personne ne peut tout savoir. Les systèmes grossissent, les équipes changent, les contextes évoluent. Sans structure, chaque information devient une chasse au trésor — et ce coût invisible s'accumule sprint après sprint, ralentissant tout le monde.

Un Internal Developer Portal (IDP) résout ce problème à la source : il centralise ce qui existe, qui en est propriétaire, et comment l'utiliser.

## Qu'est-ce que Backstage ?
[Backstage](https://backstage.io/) est un framework open source développé en interne par Spotify pour résoudre exactement ces problèmes à leur échelle — des centaines d'équipes, des milliers de services.

Ils savaient dès le départ que chaque équipe a des besoins différents. Et que les grandes entreprises en ont encore plus. C'est pourquoi ils l'ont conçu **modulaire et extensible** : un socle open source sur lequel chaque organisation construit son propre portail.

Spotify a depuis lancé une version managée ([Spotify Portal](https://backstage.spotify.com/products/portal)) pour ceux qui ne souhaitent pas opérer eux-mêmes l'infrastructure. Mais la force de Backstage reste sa capacité à s'adapter à votre contexte — et non l'inverse.

Au-delà de la modularité, Backstage est avant tout une couche d'abstraction. Les briques de la plateforme — CI/CD, secrets, provisioning cloud, observabilité — sont souvent puissantes mais difficiles à exploiter pour les équipes produit. Backstage leur offre une interface unifiée : un point d'entrée unique, sans avoir à maîtriser chaque outil sous-jacent.

Un IDP comme Backstage est la cerise sur le gâteau du platform engineering. Tout le travail d'exposition des API, de structuration des équipes, d'automatisation des workflows — Backstage lui donne une interface. Il rend visible ce qui est invisible, accessible ce qui est complexe.

## Les 3 piliers : Software Catalog, TechDocs, Scaffolder
Backstage repose sur trois briques fondamentales :

**Software Catalog** — la carte de votre système.
Chaque service, API, librairie ou pipeline est enregistré avec son propriétaire, ses dépendances et son état. Fini le « je ne sais pas qui gère ça » — la réponse est dans le catalogue, à un clic.

En pratique, cela ressemble à un fichier catalog-info.yaml à la racine de chaque repo :

```
# Cas minimal — enregistrer un service dans le catalogue
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  name: payment-service
  description: Service de paiement
spec:
  type: service
  lifecycle: production
  owner: team-payments
```

Un fichier, un commit, et votre service est visible dans le portail. Mais en pratique, on va plus loin :

```
# Cas réaliste — avec dépendances, liens et TechDocs
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  name: payment-service
  description: Gère les transactions Stripe et PayPal
  annotations:
    backstage.io/techdocs-ref: dir:.          # active TechDocs sur ce repo
    github.com/project-slug: sokube/payment-service
  tags:
    - payments
    - critical
  links:
    - url: https://grafana.internal/d/payment-dashboard
      title: Grafana Dashboard
      icon: dashboard
spec:
  type: service
  lifecycle: production
  owner: team-payments
  system: checkout-platform
  dependsOn:
    - component:order-service
    - resource:postgres-payments
  providesApis:
    - payment-api
```

Ce fichier devient la source de vérité du composant : qui en est propriétaire, de quoi il dépend, quelle API il expose, où vit sa documentation. Tout est visible dans le portail — sans réunion, sans ticket.

**TechDocs** — la documentation là où elle doit être.
La documentation vit dans le repo, au format Markdown, versionnée avec le code. Elle s'affiche directement dans Backstage. Fini les recherches interminables dans Confluence, à tomber sur une page mise à jour pour la dernière fois en 2021.

**Scaffolder** — l'accélérateur de nouveaux projets.
Des templates as-code pour générer un nouveau service en quelques minutes, avec les bonnes pratiques, les bons secrets, les bonnes configurations — déjà branchés.

Tout cela **en tant que code**. Versionné. Relisable. Auditable.

## Architecture de Backstage : frontend, backend, plugins
Backstage est une application Node.js/TypeScript composée de deux parties distinctes — souvent hébergées dans le même repo, mais rien n'empêche de les séparer :

```
packages/
  app/        # Frontend React — ce que voient vos équipes
  backend/    # API Express — orchestration, catalogue, providers
```

**Le frontend** est une application React. Il expose les plugins sous forme de pages et d'onglets. Vous pouvez le personnaliser — routing, vues, tableaux de bord — sans toucher au backend.

**Le backend** orchestre l'ensemble : il lit les fichiers catalog-info.yaml, interroge des providers externes (GitHub, GitLab, AWS, PagerDuty…), stocke les entités dans une base PostgreSQL, et sert les données aux plugins frontend via une API interne.

### Écosystème de plugins — l'extensibilité sans tout reconstruire
Chaque outil de votre stack peut devenir un onglet dans Backstage. Un plugin est un package npm en deux parties :

- **Plugin frontend** : les composants React visibles dans l'interface
- **Plugin backend** : l'API qui alimente le frontend (selon le plugin)

L'installation se résume à ajouter les packages npm et à les enregistrer dans packages/app/src/App.tsx (frontend) et packages/backend/src/index.ts (backend).

S'il manque une brique, il y a de bonnes chances qu'un plugin existe déjà. La [bibliothèque de plugins Backstage](https://backstage.io/plugins) recense plusieurs centaines de contributions communautaires — Kubernetes, Datadog, PagerDuty, GitHub Actions, Vault, ArgoCD… Votre DSI peut intégrer de nouveaux composants à Backstage sans reconstruire le portail depuis zéro. **L'extensibilité n'est pas un bonus — c'est un pilier de l'adoption en entreprise.**

### Exemple : le plugin Kubernetes
Le plugin Kubernetes permet de voir l'état des déploiements et des pods liés à un service directement dans Backstage — sans quitter le portail, sans kubectl.

```
# plugin frontend
yarn --cwd packages/app add @backstage/plugin-kubernetes

# plugin backend
yarn --cwd packages/backend add @backstage/plugin-kubernetes-backend
```

Configuration dans app-config.yaml :
```
kubernetes:
  serviceLocatorMethod:
    type: multiTenant
  clusterLocatorMethods:
    - type: config
      clusters:
        - url: https://k8s.internal
          name: production
          authProvider: serviceAccount
          serviceAccountToken: ${K8S_SERVICE_ACCOUNT_TOKEN}
          caData: ${K8S_CA_DATA}
```
Puis une annotation dans le catalog-info.yaml du service pour relier le composant à ses pods :
```
metadata:
  annotations:
    backstage.io/kubernetes-label-selector: 'app=payment-service'
```

![Plugin Kubernetes dans Backstage](/images/blog/blog-01/backstage-03.webp)

Résultat : un onglet « Kubernetes » apparaît sur la page de détail du service. Les développeurs voient l'état des pods, les déploiements récents, les erreurs — sans accès direct au cluster. La même logique s'applique à n'importe quel outil de votre stack : Datadog, ArgoCD, Vault, GitHub Actions. Chaque plugin ajoute un onglet, une vue, une intégration — sans réécrire le portail.

## Tout en tant que code : auto-découverte et cycle de vie
Quand on dit que Backstage est « as code », cela ne signifie pas seulement que « les fichiers sont dans un repo ». Cela signifie que Backstage lit vos repos pour se mettre à jour automatiquement.

### Découverte automatique
Backstage peut scanner une organisation GitHub ou GitLab entière et importer automatiquement chaque catalog-info.yaml qu'il trouve :
```
# app-config.yaml — configuration Backstage
catalog:
  providers:
    github:
      myOrg:
        organization: sokube
        catalogPath: /catalog-info.yaml   # recherche ce fichier dans chaque repo
        schedule:
          frequency: { minutes: 30 }      # rescanne toutes les 30 minutes
          timeout: { minutes: 3 }
```
Un nouveau repo créé avec un catalog-info.yaml apparaît dans le portail à la prochaine synchronisation. Aucune action manuelle. Aucun ticket disant « merci d'ajouter notre service au catalogue ».

C'est la différence fondamentale avec une CMDB ou un tableur : **la source de vérité est dans le repo**, pas dans un outil externe qu'il faut alimenter séparément.

### Cycle de vie des composants
Le champ lifecycle dans catalog-info.yaml n'est pas cosmétique. Il structure la gouvernance de votre système :

| Lifecycle    | Signification                                                    |
|--------------|-------------------------------------------------------------------|
| experimental | En développement — aucune garantie de stabilité                   |
| production   | Service actif — SLA engagé, changements cassants interdits        |
| deprecated   | À migrer — plus maintenu, date de fin de vie connue                |

```
spec:
  type: service
  lifecycle: deprecated   # visible dans le catalogue, filtrable, recherchable
  owner: team-platform
```

Les managers peuvent filtrer le catalogue par lifecycle — et identifier d'un coup d'œil ce qui est en production, ce qui est en cours de décommissionnement, ce qui est encore en évaluation. **Une gouvernance par le catalogue plutôt que par des tableurs.**

## Ce que cela change concrètement
La visibilité, d'abord. Les managers peuvent voir quels composants sont utilisés, par qui, et à quelle fréquence. Ce qui était une boîte noire devient observable.

Ensuite, la boucle de feedback. Un composant exposé dans le catalogue peut recevoir des retours directement. Le propriétaire sait si son API est utilisée, si elle pose problème, si elle répond aux besoins. Le cycle de vie d'un service devient vivant — plutôt que figé dans un wiki interne oublié.

Les chiffres parlent d'eux-mêmes : après le déploiement de Backstage, Spotify a mesuré une réduction de 55 % du temps d'onboarding des ingénieurs. Ce n'est pas un chiffre marketing — c'est le résultat direct de la documentation, de la centralisation et de l'automatisation de ce qui se transmettait auparavant de bouche à oreille.

![Ce que cela change concrètement](/images/blog/blog-01/backstage-04.webp)

## Le prérequis que tout le monde néglige : une plateforme pilotée par API
C'est le point que la plupart des équipes sous-estiment au départ : **Backstage ne fonctionne bien que si votre plateforme est exposée via API**.

Si vos outils internes — CI/CD, gestion des secrets, provisioning cloud, observabilité — ne sont pas consommables de façon programmatique, Backstage restera un beau catalogue vide. Un portail sans self-service n'est qu'une page Confluence avec un meilleur design.

Une page Confluence avec un bouton « Créer un ticket Jira » n'est pas de l'automatisation. C'est de la délégation manuelle avec une plus grande police d'écriture.

Être piloté par API n'est pas optionnel. C'est le prérequis.

Et c'est là qu'intervient **Team Topologies**.

Le framework de [Skelton & Pais](https://teamtopologies.com/) distingue quatre types d'équipes. Deux sont critiques ici :
- Les **stream-aligned teams** : elles livrent de la valeur métier. Elles ont besoin de consommer la plateforme sans friction, sans ticket.
- La **Platform team** : elle construit et maintient la plateforme interne comme un produit. Avec une API. Avec une documentation. Avec un SLA. Ses clients sont les stream-aligned teams.

Backstage est l'interface entre les deux. C'est le « golden path » que la platform team expose aux équipes produit pour qu'elles puissent se servir elles-mêmes — sans dépendre d'un humain pour chaque action.

Sans platform team structurée, sans plateforme exposée via API, Backstage amplifie le vide au lieu de le combler. **L'outil ne remplace pas l'organisation**.

## Par où commencer ?
**Commencez petit.**

L'adoption est le plus grand défi. Backstage peut bousculer les habitudes des équipes — comment elles documentent, comment elles créent des projets, comment elles découvrent les services existants.

Si vous commencez trop large, vous perdez les gens avant qu'ils ne voient la valeur.

Commencez avec une seule équipe, un seul cas d'usage concret — le Software Catalog sur un périmètre limité, par exemple. Montrez la valeur rapidement. Laissez les autres équipes venir à vous une fois convaincues.

Chaque partie prenante convertie par l'exemple est dix fois plus efficace qu'une note de direction.

## Conclusion
Trois choses à retenir :
- Un IDP réduit la charge cognitive, améliore la collaboration inter-équipes, et diminue les tickets ops liés au « je ne sais pas qui gère ça ».
- Backstage est un framework modulaire, pas un produit clé en main — il ne vaut que ce que votre platform team y investit.
- Backstage est un portail de consommation, pas une plateforme autonome. Démarrer un IDP sans plateforme pilotée par API derrière n'a pas de sens.

Et si vous pensez à l'IA : c'est précisément là que Backstage devient stratégique. Une plateforme bien structurée, avec des API claires et un portail comme Backstage, est extrêmement propice à une utilisation maîtrisée de l'IA — des agents capables de provisionner, déployer ou orchestrer en consommant les golden paths définis par votre platform team. Sans cette structure, l'IA reste un outil isolé. Avec elle, elle devient un levier de productivité à grande échelle.

![Conclusion](/images/blog/blog-01/backstage-05.webp)

# NeuroKube Website

Site web généré avec **Hugo**, versionné sur **GitLab** et déployé en production sur **GitLab Pages** ([www.neurokube.ai](https://www.neurokube.ai)). Le développement local se fait avec `hugo server` ; **Docker** fournit une image conteneur de déploiement portable.

## 📚 Sommaire

### Mise en route
- [🧰 Prérequis](#-prérequis)
- [📦 Installation](#-installation)
- [🚀 Démarrage en local (Hugo)](#-démarrage-en-local-hugo)
- [🐳 Image Docker (déploiement)](#-image-docker-déploiement)

### Déploiement
- [🚀 Production sur GitLab Pages](#-production-sur-gitlab-pages)
- [🔀 Prévisualisations par branche](#-prévisualisations-par-branche)
- [🌐 Domaine et DNS](#-domaine-et-dns)
- [🔒 Visibilité du site](#-visibilité-du-site)

### Développement
- [🔄 Mode développement](#-mode-développement)
- [🧱 Structure du projet](#-structure-du-projet)
- [🧩 Configuration des shortcodes](#-configuration-des-shortcodes)
- [🧵 Architecture CSS](#-architecture-css)
- [🎴 Système de palettes des cartes](#-système-de-palettes-des-cartes)
- [🏷️ Badges des pages Feature](#️-badges-des-pages-feature)
- [✍️ Ajouter ou modifier du contenu](#️-ajouter-ou-modifier-du-contenu)
- [🌍 Ajouter un nouveau langage](#-ajouter-un-nouveau-langage)
- [⚙️ Configuration Hugo](#️-configuration-hugo)
- [🎨 Charte graphique](#-charte-graphique)


## Mise en route

### 🧰 Prérequis

Pour le développement local :

- [Hugo extended](https://gohugo.io/installation/) ≥ 0.158 (l'image Docker utilise la 0.163.3)
- Node.js 18+ avec npm
- Git

Pour uniquement construire l'image de déploiement, **Docker** suffit : Hugo et Node.js ne sont alors pas nécessaires, tout se passe dans l'image.

### 📦 Installation

Cloner le projet :

> git clone https://gitlab.com/sokube-io/website/neurokube-site.git

Installer les dépendances Node (Tailwind / PostCSS, utilisées par Hugo pour générer le CSS) :

> cd neurokube-site/site
> npm install

### 🚀 Démarrage en local (Hugo)

Depuis le dossier `site/`, lancer le serveur de développement Hugo (live reload) :

> hugo server --port 1414

Le site est accessible sur http://localhost:1414. Toute modification (contenu, templates, assets CSS) est rechargée automatiquement — **le CSS est régénéré par Hugo Pipes lui-même** (voir "Architecture CSS"), aucun script séparé n'est nécessaire.

⚠️ **Deux pièges de cache à connaître si un changement ne semble pas pris en compte** (vécus en conditions réelles) :
- **Fast Render Mode** : par défaut, `hugo server` ne re-render que la page consultée à chaque sauvegarde, pas tout le site. Une page non rechargée depuis peut afficher un rendu obsolète. Pour un rebuild complet à chaque changement (utile en debug CSS/shortcodes) : `hugo server --disableFastRender`.
- **Cache `resources/`** : Hugo Pipes met en cache les assets transformés (dont le CSS passé par PostCSS). Ce cache est indexé sur le contenu des fichiers CSS, pas sur `tailwind.config.js` — modifier uniquement la safelist peut donc ne rien changer tant que le cache n'est pas vidé :
  ```bash
  # Arrêter le serveur (Ctrl+C), puis :
  rm -rf resources public
  hugo server -D --port 1414 --disableFastRender
  ```

### 🐳 Image Docker (déploiement)

Pour construire et tester l'image livrable (build Hugo minifié, servi par un serveur statique léger) :

> docker build -t neurokube-site .
> docker run -p 8080:8080 neurokube-site

Le site est servi sur http://localhost:8080. Tout le build Hugo se fait dans l'image, aucune dépendance locale n'est requise.

Pour un déploiement sur un autre domaine, surcharger l'URL de base :

> docker build --build-arg HUGO_BASEURL=https://exemple.com/ -t neurokube-site .

## Déploiement (GitLab Pages)

Le site de production est hébergé par **GitLab Pages** et construit automatiquement par le pipeline CI ([.gitlab-ci.yml](.gitlab-ci.yml)). L'image Docker décrite ci-dessus reste un **livrable conteneur indépendant et portable** (déploiement ailleurs : Kubernetes, Cloud Run…), **non utilisé par GitLab Pages**.

> 📘 Détail complet de la configuration (Pages, domaine, DNS OVH, certificat, visibilité, dépannage) : **[docs/deploiement.md](docs/deploiement.md)**.

### 🚀 Production sur GitLab Pages

À chaque push sur `main`, le job `pages` construit le site (`npm ci` + `hugo --minify --gc` — même logique que le stage *builder* du Dockerfile) et le publie sur GitLab Pages.

**Accéder au site avant que `www.neurokube.ai` soit configuré.** Le site est servi à l'URL GitLab Pages du projet, affichée dans **Settings → Pages** après le premier déploiement :

> https://sokube-io.gitlab.io/website/neurokube-site/

(ou un domaine unique `https://neurokube-site-XXXX.gitlab.io/` si l'option *unique domain* est active).

Le `baseURL` de production est piloté par la variable CI/CD de projet **`PROD_BASEURL`** :

- **Non définie** (par défaut) : le site est construit avec l'URL GitLab Pages réelle (`$CI_PAGES_URL`), donc **pleinement fonctionnel** (CSS, liens, images) à l'adresse `gitlab.io` ci-dessus — idéal pour valider avant le DNS.
- **Définie** à `https://www.neurokube.ai/` (une fois le DNS en place) : la production utilise le domaine canonique.

### 🔀 Prévisualisations par branche

Chaque branche peut être déployée sur sa propre URL via les *parallel deployments* GitLab (`path_prefix`) :

> https://sokube-io.gitlab.io/website/neurokube-site/&lt;branche&gt;/

Cette fonctionnalité nécessite **GitLab Premium/Ultimate** (GA en 17.9). Elle est donc **désactivée par défaut** et s'active sans modifier le pipeline : créer la variable CI/CD de projet `PAGES_PREVIEW = true` (Settings → CI/CD → Variables). En attendant, prévisualiser une branche en local avec `hugo server --port 1414`.

### 🌐 Domaine et DNS

`www.neurokube.ai` est le domaine canonique ; l'apex `neurokube.ai` redirige (301) vers `www`. Côté OVH (zone DNS de `neurokube.ai`) :

| Enregistrement | Type | Valeur |
| --- | --- | --- |
| `www` | CNAME | `sokube-io.gitlab.io.` (valeur exacte affichée par GitLab) |
| `_gitlab-pages-verification-code.www` | TXT | `gitlab-pages-verification-code=<code GitLab>` |
| `neurokube.ai` (apex) | Redirection web 301 | `https://www.neurokube.ai/` |

Ajouter le domaine dans **Settings → Pages**, valider via l'enregistrement TXT, puis activer HTTPS (certificat Let's Encrypt automatique). Enfin, définir la variable CI/CD `PROD_BASEURL = https://www.neurokube.ai/` et relancer le pipeline `main` pour basculer la production sur le domaine canonique.

### 🔒 Visibilité du site

L'accès au site publié se règle dans **Settings → General → Visibility, project features, permissions → Pages** :

- **Only project members** : site privé, visible des seuls membres connectés du projet (utile avant le lancement public).
- **Everyone** : site public.

Réglage indépendant du pipeline, modifiable à tout moment (effet en moins d'une minute).

## Développent

### 🔄 Mode développement

Le projet est configuré pour fonctionner avec Hugo en mode live reload.

Toute modification des fichiers du site (contenu, templates, assets) est automatiquement prise en compte et le navigateur se rafraîchit.

### 🧱 Structure du projet

```
neurokube-site/
├── site
│   ├── assets/         # Sources CSS (voir "Architecture CSS")
│   │   └── css/
│   │       ├── neurokube-overrides.css   # Composants NeuroKube (cards, boutons...)
│   │       ├── custom.css                # Correctifs dark: sur le thème (passe PostCSS isolée)
│   │       └── company.css               # Orphelin, non chargé (voir note dans "Architecture CSS")
│   ├── content/        # Pages du site (Markdown)
│   │   └── en-us       # Pages en anglais
│   │   │   └── features    # Pages en anglais listant les features de NeuroKube
│   │   └── fr-ch       # Pages en français
│   │       └── features    # Pages en français listant les features de NeuroKube
│   ├── i18n/           # Traduction des mot-clefs du template
│   ├── layouts/        # Templates Hugo
│   └── static/         # Fichiers statiques
│   │   ├── css         # CSS compilé (généré par Hugo Pipes, ne pas éditer à la main)
│   │   └── images      # Images statiques
│   ├── themes/         # Thème Hugo hugo-saasify-theme — NE JAMAIS MODIFIER SON CONTENU
│   ├── hugo.toml       # Configuration du site web Hugo
│   ├── package.json
│   ├── postcss.config.js
│   └── tailwind.config.js
├── docs/               # Images de la documentation (non publiées sur le site)
├── scripts/            # Scripts utilitaires (ex : optimize-images.sh)
├── .dockerignore
├── .gitignore
├── Dockerfile
└── README.md
```

### 🧩 Configuration des shortcodes

Tous les shortcodes customisés pour le site web sont disponibles dans le répertoire :

> /site/layouts/. 

Le thème **hugo-saasify-theme** met à disposition plein d'autres styles, qui sont stockés dans le répertoire :

> /site/themes/hugo-saasify-theme/layouts/

#### 📄 Shortcodes de mise en page

##### Header

Le shortcode **Header** se trouve dans le répertoire :
>/site/layouts/partials

La configuration du style de ce shortcode n'a pas complètement été externalisée. Une partie se trouve directement décrite dans le fichier **header.html**, et l'autre dans le fichier **hugo.toml**.
Si vous changez des couleurs de ce shortcode, veillez à bien utiliser les couleurs autorisées dans le fichier suivant:
> /site/tailwond.config-js

Voici les variables du fichier **hugo.toml** impactant le style de ce shortcode:

```
  # Header Configuration
  [params.header]
    # Header background and border styles (optional)
    background = "bg-neurokube-900"
    border = "border-neurokube-900"
    
    # Logo configuration
    [params.header.logo]
      src = "/images/logo_fond-sombre.svg"
      textClass = "text-neurokube-100"
    
    # Menu configuration
    [params.header.menu]
      spacing = "space-x-8"
      linkClass = "text-base text-neurokube-100 hover:text-neurokube-200 font-bold transition duration-200"
      
      # Dropdown menu configuration
      [params.header.menu.dropdown]
        width = "w-72"
        container_padding = "py-6"
        item_padding = "px-8 py-3"
        background = "bg-white"
        border = "border border-gray-100"
        shadow = "shadow-xl"
        radius = "rounded-lg"
        text_color = "text-gray-700"
        hover_background = "hover:bg-gray-50"
        text_size = "text-sm"
    
      # Button configuration
      [params.header.buttons]
      # Sign In button
      [params.header.buttons.signIn]
        text = "Sign in"
        url = "/signin"
      
      # Get Started button
      [params.header.buttons.getStarted]
        text = "Get Started"
        url = "/get-started"
```

Veuillez noter que pour le moment le site n'utilise pas les deux boutons du menu **Sign in** et **Get started**.

Le menu du shortcode **Header** est défini dans le fichier suivant:
> /site/hugo.toml

Vous trouverez les variables permettant de définir le contenu de ce menu dans la partie **multilinguisme** du fichier **hugo.toml**. Vous aurez donc plusieurs informations similaires à saisir, à chaque langue proposée.

Voici les variables du fichier **hugo.toml** impactant le menu de ce shortcode :

```
# French language
  [languages.fr]
      ...
      [[languages.fr.menu.main]]
        name = "Intitulé du 1er titre"
        url = "Lien du 1er titre"
        weight = 1
        [languages.fr.menu.main.params]
          has_submenu = true/false
          submenu = [
            { name = "Nom du 1er sous-menu", url = "Lien du 1er sous-menu" },
            { name = "Nom du 2ème sous-menu", url = "Lien du 2ème sous-menu" },
            ...
          ]

      [[languages.fr.menu.main]]
        name = "Intitulé du 2ème titre"
        url = "Lien du 2ème titre"
        weight = 2
      
      ...
```

###### Mega-menu (dropdown groupé par thèmes)

Pour un dropdown avec de nombreuses entrées (typiquement "Capabilities"/"Capacités"), le simple `submenu` en liste plate devient vite illisible. Un second mode existe, activé par `megamenu = true` en plus de `has_submenu = true` : au lieu de `submenu`, on définit `groups`, une liste de thèmes, chacun avec son propre titre cliquable et ses `items` :

```
[menu.main.params]
  has_submenu = true
  megamenu = true
  groups = [
    { name = "Nom du thème 1", url = "/lien-vers-la-page-du-thème/", items = [
        { name = "Sous-page 1", url = "/lien-1/" },
        { name = "Sous-page 2", url = "/lien-2/", badge = "Nouveau" }
    ] },
    { name = "Nom du thème 2", url = "/lien-vers-la-page-du-thème-2/", items = [
        { name = "Sous-page 3", url = "/lien-3/" }
    ] }
  ]
```

Important, contrainte TOML : **chaque `{ ... }` doit rester sur une seule ligne physique** (les tables inline TOML n'acceptent pas de retour à la ligne en leur sein), même si la ligne est longue — seul le tableau englobant (`groups = [ ... ]`) peut s'étaler sur plusieurs lignes.

Le champ `badge` est optionnel, sur n'importe quel item (ex. `badge = "Nouveau"`) — s'affiche comme un petit badge à côté du libellé, en réutilisant les couleurs `bg-neurokube-100`/`text-neurokube-600` déjà safelistées, donc aucune classe supplémentaire à ajouter à `tailwind.config.js`.

Le rendu répartit automatiquement les thèmes en 2 colonnes (les premiers `ceil(n/2)` thèmes dans la colonne de gauche, le reste à droite), sur le modèle du mega-menu de [skello.io](https://www.skello.io/ch). Sans `megamenu` (ou avec `megamenu = false`), le dropdown reste la liste plate simple d'origine (comportement inchangé, ex. "About NeuroKube"/"À propos de NeuroKube").

##### Footer

Le shortcode **Footer** se trouve dans le répertoire :
>/site/layouts/partials

La configuration du style de ce shortcode n'a pas complètement été externalisée. Une partie se trouve directement décrite dans le fichier **footer.html**, et l'autre dans le fichier **hugo.toml**.
Si vous changez des couleurs de ce shortcode, veillez à bien utiliser les couleurs autorisées dans le fichier suivant:
> /site/tailwond.config-js

Le contenu du shortcode **footer** est par contre complètement défini dans le fichier suivant:
> /site/hugo.toml

Voici les variables du fichier **hugo.toml** impactant le style de ce shortcode:

```
  # Footer Configuration
  [params.footer]
    # Column names
    column_1_title = "Features"
    column_2_title = "SoKube"
    column_3_title = "Legal"

    [params.footer.logo]
    # Logo configuration
      src = "/images/logo_fond-clair.svg"
    
    [params.footer.style]
      background = "bg-neurokube-200"
      border = "border-neurokube-50"
      title = "text-neurokube-900"
      text = "text-neurokube-900"
      link = "text-neurokube-800 hover:text-neurokube-600"
      social = "text-neurokube-400 hover:text-neurokube-600"
      copyright = "text-neurokube-900"
      designer = "text-neurokube-900 hover:text-neurokube-600"
```

Le menu du shortcode **Footer** est défini dans le fichier suivant:
> /site/hugo.toml

Vous trouverez les variables permettant de définir le contenu de ce menu dans la partie **multilinguisme** du fichier **hugo.toml**. Vous aurez donc plusieurs informations similaires à saisir, à chaque langue proposée.

Voici les variables du fichier **hugo.toml** impactant le menu de ce shortcode :

```
# French language
  [languages.fr]
      ...
      [[languages.fr.menu.footer_column_1]]
        name = "Intitulé du 1er sous-titre de la 1ère colonne"
        url = "Lien destination du 1er sous-titre"
        weight = 1
      [[languages.fr.menu.footer_column_1]]
        name = "Intitulé du 2ème sous-titre de la 1ère colonne"
        url = "Lien destination du 2ème sous-titre"
        weight = 2
      [[languages.fr.menu.footer_column_1]]
        name = "Intitulé du 3ème sous-titre de la 1ère colonne"
        url = "Lien destination du 3ème sous-titre"
        weight = 3
      
      [[languages.fr.menu.footer_column_2]]
        name = "Intitulé du 1er sous-titre de la 2ème colonne"
        url = "Lien destination du 1er sous-titre"
        weight = 1
      ...
```

### 🧵 Architecture CSS

Le CSS **n'est pas** construit par un script `tailwindcss` séparé — c'est un mécanisme envisagé puis abandonné en cours de projet (`package.json` peut encore contenir un script `start`/`build` appelant `tailwindcss` en CLI, mais il n'est **plus utilisé** : à supprimer si présent). Le vrai pipeline est **Hugo Pipes**, câblé directement dans `site/layouts/_default/baseof.html` :

```go-html-template
{{ $themeCSS := resources.Get "css/main.css" }}
{{ $overridesCSS := resources.Get "css/neurokube-overrides.css" }}
{{ $css := slice $themeCSS $overridesCSS | resources.Concat "css/bundle.css" }}
{{ $css = $css | css.PostCSS }}
<link rel="stylesheet" href="{{ $css.RelPermalink }}">

{{ with resources.Get "css/custom.css" }}
    {{ $customCSS := . | css.PostCSS }}
    <link rel="stylesheet" href="{{ $customCSS.RelPermalink }}">
{{ end }}
```

Rôle de chaque fichier dans `site/assets/css/` :

| Fichier | Rôle | Passe PostCSS |
|---|---|---|
| `themes/hugo-saasify-theme/assets/css/main.css` | CSS du thème — **strictement intouché**, jamais édité directement | 1ère passe, concaténé avec `neurokube-overrides.css` avant traitement |
| `neurokube-overrides.css` | Composants propres à NeuroKube (`.card-neurokube`, `.btn-neurokube`, `.card`...) | Même passe que le thème → `@layer`/`@apply` pleinement fonctionnels |
| `custom.css` | Correctifs `.dark` sur des éléments du **thème** dépourvus de variante `dark:` native (titres, `body`, `.prose`) | Passe **isolée** (`resources.Get "css/custom.css" \| css.PostCSS`), sans directive `@tailwind` → pas de `@layer`/`@apply`, uniquement CSS classique + `theme()` |
| `company.css` | Typographie prévue pour du Markdown brut sur la page About (`layout: "company"`) | **Non chargé actuellement** (orphelin assumé) — contient une duplication de règles non corrigée ; à corriger et raccorder dans `company.html` le jour où du Markdown brut hors shortcode y sera ajouté |

**Pourquoi `neurokube-overrides.css` et `custom.css` restent séparés** : deux passes PostCSS différentes. Les fusionner ferait perdre le contexte Tailwind complet pour l'un, ou obligerait à injecter des classes `dark:` dans les templates du thème — ce qu'on s'interdit.

**Trois pièges récurrents, tous rencontrés en pratique sur ce projet :**

1. **Safelist obligatoire pour toute classe référencée uniquement depuis `hugo.toml`** (jamais littéralement dans un `.html`/`.md` scanné) : sans ça, Tailwind ne la génère jamais, silencieusement. Concerne notamment `bg-gradient-to-br` (la classe qui déclare la règle de dégradé elle-même — sans elle, aucun dégradé ne s'affiche, quelle que soit la palette ou le mode), les couleurs de fin de dégradé (`to-<palette>-50`), les couleurs de texte (`dark:text-gray-300`) et les puces (`marker:text-<palette>-*`).
2. **Une règle CSS qui cible directement un élément enfant gagne toujours sur la couleur héritée d'un parent**, quelle que soit la spécificité de ce dernier. Ne jamais fixer de couleur sur `p`/`li`/etc. à l'intérieur d'un composant dont la couleur doit varier dynamiquement (palette, mode sombre) — laisser hériter du conteneur.
3. **À spécificité CSS égale, c'est l'ordre de chargement des `<link>` qui tranche entre deux feuilles de style différentes** (pas seulement l'ordre interne à un fichier). `custom.css` étant chargé après le bundle principal, toute règle `.dark .xxx` y est prioritaire — à réserver aux composants du thème sans alternative dynamique, jamais à un composant qui gère déjà sa propre logique de palette (ex. ne pas y remettre de règle sur `.card-label`, propre à `neurokube-card`).

### 🎴 Système de palettes des cartes

Le shortcode `neurokube-card` accepte un paramètre `palette` (`neurokube` par défaut, `kube`, `hr`). Toute la couleur (fond, bordure, hover, label, titre, texte, puces) est centralisée dans `hugo.toml` sous `[params.cards.<palette>]`, variantes `dark:` incluses :

```toml
[params.cards]
  grid_gap = "gap-8"

  [params.cards.default]
    background = "bg-gradient-to-br from-neurokube-100 to-neurokube-50 dark:from-neurokube-900 dark:to-neurokube-800"
    border = "border-neurokube-300 dark:border-neurokube-400"
    hover_border = "hover:border-neurokube-600 dark:hover:border-neurokube-400"
    label = "text-neurokube-600 dark:text-neurokube-300"
    title = "text-neurokube-900 dark:text-white"
    text = "text-gray-700 dark:text-gray-300"
    marker = "marker:text-neurokube-600 dark:marker:text-neurokube-300"

  [params.cards.kube]
    background = "bg-gradient-to-br from-kube-100 to-kube-50 dark:from-kube-900 dark:to-kube-800"
    border = "border-kube-300 dark:border-kube-400"
    hover_border = "hover:border-kube-600 dark:hover:border-kube-400"
    label = "text-kube-600 dark:text-kube-300"
    title = "text-kube-900 dark:text-white"
    text = "text-gray-700 dark:text-gray-300"
    marker = "marker:text-kube-600 dark:marker:text-kube-300"

  [params.cards.hr]
    background = "bg-gradient-to-br from-hr-100 to-hr-50 dark:from-hr-900 dark:to-hr-800"
    border = "border-hr-300 dark:border-hr-400"
    hover_border = "hover:border-hr-600 dark:hover:border-hr-400"
    label = "text-hr-600 dark:text-hr-300"
    title = "text-hr-900 dark:text-white"
    text = "text-gray-700 dark:text-gray-300"
    marker = "marker:text-hr-600 dark:marker:text-hr-300"
```

Usage dans le Markdown :
```
{{< neurokube-card label="Problème" title="..." palette="kube" >}}
Contenu...
{{< /neurokube-card >}}
```

Sans `palette`, la carte utilise `[params.cards.default]`. **Aucune couleur ne doit être codée en dur dans `neurokube-overrides.css` pour `.card-neurokube`** — uniquement de la structure (padding, arrondi, transition) : toute couleur y compris code en dur y a recréé un bug d'affichage figé, indépendant de la palette demandée.

### 🏷️ Badges des pages Feature

Les pages `layout: "feature"` (`site/layouts/_default/feature.html`) utilisent désormais les **mêmes classes Tailwind fixes** que le shortcode `neurokube-feature` de la page d'accueil, plutôt qu'un ancien mécanisme `badgeColor` (hex) + `color-mix()` CSS qui faisait varier la teinte du badge de façon incontrôlée entre mode clair et sombre :

```yaml
# Front matter de chaque page Feature
badgeColor: "#197FE3"        # conservé uniquement pour le dégradé décoratif du hero
badgeBgColor: "bg-neurokube-100"
badgeTextColor: "text-neurokube-600"
```

Correspondance hex → classes (mêmes couleurs de marque que le reste du site) :

| `badgeColor` | `badgeBgColor` | `badgeTextColor` |
|---|---|---|
| `#197FE3` (neurokube) | `bg-neurokube-100` | `text-neurokube-600` |
| `#E6007E` (kube) | `bg-kube-100` | `text-kube-600` |
| `#76B82A` (hr) | `bg-hr-100` | `text-hr-600` |

#### 🃏 Cartes

Le shortcode **card** se trouve dans le répertoire :
> /site/layouts/shortcodes/

Il nécessite l'utilisation de plusieurs shortcodes parents :
- neurokube-cards-section : le chapeau, permettant d'afficher un titre, une description global et de définir un style particulier à toutes les cartes
- neurokube-card-grid : le sous-chapeau, permettant de définir le nombre de cartes que l'on veut voir afficher par ligne
- neurokube-card : le shortcode en question, dont le style dépend du système de palettes décrit ci-dessus (section "🎴 Système de palettes des cartes")

![Card Shortcode](/docs/images/readme/neurokube-cards.png "Card Shortcode")

##### Configurer son contenu

Vous devez insérer le code suivant pour ajouter le composant **neurokube-cards-section** dans une page :

```
{{< neurokube-cards-section
    id="nom servant de lien"
    title="Titre de la section"
    description="Description de la section"
>}}
...
{{< /neurokube-cards-section >}}
```

Vous devez insérer le code suivant pour ajouter le composant **neurokube-card-grid** dans une page :

```
{{< neurokube-card-grid cols="Nombre de colonnes souhaitées" >}}
...
{{< /neurokube-card-grid >}}
```

Vous devez insérer le code suivant autant de fois que vous le souhaitez pour ajouter les composants **neurokube-card** dans une page :

```
{{< neurokube-card
label="Libellé court"
title="Titre de la carte"
palette="neurokube | kube | hr (optionnel, neurokube par défaut)"
>}}
Ajoutez le contenu de la carte en HTML ou en MD
{{< /neurokube-card >}}
```

#### 🎯 Hero

Le shortcode **Hero** se trouve dans le répertoire :
> /site/layouts/shortcodes/

Il est composé d'une image, d'un titre accrocheur, d'une rapide description et de deux boutons incitant à la mise en action.

![Hero Shortcode](/docs/images/readme/neurokube-hero.png "Hero Shortcode")

##### Configurer son style

Pour une question d'homogénéité dans le site Web, toute la configuration du style du composant **Hero** est centralisée dans le fichier /site/hugo.toml. Si vous utilisez plusieurs shortcodes Hero dans le site, vous aurez donc exactement le même look&feel.

Voici les variables impactant le style du shortcode Hero:

```
# Global Hero Configuration
[params.hero]
  background = "bg-gradient-to-b from-neurokube-100 to-neurokube-50"

  [params.hero.style]
    title = "text-neurokube-900"
    description = "text-gray-600"

    decoration_1 = "bg-neurokube-100"
    decoration_2 = "bg-neurokube-200"

  [params.hero.primary_button]
    background = "bg-neurokube-600"
    text_color = "text-white"
    hover_background = "hover:bg-neurokube-700"

  [params.hero.secondary_button]
    background = "bg-white"
    text_color = "text-neurokube-600"
    hover_background = "hover:bg-neurokube-100"
    border_color = "border-neurokube-600"
```

##### Configurer son contenu

Vous devez insérer le code suivant pour ajouter le shortcode **hero** dans une page contenu:

```
{{< neurokube-hero
    headline="Votre titre accrocheur"
    sub_headline="Votre rapide description"
    primary_button_text="Intitulé du premier bouton"
    primary_button_url="Lien destination du bouton"
    secondary_button_text="Intitulé du second bouton"
    secondary_button_url="Lien destination du bouton"
    hero_image="Lieu de stockage de votre image"
>}}
```

#### 📣 Call To Action (CTA)

Le shortcode **CTA** se trouve dans le répertoire :
> /site/layouts/shortcodes/

Le shorcode **CTA** est composé d'un titre accrocheur, d'une rapide description et de deux boutons incitant à la mise en action.

![CTA Shortcode](/docs/images/readme/neurokube-cta.png "CTA Shortcode")

##### Configurer son style

Pour une question d'homogénéité dans le site Web, toutes les configurations de style et de contenu du composant **CTA** sont centralisées dans le fichier /site/hugo.toml. Si vous utilisez plusieurs shortcodes **CTA** dans le site, vous aurez donc exactement le même look&feel et le même contenu.

Voici les variables du shortcode **CTA**:

```
# Global CTA Configuration
[params.cta]
  enable = true

  [params.cta.style]
    background = "bg-neurokube-600"
    title = "text-white"
    description = "text-neurokube-100"

  [params.cta.primary_button]
    class = "bg-white text-neurokube-600 hover:bg-neurokube-200"

  [params.cta.secondary_button]
    class = "border-white text-white hover:bg-neurokube-800"
```

Vous devez déclarer le code suivant pour ajouter le shortcode **CTA** dans une page contenu:

```
{{< neurokube-cta >}}
```

#### 📝 Formulaires

Les formulaires sont composés de trois shortcodes contenus dans le répertoire :
> /site/layouts/shortcodes/

- neurokube-form-field
- neurokube-form-textarea
- neurokube-form-form

Ainsi un formulaire **Form** est composé de champs **field** et/ou de champs **textarea** et d'un bouton validant le formulaire.

![Form Shortcode](/docs/images/readme/neurokube-form.png "Form Shortcode")

##### Configurer son style

Pour une question d'homogénéité dans le site Web, toute la configuration du style du composant **Form** est centralisée dans le fichier /site/hugo.toml. Si vous utilisez plusieurs shortcodes Hero dans le site, vous aurez donc exactement le même look&feel.

Voilà les variables impactant le style du shortcode **Form**:

```
# Forms Configuration
[params.forms]

  [params.forms.style]
    container = "max-w-3xl mx-auto"
    input = "w-full rounded-xl border border-gray-300 px-4 py-3"
    label = "block text-sm font-medium mb-2 text-gray-700"
    button = "btn btn-primary w-full"
```

##### Configurer son contenu

Vous devez insérer le code suivant pour ajouter le shortcode **form** dans une page contenu, le nombre de shortcodes **field** et **textarea** insérés étant libre:

```
{{< neurokube-form
action="Lien destination du bouton"
buttonText="Intitulé du bouton"
>}}

    {{< neurokube-form-field
        label="Intitulé du champ"
        name="Nom du champ"
        required="true/false"
    >}}

    {{< neurokube-form-field
        label="Intitulé du champ"
        name="Nom du champ"
        type="email"
        required="true/false"
    >}}

    {{< neurokube-form-textarea
        label="Intitulé du champ"
        name="Nom du champ"
        placeholder="Phrase inscrite dans la zon de texte en attendant la saisie de l'utilisateur"
    >}}

{{< /neurokube-form >}}
```

##### Envoi des soumissions par email (Formspree)

Le site étant statique, l'envoi d'email à la soumission passe par **Formspree** (`action="https://formspree.io/f/XXXXXXXX"`), pas par du code côté serveur.

- **Destination de l'email** : se configure côté compte Formspree (dashboard), pas dans le code. `XXXXXXXX` doit être remplacé par l'identifiant du formulaire réellement créé et rattaché à l'adresse voulue (ex. `neurokube@sokube.ch`).
- **Objet de l'email = libellé du bouton** : le shortcode `neurokube-form.html` injecte automatiquement un champ caché `_subject` avec la valeur de `buttonText` — reconnu nativement par Formspree, aucune configuration supplémentaire requise.
- **Corps de l'email** : généré automatiquement par Formspree à partir de tous les champs nommés du formulaire (`name`, `email`, `phone`, `company`, `message`...). Rien à coder.
- **Adresse de réponse (reply-to)** : Formspree utilise automatiquement le champ nommé exactement `email` s'il est présent — déjà le cas dans ce formulaire.

#### 💰 Tarification

Le shortcode **neurokube-pricing-table** se trouve dans le répertoire :
> /site/layouts/shortcodes/

Ce shortocde est complexe et comprend un titre, une description et une liste de plans affichés sous forme de cartes.
Chacun des plans le composant contient:
- Un nom
- Un tarif
- Une description courte
- Une liste courte de fonctionnalités ou capacités
- Un bouton
- Un badge si l'option **Featered* est activé pour le plan

![Pricing table Shortcode](/docs/images/readme/neurokube-pricing-table.png "Pricing table Shortcode")

##### Configurer son style

Pour une question d'homogénéité dans le site Web, **presque** toute la configuration du style du composant **Form** est centralisée dans le fichier /site/hugo.toml. SEule la configuration du style des boutons de chacun des plans est restée pour le moment dans le shortcode lui-même. Si vous utilisez plusieurs shortcodes Hero dans le site, vous aurez donc exactement le même look&feel.

Donc, pour le style du bouton de chacun des plans, vous devez saisir les jeux de couleurs adéquats, parmi la liste des couleurs autorisées dans le fichier :
> /site/tailwing.config.js.

Voilà les variables impactant le style du shortcode **neurokube-pricing-table** dans le fichier :
> /site/hugo.toml

```
# Pricing Configuration
[params.pricing]
  currency = "CHF"

  [params.pricing.style]
    card_background = "bg-white"
    card_border = "border-neurokube-300"
    featured_border = "border-neurokube-600"
    featured_shadow = "shadow-xl"
    badge_background = "bg-neurokube-100"
    badge_text = "text-neurokube-600"
    icon_color = "text-neurokube-600"
    title_color = "text-gray-900"
    description_color = "text-gray-500"
    price_color = "text-gray-900"
    button_class = "btn-primary"
```

##### Configurer son contenu

Vous devez insérer le code ci-dessous pour ajouter le shortcode **pricing-table** dans une page de contenu. Bien que le nombre de plans insérés soit libre, il n'est pas conseillé d'en mettre plus de quatre.

```
{{< neurokube-pricing-table >}}
{
    "title": "Titre du shortcode",
    "description": "Description du shortcode",
    "plans": [
        {
            "name": "Nom du plan",
            "price": "Tarif du plan",
            "description": "Description courte du plan",
            "features": [ 
                "Nombre de clusters Kubernetes : 1",
                "Taille de l'équipe : 10",
                "Agent de troubleshooting",
                "Alertes et rapports",
                "Support client par e-mail",
                "Intégration dans votre environnement existant incluse"
            ],
            "button": {
                "text": "Intitulé du bouton",
                "url": "Lien destination du bouton",
                "style": {
                    "bg": "couleur de fond du bouton",
                    "text": "Couleur du texte du bouton",
                    "border": "Couleur de la bordure du bouton",
                    "hoverBg": "Couleur de fond du bouton lorsque l'utilisateur passe la souris au-dessus",
                    "hoverText": "Couleur du texte du bouton lorsque l'utilisateur passe la souris au-dessus"
                }
            }
        },
        {
            "name": "Nom du plan",
            "price": "Tarif du plan",
            "description": "Description courte du plan",
            "featured": true/false,
            "badge": {
                "label": "Intitulé du badge",
                "background": "Couleur de fond du badge",
                "text": "Couleur du texte du badge"
            },
            "features": [
                "Nombre de clusters Kubernetes : 5",
                "Taille de l'équipe : 50 développeurs",
                "Agent GitOps et pull requests automatiques",
                "Rapports d'activité trimestriels",
                "Support client prioritaire",
                "Intégration dans votre environnement existant incluse"
            ],
            "button": {
                "text": "Intitulé du bouton",
                "url": "Lien destination du bouton",
                "style": {
                    "bg": "couleur de fond du bouton",
                    "text": "Couleur du texte du bouton",
                    "border": "Couleur de la bordure du bouton",
                    "hoverBg": "Couleur de fond du bouton lorsque l'utilisateur passe la souris au-dessus",
                    "hoverText": "Couleur du texte du bouton lorsque l'utilisateur passe la souris au-dessus"
                }
            }
        }
    ]
}
{{< /neurokube-pricing-table >}}
```

#### ❓ FAQ
#### 🧭 Navigation et menus

### ✍️ Ajouter ou modifier du contenu

Les pages sont écrites en Markdown dans le dossier :

> /site/content/

Dans ce répertoire on différencie les pages pour chaque langue, à savoir :
* pour les pages en anglais
> /site/content/en-us/
* pour les pages en français
> /site/content/fr-ch/

### 🌍 Ajouter un nouveau langage

Voici les étapes à réaliser pour ajouter un nouveau langage :

1. Créer un nouveau répertoire pour y stocker toutes les pages traduites dans cette langue
> ex: /site/content/de-de/ 

2. Dupliquer et renommer le fichier /site/i18n/en.toml pour ensuite traduire les mots clés contenus dans ce fichier dans la langue souhaitée

3. Traduire le menu (header et footer) et faire pointer les liens vers les nouvelles pages traduites en ajoutant et adaptant les informations ci-dessous dans la rubrique [languages] du fichier /site/hugo.toml

```
# French language
  [languages.fr]
    languageCode = "fr-ch"
    languageName = "Français"
    title = "NeuroKube"
    weight = 2
    contentDir = "content/fr-ch"

    # French language for Hero
    [languages.fr.params.hero.primary_button]
      text = "Demander une démonstration"
      url = "/demo"

    [languages.fr.params.hero.secondary_button]
      text = "En savoir plus"
      url = "/about"
    
    # French language for CTA
    [languages.fr.params.cta]
      title = "Prêt à libérer le plein potentiel de votre équipe DevOps ?"
      description = "Rejoignez les entreprises qui utilisent déjà NeuroKube pour réduire la charge cognitive de leurs équipes DevOps."

    [languages.fr.params.cta.primary_button]
      text = "Découvrir les offres"
      url = "/pricing"
      class = "bg-white text-neurokube-600 hover:bg-neurokube-200"

    [languages.fr.params.cta.secondary_button]
      text = "Demander une démonstration"
      url = "/demo"
      class = "border-white text-white hover:bg-neurokube-800"

    # French language for footer's columns
    [languages.fr.params.footer]
      column_1_title = "FONCTIONNALITÉS"
      column_2_title = "SOKUBE"
      column_3_title = "LÉGAL"

    # French language for header
    [[languages.fr.menu.main]]
      name = "Fonctionnalités"
      url = "/fr/features"
      weight = 1
      [languages.fr.menu.main.params]
        has_submenu = true
        submenu = [
          { name = "Investigation d'incidents assistée par l'IA", url = "/fr/features/ai-powered-incident-investigation/" },
          { name = "Intelligence plateforme multi-contextes", url = "/fr/features/multi-context-platform-intelligence/" },
          { name = "Assistance à l'analyse des causes racines", url = "/fr/features/root-cause-analysis-assistance/" },
          { name = "Remédiation assistée par l'IA", url = "/fr/features/ai-assisted-remediation/" },
          { name = "Apprentissage opérationnel continu", url = "/fr/features/continuous-operational-learning/" },
          { name = "Gouvernance avec l'humain au cœur du processus", url = "/fr/features/human-in-the-loop-governance/" }
        ]

      [[languages.fr.menu.main]]
        name = "Tarifs"
        url = "/fr/pricing"
        weight = 2
      
      [[languages.fr.menu.main]]
        name = "Blog"
        url = "https://www.sokube.io/blog"
        weight = 3
        [languages.fr.menu.main.params]
          external = true

      [[languages.fr.menu.main]]
        name = "A propos de NeuroKube"
        url = "/fr/about"
        weight = 4
        [languages.fr.menu.main.params]
          has_submenu = true
          submenu = [
            { name = "Notre mission", url = "/fr/about/#mission" },
            { name = "Ce qui distingue NeuroKube", url = "/fr/about/#ce-qui-distingue-neurokube" },
            { name = "Né d'un problème opérationnel récurrent", url = "/fr/about/#ne-d-un-problem-operationnel-recurrent" },
            { name = "Intelligence organisationnelle", url = "/fr/about/#intelligence-organisationnelle" }
          ]

      # French language for footer's links
      [[languages.fr.menu.footer_column_1]]
        name = "Investigation d'incidents"
        url = "/fr/features/ai-powered-incident-investigation/"
        weight = 1
      [[languages.fr.menu.footer_column_1]]
        name = "Analyse des causes racines"
        url = "/fr/features/root-cause-analysis-assistance/"
        weight = 2
      [[languages.fr.menu.footer_column_1]]
        name = "Remédiation"
        url = "/fr/features/ai-assisted-remediation/"
        weight = 3
      
      [[languages.fr.menu.footer_column_2]]
        name = "Mission"
        url = "/fr/about/#mission"
        weight = 1
      [[languages.fr.menu.footer_column_2]]
        name = "Analyse des causes racines"
        url = "/fr/demo"
        weight = 2
      [[languages.fr.menu.footer_column_2]]
        name = "Blog"
        url = "https://www.sokube.io/blog"
        weight = 3

      [[languages.fr.menu.footer_column_3]]
        name = "CGU"
        url = "/fr/cgu"
        weight = 1
      [[languages.fr.menu.footer_column_3]]
        name = "Politique en matière de cookies"
        url = "/fr/cookies"
        weight = 2
      [[languages.fr.menu.footer_column_3]]
        name = "Politique de confidentialité des données"
        url = "/fr/privacy"
        weight = 3
```

### ⚙️ Configuration Hugo

Le fichier principal de configuration se trouve ici:

> /site/hugo.toml

Dans ce fichier vous trouvez la configuration des éléments suivants : 
- La configuration générale du site web Hugo
- La configuration du header contenant le menu de navigation
- La configuration du footer 
- La configuration multilingue
- La configuration des éléments transverses au site:
  - Le **Hero**
  - Le **CTA**
  - Les **Cards**
  - Les **Forms**
  - Le **Pricing**

### 🎨 Charte graphique

L'ensemble des éléments de la charte graphique est centralisé dans le fichier :

> /tailwind.config.js

Ce fichier contient notamment :
- Un nuancier de couleurs formé à partir des couleurs principales de la charte graphique
- La famille de police de la charte, à savoir Montserrat sans-serif
- Une liste de couleurs autorisées utilisant les codes couleur du nuancier

| Nom Tailwind | Usage | Couleur |
|--------------|--------|----------|
| `bg-white` | Background | `#ffffff` |
| `bg-neurokube-50` | Background | `#f7faff` |
| `bg_neurokube-100` | Background | `#eaf1fb` |
| `bg_neurokube-200` | Background | `#98B1DD` |
| ... | ... | ... |
| `bg-neurokube-900` | Background | `#000040` |
| `bg-kube-600` | Background Kube | `#E6007E` |
| ... | ... | ... |
| `bg-hr-600` | Background Human Ressources | `#76B82A` |
| ... | ... | ... |
| `bg-neurokube-50/80` | Background avec transparence | `#f7faff` avec transparence 80% |
| `bg-neurokube-100/80` | Background avec transparence | `#eaf1fb` avec transparence 80% |
| `bg-neurokube-100-90` | Background avec transparence | `#eaf1fb` avec transparence 90% |
| ... | ... | ... |
| `bg-neurokube-900/90` | Background avec transparence | `#000040` avec transparence 90% |
| `border-white` | Border | `#ffffff` |
| `border-neurokube-50` | Border | `#f7faff` |
| `border-neurokube-100` | Border | `#eaf1fb` |
| `border-neurokube-200` | Border | `#98B1DD` |
| ... | ... | ... |
| `border-neurokube-900` | Border | `#000040` |
| `text-white` | Text | `#ffffff` |
| `text-neurokube-50` | Text | `#f7faff` |
| `text-neurokube-100` | Text | `#eaf1fb` |
| `text-neurokube-200` | Text | `#98B1DD` |
| ... | ... | ... |
| `text-neurokube-900` | Text | `#000040` |
| `hover:text-neurokube-100` | Hover Text | `#eaf1fb` |
| `hover:text-neurokube-200` | Hover Text | `#98B1DD` |
| ... | ... | ... |
| `hover:text-neurokube-900` | Hover Text | `#000040` |
| `hover:bg-neurokube-100` | Hover Background | `#eaf1fb` |
| `hover:bg-neurokube-200` | Hover Background | `#98B1DD` |
| ... | ... | ... |
| `hover:bg-neurokube-900` | Hover Background | `#000040` |
| `from-neurokube-50` | Gradients | `#f7faff` |
| `from-neurokube-100` | Gradients | `#eaf1fb` |
| ... | ... | ... |
| `via-neurokube-100` | Gradients | `#eaf1fb` |
| `via-neurokube-200` | Gradients | `#98B1DD` |
| ... | ... | ... |
| `to-neurokube-100` | Gradients | `#eaf1fb` |
| `to-neurokube-200` | Gradients | `#98B1DD` |
| `to-neurokube-300` | Gradients | `#7fa0d8` |


#### Utiliser une couleur

Pour utiliser une couleur dans un des composants du site, sélectionner la couleur prédéfinie dans la **Safelist** définie dans le fichier **tailwind.config.js**, et éviter d'utiliser directement le code hexadecimal de la couleur. 

#### Ajouter une nouvelle couleur

Si vous devez créer un nouveau type de couleur à partir de la palette existante, ajouter cette couleur directement dans la **SafeList**, tout en respectant la nomenclature déjà en place.
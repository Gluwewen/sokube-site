# Instructions projet — SoKube-site (Hugo)

Ce fichier documente les règles à respecter pour tout développement futur sur ce site, en particulier la création ou modification de shortcodes. Objectif : qu'une personne non-développeuse puisse mettre à jour le contenu des pages en toute sécurité, sans jamais toucher à du code.

## Règle 1 — Pas de HTML dans les pages Markdown

Les fichiers `.md` de `content/` ne doivent contenir que du Markdown et des appels de shortcodes (`{{< ... >}}`). Aucune balise HTML brute. Si un shortcode a besoin de contenu riche en paramètre (`.Inner`), il doit le rendre lui-même via `.Page.RenderString` pour accepter du Markdown.

## Règle 2 — Shortcodes non instanciables en page

Tout élément qui n'est pas appelé depuis une page Markdown (header, footer, menu, sidebar...) reste un partial (`layouts/partials/`), jamais un shortcode, et sa configuration vit uniquement dans `hugo.toml`.

## Règle 3 — Aspect visuel dans le layout, pas dans hugo.toml

Le paramétrage structurel d'un shortcode (arrondis, ombres, tailles, structure de grille...) est codé en dur dans le fichier du shortcode (`layouts/shortcodes/*.html`). Ça ne doit pas être exposé comme variable dans `hugo.toml` ni comme paramètre d'appel : une fois défini, l'aspect ne change plus.

## Règle 4 — Couleurs clair/sombre

Convention unique dans tout le projet : **un seul paramètre par usage**, sous forme de string combinée classe claire + variante sombre :

```
background = "bg-neurokube-600 dark:bg-neurokube-800"
```

Pas de paramètres séparés type `backgroundLight`/`backgroundDark`. Toute nouvelle combinaison de classes doit être ajoutée au safelist de `tailwind.config.js`.

## Règle 5 — Où mettre les valeurs par défaut

Toute valeur par défaut de style (couleur, palette...) vit dans `hugo.toml`, jamais codée en dur dans le template du shortcode. Objectif : pouvoir reconfigurer entièrement l'aspect du site (ou en extraire un thème réutilisable pour un autre site) sans toucher au code des shortcodes.

- **Shortcodes de type "section", instanciés une fois par page** (hero, cta, callout, highlight-section...) : la valeur par défaut vit dans `hugo.toml`, sous `[params.<nom>.style]`, avec override possible par langue dans `[languages.xx.params.<nom>]` et par instance via les paramètres du shortcode.
- **Shortcodes répétés plusieurs fois sur une même page** (card, feature, testimonial...) : fonctionnent par palettes nommées, toutes définies dans `hugo.toml` (y compris la palette `default`, ex. `[params.cards.default]` pour `sokube-card`) — le template ne fait que sélectionner la palette demandée (`palette="kube"`) et valider son existence (règle 8), il ne contient aucune couleur en dur.

Le template d'un shortcode ne doit donc contenir aucune classe Tailwind de couleur de marque en dur : seules les classes structurelles (règle 3) peuvent l'être.

## Règle 6 — Activation d'un shortcode

Toujours via un flag `enable = true/false` dans `hugo.toml` (voir `[params.sections]`, `[params.blog]`, `[params.trainings]`).

## Règle 7 — Contenu propre à une instance

Texte, image spécifique, lien de bouton : toujours passés en paramètre lors de l'appel du shortcode dans la page Markdown. Jamais en config globale.

## Règle 8 — Validation et messages d'erreur

Tout shortcode qui référence une config nommée dans `hugo.toml` (palette, variant...) doit vérifier son existence et lever une erreur explicite avec `errorf` si elle est absente, en indiquant le nom de la palette et le chemin de la page concernée (voir `sokube-card.html` comme référence).

## Règle 9 — Documentation embarquée

Chaque fichier de shortcode commence par un bloc de commentaire décrivant : à quoi il sert, ses paramètres (avec valeurs par défaut), un exemple d'appel minimal et un exemple d'appel complet (voir `sokube-cta.html` comme référence).

## Règle 10 — Catalogue des shortcodes

Le README.md du projet maintient la liste de tous les shortcodes disponibles, leurs paramètres et un exemple d'usage — à tenir à jour à chaque shortcode créé, renommé ou modifié.

## Règle 11 — Cohérence FR / EN

Toute modification de shortcode doit être vérifiée sur les deux arborescences de contenu (`content/en-us`, `content/fr-ch`) : mêmes paramètres, même rendu, pas de régression sur une langue sans l'autre.

## Règle 12 — Toujours statuer sur la portée avant de créer un shortcode

Avant d'écrire le moindre code pour un **nouveau** shortcode, on se pose systématiquement la question ensemble : ce shortcode est-il **site-wide** (une seule instance, configurable globalement dans `hugo.toml`, règle 5) ou **instanciable par page** (peut avoir un aspect ou un contenu différent selon où il est appelé, règle 5) ? Cette décision conditionne où vivent ses valeurs par défaut (règle 5) et sa structure de paramètres — elle doit donc être prise avant le développement, jamais déduite après coup. Ne jamais commencer à coder un nouveau shortcode sans avoir explicitement posé et tranché cette question au préalable.

## Règle 13 — Shortcode réutilisé hors des pages Markdown : partial partagée + shortcode-adaptateur

Un shortcode ne peut être invoqué que depuis le contenu Markdown d'une page — jamais depuis un template Go (`layouts/partials/*.html`, `layouts/_default/*.html`). Quand un composant doit être à la fois (a) posé à la main dans une page, et (b) injecté automatiquement ailleurs par le thème (ex. section ajoutée en fin de chaque page de formation), sa logique de rendu doit vivre dans une partial partagée (`layouts/partials/<nom>.html`), et le shortcode (`layouts/shortcodes/sokube-<nom>.html`) devient un mince adaptateur qui se contente d'appeler cette partial. La configuration (couleurs, défauts) suit les mêmes règles que d'habitude (règles 4, 5, 7) et peut être lue directement par la partial via `site.Params`, sans que chaque appelant (shortcode ou autre partial) ait besoin de la relayer. Voir `sokube-brand-heading.html` / `brand-heading.html` et `sokube-cta.html` / `cta-block.html` comme référence.

## Process de refactoring d'un shortcode existant

Le refactoring des shortcodes existants se fait un par un, jamais en lot :

1. Avant de toucher au code, on définit ensemble si le shortcode est **site-wide** ou **instanciable par page** (voir règle 12 — même question, appliquée ici à un shortcode déjà existant).
2. Refactoring du shortcode selon les règles ci-dessus.
3. Vérification (build Hugo local, comparaison visuelle des pages qui l'utilisent, pas de régression FR/EN).
4. Commit isolé de ce seul shortcode avant de passer au suivant.

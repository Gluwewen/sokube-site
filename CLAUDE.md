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

- **Shortcodes de type "section", instanciés une fois par page** (hero, cta, highlight-section...) : la valeur par défaut vit dans `hugo.toml`, sous `[params.<nom>]`, avec override possible par langue dans `[languages.xx.params.<nom>]`.
- **Shortcodes répétés plusieurs fois sur une même page** (card, feature, testimonial...) : la valeur par défaut est codée en dur dans le template du shortcode (ex. palette `default` de `sokube-card`), et seule une config nommée explicite (`palette="kube"`) vient de `hugo.toml`.

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

## Process de refactoring d'un shortcode existant

Le refactoring des shortcodes existants se fait un par un, jamais en lot :

1. Avant de toucher au code, on définit ensemble si le shortcode est **site-wide** ou **instanciable par page** (voir règle 12 — même question, appliquée ici à un shortcode déjà existant).
2. Refactoring du shortcode selon les règles ci-dessus.
3. Vérification (build Hugo local, comparaison visuelle des pages qui l'utilisent, pas de régression FR/EN).
4. Commit isolé de ce seul shortcode avant de passer au suivant.

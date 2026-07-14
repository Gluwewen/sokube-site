#!/usr/bin/env bash
#
# Optimise les images servies du site neurokube.
#
#   - convertit toute image matricielle (PNG/JPG/JPEG) de site/static/images
#     en WebP (qualité 82) ;
#   - met à jour les références (/images/...) dans content/ + layouts/ + hugo.toml ;
#   - supprime l'original converti.
#
# Sont volontairement ignorés : les logos (transparence, déjà minuscules),
# la favicon, et les images déjà en .webp.
#
# Idempotent : relançable à volonté (ne fait rien s'il n'y a plus de PNG/JPG).
# Prérequis : cwebp  ->  brew install webp
#
set -euo pipefail
cd "$(dirname "$0")/.."          # racine du repo
SITE=site
IMG_DIR="$SITE/static/images"

QUALITY=82
CWEBP_OPTS=(-quiet -q "$QUALITY" -m 6 -sharp_yuv)

command -v cwebp >/dev/null || { echo "cwebp introuvable — 'brew install webp'"; exit 1; }

# Remplace une chaîne (chemin public) littérale dans toutes les sources du site.
replace_ref() {
  local old="$1" new="$2"
  grep -rlF "$old" "$SITE/content" "$SITE/layouts" \
       "$SITE/themes/hugo-saasify-theme/layouts" "$SITE/hugo.toml" 2>/dev/null \
    | grep -v node_modules \
    | while IFS= read -r f; do
        perl -pi -e "s#\Q$old\E#$new#g" "$f"
        echo "    ref maj : $f"
      done
}

found=0
while IFS= read -r src; do
  found=1
  dst="${src%.*}.webp"
  rel="${src#"$IMG_DIR"/}"                 # ex: features/foo.png
  before=$(du -k "$src" | cut -f1)
  cwebp "${CWEBP_OPTS[@]}" "$src" -o "$dst"
  after=$(du -k "$dst" | cut -f1)
  echo "✔ $rel : ${before} Ko -> ${after} Ko (webp)"

  replace_ref "/images/${rel}" "/images/${rel%.*}.webp"
  git rm -q "$src" 2>/dev/null || rm -f "$src"
done < <(
  find "$IMG_DIR" -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) \
       -not -path '*/logos/*' -not -iname 'favicon.*'
)

[ "$found" -eq 0 ] && echo "Aucune image à convertir (déjà optimisé)." || echo "Terminé."

# syntax=docker/dockerfile:1

##########################################################################
# Stage 1 — build the static site (Hugo + Tailwind/PostCSS)
##########################################################################
FROM hugomods/hugo:0.163.3 AS builder
WORKDIR /src

# Image = Hugo Extended + Node.js. Le toolchain CSS (postcss-cli, tailwindcss,
# autoprefixer) vient des devDependencies npm, pas de l'image : Hugo exécute
# PostCSS lui-même (baseof.html -> css.PostCSS) et résout les binaires depuis
# ./node_modules/.bin. Installer les deps d'abord pour cacher ce layer.
COPY site/package.json site/package-lock.json ./
RUN npm ci

# Copy the rest of the site and render it.
# `hugo` defaults to the production environment => minify + fingerprint +
# PostProcess kick in (see baseof.html). Output goes to /src/public.
COPY site/ ./

# hugo.toml sets enableGitInfo = true for accurate per-page lastmod dates, but
# .git lives at the repo root, outside the site/ build context. Its only
# consumer here is the <lastmod> in the generated sitemap.xml, so we disable it
# for the container build only — native/local builds keep accurate git dates.
ENV HUGO_ENABLEGITINFO=false

# Override the baseURL at build time if deploying somewhere other than the
# value in hugo.toml:  docker build --build-arg HUGO_BASEURL=https://example.com/
ARG HUGO_BASEURL=
RUN hugo --minify --gc ${HUGO_BASEURL:+--baseURL "$HUGO_BASEURL"}

##########################################################################
# Stage 2 — serve it.
# static-web-server (Rust) on a scratch base: ~5 MB, distroless,
# gzip/brotli + cache-control built in. Default doc root is /public.
# Project: https://github.com/static-web-server/static-web-server
# Registry alt: ghcr.io/static-web-server/static-web-server:2
# Version épinglée pour des builds reproductibles (bumper au besoin).
##########################################################################
FROM joseluisq/static-web-server:2.36.0 AS runtime
ENV SERVER_PORT=8080
COPY --from=builder /src/public /public
EXPOSE 8080

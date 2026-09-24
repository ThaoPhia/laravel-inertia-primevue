# Laravel + PrimeVue Starter Kit

## Tech Stack

- **Backend:** Laravel 13, PHP 8.3+, Laravel Fortify
- **Frontend:** Vue 3, Inertia.js v3, Vite 8, TypeScript
- **UI:** PrimeVue 4, Tailwind CSS 4, Lucide Vue icons
- **Data and types:** Spatie Laravel Data, Spatie TypeScript Transformer
- **Testing and quality:** PHPUnit, PHPStan/Larastan, Laravel Pint, ESLint, vue-tsc
- **Default local database:** SQLite

## Requirements

- PHP 8.3 or newer
- Composer
- Node.js 22 or newer
- npm

## Setup

Install PHP and JavaScript dependencies:

```bash
composer install
npm install
```

Create the local environment file and application key:

```bash
cp .env.example .env
php artisan key:generate
```

Create the default SQLite database file and run migrations:

```bash
touch database/database.sqlite
php artisan migrate
```

On Windows PowerShell, use this command instead of `touch`:

```powershell
New-Item -ItemType File -Path database/database.sqlite -Force
php artisan migrate
```

## Local Development

Start the full development stack:

```bash
npm run dev:composer
```

This runs the Laravel server, queue listener, Vite dev server, and TypeScript transformer watcher through the Composer `dev` script.

Use the frontend-only Vite server when the Laravel app is already running separately:

```bash
npm run dev
```

Stop active local dev processes started by the full stack:

```bash
npm run dev:kill
```

## Quality Checks

Run the main checks before opening a pull request:

```bash
composer test
composer analyse
npm run lint
npm run typecheck
```

Build production assets:

```bash
npm run build
```

## Docker

The `Dockerfile` builds a self-contained production-style image (Vite assets + Composer deps baked in via multi-stage build). To build and run it:

```bash
npm run docker:rebuild
```

This script (`docker/rebuild.ps1`) builds the image, stops/removes any existing container, and starts a fresh one using the local `.env` file (`--env-file .env`).

The image name, container name, volume name, and port are all read from `.env`, with fallback defaults if unset:

```dotenv
APP_PORT=8000
DOCKER_CONTAINER_NAME=laravel-inertia-primevue
DOCKER_IMAGE_NAME=laravel-inertia-primevue:latest
DOCKER_VOLUME_NAME=laravel-inertia-primevue-sqlite
```

Notes on how it works:

- **Environment variables are not baked into the image.** `.env` is excluded via `.dockerignore`, so it must be supplied at runtime with `--env-file .env` (already handled by the rebuild script).
- **The SQLite database persists across rebuilds.** The database file lives at `/var/www/data/database.sqlite` inside the container, backed by a named Docker volume (`laravel-inertia-primevue-sqlite`) rather than the image itself. This keeps rebuilds reproducible (no dev data baked into the image) while preserving your data between rebuilds. On container startup, [`docker/local/web/entrypoint.sh`](docker/local/web/entrypoint.sh) creates the database file if missing and runs `php artisan migrate --force`.
- To wipe the database entirely, remove the volume: `docker volume rm laravel-inertia-primevue-sqlite`.
- This is separate from `docker-compose.dev.yml`, which sets up a Postgres-backed dev environment (e.g. for use with a dev container / Sail-style workflow) instead of this SQLite-based image.

> [!WARNING]
> Before adopting this starter kit, be aware that it is designed for [PrimeVue v4](https://v4.primevue.org/), the final MIT-licensed open source release. PrimeTek has announced that PrimeVue v5 will transition to the [new PrimeUI licensing model](https://primeui.dev/pricing) and will no longer be released as open source. As a result, this starter kit does not plan to migrate to PrimeVue v5.
>
> Consider migrating the PrimeVue packages to use [OpenVue](https://openvue.dev/), or use the [Laravel Nuxt UI Starter Kit](https://github.com/connorabbas/laravel-nuxtui-starter-kit) as an alternative.

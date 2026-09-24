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


> [!WARNING]
> Before adopting this starter kit, be aware that it is designed for [PrimeVue v4](https://v4.primevue.org/), the final MIT-licensed open source release. PrimeTek has announced that PrimeVue v5 will transition to the [new PrimeUI licensing model](https://primeui.dev/pricing) and will no longer be released as open source. As a result, this starter kit does not plan to migrate to PrimeVue v5.
>
> Consider migrating the PrimeVue packages to use [OpenVue](https://openvue.dev/), or use the [Laravel Nuxt UI Starter Kit](https://github.com/connorabbas/laravel-nuxtui-starter-kit) as an alternative.

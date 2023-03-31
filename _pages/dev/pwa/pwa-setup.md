---
title: Adding PWA Support to Spartacus
---

You can add Progressive Web Application (PWA) support to the Spartacus app. Spartacus supports the latest major version of `@angular/pwa`.

## Setting up PWA in Spartacus

1. Run the following command in the workspace of your Angular application:

   ```bash
   ng add @angular/pwa --project <project-name>
   ```

1. Remove all service worker references from `app.module.ts`.

1. Build your app in `prod` mode, as follows:

   ```bash
   ng build --prod
   ```

   The build generates the required files to register your service worker and serve your app in PWA mode.

   **Note:** The Spartacus PWA module assumes a `production===true` flag, which is set using the `environment.production` file. You need to manually set this setting.

1. Deploy and serve your app using an HTTP server.

   For testing purposes, we recommend that you install [http-server](https://www.npmjs.com/package/http-server) as a dev dependency, and that you serve the app using `http-server ./dist/your-app`

   Double-check that the service worker is running and that the Add to Home Screen feature works. For more information, see [{% assign linkedpage = site.pages | where: "name", "add-to-home-pwa.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/pwa/add-to-home-pwa.md %}).

## Limitations

- The default `ng` server ([webpack devserver](https://webpack.js.org/configuration/dev-server/)) does not provide support for service workers. You must use a separate HTTP server to support PWA.

- PWA is only supported in secure mode, so the HTTP server of your choice needs to serve Spartacus in secure (HTTPS) mode.

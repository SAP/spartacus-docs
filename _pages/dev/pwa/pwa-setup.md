---
title: Adding PWA Support to Spartacus
---

You can add Progressive Web Application (PWA) support to the Spartacus app. Spartacus supports the latest major version of `@angular/pwa`.

## Setting up PWA in Spartacus

1. Add the Angular PWA dependency to your shell app, as follows:

    ```bash
    ng add @spartacus/schematics --pwa
    ```

    **Note:** The command works even if you already have Spartacus installed.

    **Note:** If you have more than one project in your workspace, use the `--project` flag to add PWA to your main project.

    If you already have the `@angular/pwa` dependency, do the following:

   1. Remove the `@angular/pwa` dependency from `package.json`
   1. Run `npm install` to remove the dependencies from your app
   1. Run `ng add @spartacus/schematics --pwa`

    Adding the dependency using `ng add @spartacus/schematics --pwa` also triggers the angular PWA schematic, which automatically does the following:

   - creates default PWA configuration files
   - creates the `ngsw-config.json` service worker configuration file
   - creates icons
   - updates the `angular.json` file to include PWA-related resources in your build
   - updates project files for PWA readiness.

2. Build your app in `prod` mode, as follows:

    ```bash
    ng build --prod
    ```

    The build generates the required files to register your service worker and serve your app in PWA mode.

    **Note:** The Spartacus PWA module assumes a `production===true` flag, which is set using the `environment.production` file. You need to manually set this setting.

3. Deploy and serve your app using an HTTP server.

    For testing purposes, we recommend that you install [http-server](https://www.npmjs.com/package/http-server) as a dev dependency, and that you serve the app using `http-server ./dist/your-app`

    Double-check that the service worker is running and that the Add to Home Screen feature works. For more information, see [{% assign linkedpage = site.pages | where: "name", "add-to-home-pwa.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/pwa/add-to-home-pwa.md %}).

## Limitations

- The default `ng` server ([webpack devserver](https://webpack.js.org/configuration/dev-server/)) does not provide support for service workers. You must use a separate HTTP server to support PWA.

- PWA is only supported in secure mode, so the HTTP server of your choice needs to serve Spartacus in secure (HTTPS) mode.

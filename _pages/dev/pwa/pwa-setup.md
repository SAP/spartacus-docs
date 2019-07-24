---
title: Adding PWA Support to Spartacus
---

You can add Progressive Web Application (PWA) support to the Spartacus app. Spartacus supports the latest major version of `@angular/pwa`.

## Setting up PWA in Spartacus

1. Add the Angular PWA dependency to your shell app, as follows:

    ```bash
    ng add @angular/pwa
    ```

    **Note:** If you have more than one project in your workspace, use the `--project` flag to add PWA to your main project.

    **Note:** If you already have the `@angular/pwa` dependency, do the following:

    - remove the `@angular/pwa` dependency from `package.json`
    - run `yarn` to remove the dependencies from your app
    - reinstall the dependencies again using `ng`.

    Adding the dependency using `ng` also triggers the angular PWA schematic, which automatically does the following:

    - creates default PWA configuration files
    - creates icons
    - updates the `angular.json` file to include PWA related resources in your build
    - updates project files for PWA readiness.

2. Update your `ngsw-config.json`, as follows:

    ```json
    {
      "index": "/index.html",
      "assetGroups": [
        {
          "name": "app",
          "installMode": "prefetch",
          "resources": {
            "files": ["/favicon.ico", "/index.html", "/*.css", "/*.js"]
          }
        }
      ]
    }
    ```

3. Build your app in `prod` mode, as follows:

    ```bash
    ng build --prod
    ```

    The build generates the required files to register your service worker and serve your app in PWA mode.

    **Note:** The Spartacus PWA module assumes a `production===true` flag, which is set using the `environment.production` file. This setting needs to be set manually by customers.

4. Deploy and serve your app using an HTTP server.

    For testing purposes, we recommend that you install [http-server](https://www.npmjs.com/package/http-server) as a dev dependency, and that you serve the app using `http-server ./dist/your-app`

    Double-check that the service worker is running and that the Add to Home Screen feature works. For more information, see [Adding the Spartacus App to the Home Screen]({{ site.baseurl }}{% link _pages/dev/pwa/add-to-home-pwa.md %}).


## Limitations

- The default `ng` server ([webpack devserver](https://webpack.js.org/configuration/dev-server/)) does not provide support for service workers. You must use a separate HTTP server to support PWA.

- PWA is only supported in secure mode, so the HTTP server of your choice needs to serve Spartacus in secure (HTTPS) mode.

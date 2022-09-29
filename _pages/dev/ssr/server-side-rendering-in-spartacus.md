---
title: Server-Side Rendering
---

In Spartacus, server-side rendering allows you to render static versions of pages on the server side. This speeds up response times, assists with SEO, and allows the application to render more quickly. After Angular has bootstrapped, users of your site will have the full experience.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Adding SSR Support Using Schematics (Recommended)

The recommended way to add SSR support to your Spartacus application is to use schematics. With a single command, all required files are added automatically, and all modifications for SSR support are done automatically as well. To add SSR support to your Spartacus application, run the following command:

```bash
ng add @spartacus/schematics --ssr
```

You have now added SSR support to your Spartacus application. No further steps are required.

If you experience any issues, see [Troubleshooting]({{ site.baseurl }}{% link _pages/dev/ssr/server-side-rendering-optimization.md %}#troubleshooting) for more information.

## Adding SSR Support Manually

For most situations and setups, is is best to add SSR support to your Spartacus application using schematics, as described in the previous section. However, if you are unable to add SSR support using schematics, the following steps describe how to manually add SSR support so that your Spartacus shell app includes the Spartacus libraries running in SSR mode.

1. Add the following dependencies to `package.json`:

    ```json
    "@angular/platform-server": "~10.1.0",
    "@nguniversal/express-engine": "^10.1.0",
    "@spartacus/setup": "^3.0.0-rc.2",
    "express": "^4.15.2"
    ```

1. Add the following developer dependencies to `package.json`:

    ```json
    "ts-loader": "^6.0.4",
    "@nguniversal/builders": "^10.1.0",
    "@types/express": "^4.17.0",
    ```

1. For convenience, add the following scripts to `package.json`:

    ```json
    "e2e": "ng e2e",
    "dev:ssr": "ng run <your-project-name>:serve-ssr",
    "serve:ssr": "node dist/<your-project-name>/server/main.js",
    "build:ssr": "ng build --prod && ng run <your-project-name>:server:production",
    "prerender": "ng run <your-project-name>:prerender"
    ```

1. Update the `src/main.ts` file, as follows:

    ```typescript
    //from
    platformBrowserDynamic().bootstrapModule(AppModule);
    //to
    document.addEventListener("DOMContentLoaded", () => {
      platformBrowserDynamic().bootstrapModule(AppModule);
    });
    ```

1. Update the `app.module.ts` file, as follows:

    ```typescript
    //from:
    BrowserModule,
    //to
    BrowserModule.withServerTransition({ appId: 'spartacus-app' }),
    ```

1. Additionally, update the `app.module.ts` file, as follows:

    ```typescript
    //from
    import { BrowserModule } from '@angular/platform-browser';
    //to
    import { BrowserModule, BrowserTransferStateModule } from '@angular/platform-browser';
    ```

1. Also in the `app.module.ts` file, add `BrowserTransferStateModule` to the `imports` array of the `@NgModule` decorator.

1. In the `src/index.html` file, add the following meta attribute, and replace `OCC_BACKEND_BASE_URL_VALUE` with the URL of your back end instance, as follows:

    ```html
    <meta name="occ-backend-base-url" content="OCC_BACKEND_BASE_URL_VALUE" />
    ```

1. Update `projects.<your-project-name>.architect.build.options`, as follows:

    ```json
    //from
    "outputPath": "dist/<your-project-name>",
    //to
    "outputPath": "dist/<your-project-name>/browser",
    ```

1. In `projects.<your-project-name>.architect.lint.options.tsConfig`, add the following line:

    ```json
    "tsconfig.server.json"
    ```

1. In `projects.<your-project-name>.architect`, add the following configuration to your existing `angular.json` file:

    ```json
    "server": {
        "builder": "@angular-devkit/build-angular:server",
        "options": {
          "outputPath": "dist/<your-project-name>/server",
          "main": "server.ts",
          "tsConfig": "tsconfig.server.json"
        },
        "configurations": {
          "production": {
            "outputHashing": "media",
            "fileReplacements": [
              {
                "replace": "src/environments/environment.ts",
                "with": "src/environments/environment.prod.ts"
              }
            ],
            "sourceMap": false,
            "optimization": true
          }
        }
    },
    "serve-ssr": {
      "builder": "@nguniversal/builders:ssr-dev-server",
      "options": {
        "browserTarget": "<your-project-name>:build",
        "serverTarget": "<your-project-name>:server"
      },
      "configurations": {
        "production": {
          "browserTarget": "<your-project-name>:build:production",
          "serverTarget": "<your-project-name>:server:production"
        }
      }
    },
    "prerender": {
      "builder": "@nguniversal/builders:prerender",
      "options": {
        "browserTarget": "<your-project-name>:build:production",
        "serverTarget": "<your-project-name>:server:production",
        "routes": [
          "/"
        ]
      },
      "configurations": {
        "production": {}
      }
    }
    ```

    **Note:** In the above example, remember to replace the string `"<your-project-name>"` with your project name (such as `mystore`, for example).

1. Add the `tsconfig.server.json` file to your existing shell app. The following is an example:

    ```json
    {
      "extends": "./tsconfig.app.json",
      "compilerOptions": {
        "outDir": "./out-tsc/server",
        "target": "es2016",
        "types": [
          "node"
        ]
      },
      "files": [
        "src/main.server.ts",
        "server.ts"
      ],
      "angularCompilerOptions": {
        "entryModule": "./src/app/app.server.module#AppServerModule"
      }
    }
    ```

1. Add the `src/main.server.ts` file to your existing shell app. The following is an example:

    ```typescript
    /**
    * Load `$localize` onto the global scope - used if i18n tags appear in Angular templates.
    */
    import '@angular/localize/init';

    import { enableProdMode } from "@angular/core";

    import { environment } from "./environments/environment";

    if (environment.production) {
      enableProdMode();
    }

    export { AppServerModule } from './app/app.server.module';
    export { renderModule, renderModuleFactory } from '@angular/platform-server';
    ```

1. Add the `src/app/app.server.module` file to your existing shell app. The following is an example:

    ```typescript
    import { NgModule } from "@angular/core";
    import {
      ServerModule,
      ServerTransferStateModule,
    } from "@angular/platform-server";

    import { AppModule } from "./app.module";
    import { AppComponent } from "./app.component";

    @NgModule({
      imports: [
        // The AppServerModule should import your AppModule followed
        // by the ServerModule from @angular/platform-server.
        AppModule,
        ServerModule,
        ServerTransferStateModule,
      ],
      bootstrap: [AppComponent],
    })
    export class AppServerModule {}
    ```

    For more information about caching and transfer state, see [Caching the Site Context with Server-Side Rendering]({{ site.baseurl }}/automatic-context-configuration/#caching-the-site-context-with-server-side-rendering).

1. Add the `server.ts` file to your existing shell app. The following is an example:

    ```typescript
    /**
     * Load `$localize` onto the global scope - used if i18n tags appear in Angular templates.
    */
    import '@angular/localize/init';
    import 'zone.js/dist/zone-node';

    import { ngExpressEngine as engine } from '@nguniversal/express-engine';
    import { NgExpressEngineDecorator } from '@spartacus/setup/ssr';
    import * as express from 'express';
    import { join } from 'path';

    import { AppServerModule } from './src/main.server';
    import { APP_BASE_HREF } from '@angular/common';
    import { existsSync } from 'fs';

    const ngExpressEngine = NgExpressEngineDecorator.get(engine);

    // The Express app is exported so that it can be used by serverless Functions.
    export function app() {
      const server = express();
      const distFolder = join(process.cwd(), 'dist/<your-project-name>/browser');
      const indexHtml = existsSync(join(distFolder, 'index.original.html'))
        ? 'index.original.html'
        : 'index';

      server.engine(
        'html',
        ngExpressEngine({
          bootstrap: AppServerModule,
        })
      );

      server.set('view engine', 'html');
      server.set('views', distFolder);

      // Serve static files from /browser
      server.get(
        '*.*',
        express.static(distFolder, {
          maxAge: '1y',
        })
      );

      // All regular routes use the Universal engine
      server.get('*', (req, res) => {
        res.render(indexHtml, {
          req,
          providers: [{ provide: APP_BASE_HREF, useValue: req.baseUrl }],
        });
      });

      return server;
    }

    function run() {
      const port = process.env.PORT || 4000;

      // Start up the Node server
      const server = app();
      server.listen(port, () => {
        console.log(`Node Express server listening on http://localhost:${port}`);
      });
    }

    // Webpack will replace 'require' with '__webpack_require__'
    // '__non_webpack_require__' is a proxy to Node 'require'
    // The below code is to ensure that the server is run only when not requiring the bundle.
    declare const __non_webpack_require__: NodeRequire;
    const mainModule = __non_webpack_require__.main;
    const moduleFilename = (mainModule && mainModule.filename) || '';
    if (moduleFilename === __filename || moduleFilename.includes('iisnode')) {
      run();
    }

    export * from './src/main.server';
    ```

    **Note:** In the above example, remember to replace the string `"<your-project-name>"` with your project name (such as `mystore`, for example).

1. Build the SSR version of your Spartacus shell app by running the following command:

    ```bash
    yarn run build:ssr && yarn run serve:ssr
    ```

## Installation Steps for Internal Spartacus Development

If you are involved in Spartacus internal development (for example, if you are contributing to the Spartacus core libraries), or if you wish to submit a pull request, you can perform the following steps, which describe how to run Spartacus in SSR mode using the Spartacus storefront app.

**Note:** You do not need to follow the steps in this section if your intention is to add SSR support to your Spartacus application. You can do that simply by running the schematics command, as described in [Adding SSR Support Using Schematics (Recommended)](#adding-ssr-support-using-schematics-recommended).

1. Set the production server endpoint in your `environment.prod.ts` (dev mode) or `app.module.ts` (shell app mode), as follows:

    ```json
    environment = {
      occBaseUrl: 'https://[your_occ_endpoint]',
    };
    ```

1. Turn PWA off.

    As soon as Spartacus is installed in PWA mode, a service worker is installed, and it serves a cached version of `index.html`, along with the `js` files. This results in SSR being completely skipped. The following steps describe how to turn off PWA:

    1. Check that there are no service workers registered in your app. If you do find any service workers, remove them.

    1. Turn PWA off in your app module configuration, as follows:

       ```json
       StorefrontModule.withConfig({
             backend: {
               occ: {
                 baseUrl: 'https://[your_enpdoint],
               },
             },
             pwa: {
               enabled: false,
             },
       };
       ```

1. Rebuild your local Spartacus libraries by running the following command:

    ```bash
    yarn build:core:lib
    ```

1. Build your local Spartacus shell app by running the following command:

    ```bash
    yarn build --prod
    ```

1. Build the SSR version of your shell app by running the following command:

    ```bash
    yarn build:ssr
    ```

1. Start Spartacus with the SSR server by running the following command:

    ```bash
    yarn serve:ssr
    ```

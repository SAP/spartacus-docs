---
title: Server-Side Rendering
---

In Spartacus, server-side rendering allows you to render static versions of pages on the server side. This speeds up response times, assists with SEO, and allows the application to render more quickly. After Angular has bootstrapped, users of your site will have the full experience.

## Adding SSR Support Using Schematics (Recommended)

The recommended way to add SSR support to your Spartacus application is to use schematics. With a single command, all required files are added automatically, and all modifications for SSR support are done automatically as well. To add SSR support to your Spartacus application, run the following command:

```bash
ng add @spartacus/schematics --ssr
```

The steps executed by this command are described in more detail in the following sections.

## Adding SSR Support Manually

The following steps describe how to manually add SSR support so that your Spartacus shell app includes the Spartacus libraries running in SSR mode.

1. Add the following dependencies to `package.json`:

    ```json
    "@angular/platform-server": "~8.2.14",
    "@nguniversal/express-engine": "^8.1.1",
    "@nguniversal/module-map-ngfactory-loader": "^8.2.6",
    "express": "^4.15.2"
    ```

1. Add the following developer dependencies to `package.json`:

    ```json
    "ts-loader": "^5.3.2",
    "webpack-cli": "^3.3.2"
    ```

1. For convenience, add the following scripts to `package.json`:

    ```json
    "compile:server": "webpack --config webpack.server.config.js --progress --colors",
    "serve:ssr": "node dist/server",
    "build:ssr": "npm run build:client-and-server-bundles && npm run compile:server",
    "build:client-and-server-bundles": "ng build --prod && ng run spartacus:server"
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

1. Replace the following lines in `app.module.ts`:

    ```typescript
    //from:
    BrowserModule,
    //to
    BrowserModule.withServerTransition({ appId: 'spartacus-app' }),
    ```

1. In the `src/index.html` file, add the following meta attribute, and replace `OCC_BASE_URL` with the URL of your back end instance, as follows:

    ```html
    <meta name="occ-backend-base-url" content="OCC_BASE_URL" />
    ```

1. In `projects.<your-project-name>.architect`, add the following configuration to your existing `angular.json` file:

    ```json
    "server": {
      "builder": "@angular-devkit/build-angular:server",
      "options": {
        "outputPath": "dist/<your-project-name>-server",
        "main": "src/main.server.ts",
        "tsConfig": "tsconfig.server.json",
        "fileReplacements": [
          {
            "replace": "src/environments/environment.ts",
            "with": "src/environments/environment.prod.ts"
          }
        ]
      }
    }
    ```

    **Note:** In the above example, remember to replace the string `"<your-project-name>"` with your project name (such as `mystore`, for example).

1. Add the `tsconfig.server.json` file to your existing shell app. The following is an example:

    ```json
    {
      "extends": "./tsconfig.json",
      "compilerOptions": {
        "outDir": "../out-tsc/app",
        "baseUrl": "./",
        "module": "commonjs",
        "types": []
      },
      "exclude": ["test.ts", "e2e/src/app.e2e-spec.ts", "**/*.spec.ts"],
      "angularCompilerOptions": {
        "entryModule": "src/app/app.server.module#AppServerModule"
      }
    }
    ```

1. Add the `src/main.server.ts` file to your existing shell app. The following is an example:

    ```typescript
    import { enableProdMode } from "@angular/core";

    import { environment } from "./environments/environment";

    if (environment.production) {
      enableProdMode();
    }

    export { AppServerModule } from "./app/app.server.module";
    export { provideModuleMap } from "@nguniversal/module-map-ngfactory-loader";
    import { ngExpressEngine as engine } from "@nguniversal/express-engine";
    import { NgExpressEngineDecorator } from "@spartacus/core";
    export const ngExpressEngine = NgExpressEngineDecorator.get(engine);
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
    import { ModuleMapLoaderModule } from "@nguniversal/module-map-ngfactory-loader";

    @NgModule({
      imports: [
        // The AppServerModule should import your AppModule followed
        // by the ServerModule from @angular/platform-server.
        AppModule,
        ServerModule,
        ModuleMapLoaderModule,
        ServerTransferStateModule,
      ],
      bootstrap: [AppComponent],
    })
    export class AppServerModule {}
    ```

    For more information about caching and transfer state, see [Caching the Site Context with Server-Side Rendering](https://sap.github.io/spartacus-docs/automatic-context-configuration/#caching-the-site-context-with-server-side-rendering)

1. Add the `webpack.server.config.js` file to your existing shell app. The following is an example:

    ```javascript
    const path = require("path");
    const webpack = require("webpack");

    module.exports = {
      mode: "none",
      entry: {
        // This is our Express server for Dynamic universal
        server: "./server.ts",
      },
      externals: {
        "./dist/server/main": 'require("./server/main")',
      },
      target: "node",
      resolve: { extensions: [".ts", ".js"] },
      optimization: {
        minimize: false,
      },
      output: {
        // Puts the output at the root of the dist folder
        path: path.join(__dirname, "dist"),
        filename: "[name].js",
      },
      module: {
        noParse: /polyfills-.*\.js/,
        rules: [
          { test: /\.ts$/, loader: "ts-loader" },
          {
            // Mark files inside `@angular/core` as using SystemJS style dynamic imports.
            // Removing this will cause deprecation warnings to appear.
            test: /(\\|\/)@angular(\\|\/)core(\\|\/).+\.js$/,
            parser: { system: true },
          },
        ],
      },
      plugins: [
        new webpack.ContextReplacementPlugin(
          // fixes WARNING Critical dependency: the request of a dependency is an expression
          /(.+)?angular(\\|\/)core(.+)?/,
          path.join(__dirname, "src"), // location of your src
          {} // a map of your routes
        ),
        new webpack.ContextReplacementPlugin(
          // fixes WARNING Critical dependency: the request of a dependency is an expression
          /(.+)?express(\\|\/)(.+)?/,
          path.join(__dirname, "src"),
          {}
        ),
      ],
    };
    ```

1. Add the `server.ts` file to your existing shell app. The following is an example:

    ```typescript
    import "zone.js/dist/zone-node";

    import * as express from "express";
    import { join } from "path";

    // Express server
    const app = express();

    const PORT = process.env.PORT || 4200;
    const DIST_FOLDER = join(process.cwd(), "dist/<your-project-name>");

    // * NOTE :: leave this as require() since this file is built Dynamically from webpack
    const {
      AppServerModuleNgFactory,
      LAZY_MODULE_MAP,
      ngExpressEngine,
      provideModuleMap,
    } = require("./dist/<your-project-name>-server/main");

    app.engine(
      "html",
      ngExpressEngine({
        bootstrap: AppServerModuleNgFactory,
        providers: [provideModuleMap(LAZY_MODULE_MAP)],
      })
    );

    app.set("view engine", "html");
    app.set("views", DIST_FOLDER);

    app.get(
      "*.*",
      express.static(DIST_FOLDER, {
        maxAge: "1y",
      })
    );

    // All regular routes use the Universal engine
    app.get("*", (req, res) => {
      res.render("index", { req });
    });

    // Start up the Node server
    app.listen(PORT, () => {
      console.log(`Node server listening on http://localhost:${PORT}`);
    });
    ```

    **Note:** In the above example, remember to replace the string `"<your-project-name>"` with your project name (such as `mystore`, for example).

1. Add the following scripts to your `package.json`. Remember to replace `<your-project-name>` with your project name (such as `mystore`, for example).

    ```json
    "compile:server": "webpack --config webpack.server.config.js --progress --colors",
    "serve:ssr": "node dist/server",
    "build:ssr": "npm run build:client-and-server-bundles && npm run compile:server",
    "build:client-and-server-bundles": "ng build --prod && ng run <your-project-name>:server"
    ```

    **Note:** For the `build:client-and-server-bundles` script, replace `<your-project-name>` with the name of your Angular application.

1. Build the SSR version of your Spartacus shell app by running the following command:

    ```bash
    npm run build:ssr && npm run serve:ssr
    ```

## Installation Steps for Spartacus Development

If you are involved in Spartacus internal development, or wish to submit a pull request, you can perform the following steps, which describe how to run Spartacus in SSR mode using the Spartacus storefront app.

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
    yarn start:ssr
    ```

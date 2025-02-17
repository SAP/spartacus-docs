---
title: Modernizing Your Storefront App That Was Upgraded to Version 2211.19
---

Angular 17 introduced a new Angular CLI configuration format, which was not initially recommended for use with Spartacus apps that were updated to version 2211.19 because there were compatibility issues at the time.

Now that you are preparing to update to Angular 19 and Spartacus 2211.36, it is recommended that you use the new Angular CLI configuration format. The benefits of using the new Angular configuration format are that application builds are quicker, and it makes your app "future proof" in the sense that, in the future, any new Angular or Spartacus features might require you to use the new configuration format as a prerequisite.

**Note:** You should follow the migration guide here **only if your storefront app was originally created using Spartacus 6.x libraries or older**, and was then updated to 2211.19. If your Spartacus app was originally built with 2211.19 libraries or newer, skip the steps here and go straight to [Update Release 2211.36](./migration.md).

## Automatic Migration

Spartacus includes specially-prepared schematics to automatically modernize your app to be as similar as possible to a newly created Angular 17 app.

**Note:** These schematics were only released in `@spartacus/schematics2211.36.1`, but you need to run them before fully upgrading your app to 2211.36. As a result, you need to install `@spartacus/schematics@2211.36.1` in a temporary directory and run the migration schematics from there.

**Note:** In all of the following steps, the commands should be run from the root directory of your project.

1. Create a temporary sibling directory for the isolated 2211.36 installation schematics by running the following command:

   ```bash
   node -e "require('fs').mkdirSync('../temp-schematics-36')"
   ```

2. Install the schematics in the temporary directory by running the following command:

   ```bash
   npm install @spartacus/schematics@2211.36.1 --prefix ../temp-schematics-36
   ```

3. Execute the schematics by running the following command:

   ```bash
   ng g ../temp-schematics-36/node_modules/@spartacus/schematics:modernize-app-migrated-from-6_8-to-2211_19
   ```

4. Clean up the temporary directory by running the following command:

   ```bash
   node -e "require('fs').rmSync('../temp-schematics-36', { recursive: true, force: true })"
   ```

Congratulations! Your storefront app has been modernized to look like a new Angular 17 app. If your storefront app uses SSR, continue with [Additional Migration and New Commands for SSR Projects](#additional-migration-and-new-commands-for-ssr-projects). If your storefront app does not use SSR, you can now continue with updating your Spartacus app by following the rest of the procedures in [Update Release 2211.36](./migration.md).

If you encounter any issues during the automatic migration steps described above, you can complete the migration by following the steps in [Manual Migration For Modernizing Angular 17 Storefront Apps](#manual-migration-for-modernizing-angular-17-storefront-apps), below.

## Additional Migration and New Commands for SSR Projects

For apps that use server-side rendering (SSR), now that you have completed the modernization of your app to be as similar as possible to a newly created Angular 17 app, you will need to run SSR and prerendering scripts in a different way. Also, if you host your storefront in SAP Commerce Cloud, you need to update the corresponding `manifest.json` file.

### Updating the Manifest for SAP Commerce Cloud

This update applies to storefront apps that are hosted in SAP Commerce Cloud.

In the `js-storefront/manifest.json` file, if the `srr.path` object ends in `main.js`, it now needs to be updated to end with `server.mjs`. The following is an example of what the updated `manifest.json` file should look like:

```json
{
      "name": "<Your-Storefront-App-Name>",
      "path": "<Your-Storefront-App-Path>",
      "ssr": {
         "enabled": true,
         "path": "dist/<Your-Storefront-App-Name>/<Your-Storefront-App-Name>-server/server.mjs"
      }
      ...
 }
 ```

For more information, see [Enable Server-Side Rendering](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/b2f400d4c0414461a4bb7e115dccd779/cd5b94c25a68456ba5840f942f33f68b.html?locale=en-US&version=v2211).

### Running an SSR Dev Server

With older storefront apps, it was possible to run an SSR dev server with the command `npm run dev:ssr`. This server watched for changed files, and would rebuild when changes were detected. However, after modernizing your app to match the appearance of a newly-created Angular 17 app, this command is removed, because its builder has been replaced by the new Angular `application` builder.

The following steps provide a workaround.

1. In your `package.json` file, add a new, custom `"serve:ssr:watch"` command, as shown in the following example:

   ```json
     "serve:ssr": "node dist/YOUR-APP-NAME/server/server.mjs",
     "serve:ssr:watch": "node --watch dist/YOUR-APP-NAME/server/server.mjs",
   ```

1. From the root directory of your project, open a terminal window and run the following command:

   ```bash
   npm run watch
   ```

   This builds the app in watch mode, which means it watches for changed source files and rebuilds when changes are detected.

1. In a separate terminal window, run the following command:

   ```bash
   npm run serve:ssr:watch
   ```

   This command runs the SSR dev server in watch mode, which means it watches for compiled files and reruns the server when new compiled files are detected.

**Note:** The same workaround has been documented for new Angular 17 apps in [KBA 3460263](https://me.sap.com/notes/3460263).

### Running Server Prerendering

With older storefront apps, it was possible to run server prerendering with the command `npm run prerender`. However, after modernizing your app to match the appearance of a newly-created Angular 17 app, this command is removed, because its builder has been replaced by the new Angular `application` builder.

The following steps provide a workaround.

1. In `package.json`, create the following new, custom `"prerender"` command:

   ```json
   "prerender": "ng build --prerender=true",
   ```

1. Run the following command in a terminal, while passing the `SERVER_REQUEST_ORIGIN` Node env variable.

   ```bash
   SERVER_REQUEST_ORIGIN="http://localhost:4200" npm run prerender
   ```

   Remember to replace `"http://localhost:4200"` with the real target domain where you want to deploy your prerendered pages, especially if you are deploying for production. Otherwise, some Spartacus SEO features might not work properly.

   For example, [Canonical URLs](https://help.sap.com/docs/SAP_COMMERCE_COMPOSABLE_STOREFRONT/eaef8c61b6d9477daf75bff9ac1b7eb4/e712f36722c543359ed699aed9873075.html?version=2211#canonical-urls) might point to a wrong domain, or [Automatic Multi-Site Configuration](https://help.sap.com/docs/SAP_COMMERCE_COMPOSABLE_STOREFRONT/eaef8c61b6d9477daf75bff9ac1b7eb4/9d2e339c2b094e4f99df1c2d7cc999a8.html?version=2211) might not recognize the base site correctly if, for example, some regexes that are configured in the CMS for base site recognition depend on the domain name.

**Note:** The same workaround has been documented for new Angular 17 apps in [KBA 3460211](https://me.sap.com/notes/3460211).

Congratulations! You have completed all the steps for updating the use of SSR in your storefront app. You can now continue with updating your Spartacus app by following the rest of the procedures in [Update Release 2211.36](./migration.md).

## Manual Migration For Modernizing Angular 17 Storefront Apps

The following steps apply to all storefront apps that were previously updated from version 6.8 to version 2211.36.

**Note:** These steps are provided for reference and for troubleshooting purposes. You should only follow these steps if you run into issues with the automatic migration described above.

### Migration to the New Angular Application Builder

1. In the `architect > build` section of `angular.json`, change the value `"builder": "@angular-devkit/build-angular:browser",`
   to `"builder": "@angular-devkit/build-angular:application",`.

   The updated section should appear as follows:

```json
        "architect": {
          "build": {
            "builder": "@angular-devkit/build-angular:application",
```

   This step configures the new `application` builder for Angular 17 and newer. This is the recommended, faster, and "future proof" builder for Angular version 17 and newer.

1. In the `architect > build > options` section of `angular.json`, apply all of the following modifications, to adapt to the new configuration format for the new builder:

   1. Rename `"main": "src/main.ts"` to `"browser": "src/main.ts"`.

      The updated section should appear as follows:

      ```json
      "architect": {
        "build": {
         "options": {
            "browser": "src/main.ts",
      ```

   1. In the `architect > build > configurations > development` section, remove the following three properties: `"buildOptimizer"`, `"vendorChunk"`, and `"namedChunks"`

1. In the `"compilerOptions"` section of `tsconfig.json`, remove the following properties: `"baseUrl"`, `"forceConsistentCasingInFileNames"`, and `"downlevelIteration"`.
1. In the same `"compilerOptions"` section of `tsconfig.json`, add the following properties: `"skipLibCheck": true` and `"esModuleInterop": true`.

   The updated section should appear as follows:

   ```json
      "compilerOptions": {
        "skipLibCheck": true,
        "esModuleInterop": true,
        /*...*/
   },
   ```

   If your storefront app uses server-side rendering (SSR), continue with the next procedure, [Additional Migration Steps For Projects Using SSR](#additional-migration-steps-for-projects-using-ssr). If your project does not use SSR, skip ahead to the steps in [Using Non-Deprecated Angular APIs](#using-non-deprecated-angular-apis).

### Additional Migration Steps For Projects Using SSR

1. In the `architect > build > options` section of `angular.json`, apply all the following modifications:

   1. In the `"outputPath"` property, remove `"/browser"` from the end of the string value.

   The updated property should appear as follows:

   ```json
           "architect": {
             "build": {
               "options": {
                 "outputPath": "dist/YOUR-APP-NAME",
   ```

   1. Add three new options with the following values: `"server": "src/main.server.ts"`, `"prerender": false`, and `"ssr": { "entry": "server.ts" }`.

   The updated section should appear as follows:

   ```json
           "architect": {
             "build": {
              "options": {
                 "outputPath": "dist/YOUR-APP-NAME",
                 "server": "src/main.server.ts",
                 "prerender": false,
                 "ssr": {
                   "entry": "server.ts"
                 }
   ```

1. In the `architect > build > configurations` section of `angular.json`, add a new property with the following object value: `"noSsr": { "ssr": false, "prerender": false }`

   The updated section should appear as follows:

   ```json
           "architect": {
             "build": {
               "configurations": {
                 "noSsr": {
                   "ssr": false,
                   "prerender": false
                 }
   ```

   You have finished updating the `build` configuration section, and in the next step, you will be updating the `serve` configuration section.

1. In the `architect > serve > configurations` section, add `,noSsr` (including the initial comma) to the end of the string values in the following subsections: `... > production > buildTarget` and `... > development > buildTarget`.

   The updated subsections should appear as follows:

   ```json
           "architect": {
             "serve": {
               "builder": "@angular-devkit/build-angular:dev-server",
                 "configurations": {
                   "production": {
                     "buildTarget": "YOUR-APP-NAME:build:production,noSsr"
                   },
                   "development": {
                     "buildTarget": "YOUR-APP-NAME:build:development,noSsr"
                   }
   ```

1. Remove the following three sections entirely: `architect > server`, `architect > serve-ssr` and `architect > prerender`.

   These sections are removed because their responsibilities are now handled by the single, new Angular `application` builder.

   In the following example, everything after the first line (`"architect": {`) should be removed:

   ```json
          "architect": {
            "server": {
              "builder": "@angular-devkit/build-angular:server",
              "options": {
                "outputPath": "dist/YOUR-APP-NAME/server",
                "main": "server.ts",
                "tsConfig": "tsconfig.server.json",
                "stylePreprocessorOptions": {
                  "includePaths": [
                    "node_modules/"
                  ]
                },
                "inlineStyleLanguage": "scss"
              },
              "configurations": {
                "production": {
                  "outputHashing": "media"
                },
                "development": {
                  "optimization": false,
                  "sourceMap": true,
                  "extractLicenses": false,
                  "vendorChunk": true,
                  "buildOptimizer": false
                }
              },
              "defaultConfiguration": "production"
            },
            "serve-ssr": {
              "builder": "@angular-devkit/build-angular:ssr-dev-server",
              "configurations": {
                "development": {
                  "browserTarget": "YOUR-APP-NAME:build:development",
                  "serverTarget": "YOUR-APP-NAME:server:development"
                },
                "production": {
                  "browserTarget": "YOUR-APP-NAME:build:production",
                  "serverTarget": "YOUR-APP-NAME:server:production"
                }
              },
              "defaultConfiguration": "development"
            },
            "prerender": {
              "builder": "@angular-devkit/build-angular:prerender",
              "options": {
                "routes": [
                  "/"
                ]
              },
              "configurations": {
                "production": {
                  "browserTarget": "YOUR-APP-NAME:build:production",
                  "serverTarget": "YOUR-APP-NAME:server:production"
                },
                "development": {
                  "browserTarget": "YOUR-APP-NAME:build:development",
                  "serverTarget": "YOUR-APP-NAME:server:development"
                }
              },
              "defaultConfiguration": "production"
            }
   ```

1. In `package.json`, change the following `"scripts"` properties, because the new `application` builder handles the SSR and prerendering with different commands:

   1. Remove the `"dev:ssr"` and `"prerender"` properties.

   1. Change the value of the `"build:ssr"` property to `"ng build"`.

      The updated `"build:ssr"` property should appear as follows:

      ```json
         "scripts": {
            "build:ssr": "ng build"
      ```

   1. Rename the `"serve:ssr"` property to `"serve:ssr:YOUR-APP-NAME"` and change its value to `"node dist/YOUR-APP-NAME/server/server.mjs"`

      The updated `"serve:ssr"` property should appear as follows:

      ```json
         "scripts": {
           "serve:ssr:YOUR-APP-NAME": "node dist/YOUR-APP-NAME/server/server.mjs",
      ```

1. In `tsconfig.app.json`, add `"node"` to the array in the `"types"`property.

   The updated array should appear as follows:

   ```json
      "types": [
        "node"
      ]
   ```

1. In `tsconfig.app.json`, add the following two new items to the `"files"` array: `"src/main.server.ts"` and `"server.ts"`.

   The updated `"files"` array should appear as follows:

   ```diff
      "files": [
        "src/main.ts",
        "src/main.server.ts",
        "server.ts"
      ]
   ```

1. Remove the `tsconfig.server.json` file.

   For example, you can do this by running the following command on Mac or Linux:

   ```bash
   rm tsconfig.server.json
   ```

1. Rename the `app.server.module.ts` file to `app.module.server.ts`.

   For example, you can do this by running the following command on Mac or Linux:

   ```bash
   mv src/app/app.server.module.ts src/app/app.module.server.ts
   ```

1. In `src/main.server.ts`, change the export path of the `AppServerModule` from `./app/app.server.module'` to `./app/app.module.server'`.
1. And `as default` to the `AppServerModule` export, as shown in the following example:

   ```ts
   export { AppServerModule as default } from './app/app.module.server';
   ```

1. At the top of the `server.ts` file, select (highlight) the following imports:

   ```ts
   import 'zone.js/node';
   
   import { ngExpressEngine as engine } from - '@spartacus/setup/ssr';
   import { NgExpressEngineDecorator } from - '@spartacus/setup/ssr';
   import * as express from 'express';
   import { join } from 'path';
   
   import { AppServerModule } from './src/main.- server';
   import { APP_BASE_HREF } from '@angular/common';
   import { existsSync } from 'fs';
   ```

1. Replace the selected imports with the following imports:

   ```ts
   import { APP_BASE_HREF } from '@angular/common';
   import {
     NgExpressEngineDecorator,
     ngExpressEngine as engine,
   } from '@spartacus/setup/ssr';
   import express from 'express';
   import { dirname, join, resolve } from 'node:path';
   import { fileURLToPath } from 'node:url';
   import AppServerModule from './src/main.server';
   ```

1. In `server.ts`, remove the following constants:

   ```ts
   const distFolder = join(process.cwd(), 'dist/YOUR-APP-NAME/browser');
   const indexHtml = existsSync(join(distFolder, 'index.original.html'))
     ? 'index.original.html'
     : 'index';
   ```

1. In `server.ts`, add the following constants:

   ```ts
   const serverDistFolder = dirname(fileURLToPath(import.meta.url));
   const browserDistFolder = resolve(serverDistFolder, '../browser');
   const indexHtml = join(browserDistFolder, 'index.html');
   ```

1. In the `server.set('views'` call of `server.ts`, use the `browserDistFolder` constant as a second argument, instead of `distFolder`.

   The updated call should appear as follows:

   ```ts
   server.set('views', browserDistFolder);
   ```

1. In the `express.static(` call of `server.ts`, please use the `browserDistFolder` constant as a first argument, instead of `distFolder`.

   The updated call should appear as follows:

   ```ts
      server.get(
        '*.*',
        express.static(browserDistFolder, {
   ```

1. At the end of `server.ts`, remove the following block of code that is related to handling Webpack's `require`:

   ```ts
   // Webpack will replace 'require' with - '__webpack_require__'
   // '__non_webpack_require__' is a proxy to Node 'require'
   // The below code is to ensure that the server is run - only when not requiring the bundle.
   declare const __non_webpack_require__: NodeRequire;
   const mainModule = __non_webpack_require__.main;
   const moduleFilename = (mainModule && mainModule.- filename) || '';
   if (moduleFilename === __filename || moduleFilename.- includes('iisnode')) {
     run();
   }
   ```

1. In place of the block of code that was removed in the previous step, add the following line:

   ```ts
   run();
   ```

1. At the very end of `server.ts`, remove the following line:

   ```ts
   export * from './src/main.server';
   ```

   You have now completed the migration of your app to use the Angular `application` builder. You can now continue with the following procedure.

## Using Non-Deprecated Angular APIs

After completing the migration of your app to use the new Angular `application` builder, it is also necessary to update the `app.module.ts` file to use new, non-deprecated Angular APIs.

1. In `src/app/app.module.ts`, remove `HttpClientModule` from the `imports` array.

1. Add `provideHttpClient(withFetch(), withInterceptorsFromDi()),` to the `providers` array.

   The following is an example:

   ```ts
     providers: [
       provideHttpClient(withFetch(), withInterceptorsFromDi()),
       /*...*/
     ],
   ```

1. If your storefront app uses SSR, you must also replace `BrowserModule.withServerTransition({ appId: 'serverApp' }),` with `BrowserModule` in the `imports` array.

   The update `imports` array should appear as follows:

   ```ts
     imports: [
        BrowserModule,
        /*...*/
     ],
   ```

## Next Steps

Congratulations! Your storefront app has been modernized to look like a new Angular 17 app. You can now continue with updating your Spartacus app by following the rest of the procedures in [Update Release 2211.36](./migration.md).

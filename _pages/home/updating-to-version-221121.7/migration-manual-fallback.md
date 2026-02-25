---
title: Manually Updating Spartacus to Version 221121.7 (Fallback Steps Only)
---

The procedures on this page are provided only in case you encounter an issue while running the Spartacus update schematics described in [Updating Spartacus to 221121.7](migration.md#updating-spartacus-to-2211217). If you have already successfully run the update schematics, you can ignore the steps on this page.

This page describes the changes that the Spartacus update schematics perform automatically. If you have run the update schematics and encountered an issue, proceed with the following manual steps to upgrade your storefront app to version 221121.7.

1. In `angular.json`, remove the redundant `index` property, `"index": "src/index.html",`.

   For more information, see the relevant angular-cli [commit](https://github.com/angular/angular-cli/commit/901ab60d9f63fcff17213dbf7fe17e4a46835974) and [pull request](https://github.com/angular/angular-cli/pull/29905) in GitHub.

2. Update `tsconfig.json` to appear as follows:

   ```json
   /* To learn more about Typescript configuration file: https://www.typescriptlang.org/docs/handbook/tsconfig-json.html. */
   /* To learn more about Angular compiler options: https://angular.dev/reference/configs/angular-compiler-options. */
   {
     "compileOnSave": false,
     "compilerOptions": {
       "strict": true,
       "noImplicitOverride": true,
       "noPropertyAccessFromIndexSignature": true,
       "noImplicitReturns": true,
       "noFallthroughCasesInSwitch": true,
       "skipLibCheck": true,
       "isolatedModules": true,
       "experimentalDecorators": true,
       "importHelpers": true,
       "target": "ES2022",
       "module": "preserve"
     },
     "angularCompilerOptions": {
       "enableI18nLegacyMessageIdFormat": false,
       "strictInjectionParameters": true,
       "strictInputAccessModifiers": true,
       "strictTemplates": true
     },
     "files": [],
     "references": [
       {
         "path": "./tsconfig.app.json"
       },
       {
         "path": "./tsconfig.spec.json"
       }
     ]
   }
   ```

   **Note:** In newly created apps generated with Angular 21 CLI, the `typeCheckHostBindings` flag is enabled by default. Accordingly, we suggest adding it also in apps updated from Angular 19 to 21. However in apps that have been updated from Angular 19 to 21, be aware this could cause issues. Due to its strict type checking, it causes a [known Angular issue](https://github.com/angular/angular/issues/63170) if specific `keydown` bindings are used in `@HostListener` decorators. To solve the problem in the Spartacus repository, [type augmentation](https://github.com/SAP/spartacus/blob/ac651f413f44345bf8519391789c4f47c8ed02b0/types.d.ts#L1) was introduced for the `global` interface. If you encounter similar issues in your application, it is recommended that you apply similar augmentation solutions in your project, as was done in the Spartacus repo.

   Although it is not recommended, you can still disable the flag by adding the following configuration to your `tsconfig.json`:

   ```json
   {
     "angularCompilerOptions": {
       "typeCheckHostBindings": false
     },
   }
   ```

3. In your `app.module.ts` file, add the `provideBrowserGlobalErrorListeners` and `provideZoneChangeDetection({ eventCoalescing: true }),` to the `providers` array.

   The following is an example:

   ```ts
   import { NgModule, provideBrowserGlobalErrorListeners, provideZoneChangeDetection } from '@angular/core';
   import { BrowserModule } from '@angular/platform-browser';
   
   import { provideHttpClient, withFetch, withInterceptorsFromDi } from "@angular/common/http";
   import { EffectsModule } from "@ngrx/effects";
   import { StoreModule } from "@ngrx/store";
   import { AppRoutingModule } from "@spartacus/storefront";
   import { App } from './app.component';
   import { SpartacusModule } from './spartacus/spartacus.module';
   
   @NgModule({
     declarations: [
       App
     ],
     imports: [
       BrowserModule,
       StoreModule.forRoot({}),
       AppRoutingModule,
       EffectsModule.forRoot([]),
       SpartacusModule
     ],
     providers: [
       provideBrowserGlobalErrorListeners(),
       provideZoneChangeDetection({ eventCoalescing: true }),
       provideHttpClient(withFetch(), withInterceptorsFromDi())
     ],
     bootstrap: [App]
   })
   export class AppModule { }
   ```

   For more information about the `provideBrowserGlobalErrorListeners`, see [Client-side rendering](https://angular.dev/best-practices/error-handling#client-side-rendering) in the official Angular documentation.

   For more about information about the `provideZoneChangeDetection`, see [provideZoneChangeDetection](https://angular.dev/api/core/provideZoneChangeDetection) in the official Angular documentation.

4. In `main.ts`, remove `import { provideZoneChangeDetection } from '@angular/core';`, and remove the `applicationProviders` with `provideZoneChangeDetection({ eventCoalescing: true })` from the `platformBrowser().bootstrapModule` call.

   The following is an example:

   ```ts
   platformBrowser().bootstrapModule(AppModule, {
   })
     .catch(err => console.error(err));
   ```

5. Third-party dependencies in `package.json` should be updated to the `Current Version`, as follows:

| Library Name                    | Version Before | Current Version | Change Type |
| ------------------------------- | -------------- | --------------- | ----------- |
| `@fontsource/open-sans`         | `^5.1.0`       | `^5.2.7`        | Minor       |
| `@fortawesome/fontawesome-free` | `6.7.2`        | `7.1.0`         | Major       |
| `i18next`                       | `^24.2.1`      | `^25.7.4`       | Major       |
| `i18next-http-backend`          | `^3.0.1`       | `^3.0.2`        | Patch       |
| `parse5`                        | `^7.2.1`       | `^8.0.0`        | Major       |

## Additional Steps if Using SSR with Express

1. Add the `build:ssr` script to `package.json`

   The Angular `use-application-builder` migration (available when updating to Angular 20 and Angular 21) removes the `build:ssr` script from `package.json`. This script is required for SAP Commerce Cloud build process.

   In `package.json`, add the `build:ssr` script, as shown in the following example:

   ```json
   {
     "scripts": {
       "ng": "ng",
       "start": "ng serve",
       "build": "ng build",
       "build:ssr": "ng build",
       "watch": "ng build --watch --configuration development",
       "test": "ng test"
     }
   }
   ```

1. Run the following command to update Express to version 5.

   ```bash
   ng update express@5.1.0
   git add .
   git commit -m "chore: upgrade Express to v5.1.0"
   ```

1. In `server.ts`, update the wildcard strings with regular expressions for Express 5 compatibility.

   The following is an example of the updated `server.ts` file:

   ```ts
     // Serve static files from /browser
     server.get(
       /.*\..*/,
       express.static(browserDistFolder, {
         maxAge: '1y',
       })
     );
   
     // All regular routes use the Universal engine
     server.get(/.*/, (req, res) => {
       res.render(indexHtml, {
         req,
         providers: [{ provide: APP_BASE_HREF, useValue: req.baseUrl }],
       });
     });
   ```

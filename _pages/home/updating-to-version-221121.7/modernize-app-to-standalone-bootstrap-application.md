---
title: Modernizing Your Storefront (Manual Fallback Steps Only)
---

If you wish to run the automated Spartacus schematics that modernize your app to use the Angular `bootstrapApplication()` API and convert your root `AppComponent` to a standalone component, see [Modernizing Your Storefront to Use the Standalone Bootstrap Application](migration.md#modernizing-your-storefront-to-use-the-standalone-bootstrap-application).

The procedures on this page are provided only in case you encountered an issue while running the Spartacus schematics for [Modernizing Your Storefront to Use the Standalone Bootstrap Application](migration.md#modernizing-your-storefront-to-use-the-standalone-bootstrap-application). If you have already successfully run those schematics, you can ignore the steps below.

1. In `src/app/app.component.ts`, convert your root `AppComponent` to a standalone component by removing `standalone: false` and adding the necessary imports of Spartacus `StorefrontComponent`.

   The following is an example of how your `app.component.ts` file should look:

   ```ts
   import { StorefrontComponent } from '@spartacus/storefront';
   
    @Component({
     selector: 'app-root',
     imports: [StorefrontComponent],
    })
    export class AppComponent {
   ```

   **Note:** The root component must be standalone to work with the modern Angular `bootstrapApplication()` API.

2. In `src/app/app.module.ts`, remove the following Angular configurations from your `AppModule`:

   - remove `bootstrap: [AppComponent]` from `@NgModule`
   - remove `declarations: [AppComponent]` from `@NgModule`
   - remove the following `providers` from `@NgModule`:
     - `provideBrowserGlobalErrorListeners()`
     - `provideZoneChangeDetection({ eventCoalescing: true })`
     - `provideHttpClient(withFetch(), withInterceptorsFromDi())`
   - remove `BrowserModule` from the `imports` array of `@NgModule`

   The following is an example of how your `app.module.ts` file should look:

   ```ts
    @NgModule({
     imports: [
       /*...*/
       StoreModule.forRoot({}),
       AppRoutingModule,
       EffectsModule.forRoot([]),
       SpartacusModule
     ],
     providers: [
      /* REMOVED:
       *  provideBrowserGlobalErrorListeners(),
       *  provideZoneChangeDetection({ eventCoalescing: true }),
       *  provideHttpClient(withFetch(), withInterceptorsFromDi()),
       */
     ],
    })
    export class AppModule { }
   ```

   **Note:** In the next step, the Angular configurations are moved to a new file, named `app.config.ts`.

3. Create a new file called `src/app/app.config.ts`.
4. In the new `app.config.ts` file, which will contain the Angular configurations previously located in `AppModule`, import what remains in the `AppModule` using `importProvidersFrom(AppModule)`.

   The following is an example of how your `app.config.ts` file should look:

   ```typescript
   import { provideHttpClient, withFetch, withInterceptorsFromDi } from '@angular/common/http';
   import {
     ApplicationConfig,
     importProvidersFrom,
     provideBrowserGlobalErrorListeners,
     provideZoneChangeDetection,
   } from '@angular/core';
   import {
     provideClientHydration,
     withEventReplay,
     withNoHttpTransferCache,
   } from '@angular/platform-browser';
   import { AppModule } from './app.module';
   
   export const appConfig: ApplicationConfig = {
     providers: [
       provideBrowserGlobalErrorListeners(),
       provideZoneChangeDetection({ eventCoalescing: true }),
       provideHttpClient(withFetch(), withInterceptorsFromDi()),
   
       importProvidersFrom(AppModule),
     ],
   };
   ```

5. In `src/main.ts`, replace the old `platformBrowser().bootstrapModule(AppModule)` with the modern `bootstrapApplication(appConfig)` API, which points to the new `app.config.ts` file.

6. Remove the following imports from `src/main.ts`:

   - `import { platformBrowser } from '@angular/platform-browser';`
   - `import { AppModule } from './app/app.module';`

7. Add the following imports to `src/main.ts`:

   - `import { bootstrapApplication } from '@angular/platform-browser';`
   - `import { appConfig } from './app/app.config';`
   - `import { AppComponent } from './app/app.component';`

   Your `src/main.ts` should now look like the following example:

   ```ts
   import { bootstrapApplication } from '@angular/platform-browser';
   import { appConfig } from './app/app.config';
   import { AppComponent } from './app/app.component';
   
   bootstrapApplication(AppComponent, appConfig)
     .catch((err) => console.error(err));
   ```

8. In the `"schematics"` section of your `angular.json` file, remove `"standalone": false,` from `"@schematics/angular:component"` and `"@schematics/angular:directive"`, and remove `"@schematics/angular:pipe"` altogether.

   The following is an example of the updated `angular.json` file:

   ```json
   "schematics": {
     "@schematics/angular:component": {
       "style": "scss",
       "type": "component",
       "addTypeToClassName": false
     },
     "@schematics/angular:directive": {
       "type": "directive",
       "addTypeToClassName": false
     },
     "@schematics/angular:service": {
       "type": "service",
   ```

   **Note:** With this update, you will now be able to create new custom components with the Angular CLI (`ng generate component ...`) as standalone by default.

## Manual Migration for SSR Projects (Fallback Steps Only)

If your storefront app does not use server-side rendering (SSR), you can ignore these steps.

1. Create a new file for Angular SSR configuration, named `src/app/app.config.server.ts`.
2. In your new `app.config.server.ts` file, import what remains in `AppServerModule` using `importProvidersFrom(AppServerModule)`.

   The following is an example of how your `app.config.server.ts` file should look:

   ```typescript
   import { ApplicationConfig, importProvidersFrom, mergeApplicationConfig } from '@angular/core';
   import { provideServerRendering } from '@angular/ssr';
   import { appConfig } from './app.config';
   import { AppServerModule } from './app.module.server';
   
   const serverConfig: ApplicationConfig = {
     providers: [provideServerRendering(), importProvidersFrom(AppServerModule)],
   };
   
   export const config = mergeApplicationConfig(appConfig, serverConfig);
   ```

3. In `src/app/app.module.server.ts`, remove the following Angular configurations from your `AppServerModule`:

   - remove `imports: [AppModule]` from `@NgModule`
   - remove `bootstrap: [AppComponent]` from `@NgModule`

   The following is an example of how your `app.module.server.ts` file should look:

   ```ts
    import { NgModule } from '@angular/core';
    import { provideServer } from '@spartacus/setup/ssr';
   
    @NgModule({
     providers: [
       ...provideServer({
         serverRequestOrigin: process.env['SERVER_REQUEST_ORIGIN'],
       }),
     ],
     })
     export class AppServerModule {}
   ```

4. In `src/main.server.ts`, replace the old default re-export `AppServerModule` to a function-based default `bootstrap` export that uses `bootstrapApplication()` with the server configuration from `app.config.server.ts`.

   Specifically, remove `export { AppServerModule as default } from './app/app.module.server';`, and otherwise update `main.server.ts` to look as follows:

   ```ts
   import { BootstrapContext, bootstrapApplication } from '@angular/platform-browser';
   import { AppComponent } from './app/app.component';
   import { config } from './app/app.config.server';
   
   const bootstrap = (context: BootstrapContext) =>
     bootstrapApplication(AppComponent, config, context);
   
   export default bootstrap;
   ```

5. In `src/server.ts`, rename the default import from `AppServerModule` to the `bootstrap` function, and update the `ngExpressEngine` configuration accordingly.

   Specifically, remove `import AppServerModule from './main.server';`, remove `bootstrap: AppServerModule,` from `ngExpressEngine`, and otherwise update `server.ts` to look as follow:

   ```ts
   import bootstrap from './main.server';
   
    /* ... */
   
       ngExpressEngine({
        bootstrap,
       })
   ```

6. In `src/app/app.module.ts`, remove the configuration of non-destructive client hydration from `AppModule`.

   Specifically, remove `provideClientHydration(withEventReplay(), withNoHttpTransferCache())` from the `providers` array. Your `app.module.ts` file should look as follows:

   ```ts
    @NgModule({
      /* ... */
      providers: [
        /* ... There should be no `provideClientHydration(withEventReplay(), withNoHttpTransferCache())` here */
      ],
    })
    export class AppModule { }
   };
   ```

   **Note:** The configuration of non-destructive client hydration is moved to `app.config.ts` in the next step.

7. In `src/app/app.config.ts`, add the configuration of non-destructive client hydration, as shown in the following example:

   ```ts
    export const appConfig: ApplicationConfig = {
      providers: [
        /* ... */
        provideClientHydration(withEventReplay(), withNoHttpTransferCache())
     ]
   };
   ```

   You have now modernized your app to use Angular's `bootstrapApplication()` API and converted your root `AppComponent` to a standalone component, aligning it with current Angular best practices.

   It is also strongly recommended that you migrate your custom components to standalone components. For more information, see [Migrating to Standalone Components in Spartacus](standalone-components-in-spartacus.md).

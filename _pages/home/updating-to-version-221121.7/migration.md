---
title: Update Release 221121.7
---

To update your Spartacus app to version 221121.7, you must carry out the following steps:

1. Update your Spartacus app to version 221121.5 (with Angular 19). For more information, see [Update Release 221121.5](link-added-post-conversion).
2. Ensure you have Node.js 22 installed. Version 22.22.0 is the minimum required. The most recent 22.x version is strongly recommended. For more information, see the official [Node.js website](https://nodejs.org/en).
3. Update your Angular libraries. For more information, see [Updating Your Angular Libraries](#updating-your-angular-libraries).
4. Update Spartacus to 221121.7.
5. Modernize your storefront to use the standalone `bootstrapApplication()` function. For more information, see [Modernizing Your Storefront to Use the Standalone Bootstrap Application](modernize-app-to-standalone-bootstrap-application.md).
6. Optionally migrate your custom components to standalone components. For more information, see [Standalone Components in Spartacus](standalone-components-in-spartacus.md).

## Updating Your Angular Libraries

Before updating Spartacus to version 221121.7, you first need to make sure your Angular libraries are up to date. Spartacus 221121.7 requires Angular 21.

You can update your application to use Angular 21 as follows:

- Start by updating Angular to version 20. Ensure that third-party dependencies are compatible with Angular 20, and verify that any breaking changes have been addressed.
- When you have finished updating to Angular 20, you can then update to Angular 21.

### Updating to Angular 20

1. Run the following command, which updates the Angular version locally, and also updates other third-party dependencies from the Angular ecosystem to versions that are compatible with Angular 20, such as `@ng-select/ng-select@20`, `@ngrx/store@20`, `angular-oauth2-oidc@20`, and `ngx-infinite-scroll@20`:

   ```bash
   ng update @angular/core@20 @angular/cli@20 @ngrx/store@20 angular-oauth2-oidc@20 @ng-select/ng-select@20 ngx-infinite-scroll@20 --force
   git add .
   git commit -m "update angular 20 and 3rd party deps angular 20 compatible"
   ```

   This command is sourced from the Angular [Update Guide](https://angular.dev/update-guide?v=19.0-20.0&l=3) for updating from version 19 to version 20.

2. While you are updating to Angular 20, run the migration to replace old builders located under `@angular-devkit/build-angular` with new builders located under `@angular/build`.

   The option to run this migration appears as follows:

   ```bash
   ❯◯ [use-application-builder] Migrate application projects to the new build system.
   ```

   The result should appear as follows:

   ```json
    "projects": {
       <your-project-name>: {
         "projectType": "application",
         "prefix": "app",
         "architect": {
           "build": {
             "builder": "@angular/build:application",
               ...
           },
           "serve": {
             "builder": "@angular/build:dev-server",
             ...
           },
           "extract-i18n": {
             "builder": "@angular/build:extract-i18n"
           },
           "test": {
             "builder": "@angular/build:karma",
           }
         }
       },
      "schematics": {
       "@schematics/angular:component": {
         "type": "component"
       },
       "@schematics/angular:directive": {
         "type": "directive"
       },
       "@schematics/angular:service": {
         "type": "service"
       },
       "@schematics/angular:guard": {
         "typeSeparator": "."
       },
       "@schematics/angular:interceptor": {
         "typeSeparator": "."
       },
       "@schematics/angular:module": {
         "typeSeparator": "."
       },
       "@schematics/angular:pipe": {
         "typeSeparator": "."
       },
       "@schematics/angular:resolver": {
         "typeSeparator": "."    }
     }
   ```

   You might also be offered the option to run the following migrations when updating to Angular 20:

   ```bash
   Select the migrations that you'd like to run  
   ❯◯ [control-flow-migration] Converts the entire application to block control flow syntax.  
    ◯ [router-current-navigation] Replaces usages of the deprecated Router getCurrentNavigation method with the Router.currentNavigation signal.
   ```

   In terms of updating Spartacus to version 221121.7, these migrations are not required. However, you can safely run these migrations if you wish to.

### Updating to Angular 21

1. Run the following command, which updates the Angular version locally, and also updates other third-party dependencies from the Angular ecosystem to versions that are compatible with Angular 21, such as `@ng-select/ng-select@21`, `@ngrx/store@21`, `angular-oauth2-oidc@20`, and `ngx-infinite-scroll@21`:

   ```bash
   ng update @angular/core@21 @angular/cli@21 @ngrx/store@21 angular-oauth2-oidc@20 @ng-select/ng-select@21 ngx-infinite-scroll@21 --force
   git add .
   git commit -m "update angular 21 and 3rd party deps angular 21 compatible"
   ```

   This command is sourced from the Angular [Update Guide](https://angular.dev/update-guide?v=20.0-21.0&l=3) for updating from version 20 to version 21.

2. While you are updating to Angular 21, if you have not already done so, run the migration to replace old builders located under `@angular-devkit/build-angular` with new builders located under `@angular/build`.

   The option to run this migration appears as follows:

   ```bash
   ❯◯ [use-application-builder] Migrate application projects to the new build system.
   ```

   The result of migration should be similar to the one shown in the previous section for updating to Angular 20. If you already ran the `use-application-builder` migration when you were updating to Angular 20, this migration won't make any further changes.

## Updating Spartacus to 221121.7

The update to Spartacus 221121.7 is mostly focused on updating the framework to Angular 21. With framework updates, there is always the chance that breaking changes could be introduced for your application. In this case, additional work on your side may be required to fix issues that result from updating from 221121.5 to 221121.7.

**Note:** You must start with a version 221121.5 Spartacus app to be able to update to version 221121.7.

1. Run the following command in the workspace of your Angular application:

   ```bash
   ng update @spartacus/schematics@221121.7
   ```

   If the migration fails for any reason, proceed with the steps described in [Manually Updating Spartacus (Fallback Steps Only)](migration-manual-fallback.md).

1. In `angular.json`, you can optionally remove the redundant `outputPath` property if it matches the default value.

   This is a manual change that is not handled by the Spartacus update schematics.

   In newly-created Spartacus apps that are generated with Angular 21, the `outputPath` option is skipped and implicitly defaults to `dist/<your-project-name>`. If your migrated app has the `outputPath` set to `dist/<your-project-name>`, it is recommended that you remove it from `angular.json`, since it is not necessary.

## Enabling Non-Destructive Hydration

If your Spartacus app does not use server-side rendering (SSR), you do not need to enable non-destructive hydration. You can now proceed with [Modernizing Your Storefront to Use the Standalone Bootstrap Application](modernize-app-to-standalone-bootstrap-application.md).

If your storefront application does use SSR, you must enable non-destructive hydration. Enabling non-destructive hydration aligns your app with current Angular best practices, making it easier to maintain and update your storefront application.

Non-destructive hydration is an Angular feature that improves performance by reusing the server-rendered DOM instead of destroying and recreating it on the client side. This reduces the Time to Interactive (TTI) metric and provides a better user experience.

For more information, see [Hydration](https://angular.dev/guide/hydration) in the official Angular documentation.

If you are working with a module-based application, you enable non-destructive hydration by adding `provideClientHydration()` with `withEventReplay()` and `withNoHttpTransferCache()` in your `app.module.ts` file, as shown in the following example:

```ts
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import {
  provideClientHydration,
  withEventReplay,
  withNoHttpTransferCache,
} from '@angular/platform-browser';

@NgModule({
  imports: [
    BrowserModule,
    // ...
  ],
  providers: [
    provideClientHydration(withEventReplay(), withNoHttpTransferCache()),
    // ...
  ],
  // ...
})
export class AppModule { }
```

If you are working with a standalone application, you enable non-destructive hydration by adding `provideClientHydration()` with `withEventReplay()` and `withNoHttpTransferCache()` in your `app.config.ts` file, as shown in the following example:

```typescript
import { ApplicationConfig } from '@angular/core';
import {
  provideClientHydration,
  withEventReplay,
  withNoHttpTransferCache,
} from '@angular/platform-browser';

export const appConfig: ApplicationConfig = {
  providers: [
    provideClientHydration(withEventReplay(), withNoHttpTransferCache()),
    // ...
  ]
};
```

The `withEventReplay()` and `withNoHttpTransferCache()` options are required for the following reasons:

- `withEventReplay()` ensures that user interactions that occur before the application is fully hydrated are captured and replayed. This provides a seamless user experience even during the hydration process.
- `withNoHttpTransferCache()` disables the HTTP transfer cache for hydration. This is required for Spartacus because the storefront app uses its own state transfer mechanism. Without this option, there could be conflicts between Angular's built-in HTTP transfer cache and custom implementation provided in Spartacus.

**Note:** Ensure you test your application thoroughly after enabling non-destructive hydration to ensure all components hydrate correctly.

You can now proceed with [Modernizing Your Storefront to Use the Standalone Bootstrap Application](modernize-app-to-standalone-bootstrap-application.md).

### Known Warning: NG05001

After enabling hydration, you may see the following warning in your console:

```text
NG05001: Configuration error: found both hydration and enabledBlocking initial navigation 
in the same application, which is a contradiction.
```

In practice, no issues were encountered with this setup.

This diagnostic was introduced by the Angular team during the development of Angular 21 ([Angular issue #59624](https://github.com/angular/angular/issues/59624), [Angular PR #62963](https://github.com/angular/angular/pull/62963)). The warning appears because Spartacus uses `initialNavigation: 'enabledBlocking'` in its router configuration to ensure proper CMS page loading and lazy-loading of JS chunks before rendering the components.

It is not clear why this diagnostic was added by the Angular team. Since May 2025, no negative consequences have been observed with the current setup. The implications are still being investigating, and an update will provided if it is deemed to be necessary.

Observations about this warning so far are the following:

- Since May 2025, no functional issues have been reported that are related to this warning
- Both hydration and `enabledBlocking` work correctly together in Spartacus
- During SSR, `enabledBlocking` ensures all route guards (including `CmsPageGuard`) complete before rendering
- During hydration in the browser, Angular's hydration system prevents UI flickering by reusing the server-rendered DOM

You can safely ignore this warning for now. This topic continues to be actively monitored, and if any issues are found, they will be addressed in a future release of Spartacus, as required and as part of the ongoing modernization of the SSR implementation.

## Known Issue

As described in the [Font Awesome documentation](https://docs.fontawesome.com/upgrade/whats-changed/#fixed-width-icons-by-default), the Font Awesome library introduce a breaking change in version 7.x. By default, all Font Awesome icons now display at a fixed width rather than an automatic width.

As as result, you might see icons overlapping sibling HTML elements. So far, two occurrences have been observed, for the Product Configuration alert icon, and the legacy carousel circle icons.

This issue can be resolved by manually adding the following in `root.scss`:

```css
--fa-width: auto;
```

More information about this solution can be found in the [official Font Awesome documentation](https://docs.fontawesome.com/web/style/icon-canvas/#using-css-custom-properties).

**Note:** This issue will be addressed in the next release of Spartacus, at which point the workaround described above will no longer be required.

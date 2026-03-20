---
title: Update Release 221121.7
---

To update your Spartacus app to version 221121.7, you must carry out the following steps:

1. Update your Spartacus app to version 221121.5 (with Angular 19). For more information, see [Update Release 221121.5](link-added-post-conversion).
2. Ensure you have Node.js 22 installed. Version 22.22.0 is the minimum required. The most recent 22.x version is strongly recommended. For more information, see the official [Node.js website](https://nodejs.org/en).
3. Update your Angular libraries. For more information, see [Updating Your Angular Libraries](#updating-your-angular-libraries).
4. Update Spartacus to 221121.7. For more information, see [Updating Spartacus to 221121.7](#updating-spartacus-to-2211217).
5. Modernize your storefront to use the standalone `bootstrapApplication()` function. For more information, see [Modernizing Your Storefront to Use the Standalone Bootstrap Application](#modernizing-your-storefront-to-use-the-standalone-bootstrap-application).
6. Migrate your custom components to standalone components. This step is optional, but strongly recommended. For more information, see [Standalone Components in Spartacus](#standalone-components-in-spartacus).
7. Enable Non-Destructive Hydration. This is required for projects that use server-side rendering (SSR). For more information, see [Enabling Non-Destructive Hydration (SSR Only)](#enabling-non-destructive-hydration-ssr-only).

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

2. During the update to Angular 20, when you are asked if you want to "migrate application projects to the new build system" (which is to say, replace old builders located under `@angular-devkit/build-angular` with new builders located under `@angular/build`), run this migration.

   If you choose not to run the migration at this step, you will again have the option to run it during the update to Angular 21.

   During the update to Angular 20, the option to run this migration appears as follows:

   ```bash
   ❯◯ [use-application-builder] Migrate application projects to the new build system.
   ```

   The following is an example of the result when the migration is done:

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

  We recommend to NOT run the `control-flow-migration` now. We'll run it after Angular 20 migration, as described later in this document. Regarding `router-current-navigation` migration, you can run it, although it's not required.

### Migrating to New Control Flow

In the root folder of your repository, run the following command to migrate your code to use the new control flow syntax:

```bash
ng generate @angular/core:control-flow
```
***NOTE:*** If any errors occur during the migration, they will be displayed in the terminal with details about the error type and location. The migration process will continue to run and attempt to migrate as much code as possible. It is recommended to review the error messages and fix the issues and re-run the migration for remaining files.For more details about errors, refer to [Angular Control Flow Migration Errors](angular-control-flow-migration-errors.md).

Commit the changes after the migration is complete:

```bash
git add .
git commit -m "Migrate to new control flow syntax"
```

### Updating to Angular 21

1. Run the following command, which updates the Angular version locally, and also updates other third-party dependencies from the Angular ecosystem to versions that are compatible with Angular 21, such as `@ng-select/ng-select@21`, `@ngrx/store@21`, `angular-oauth2-oidc@20`, and `ngx-infinite-scroll@21`:

   ```bash
   ng update @angular/core@21 @angular/cli@21 @ngrx/store@21 angular-oauth2-oidc@20 @ng-select/ng-select@21 ngx-infinite-scroll@21 --force
   git add .
   git commit -m "update angular 21 and 3rd party deps angular 21 compatible"
   ```

   This command is sourced from the Angular [Update Guide](https://angular.dev/update-guide?v=20.0-21.0&l=3) for updating from version 20 to version 21.

   **Note:** The inclusion of `angular-oauth2-oidc@20` in the update command for Angular 21 is not a mistake. Version 20 of this library is the most recently available library, and the author of the library indicates it is compatible with Angular 21, as indicated [in a comment in the GitHub repository](https://github.com/manfredsteyer/angular-oauth2-oidc/issues/1491#issuecomment-3590104924) for this library.

2. During the update to Angular 21, if you have not already done so, migrate application projects to the new build system (which is to say, run the migration to replace old builders located under `@angular-devkit/build-angular` with new builders located under `@angular/build`).

   The option to run this migration appears as follows:

   ```bash
   ❯◯ [use-application-builder] Migrate application projects to the new build system.
   ```

   This migration is also offered during the update to Angular 20, and the result of the migration should be similar to the one shown in the previous section for updating to Angular 20. If you already ran the `use-application-builder` migration when you were updating to Angular 20, running it again will not make any further changes.

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

1. When the update has finished running, inspect your code for comments that begin with `// TODO:Spartacus`.

   For detailed information about each added comment, see the following:

   - [Technical Changes in Spartacus 221121.7](link)
   - [Typescript Breaking Changes in Composable Storefront 221121.7](link)

## Modernizing Your Storefront to Use the Standalone Bootstrap Application

Modern Angular 21 apps use [standalone components](https://angular.dev/reference/migrations/standalone), as well as the `bootstrapApplication()` Angular API for bootstrapping the root standalone component, instead of using the old `bootstrapModule()`.

After you have updated your Spartacus application to version 221121.7, you need to modernize your storefront app to use the Angular `bootstrapApplication()` API.

Spartacus provides dedicated schematics to automatically modernize your app to use the Angular `bootstrapApplication()` API and convert your root `AppComponent` to a standalone component.

To modernize your app to use the Angular `bootstrapApplication()` API and convert your root `AppComponent` to a standalone component, run the following command from your project root directory:

```bash
ng g @spartacus/schematics:modernize-app-to-standalone-bootstrap-application
```

Now that you have modernized your storefront to work as a standalone application, it is strongly recommended that you also migrate your custom components to standalone components. For more information, see [Standalone Components in Spartacus](#standalone-components-in-spartacus).

If you run into any issue while running the schematics for modernizing your app, you can follow the manual fallback steps to complete the modernization of your app. For more information, see [Modernizing Your Storefront (Manual Fallback Steps Only)](modernize-app-to-standalone-bootstrap-application.md).

## Standalone Components in Spartacus

Now that you have updated your Spartacus app to version 221121.7, all Spartacus components have been converted to [Angular standalone components](https://angular.dev/reference/migrations/standalone). You can use Spartacus standalone components in the same way you previously used non-standalone components, including using them in your custom code. It should even be possible to use Spartacus standalone components in your custom non-standalone components. However, it is **strongly recommended** that you convert your custom components to standalone components. This will allow your storefront app to take advantage of the latest Angular features, innovations and best practices. Most importantly, it will make it easier for you to update your app when future framework updates are introduced in Spartacus.

**Note:** Angular `NgModules` are still in use in Spartacus. Although `NgModules` remain as non-standalone APIs, Spartacus uses them simply to organize features into cohesive modules. They are no longer used for declaring components.

### Migrating Unit Tests That Stub Child Components of Spartacus Components

If you have unit tests that stub child components of standard Spartacus components, you need to stub them differently, because stubbing standalone components in Angular works differently. For more information, see [Stubbing unneeded components](https://angular.dev/guide/testing/components-scenarios#stubbing-unneeded-components) in the official Angular documentation.

### Migrating Your Custom Components to Standalone Components

The Angular team strongly recommends converting your custom components to standalone components, as described in the [Angular Blog](https://blog.angular.dev/the-future-is-standalone-475d7edbc706). The benefits of standalone components include the following:

- Simplified component declarations, which means there is no longer a need for component declarations in your `NgModule`.
- Taking advantage of the latest Angular features and innovations, such as [Defer Loading](https://angular.dev/guide/templates/defer) and [Incremental Hydration](https://angular.dev/guide/incremental-hydration), which allow for better tree-shaking and performance. These features might also have other prerequisites, but standalone components is a major prerequisite for these features.

To automatically convert your custom components to Angular standalone components, from your project root directory, run `ng g @angular/core:standalone` and select "Convert all components, directives and pipes to standalone".

This step is taken from the Angular documentation describing how to [Migrate an existing Angular project to standalone](https://angular.dev/reference/migrations/standalone). In the Angular documentation, there are additional steps, but **do not** follow them. The second step removes "unnecessary NgModule classes", but in fact, Spartacus still uses `NgModules` for organizing features into cohesive modules. The third step is also unnecessary, because you have already carried out the necessary updates when you followed the procedure for [Modernizing Your Storefront to Use the Standalone Bootstrap Application](#modernizing-your-storefront-to-use-the-standalone-bootstrap-application), above.

## Enabling Non-Destructive Hydration (SSR Only)

If your Spartacus app does not use server-side rendering (SSR), you do not need to enable non-destructive hydration.

If your storefront application does use SSR, you must enable non-destructive hydration. Enabling non-destructive hydration aligns your app with current Angular best practices, making it easier to maintain and update your storefront application.

Non-destructive hydration is an Angular feature that improves performance by reusing the server-rendered DOM instead of destroying and recreating it on the client side. This helps to avoid flickering when transitioning from the server-side DOM to the client-side rendered DOM in the browser, which provides a better user experience.

For more information, see [Hydration](https://angular.dev/guide/hydration) in the official Angular documentation.

You enable non-destructive hydration by adding `provideClientHydration()` with `withEventReplay()` and `withNoHttpTransferCache()` in your `app.config.ts` file, as shown in the following example:

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
- `withNoHttpTransferCache()` disables the HTTP transfer cache for hydration. This is required for Spartacus because the storefront app uses its own state transfer mechanism. Without this option, there could be conflicts between Angular's built-in HTTP transfer cache and the custom implementation provided in Spartacus.

**Note:** Ensure you test your application thoroughly after enabling non-destructive hydration to ensure all components hydrate correctly.

### Known Warning: NG05001

After enabling hydration, you may see the following warning in your console in dev-mode build:

```text
NG05001: Configuration error: found both hydration and enabledBlocking initial navigation 
in the same application, which is a contradiction.
```

In practice, no issues were encountered with this setup.

This diagnostic was introduced by the Angular team during the development of Angular 21 ([Angular issue #59624](https://github.com/angular/angular/issues/59624), [Angular PR #62963](https://github.com/angular/angular/pull/62963)). The warning appears because Spartacus uses `initialNavigation: 'enabledBlocking'` in its router configuration to ensure proper CMS page loading and lazy-loading of JS chunks before rendering the components.

It is not clear why this diagnostic was added by the Angular team. Since May 2025, no negative consequences have been observed with the current setup. The implications are still being investigating, and an update will be provided if it is deemed to be necessary.

Observations about this warning so far are the following:

- Since May 2025, no functional issues have been reported that are related to this warning
- Both hydration and `enabledBlocking` work correctly together in Spartacus
- During SSR, `enabledBlocking` ensures all route guards (including `CmsPageGuard`) complete before rendering
- During hydration in the browser, Angular's hydration system prevents UI flickering by reusing the server-rendered DOM

You can safely ignore this warning for now. This topic continues to be actively monitored, and if any issues are found, they will be addressed in a future release of Spartacus, as required and as part of the ongoing modernization of the SSR implementation.

## Known Issue

As described in the [Font Awesome documentation](https://docs.fontawesome.com/upgrade/whats-changed/#fixed-width-icons-by-default), the Font Awesome library introduce a breaking change in version 7.x. By default, all Font Awesome icons now display at a fixed width rather than an automatic width.

As a result, you might see icons overlapping sibling HTML elements. So far, two occurrences have been observed, for the Product Configuration alert icon, and the legacy carousel circle icons.

This issue can be resolved by manually adding the following in `root.scss`:

```css
--fa-width: auto;
```

More information about this solution can be found in the [official Font Awesome documentation](https://docs.fontawesome.com/web/style/icon-canvas/#using-css-custom-properties).

**Note:** This issue will be addressed in an upcoming release of Spartacus, at which point the workaround described above will no longer be required.

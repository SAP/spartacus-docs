---
title: Update Release 2211.36
---

To update your Spartacus app to version 2211.36, you must carry out the following steps:

1. Modernize your storefront app to use the new Angular CLI configuration format introduced with Angular 17, but **only if your storefront app was originally created using Spartacus 6.x libraries or older**. Complete the steps in [Modernizing Your Storefront App That Was Upgraded to Version 2211.19](./modernize-apps-migrated-from-6.8-to-2211.19.md), and then continue with the rest of the steps here.

    If your original Spartacus app was built using version 2211.19 or newer libraries, skip this step and continue with the next steps.
1. Update your Spartacus app to version 2211.32.1. For more information, see [Update Release 2211.32](help portal link).
1. Install Node.js 22. For more information, see the official [Node.js website](https://nodejs.org/).
1. If your project uses server-side rendering (SSR), upgrade `@types/node` to version 22 by running the following command:

   ```bash
   npm i @types/node@22 -D
   ```

1. Update Your Angular Libraries. For more information, see [Updating Your Angular Libraries](#updating-your-angular-libraries).
1. Update Spartacus to version 2211.36. For more information, see [Updating Spartacus to 2211.36](#updating-spartacus-to-221136).
1. Adjust the use of Bootstrap in your project. For more information, see [Adjusting the Use of Bootstrap in Your Project](#adjusting-the-use-of-bootstrap-in-your-project).
1. Silence Sass deprecation warnings. For more information, see [Silencing Sass Deprecation Warnings](#silencing-sass-deprecation-warnings).
1. Modernize your migrated Angular 19 app to be as similar as possible to a new Angular 19 app. For more information, see [Modernizing Your Migrated Angular 19 Storefront App](#modernizing-your-migrated-angular-19-storefront-app).

## Updating Your Angular Libraries

Before updating Spartacus to version 2211.36, you first need to make sure your Angular libraries are up to date. Spartacus 2211.36 requires Angular 19.

You can update your application to use Angular 19 as follows:

- Start by updating Angular to version 18, and verify that all breaking changes have been addressed.
- When you have updated to Angular 18, you can then update to Angular 19.

### Updating to Angular 18

**Caution:** When migrating to Angular 18, you are offered the option to run the `use-application-builder` migration: `❯◯ [use-application-builder] Migrate application projects to the new build system.` **Do not select this migration**. Ensure the circle checkbox is empty `◯ [use-application-builder]` and only then press ENTER.

Run the following command to update the local version of Angular to version 18:

```bash
ng update @angular/core@18 @angular/cli@18 @ng-select/ng-select@13 @ngrx/store@18 ngx-infinite-scroll@18 --force
git add .
git commit -m "update angular 18 and 3rd party deps angular 18 compatible"
```

This command also updates other third-party dependencies from the Angular ecosystem to versions that are compatible with Angular 18, such as `@ng-select/ng-select@13`, `@ngrx/store@18`, and `ngx-infinite-scroll@18`.

For more information, see the official [Angular Update Guide](https://angular.dev/update-guide?v=17.0-18.0&l=3) for updating from version 17 to version 18.

### Updating to Angular 19

**Caution:** When migrating to Angular 19, you are again offered the option to run the `use-application-builder` migration, but this time it is preselected: `❯◉ [use-application-builder] Migrate application projects to the new build system.` **Unselect this migration**. Press the SPACE bar to make the circle checkbox empty `◯ [use-application-builder]` and only then press ENTER.

Run the following command to update the local version of Angular to version 19:

```bash
ng update @angular/cli@19 @angular/core@19 ngx-infinite-scroll@19 @ng-select/ng-select@14 @ngrx/store@19 angular-oauth2-oidc@19 --force
git add .
git commit -m "update angular 19 and 3rd party deps angular 19 compatible"
```

This command also updates other third-party dependencies from the Angular ecosystem to versions that are compatible with Angular 19, such as `@ng-select/ng-select@14`, `@ngrx/store@19`, and `ngx-infinite-scroll@19`.

For more information, see the official [Angular Update Guide](https://angular.dev/update-guide?v=18.0-19.0&l=3) for updating from version 18 to version 19.

## Updating Spartacus to 2211.36

The update to Spartacus 2211.36 is mostly focused on updating the framework to Angular 19. With framework updates, there is always the chance that breaking changes could be introduced for your application. In this case, additional work on your side may be required to fix issues that result from updating from 2211.32.1 to 2211.36.

**Note:** You must start with a version 2211.32.1 Spartacus app to be able to update to version 2211.36.

1. To update to version 2211.36 of Spartacus, run the following command in the workspace of your Angular application:

   ```bash
   ng update @spartacus/schematics@2211.36
   ```

1. Consult [Technical Changes in Spartacus 2211.36](./typescript-manual.doc.md) for information about additional changes that have been introduced in Spartacus 2211.36.
1. If your app uses server-side rendering (SSR) and the `application` builder, you also need to adjust the `server.ts` file by removing the following line:

   ```ts
   const indexHtml = join(browserDistFolder, 'index.html');
   ```

1. Continuing for apps that use SSR and the `application` builder, finish adjusting the `server.ts` file by adding the following line:

   ```ts
   const indexHtml = join(serverDistFolder, 'index.server.html');
   ```

## Adjusting the Use of Bootstrap in Your Project

Spartacus has internalized the styles for Bootstrap 4, so you do not need Bootstrap installed in your project anymore.

To handle these changes in your project, you first uninstall Bootstrap, then modify your `styles.scss` file to integrate the Spartacus styles along with Bootstrap. Having your imports in the correct order is necessary for the styles to be applied correctly.

These steps are described in more detail in the following procedure.

### Uninstalling Bootstrap and Updating styles.scss

1. If the bootstrap package is still installed in your project, uninstall it to avoid conflicts by running the following command:

   ```bash
   npm uninstall bootstrap
   ```

1. In `styles.scss`, place the following `styles-config` import at the top of the file:

   ```scss
   @import 'styles-config';
   ```

1. Add the `spartacus` core styles first, as follows:

   ```scss
   @import '@spartacus/styles/scss/core';
   ```

   Importing `spartacus` styles before Bootstrap styles ensures the core styles have priority when loaded.
1. Import Bootstrap styles using the Bootstrap copy that is provided by Spartacus. For consistency, ensure the order of the
   Bootstrap imports matches the sequence provided in the example below.
1. Following the Bootstrap imports, add the `spartacus` index styles.

   The following is an example of what the final file structure in `styles.scss` should look like:

   ```scss
   // ORDER IS IMPORTANT: Spartacus core is first
   @import '@spartacus/styles/scss/core';
   
   // ORDER IS IMPORTANT: Bootstrap next
   @import '@spartacus/styles/vendor/bootstrap/scss/reboot';
   @import '@spartacus/styles/vendor/bootstrap/scss/type';
   @import '@spartacus/styles/vendor/bootstrap/scss/grid';
   @import '@spartacus/styles/vendor/bootstrap/scss/utilities';
   @import '@spartacus/styles/vendor/bootstrap/scss/transitions';
   @import '@spartacus/styles/vendor/bootstrap/scss/dropdown';
   @import '@spartacus/styles/vendor/bootstrap/scss/card';
   @import '@spartacus/styles/vendor/bootstrap/scss/nav';
   @import '@spartacus/styles/vendor/bootstrap/scss/buttons';
   @import '@spartacus/styles/vendor/bootstrap/scss/forms';
   @import '@spartacus/styles/vendor/bootstrap/scss/custom-forms';
   @import '@spartacus/styles/vendor/bootstrap/scss/modal';
   @import '@spartacus/styles/vendor/bootstrap/scss/close';
   @import '@spartacus/styles/vendor/bootstrap/scss/alert';
   @import '@spartacus/styles/vendor/bootstrap/scss/tooltip';
   
   @import '@spartacus/styles/index';
   ```

1. Add individual imports.

   If your application directly imports specific Bootstrap classes in any of your stylesheets, replace those imports with the corresponding `spartacus` imports. For example, if you have an import such as the following:

   ```scss
   @import '~bootstrap/scss/reboot';
   ```

   You should replace it with the following:

   ```scss
   @import '@spartacus/styles/vendor/bootstrap/scss/reboot';
   ```

## Silencing Sass Deprecation Warnings

Silencing the deprecation warnings for the Sass `@import` is necessary because `@import` is used in the Spartacus styles and in the Bootstrap 4 styles, which are imported by the Spartacus styles.

If this action is not taken, version 19 Angular CLI pollutes the terminal with excessive deprecation warnings when you run `ng serve`, which makes the developer experience less pleasant.

For more information, see the following:

- [`@import` is Deprecated](https://sass-lang.com/blog/import-is-deprecated) in the official Sass documentation.
- [Style preprocessor options](https://angular.dev/reference/configs/workspace-config#style-preprocessor-options) in the official Angular documentation.

To silence Sass deprecation warnings, in the `architect > build > options > stylePreprocessorOptions` section of `angular.json`, add a property with the object `"sass": { "silenceDeprecations":  ["import"] }`, as shown in the following example:

```ts
              "stylePreprocessorOptions": {
                "includePaths": ["node_modules/"],
                "sass": {
                  "silenceDeprecations": ["import"]
                }
              }
```

## Modernizing Your Migrated Angular 19 Storefront App

Storefront apps that are migrated to Angular 19 are not configured in exactly the same way as newly created Angular 19 apps. It is highly recommended that you modernize your app to be as similar as possible to a new Angular 19 app. This will help with updating to new versions of Angular and Spartacus in the future.

Spartacus includes specially-prepared schematics to automatically modernize your app to be as similar as possible to a newly created Angular 19 app. To modernize your app using these schematics, run the following command from your project root directory:

```bash
ng g @spartacus/schematics:modernize-app-migrated-from-2211_32-to-2211_35
```

If you encounter any issues, you can complete the migration by following the manual migration steps provided in [Modernizing Your Storefront App After Upgrading to Version 2211.36](./modernize-apps-migrated-to-2211.36.md).

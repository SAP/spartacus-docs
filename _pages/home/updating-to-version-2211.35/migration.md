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

1. In `package.json`, if you haven't already done so, change the version range specifier for `@spartacus/schematics` from `^2211.32.1` to `~2211.32.1`.

   **Note:** For `@spartacus/schematics` in `package.json`, you are replacing `^` with `~`, but the version (`2211.32.1`) stays the same. It should **not** be changed to `2211.36.1`.

1. In `package.json`, set your `@spartacus` libraries to `“~2211.36.1"`, except `@spartacus/schematics`.

1. Run the following command in the workspace of your Angular application to install the updated dependencies:

   ```bash

   npm install --force
   git add .
   git commit -m "update Spartacus libraries to 2211.36.1 except schematics"
   ```

1. Run the following command in the workspace of your Angular application:

   ```bash
   ng update @spartacus/schematics@2211.36
   ```

   This command runs the `update` schematics, and updates your `@spartacus/schematics` package to version `2211.36.1`.

1. Consult [Technical Changes in Spartacus 2211.36](./typescript-manual.doc.md) for information about additional changes that have been introduced in Spartacus 2211.36.

## Updates to Bootstrap in Your Project

Spartacus has internalized the styles for Bootstrap 4, so you do not need Bootstrap installed in your project anymore.

To handle these changes in your project, the update schematics uninstall Bootstrap, and then modify your `styles.scss` file to integrate the Spartacus styles along with Bootstrap. The schematics ensure your imports are in the correct order, which is necessary for the styles to be applied correctly.

## Silencing Sass Deprecation Warnings

The update schematics take care of silencing deprecation warnings for the Sass `@import`. This is necessary because `@import` is used in the Spartacus styles and in the Bootstrap 4 styles (which are imported by the Spartacus styles).

If this action is not taken, version 19 Angular CLI pollutes the terminal with excessive deprecation warnings when you run `ng serve`, which makes the developer experience less pleasant.

For more information, see the following:

- [`@import` is Deprecated](https://sass-lang.com/blog/import-is-deprecated) in the official Sass documentation.
- [Style preprocessor options](https://angular.dev/reference/configs/workspace-config#style-preprocessor-options) in the official Angular documentation.

## Modernizing Your Migrated Angular 19 Storefront App

Storefront apps that are migrated to Angular 19 are not configured in exactly the same way as newly created Angular 19 apps. It is highly recommended that you modernize your app to be as similar as possible to a new Angular 19 app. This will help with updating to new versions of Angular and Spartacus in the future.

Spartacus includes specially-prepared schematics to automatically modernize your app to be as similar as possible to a newly created Angular 19 app. To modernize your app using these schematics, run the following command from your project root directory:

```bash
ng g @spartacus/schematics:modernize-app-migrated-from-2211_32-to-2211_36
```

If you encounter any issues, you can complete the migration by following the manual migration steps provided in [Modernizing Your Storefront App After Upgrading to Version 2211.36](./modernize-apps-migrated-to-2211.36.md).

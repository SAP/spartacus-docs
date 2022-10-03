---
title: Updating to Version 5.0
---

## Upgrading Your Angular Libraries

Before upgrading Spartacus to 5.0, you first need to make sure your Angular libraries are up to date. Spartacus 5.0 requires Angular 14.

You can upgrade your application to Angular 14 as follows:

- Start by upgrading Angular to version 13, and verify that all breaking changes have been addressed.
- When you have updated to Angular 13, you can then upgrade to Angular 14.

You might have to append the `--force` flag if you encounter a mismatch between peer dependencies during the migration. The following is an example command that upgrades Angular to version 13.

```bash
ng update @angular/cli@13 [--force]
```

Afterwards, you need to upgrade third party dependencies to the version that is compatible with Angular 14, such as `@ng-bootstrap/ng-bootstrap`, `@ng-select/ng-select` or `@ngrx/store`.

For more information, see the official [Angular Update Guide](https://update.angular.io/).

## Downloading Spartacus Libraries from the Repo Based Shipment Channel

Text...

## Upgrading Spartacus to 5.0

Spartacus 5.0 includes many new features and fixes. Since this update is a major release, some of the updates may also be breaking changes for your application. In this case, additional work on your side may be required to fix issues that result from upgrading from 4.x to 5.0.

To update to version 5.0 of Spartacus, run the following command in the workspace of your Angular application:

```bash
ng update @spartacus/schematics@5
```

When the update has finished running, inspect your code for comments that begin with `// TODO:Spartacus`. For detailed information about each added comment, see [5.0 Typescript Breaking Changes](https://sap.github.io/spartacus-docs/beta-docs/5-0-typescript-breaking-changes/).

The process might also downgrade some dependencies (namely RxJS), because Spartacus does not yet support the newer version.

### Additional Information

In addition to breaking changes, the following details are important to be aware of when upgrading to Spartacus 5.0:

- New entry points have been introduced for the `@spartacus/checkout` library. For more information, see [{% assign linkedpage = site.pages | where: "name", "checkout-libraries-release-notes.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/home/updating-to-version-5/checkout-libraries-release-notes.md %}).
- Spartacus provides a `webApplicationInjector.js` file that is required for working with SmartEdit. In Spartacus 5.0, the `webApplicationInjector.js` file has been updated to work with SAP Commerce Cloud 2211. If you are using an older version of SAP Commerce Cloud, you need to replace the `webApplicationInjector.js` file in your Spartacus application with the `webApplicationInjector.js` file that is shipped with your version of SAP Commerce Cloud. For more information, see [Web Application Injector](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/e1391e5265574bfbb56ca4c0573ba1dc/e9340d1d3d3249849ff154731277069a.html).

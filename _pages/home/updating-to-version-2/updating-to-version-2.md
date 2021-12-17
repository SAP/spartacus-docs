---
title: Updating to Version 2.0
---

## Prerequisites

Before upgrading your Spartacus libraries to version 2.0, you must address the following prerequisites:

- You must first upgrade all of your `@spartacus` libraries to the latest 1.5.x release before you begin upgrading to Spartacus 2.0. For more information, see [Upgrading Spartacus Libraries to a New Minor Version]({{ site.baseurl }}/release-information/#upgrading-spartacus-libraries-to-a-new-minor-version).

- Your `@spartacus` libraries must include the `@spartacus/schematics` library. If you do not have the `@spartacus/schematics` library, add it to your `package.json` file in the `devDependencies` section, and set it to the same version as your other `@spartacus` libraries. Then run `yarn install`.

- Spartacus 2.0 requires Angular version 9. You must update Angular before updating Spartacus. For more information, see [Updating to Angular version 9](https://update.angular.io/).

- If you are using `@nguniversal/express-engine` for your server-side rendering implementation, you must update it to version 9 before updating Spartacus. To update `@nguniversal/express-engine` to version 9, use the following command : `ng update @nguniversal/express-engine@^9.1`

## Updating Spartacus

Spartacus 2.0 includes many new features and fixes. Since this update is a major release, some of the updates may also be breaking changes for your application. In this case, additional work on your side may be required to fix issues that result from upgrading from 1.x to 2.0.

To help with updating to version 2.0, Spartacus provides a script that will do the following:

- Automatically fix all calls of `super(...)` in constructors of classes that extend the default Spartacus classes. New, required parameters are added, and dropped parameters are removed.
- Inject code comments into your codebase whenever you use a reference to a Spartacus class or function that has changed its behavior in version 2.0, or where your class or function has been replaced by a different class or function, or where the API has changed (for example, where a required parameter has been added or removed).

To update to version 2.0 of Spartacus, run the following command in the workspace of your Angular application:

```shell
ng update @spartacus/schematics
```

**Note:** If you do not have `@spartacus/schematics` installed, you will get the following error: `Package '@spartacus/schematics' is not a dependency.` For more information, see [Prerequisites](#prerequisites).

When the update script has finished running, you then need to add the `@angular/localize` package to your project by running the following command:

```shell
ng add @angular/localize
```

Finally, when this script has finished running, inspect your code for comments that begin with `// TODO:Spartacus`. For detailed information about each injected comment, see [{% assign linkedpage = site.pages | where: "name", "technical-changes-version-2.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/home/updating-to-version-2/technical-changes-version-2.md %}).

For more information about schematics, see the schematics project [README](https://github.com/SAP/spartacus/tree/develop/projects/schematics).

Various releases of Spartacus 1.x have contributed to the styling in Spartacus, which was grouped into a specific theme called "Calydon". This theme is no longer used in version 2.0 because the various styles have been merged into the standard styling. If you do use some (or all) of the styling from Spartacus, you might need to update your styles. For more information about the deprecated styles from Spartacus version 1.x, see [{% assign linkedpage = site.pages | where: "name", "css-changes-in-version-2.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/home/updating-to-version-2/css-changes-in-version-2.md %}).

## Migrating from Accelerator to Spartacus

If you are considering migrating a project from Accelerator to Spartacus, see [Migrate Your Accelerator-based Storefront to Project Spartacus](https://www.sap.com/cxworks/article/2589632310/migrate_your_accelerator_based_storefront_to_project_spartacus) on the SAP CX Works website.

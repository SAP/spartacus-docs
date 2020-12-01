---
title: Updating to Version 3.0
---

## Prerequisites

Before upgrading your Spartacus libraries to version 3.0, you must address the following prerequisites:

- You must first upgrade all of your `@spartacus` libraries to the latest 2.1.x release before you begin upgrading to Spartacus 2.0. For more information, see [Upgrading Spartacus Libraries to a New Minor Version](https://sap.github.io/spartacus-docs/release-information/#upgrading-spartacus-libraries-to-a-new-minor-version).

- Your `@spartacus` libraries must include the `@spartacus/schematics` library. If you do not have the `@spartacus/schematics` library, add it to your `package.json` file in the `devDependencies` section, and set it to the same version as your other `@spartacus` libraries. Then run `yarn install`.

- Spartacus 3.0 requires Angular version 10. You must update Angular before updating Spartacus. For more information, see [Updating to Angular version 10](https://update.angular.io/).

- If you are using `@nguniversal/express-engine` for your server-side rendering implementation, you must update it to version 10 before updating Spartacus. To update `@nguniversal/express-engine` to version 10, use the following command : `ng update @nguniversal/express-engine@^10`.

## Updating Spartacus

Spartacus 3.0 includes many new features and fixes. Since this update is a major release, some of the updates may also be breaking changes for your application. In this case, additional work on your side may be required to fix issues that result from upgrading from 2.1.x to 3.0.

To help with updating to version 3.0, Spartacus provides a script that will do the following:

- Automatically fix all calls of `super(...)` in constructors of classes that extend the default Spartacus classes. New, required parameters are added, and dropped parameters are removed.
- Inject code comments into your codebase whenever you use a reference to a Spartacus class or function that has changed its behavior in version 3.0, or where your class or function has been replaced by a different class or function, or where the API has changed (for example, where a required parameter has been added or removed).

To update to version 3.0 of Spartacus, run the following command in the workspace of your Angular application:

```shell
ng update @spartacus/schematics
```

**Note:** If you do not have `@spartacus/schematics` installed, you will get the following error: `Package '@spartacus/schematics' is not a dependency.` For more information, see [Prerequisites](#prerequisites).

After this script finish running, check your `package.json` and make sure all the `@angular/...` packages are version 10 (but not 11). Package `@angular-devkit/build-angular` should be version `0.10xxx`. If this isn't the case, run:

```shell
ng update @angular/cli@10
```

Finally, inspect your code for comments that begin with `// TODO:Spartacus`. For detailed information about each injected comment, see [Technical Changes in Spartacus 3.0]({{ site.baseurl }}{% link _pages/home/updating-to-version-3/technical-changes-version-3.md %}).

For more information about schematics, see the schematics project [README](https://github.com/SAP/spartacus/tree/develop/projects/schematics).

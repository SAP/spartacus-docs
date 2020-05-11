---
title: Updating to Version 2.0
---

## Prerequisites

Spartacus 2.0 requires Angular version 9. You must update Angular before updating Spartacus. For more information, see [Updating to Angular version 9](https://update.angular.io/).

## Updating Spartacus

Spartacus 2.0 includes many new features and fixes. Since this update is a major release, some of the updates may also be breaking changes for your application. In this case, additional work on your side may be required to fix issues that result from upgrading from 1.x to 2.0.

To help with updating to version 2.0, Spartacus provides a script that will do the following:

- Automatically fix all calls of `super(...)` in constructors of classes that extend the default Spartacus classes. New, required parameters are added, and dropped parameters are removed.
- Inject code comments into your codebase whenever you use a reference to a Spartacus class or function that has changed its behavior in version 2.0, or where your class or function has been replaced by a different class or function, or where the API has changed (for example, where a required parameter has been added or removed).

To update to version 2.0 of Spartacus, run the following command in the workspace of your Angular application:

```shell
ng update @spartacus/schematics
```

> NOTE: in case you don't have `@spartacus/schematics` installed, you'll get the following error: `Package '@spartacus/schematics' is not a dependency.`. Before you can use the update schematics, you need to add `@spartacus/schematics` to your `package.json` (make sure that the version matches the other spartacus libraries) and install it using your package manager (npm or yarn).

When the script has finished running, inspect your code for comments that begin with `//TODO:Spartacus`. For detailed information about each injected comment, see [Technical Changes in Spartacus 2.0](https://github.com/SAP/spartacus/blob/develop/docs/migration/2_0.md).

For more information about schematics, see the schematics project [README](https://github.com/SAP/spartacus/tree/develop/projects/schematics).

Various releases of Spartacus 1.x have contributed to the styling in Spartacus, which was grouped into a specific theme called "Calydon". This theme is no longer used in version 2.0 because the various styles have been merged into the standard styling. If you do use (some of) the styling from Spartacus, you might need to update your styles. For more information about the deprecated styles from Spartacus version 1.x, see [Deprecation of Calydon Theme](https://github.com/SAP/spartacus-docs/blob/doc/GH-547/_pages/home/updating-to-version-2/calydon.md).

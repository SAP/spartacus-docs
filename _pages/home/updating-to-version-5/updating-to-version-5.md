---
title: Updating to Version 5.0
---

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
  {:toc}

## Upgrading Your Angular Libraries

Before upgrading Spartacus to 5.0, you first need to make sure your Angular version is up to date.
As Spartacus 5.0 requires Angular 14, you need to upgrade your application Angular 14 in two steps:

- you first need to upgrade Angular to version 13 and verify that all breaking changes have been addressed.
- after you are on Angular 13, you need to upgrade to Angular 14.

You might have to append the `--force` flag, if you encounter a mismatch between peer dependencies during the migration.
The following is an example command that upgrades Angular to version 13.

```bash
ng update @angular/cli@13 [--force]
```

Afterwards, you need to upgrade third party dependencies, such as `@ng-bootstrap/ng-bootstrap`, `@ng-select/ng-select` or `@ngrx/store`, to the version that is compatible with Angular 14.

For more information, see the official[Angular Update Guide](https://update.angular.io/).

## Upgrading Spartacus to 5.0

Spartacus 5.0 includes many new features and fixes. Since this update is a major release, some of the updates may also be breaking changes for your application. In this case, additional work on your side may be required to fix issues that result from upgrading from 4.x to 5.0.

To update to version 5.0 of Spartacus, run the following command in the workspace of your Angular application:

```bash
ng update @spartacus/schematics@5
```

When the update has finished running, inspect your code for comments that begin with `// TODO:Spartacus`. For detailed information about each added comment, see the [Detailed List of Changes]({{ site.baseurl }}/technical-changes-version-4/#detailed-list-of-changes).

The process might also downgrade some dependencies (namely RxJS), as Spartacus does not yet support their newer version.

---
title: Updating to Version 5.0
---

Update information here...

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Overview

Spartacus 5.0 includes many new features and fixes. Since this update is a major release, some of the updates may also be breaking changes for your application. In this case, additional work on your side may be required to fix issues that result from upgrading from 4.3.x to 5.0.

## Upgrading Your Angular Libraries

Before upgrading Spartacus to 5.0, you first need to upgrade Angular to version 14, and upgrade Angular third party dependencies to the version that is compatible with Angular 14. (do we need to mention anything about `@ng-bootstrap/ng-bootstrap` or `@ng-select/ng-select` here÷)

The following is an example command that upgrades Angular to version 14, and also upgrades the related dependencies:

```bash
ng update details.....
```

For more information, see the official[Angular Update Guide](https://update.angular.io/).

## Upgrading Spartacus to 4.3.x

You must first upgrade all of your `@spartacus` libraries to the latest 4.3.x release before you begin upgrading to Spartacus 5.0. For more information, see [Upgrading Spartacus Libraries to a New Minor Version]({{ site.baseurl }}/release-information/#upgrading-spartacus-libraries-to-a-new-minor-version).

## Upgrading Spartacus to 5.0

To update to version 5.0 of Spartacus, run the following command in the workspace of your Angular application:

```bash
ng update @spartacus/schematics@5
```

When the update has finished running, inspect your code for comments that begin with `// TODO:Spartacus`. For detailed information about each added comment, see the [Detailed List of Changes]({{ site.baseurl }}/technical-changes-version-4/#detailed-list-of-changes).

## Migrating from Accelerator to Spartacus

If you are considering migrating a project from Accelerator to Spartacus, see [Migrate Your Accelerator-based Storefront to Project Spartacus](https://www.sap.com/cxworks/article/2589632310/migrate_your_accelerator_based_storefront_to_project_spartacus) on the SAP CX Works website.

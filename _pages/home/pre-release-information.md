---
title: Pre-Release Information
---

This document describes what is included in the latest pre-release of Spartacus libraries, such as `next` and `rc` libraries.

*Last updated March 23rd, 2020 by Matthew Burton, Scrum Master and Senior Technical Writer, Spartacus*

- For an overview of what is included in a specific release, see [Release Information]({{ site.baseurl }}{% link _pages/home/release-information.md %}).
- For information on specific code changes for a particular release, see the [development release notes](https://github.com/SAP/cloud-commerce-spartacus-storefront/releases).

## Release 2.0.0-next.2 - March 23rd, 2020

### Deprecation

We continue to work on removing deprecated code as part of the 2.0 release. This work is ongoing, and more deprecated code will be removed in future pre-releases of 2.0.

For more information about changes in our public API, including all breaking changes, see [Updating to Spartacus 2.0](https://github.com/SAP/spartacus/blob/release/2.0.0-next.2/docs/migration/2_0.md).

### Migrating with Schematics

To improve the experience of migrating to version 2.0, we are working on migration schematics for Spartacus. Before you run the migration, please be sure to update to version 9 of Angular in your project.

You can run the migration with the following command:

```bash
ng update @spartacus/schematics@next
```

**Note:** The migration schematics are still a work in progress, so you might encounter some "not ideal" modifications to your code. Please let us know about any problems you encounter by creating a GitHub issue in our repository, or by contacting us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU).

### Accessibility

We continue to work on accessibility in Spartacus. Aside from a number of improvements and bug fixes, a new `cxFocus` directive is now available. Documentation for this feature is still to come.

### Event System

The core for the event system is now included in the `@spartacus/core` library. Documentation for the event system is still to come.

### Ngrx 9

The ngrx dependency in Spartacus has been updated to version 9. Along with this update, the Angular libraries were also updated to the latest patch.

For a list of all the changes in release `2.0.0-next.2` of the Spartacus libraries, see the [Spartacus project release page](https://github.com/SAP/cloud-commerce-spartacus-storefront/releases) on GitHub.

## Release 2.0.0-next.1 - March 12th, 2020

### Deprecation

We are working on removing deprecated code as part of the 2.0 release. So far, a few classes and functions have been removed from the public API of our libraries, and for some classes, deprecated constructors have been removed. This work is ongoing, and more deprecated code will be removed in future pre-releases of 2.0.

For more information about changes in our public API, see [Updating to Spartacus 2.0](https://github.com/SAP/cloud-commerce-spartacus-storefront/blob/release/2.0.0-next.1/docs/migration/2_0.md).

### Migrating with Schematics

To improve the experience of migrating to version 2.0, we are working on migration schematics for Spartacus. Before you run the migration, please be sure to update to version 9 of Angular in your project.

You can run the migration with the following command:

```bash
ng update @spartacus/schematics@next
```

**Note:** This is our first attempt with the 2.0 migration schematics, so if you are trying it out, you might encounter some "not ideal" modifications to your code. Please let us know about any problems you encounter by creating a GitHub issue in our repository, or by contacting us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU).

### Schematics SSR Update

You can now install Spartacus with SSR in an Angular 9 app. 

The previous pre-release, `2.0.0-next.0`, only supported client-side rendering. In the `2.0.0-next.1` release, you can use schematics to install support for SSR and PWA.

### Accessibility

We continue to work on accessibility in Spartacus.

For a list of all the changes in release `2.0.0-next.1` of the Spartacus libraries, see the [Spartacus project release page](https://github.com/SAP/cloud-commerce-spartacus-storefront/releases) on GitHub.

## Release 2.0.0-next.0 - March 2nd, 2020

### Update to Angular 9

Spartacus libraries are now compatible with Angular 9.

### Keyboard Accessibility

The following accessibility features were added:

- Navigation with the tab key
- Correct focus state (visual focus)
- Navigation with auxiliary keys, such as the space bar, arrow keys, and so on

Additionally, new end-to-end tests were added for the tab and auxiliary keys. These tests check if a given page is accessible with the tab and auxiliary keys.

### Component Refactoring

The [pagination component](https://github.com/SAP/cloud-commerce-spartacus-storefront-docs/blob/v2-develop/_pages/dev/components/shared-components/pagination.md) and the item counter component were refactored, and are now simpler, while also being more extendable and easier to use.

### Schematics Updated to Angular 9

Schematics were updated to allow you to add Spartacus to applications generated with version 9 of the Angular CLI. Note, however, that the SSR and PWA options have not yet been updated, and might not fully work as intended.

For a list of all the changes in release `2.0.0-next.0` of the Spartacus libraries, see the [Spartacus project release page](https://github.com/SAP/cloud-commerce-spartacus-storefront/releases) on GitHub.

## Release 1.5 and earlier

Pre-release libraries no longer published for these versions, as the final release of these libraries was published.

## Questions

If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU). Feedback welcome!



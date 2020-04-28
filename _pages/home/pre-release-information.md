---
title: Pre-Release Information
---

This document describes what is included in the latest pre-release of Spartacus libraries, such as `next` and `rc` libraries.

*Last updated April 28th, 2020 by Bill Marcotte, Product Owner, Spartacus*

- For an overview of what is included in a specific release, see [Release Information]({{ site.baseurl }}{% link _pages/home/release-information.md %}).
- For information on specific code changes for a particular release, see the [development release notes](https://github.com/SAP/spartacus/releases).

## Release 2.0.0-RC - April 28th, 2020

The first release candidate (RC) has been released for 2.0.

Release 2.0 is a new major version and contains breaking changes. To migrate to 2.0 from 1.x, see the following documentation:
- [Updating to version 2.0](https://github.com/SAP/spartacus-docs/blob/v2-develop/_pages/home/updating-to-version-2/updating-to-version-2.md) (automated update using schematics)
- [Technical Changes in Spartacus 2.0](https://github.com/SAP/spartacus/blob/develop/docs/migration/2_0.md)
- [Changes to Styles in 2.0](https://github.com/SAP/spartacus-docs/blob/doc/GH-547/_pages/home/updating-to-version-2/css-changes-in-version-2.md)

Summary of major changes from 1.x to 2.0:

- Angular 9, ngrx 9
- Schematics updated
- Accessibility Keyboarding features
- Many components refactored
- Lazy loading of CMS components
- Events system with CartAddEntryEvent event
- New facet navigation makes extending facets easier
- Deprecated code removed

For a list of all changes for 2.0 RC and previous 'next' releases of the Spartacus libraries, see the [Spartacus project release page](https://github.com/SAP/spartacus/releases) on GitHub.

## Release 2.0.0-next.7 - April 23rd, 2020

Aside from continued work on removing deprecated code, bug fixes, and code refactoring, the following sections highlight work that has been done for this release. For a list of all the changes in release `2.0.0-next.7` of the Spartacus libraries, see the [Spartacus project release page](https://github.com/SAP/spartacus/releases) on GitHub.

### New Facet Navigation

Facet navigation was refactored to address a number of shortcomings and bugs. For more information, see [GH-6581](https://github.com/SAP/cloud-commerce-spartacus-storefront/issues/6581).

### PageSlotComponent now requires new CmsConfig and ChangeDetectorRef parameters (Breaking Change)

For more information, see [GH-7054](https://github.com/SAP/cloud-commerce-spartacus-storefront/issues/7054).

### Storefinder Radius Fixed and Made Configurable

The radius parameter was hard-coded, so "use my location" did not work. For more information, see [GH-6275](https://github.com/SAP/spartacus/issues/6275).

### Action Link Styles Standardized

For more information, see [GH-7257](https://github.com/SAP/spartacus/pull/7257).

## Release 2.0.0-next.6 (includes -next.5) - April 16th, 2020

Aside from continued work on removing deprecated code, bug fixes, and code refactoring, the following sections highlight work that has been done for this release. For a list of all the changes in release `2.0.0-next.6` of the Spartacus libraries, see the [Spartacus project release page](https://github.com/SAP/spartacus/releases) on GitHub.

### CmsPageGuard Can be Extended More Easily

Some dependencies of the `CmsPageGuard` were not public before, so the guard was not easily customizable. For more information, see [GH-6852](https://github.com/SAP/spartacus/pull/6852).

### Language ISO Values Now Use Hyphens Instead of Underscores (Breaking Change)

The language ISO value used in the HTML `lang` attribute now uses hyphens instead of underscores. For example, you will see `<html lang="es-MX">` instead of `<html lang="es_MX">`. For more information, see [GH-6802](https://github.com/SAP/cloud-commerce-spartacus-storefront/issues/6802).

### REST Prefix

In the upcoming release of 2005 of SAP Commerce Cloud, the default OCC REST API changes from REST to OCC. Spartacus already used a setting to configure this prefix, but it was not used everywhere. For more information, see [GH-7235](https://github.com/SAP/spartacus/pull/7235).

## Release 2.0.0-next.4 - April 9th, 2020

Aside from continued work on removing deprecated code, bug fixes, and code refactoring, the following sections highlight work that has been done for this release. For a list of all the changes in release `2.0.0-next.4` of the Spartacus libraries, see the [Spartacus project release page](https://github.com/SAP/spartacus/releases) on GitHub.

### Support for Session Infinity

Sending cookies to each OCC request has been implemented, using the `withCredentials` flag in the HTTP client. This requires a new OCC configuration, which (currently) defaults to false. An additional CORS configuration is required to ensure that a decoupled storefront is allowed to pass cookies into the request.

### Assisted Service Module

A new, generic service to dynamically render dialog and other non-CMS-driven components. This mechanism is now used for the ASM user interface. Customer coupons have been made ASM-friendly.

### Schematics Migrations

In our schematics, the SSR migration to 2.0 is now working. Also, `@angular/localize` has been added into the schematics for adding Spartacus, SSR, and upgrading to 2.0.

### Dependency Upgrades

Angular and Spartacus dependencies have been updated across all Spartacus libraries. In terms of third-party dependencies, ng-bootstrap, ng-select, and ngx-infinite-scroll have been updated to their latest stable versions.

### Accessibility and Forms

It was necessary to remove `disabled` attributes from the submit buttons on forms. These attributes provided a way of submitting empty forms, because previously, we did not need to guard them from empty submissions. The fix is provided with a newly introduced `FormErrorsComponent`. This fix has been implemented in all of the forms across the entire application.

### Event Service

The cart's "add entry" event has been implemented, along with minor service improvements.

## Release 2.0.0-next.3 - April 1st, 2020

Highlights for this release include the following:

- Calydon is set as the base theme.
- More deprecated code has been removed.
- Improvements have been made to the current product service.

For a list of all the changes in release `2.0.0-next.3` of the Spartacus libraries, see the [Spartacus project release page](https://github.com/SAP/spartacus/releases) on GitHub.

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

For a list of all the changes in release `2.0.0-next.2` of the Spartacus libraries, see the [Spartacus project release page](https://github.com/SAP/spartacus/releases) on GitHub.

## Release 2.0.0-next.1 - March 12th, 2020

### Deprecation

We are working on removing deprecated code as part of the 2.0 release. So far, a few classes and functions have been removed from the public API of our libraries, and for some classes, deprecated constructors have been removed. This work is ongoing, and more deprecated code will be removed in future pre-releases of 2.0.

For more information about changes in our public API, see [Updating to Spartacus 2.0](https://github.com/SAP/spartacus/blob/release/2.0.0-next.1/docs/migration/2_0.md).

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

For a list of all the changes in release `2.0.0-next.1` of the Spartacus libraries, see the [Spartacus project release page](https://github.com/SAP/spartacus/releases) on GitHub.

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

The [pagination component](https://github.com/SAP/spartacus-docs/blob/v2-develop/_pages/dev/components/shared-components/pagination.md) and the item counter component were refactored, and are now simpler, while also being more extendable and easier to use.

### Schematics Updated to Angular 9

Schematics were updated to allow you to add Spartacus to applications generated with version 9 of the Angular CLI. Note, however, that the SSR and PWA options have not yet been updated, and might not fully work as intended.

For a list of all the changes in release `2.0.0-next.0` of the Spartacus libraries, see the [Spartacus project release page](https://github.com/SAP/spartacus/releases) on GitHub.

## Release 1.5 and earlier

Pre-release libraries no longer published for these versions, as the final release of these libraries was published.

## Questions

If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU). Feedback welcome!



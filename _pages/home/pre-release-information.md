---
title: Pre-Release Information
---

This document describes what is included in the latest pre-release of Spartacus libraries, such as `next` and `rc` libraries.

*Last updated March 2nd, 2020 by Matthew Burton, Scrum Master and Technical Writer, Spartacus*

- For an overview of what is included in a specific release, see [Release Information]({{ site.baseurl }}{% link _pages/home/release-information.md %}).
- For information on specific code changes for a particular release, see the [development release notes](https://github.com/SAP/cloud-commerce-spartacus-storefront/releases).

## Release 2.0.0-next.0

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

For a list of all changes in release `2.0.0-next.0` of the Spartacus libraries, see the [Spartacus project release page](https://github.com/SAP/cloud-commerce-spartacus-storefront/releases) on GitHub.

## Release 1.5 and earlier

Pre-release libraries no longer published for these versions, as the final release of these libraries was published.

## Questions

If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU). Feedback welcome!



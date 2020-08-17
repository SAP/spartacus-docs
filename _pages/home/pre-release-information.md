---
title: Pre-Release Information
---

This document describes what is included in the latest pre-release of Spartacus libraries, such as `next` and `rc` libraries.

_Last updated August 17, 2020 by Bill Marcotte, Senior Product Manager, Spartacus_

For an overview of what is included in a specific release, see [Release Information]({{ site.baseurl }}{% link _pages/home/release-information.md %}). For detailed release notes, see the Spartacus repository [Releases page](https://github.com/SAP/spartacus/releases).


## 2.1 Pre-Release Libraries - August 12

- **Style Library Versioning**: Allows the core Spartacus development team to introduce  gradual changes in the style layer while maintaining backwards compatibility. New or adjusted style rules are added for a specific version, but these changes are not added in the style build process unless you explicitly opt in to receive these changes. For more information, see the [draft documentation](https://github.com/SAP/spartacus-docs/blob/develop/_pages/dev/styling-and-page-layout/css-architecture.md).
- **Directionality**: Provides support for bidirectional text and layout. You can configure Spartacus to use a left-to-right (LTR) orientation, or a right-to-left (RTL) orientation. The 2.1 feature is for core functionality; that Spartacus updates to CSS will be completed in the 3.0. For more information, see the [draft documentation](https://github.com/SAP/spartacus-docs/blob/5c42b580f2cdcfc5ced44a559658ac30be3a9be5/_pages/dev/styling-and-page-layout/directionality.md).
- The first pre-release of the **Customer Data Cloud** (CDC, previously known as Gigya) integration library was also published. This new library provides authentication and consent management through CDC instead of what’s out-of-the-box SAP Commerce Cloud. For more information, see the [draft documentation](https://github.com/SAP/spartacus-docs/blob/develop/_pages/install/integrations/cdc-integration.md).


## Pre-Release Libraries for 2.0 and earlier

Pre-release libraries are no longer actively updated for versions 2.0 and earlier, as the final release of these libraries was already published. Pre-release libraries are still available but the final versions should be used.

## Questions

If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU). Feedback welcome!

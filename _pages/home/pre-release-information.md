---
title: Pre-Release Information
---

This document describes what is included in the latest pre-release of Spartacus libraries, such as `next` and `rc` libraries.

- For an overview of what is included in a specific release, see [Release Information]({{ site.baseurl }}{% link _pages/home/release-information.md %}).
- For detailed release notes, see the Spartacus repository [Releases page](https://github.com/SAP/spartacus/releases).

## Configurable Products Pre-Release

The first quarter of 2021 will see the inclusion of the Spartacus libraries for SAP Variant Configuration and Pricing. These libraries will provide the following features:

- Single-level and multilevel configurable products in your Commerce Spartacus storefront, where the product model resides in SAP ERP or SAP S/4HANA
- Configuration page with the most commonly used characteristic types, such as radio buttons, checkboxes, drop-down listboxes, and images for characteristic values
- Price summary at the bottom of the configuration page with the base price, the price of the selected options, and the total price of the configured product
- Overview page with all user selections accessible at any time during configuration
- Basic conflict handling
- Configurable products are part of storefront processes such as catalog browsing, product detail page, add to cart, checkout, and order history

SAP Variant Configuration and Pricing provides the UI for configuring and selling configurable products using the SAP Variant Configuration and Pricing add-on for Commerce. **Note that the Spartacus libraries do not include the add-on itself.**

For more information, see [Product Configuration with SAP Variant Configuration and Pricing](https://help.sap.com/viewer/80c3212d1d4646c5b91db43b84e9db47/2005/en-US) and [Configurable Products Integration](https://github.com/SAP/spartacus-docs/blob/doc/GH-941/_pages/ccp/ccp-integration.md).

## Pre-Release Libraries for 3.0.0 and earlier

Pre-release libraries are no longer published for versions 3.0.0 and earlier, as the final releases of these libraries were published. Pre-release libraries are still available but the final versions should be used. New pre-release libraries will be published as needed for 3.1, 3.2, and so on.

## Customer Data Cloud Pre-Release

The **Customer Data Cloud** (CDC, previously known as Gigya) integration library remains in pre-release and will likely be final Q1 2021. This new library provides authentication and consent management through CDC instead of what’s out-of-the-box SAP Commerce Cloud. For more information, see the [documentation]({{ site.baseurl }}{% link _pages/install/integrations/cdc-integration.md %}).

## Questions

If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ). Feedback welcome!

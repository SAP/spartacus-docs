---
title: Pre-Release Information
---

This document describes what is included in the latest pre-release of Spartacus libraries, such as `next` and `rc` libraries.

- For an overview of what is included in a specific release, see [Release Information]({{ site.baseurl }}{% link _pages/home/release-information.md %}).
- For detailed release notes, see the Spartacus repository [Releases page](https://github.com/SAP/spartacus/releases).

## Release 3.1.0-next.0 - Thursday, January 28, 2021

### SAP Variant Configuration and Pricing

We're happy to announce that the Spartacus library for SAP Variant Configuration and Pricing has been released. This library provides the following features:

- single-level and multilevel configurable products in your Spartacus storefront, where the product model resides in SAP ERP or SAP S/4HANA
- a configuration page with the most commonly used characteristic types, such as radio buttons, checkboxes, drop-down listboxes, and images for characteristic values
- a price summary at the bottom of the configuration page with the base price, the price of the selected options, and the total price of the configured product
- an overview page with all user selections accessible at any time during configuration
- basic conflict handling
- inclusion of configurable products as part of storefront processes, such as catalog browsing, product detail page, add to cart, checkout, and order history

The SAP Variant Configuration and Pricing add-on for Commerce provides the user interface (UI) with which configurable products can be configured and sold using SAP Variant Configuration and Pricing.

**Note:** The SAP Variant Configuration and Pricing add-on for Commerce is not included with the Spartacus libraries.

For more information, see [Product Configuration with SAP Variant Configuration and Pricing](https://help.sap.com/viewer/80c3212d1d4646c5b91db43b84e9db47/2005/en-US) and [Configurable Products Integration](https://github.com/SAP/spartacus-docs/blob/develop/_pages/ccp/configurable-products-integration.md).

### Qualtrics Embedded Feedback

We're happy to also announce support for the Qualtrics Embedded Feedback feature. For more information, see [Spartacus Support for Qualtrics Embedded Feedback](https://github.com/SAP/spartacus-docs/blob/develop/_pages/install/integrations/qualtrics-integration.md#spartacus-support-for-qualtrics-embedded-feedback).

**Note:** Starting with Spartacus 3.1, you must install the Qualtrics feature library to be able to use Qualtrics features. You can install the Qualtrics library by running the following command:

```shell
 ng add @spartacus/qualtrics
 ```

## Pre-Release Libraries for 3.0.0 and earlier

Pre-release libraries are no longer published for versions 3.0.0 and earlier, as the final releases of these libraries were published. Pre-release libraries are still available but the final versions should be used. New pre-release libraries will be published as needed for 3.1, 3.2, and so on.

## Customer Data Cloud Pre-Release

The **Customer Data Cloud** (CDC, previously known as Gigya) integration library remains in pre-release and will likely be final Q1 2021. This new library provides authentication and consent management through CDC instead of what’s out-of-the-box SAP Commerce Cloud. For more information, see the [documentation]({{ site.baseurl }}{% link _pages/install/integrations/cdc-integration.md %}).

## Questions

If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ). Feedback welcome!

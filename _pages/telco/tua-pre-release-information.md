---
title: Pre-Release Information
---
This document describes what is included in the latest pre-release of TUA Spartacus libraries, such as `next` and `rc` libraries.

_Last updated November 25, 2020 by Deborah Cholmeley-Jones, Solution Owner, TUA Spartacus_

For an overview of what is included in a specific release, see [Release Information]({{ site.baseurl }}{% link _pages/telco/telco-release-information.md %}).

For detailed release notes, see the [TUA Spartacus repository
](https://github.com/SAP/spartacus-tua/releases).

## Release 2.0.0-next.2 - November 25, 2020

The `2.0.0-next.2` library has been published! We are happy to announce our second Spartacus for TUA pre-release. 

In the `2.0.0-next.2` pre-release version, support for both - TUA 2007 and TUA 2011 is provided. In addition to supporting composite pricing and price alteration discounts, priority pricing is now available, as well as support for 1.x spartacus features that were delivered in previous releases, with the exception of 1.3 features, which is planned next.

You can set up TUA Spartacus 2.0.0-next.2 by following the instructions from [Building the TUA Spartacus Storefront from 2.x Libraries](https://github.com/SAP/spartacus-docs/blob/doc/GH-804/_pages/telco/building-the-tua-storefront-from-libraries-2.0.md).

## Release 2.0.0-next.1 - October 28, 2020

The `2.0.0-next.1` library has been published! For more information, see [Release Information]({{ site.baseurl }}{% link _pages/telco/telco-release-information.md %}).

We are happy to announce support for the TUA 2007 release.

You can set up TUA Spartacus 2.0.0-next.1 by following the instructions from [Building the TUA Spartacus Storefront from 2.x Libraries](https://github.com/SAP/spartacus-docs/blob/doc/GH-804/_pages/telco/building-the-tua-storefront-from-libraries-2.0.md).

The following features are included as part of this pre-release:

**Composite Pricing**

Composite Pricing brings forth a new way for handling operational processes for service providers that is clearer and more efficient. The underlying TUA data model has been enhanced to support the hierarchical structure of composite prices in a TM Forum compliant manner.  Product Offering Prices are now hierarchal; that is, they can be grouped together and they are also re-usable. For more information, see [Composite Pricing](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/2e0fa8602fff440ba756e1a0a8390ea3.html) in the TUA Help portal.

**Price Alteration Discounts**

The Price Alteration Discounts works on top of the Composite Pricing data model and enables the ability to offer fixed-price and percentage discounts at any level in the composite price structure, and for any type of charge including one-time charges, recurring charges and usage-based charges. With price alteration discounts, customers can see discounts upfront before placing their order. For more information, see [Price Alteration Discounts](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/61b21155624e4a498632964bc566e1eb.html) in the TUA Help portal.

### Pre-Release Libraries for 2.0 and Earlier

Pre-release libraries are no longer actively updated for versions 1.0 and earlier, as the final release of these libraries was already published. Pre-release libraries are still available but the final versions should be used.

## Questions

If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ). Feedback welcome!

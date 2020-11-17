---
title: Release Information for TUA Spartacus Libraries
---

*Last updated November 11, 2020 by Deborah Cholmeley-Jones, Solution Owner, TUA Spartacus*

## Release Contents

- [Introduction](#introduction)
- [Release 1.3](#release-13)
- [Release 1.2](#release-12)
- [Release 1.1](#release-11)
- [Release 1.0](#release-10)
- [About Spartacus for TUA Releases](#about-spartacus-for-tua-releases)
- [Upgrading Spartacus Libraries to a New Minor Version](#upgrading-spartacus-libraries-to-a-new-minor-version)
- [Feature Releases](#feature-releases)

## Introduction

This document describes what is included in all Spartacus 1.x libraries since 1.0.

**Note:** Spartacus 1.x requires Angular 8. For more information, see [Building the TUA Spartacus Storefront from Libraries]({{ site.baseurl }}{% link _pages/telco/building-the-tua-storefront-from-libraries.md %}) and [Installing SAP Commerce for use with TUA Spartacus]({{ site.baseurl }}{% link _pages/telco/installing-sap-commerce-for-tua-spartacus.md %}).

- For information on specific code changes for a particular release, see the [Development Release Notes](https://github.com/SAP/spartacus-tua/releases).
- For information about features published in pre-release libraries, see TUA [Pre-Release Information]({{ site.baseurl }}{% link _pages/telco/tua-pre-release-information.md %}).
- For information about upgrading, see [Upgrading Spartacus Libraries to a New Minor Version](#upgrading-spartacus-libraries-to-a-new-minor-version).
- If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ). Feedback welcome!

**Disclaimer - Forward-Looking Statements**

*This document contains or may contain forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality. This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence.*

*The various documentation links provided point to SAP Commerce Cloud platform or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented in Spartacus.*

## Release 1.3

*Release 1.3.0 libraries published November 11, 2020*

What's new?

- [Cost Estimation]({{ site.baseurl }}{% link _pages/telco/cost-estimation.md %})

While it can be hard to pinpoint precisely how much your electric and water bill will cost each month, the Cost Estimation feature helps provide an indication as to the average monthly bill for a given product offering based on the anticipated consumption provided by a customer.  Leveraging the anticipated usage provided by a customer, the estimated monthly and annual cost for applicable product offerings can be presented to the customer.

- [Journey Management - Serviceability (Premise Details)]({{ site.baseurl }}{% link _pages/telco/journey-management-serviceability.md %})

Customers interested in acquiring product offerings, such as commodity items (for example,  electricity or gas) need to have an availability check of the premise details. As an  example, the premise address and meter id is needed to conduct a serviceability check for a commodity product offering.  For more information, see [Serviceability example](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/39a59f20c92f4a0090c7ef2d007d623c.html) in the TUA Help portal.

## Release 1.2

*Release 1.2.0 libraries published October 28, 2020*

What's new?

- [Journey Management - MSISDN]({{ site.baseurl }}{% link _pages/telco/journey-management-msisdn.md %})

Journey Management facilitates real-time personalized customer journeys enabling online customers to successfully place an order. With the MSISDN checklist action in place, customers who wish to purchase a simple product offering that requires an MSISDN selection, will be required to select their new telephone number as part of the ordering process. For more information, see [Journey Management](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/39a59f20c92f4a0090c7ef2d007d623c.html) in the TUA Help portal.

## Release 1.1

*Release 1.1.0 libraries published October 7, 2020*

- [Journey Management - Appointment]({{ site.baseurl }}{% link _pages/telco/journey-management-appointment.md %})

Journey Management facilitates real-time personalized customer journeys enabling online customers to successfully place an order. With the appointment checklist action in place, customers that wish to purchase a simple product offering that requires an appointment to be scheduled, will be required to make the appointment selection as part of the ordering process. For more information, see [Journey Management](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/39a59f20c92f4a0090c7ef2d007d623c.html) in the TUA Help portal.

- [Customer Product Inventory (CPI)]({{ site.baseurl }}{% link _pages/telco/customer-product-inventory.md %})

Increase NPS with the Customer Product Inventory. This features helps companies understand their customers by having a complete view of the "recurring" relationships or assets, their customers have with them. The Customer Product Inventory is used to dynamically determine user journeys: what the customer is interested in, what they are willing to pay, and what products, services, and prices they are entitled to. For more information, see [Customer Product Inventory (CPI)](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/612f26c3d5f14248965ad908cf5952f6.html) in the TUA Help portal.

- [Consumption]({{ site.baseurl }}{% link _pages/telco/consumption.md %})

Maximize customer retention by understanding the consumption of services by customers.  Not all customers are created equal. Some subscribers are more valuable than others. With consumption data available, companies are able to analyze the data and provide customers with some highly engaging content, upgrades, or promotional offers to keep subscribers engaged. On the flip side, with consumption data visible, customers are able to see for themselves how much of the services they are actually consuming, which helps them maximize their investment and make more informative decision. For more information, see [Create Average Service Usage for Subscribed Product](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/ba5f222fb5814829bd74eaf6e6505a9f.html) in the TUA Help portal.

## Release 1.0

*Release 1.0.0 libraries published September 9, 2020*

- [Simple Product Offering]({{ site.baseurl }}{% link _pages/telco/simple-product-offering.md %})

The commercial product catalog for service industries is different and the distinction between product offerings and products is important to understand. Simple product offerings are different than retail products and represents what is externally presented to the market. For more information, see [Simple Product Offerings](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/2007/en-US/6d3b4c0b88b04b709774c8ad10baa7a8.html?q=simple%20product%20offering) in the TUA Help portal.

- [Product Offering Search]({{ site.baseurl }}{% link _pages/telco/product-offering-search.md %})

To support the commercial product catalog of product offerings, changes were required in the way "searches" are technically conducted to search for and find simple product offerings. Changes were made in the areas of free text search, facets, and top level category menu navigation. For more information, see [Product Offering Search](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/315410098c024e50adf4c43373761936.html) in the TUA Help portal.

- [Cart]({{ site.baseurl }}{% link _pages/telco/cart.md %})

To support product offerings and the complex pricing structure they have for one time charges, recurring charges and usage charges, changes to the cart were necessary. For more information, see [Cart](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/525a0a7eafbb4d3ab988872a21e0e3b3.html) in the TUA Help portal.

- [Order]({{ site.baseurl }}{% link _pages/telco/order.md %})

To support product offerings and the complex pricing structure, they have for one time charges, recurring charges, and usage charges, changes to the order were necessary. For more information, see [Order](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/2007/en-US/91a9faae27bb4a7f8baa46a57078cd61.html) in the TUA Help portal.

- [Checkout]({{ site.baseurl }}{% link _pages/telco/checkout.md %})

To support product offerings and the complex pricing structure they have for one time charges, recurring charges and usage charges, changes to the checkout process were necessary. For more information, see  in the TUA Help portal. For more information, see [Checkout](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/2007/en-US/91a9faae27bb4a7f8baa46a57078cd61.html) in the TUA Help portal.

- [Configurable Guided Selling]({{ site.baseurl }}{% link _pages/telco/configurable-guided-selling.md %})

Improves the user experience by simplifying the purchase process for complex bundled product offerings. Configurable Guided Selling (CGS) is the process in which a customer is taken through a step-by-step guided selling journey to purchase a complex product bundle. For more information, see [Configurable Guided Selling](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/fa22e16db2524c0bb9b12c6102ba1b5d.html) in the TUA Help portal.

- [ Pricing - Subscription Rate Plan]({{ site.baseurl }}{% link _pages/telco/product-offering-prices.md %})

Provide greater customer experiences by providing product offerings to customers with specific pricing that they are eligible for. Pricing for product offerings is extremely complex and includes one time charges, recurring charges and usage based charges. For more information, see [Pricing](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/2007/en-US/8e591e48aa604b2f8c4a0d9804c6d6f5.html) in the TUA Help Portal.

## About Spartacus for TUA Releases

- Libraries that are “released” are new, official, tested TUA Spartacus libraries available to the public (hosted on npmjs.com)
- We usually publish new libraries every 2 weeks
- Similar to Spartacus: A change in minor means we added new features, but they are configured to be off by default, so as not to cause compatibility issues. A new minor also means inclusion of changes or bug fixes that may affect compatibility, but these are also controlled by feature flags. So all significant changes are “opt-in”. See feature flag documentation for more information.
- We will normally publish pre-release libraries labelled 'next' a few weeks before a new minor release. The goal is to provide early access to new features and get feedback from the community.
- If you choose not to use a new feature, you should have no problems upgrading to a new Major.# with features flag set to a previous Major.#. If you do see a problem, please report a bug and we’ll assess and fix it. We encourage you to upgrade to latest libraries frequently during development in order to take advantage of bug fixes and new features.
- Please visit our Spartacus for TUA Compatibility Matrix to understand requirements. For more information, see [Feature Release Versions]({{ site.baseurl }}{% link _pages/telco/tua-feature-release-versions.md %}).
- To use all functionality in Spartacus 2.*, release 2005 of SAP Commerce Cloud and 2007 of Telco & Utilities Accelerator is required.
- The latest patch release is required or at least strongly recommended, as it usually contains bug fixes that affect Spartacus

<!--## Upgrading Spartacus Libraries to a New Minor Version

You can upgrade your Spartacus libraries to a new minor version, as follows:

1. In `package.json`, set your `@spartacus` libraries to `“~2.#.0"`, where `#` is replaced with the release version number you wish to upgrade to.

   If you are upgrading from 1.x to the latest 1.5 release in order to then upgrade to 2.x, in `package.json`, set your `@spartacus` libraries to `“~1.5.5"`.

1. Delete your `node_modules` folder.
1. Run `yarn install`.-->

## Feature Releases

For more information, see [Roadmap for TUA Spartacus]({{ site.baseurl }}{% link _pages/telco/tua-spartacus-roadmap.md %}).

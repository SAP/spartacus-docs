---
title: Spartacus Roadmap
---

This document describes what what is planned for Spartacus for Q4 2022 and later.

*Last updated August 2022 by Bill Marcotte, Senior Product Manager, Spartacus*

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***
  
### Disclaimer - Forward-Looking Statements

*This document contains forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality.  This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence. The various documentation links provided point to SAP Commerce Cloud or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented in Spartacus.*
  
## Overview

### General Release Information

New Spartacus libraries are usually published every week. Each release may contain bug fixes, improvements, and new features.

When new features are available for release, normally we will publish a pre-release "next" version of the libraries with the new features, in order to get feedback. When the final, new, minor version is ready, we usually publish a release candidate (RC), with the final new x.y.0 a few days or weeks later.

Some of the links provided in the following lists point to SAP Commerce Cloud Accelerator or platform documentation, to give an idea of what the feature is about. These links are for context only. While we strive for feature parity, the Spartacus implementation of features may not work exactly as in Accelerator.
  
### Other Release Documentation

For an overview of what was included in a specific release, see [{% assign linkedpage = site.pages | where: "name", "release-information.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/home/release-information.md %}).

For information about features published in pre-release libraries, see [{% assign linkedpage = site.pages | where: "name", "pre-release-information.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/home/pre-release-information.md %}).

For roadmap information for all of SAP Commerce Cloud, including Spartacus topics, see the [SAP Roadmap Tool](https://roadmaps.sap.com/board?PRODUCT=089E017A62AB1EDA94C15F5EDB33E0E1).
  
### Questions? Assistance needed?

If you have technical or how-to questions about using Spartacus, try asking on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront).

If you would like to report an issue for assistance from SAP, please use the [SAP Launchpad reporting tool](https://launchpad.support.sap.com/)
  
## Summary of Tentative Release Dates

### 5.0 (scheduled for Q4 2022)

User experience and feature improvements:

- Screen Reader support for all B2C/Core features, plus addition of other accessibility requirements related to contract, labels, and more
- Support for new PDF and Video component types introduced in SAP Commerce Cloud 2205
- Toast option when adding to cart: Displays temporary confirmation message in top right corner, after adding to cart, instead of modal that must be closed
- Clear Cart command on cart page

Architecture-related improvements:

- Angular 13 framework
- Cart and B2B Checkout libraries bringing performance by splitting modules into smaller libraries
- Command & Queries for the checkout library, for improved developer experience
- Schematics for "wrapper" modules
- Strict compilation enabled
- Removal of most deprecated code

### Post-5.0 (end of 2022 and into 2023)

User experience and feature improvements:

- B2B Registration
- B2B Future Stock: Allow customers to see when future stock is to be delivered to seller
- ASM Anonymous Cart Binding
- ASM Customer List ([SAP Commerce Cloud Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b571515866910148fc18b9e59d3e084.html))
- Configurable Bundles (requires SAP Commerce Cloud 2011) ([SAP Commerce Cloud Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b6eec0286691014a041e59dc69dc185.html))
- Customer Ticketing (as described in [SAP Commerce Cloud Accelerator Documentation](https://help.sap.com/docs/SAP_COMMERCE/9d346683b0084da2938be8a285c0c27a/8ba078758669101498e4f89f5e4f5ea1.html))
- Buy online pickup in store ([SAP Commerce Cloud Accelerator Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ae75e2086691014a64bf7cdd7ed5fd6.html))
- Account Summary for Commerce Organization (as described in [SAP Commerce Cloud Accelerator Documentation](https://help.sap.com/docs/SAP_COMMERCE/4c33bf189ab9409e84e589295c36d96e/0075e2910fc64079bc1baa4a5b0e510a.html))
- Captcha support (similar to what's described in [SAP Commerce Cloud Documentation](https://help.sap.com/docs/SAP_COMMERCE/4c33bf189ab9409e84e589295c36d96e/8ac8663086691014ab34b77436f85412.html))
- Multi-site user support (to correspond with feature planned for SAP Commerce Cloud 2211)
- yForms support (to correspond with feature planned for SAP Commerce Cloud 2211)
- Completion of Screen Reader support for B2B channel Spartacus storefront
- Punchout support in Spartacus ([SAP Commerce Cloud Documentation](https://help.sap.com/docs/SAP_COMMERCE/4c33bf189ab9409e84e589295c36d96e/60fbb8dccb7a45949c570b6b1c272f10.html?version=latest))
- B2B Commerce Quotes ([SAP Commerce Cloud Accelerator Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/a795b4722f6942c091ef716c66ddb37d.html))
- S4 Order Management Schedule Lines on cart page: Estimated delivery schedules for the items in cart for S/4HANA-based Order Management

Note that certain features require specific SAP Commerce Cloud backend releases, including future releases. For example, B2B Registration requires  SAP Commerce Cloud 2105. Requirements will be documented when the feature is released.

Architecture-related improvements:

- Lazy loading for outlets and CSS styles (performance improvement)
- Further code splitting (modules to be determined)
- Update of Angular framework as available

---
title: Spartacus Roadmap
---

This document describes what what is planned for Spartacus for Q1 2022 and later.

*Last updated March 30, 2022 by Bill Marcotte, Senior Product Manager, Spartacus*

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

Current release plans are (dates are tentative):

- 5.0 planned for September
- 5.x releases to follow end of 2022

## 2022

### 5.0 (tentatively scheduled for September 2022)

The Spartacus 5.0 has been delayed from May 2022 to September 2022.

5.0 will feature:

- **Screen Reader** support for all B2C/Core features
- **Cart library** bringing performance by splitting modules into smaller libraries
- **Checkout libraries** separating B2B checkout and scheduled replenishment code from main checkout library
- **Command & Queries** for checkout library
- **Newest Angular framework** (currently 13, might be 14 depending on release schedule)
- **Removal of most deprecated code**
- **Support for new PDF and Video component types**
- **Toast option when adding to cart** - Displays temporary confirmation message in top right corner, after adding to cart, instead of modal that must be closed
- **Clear Cart** command on cart page
- **S4 Order Management Schedule Lines** on cart page

With the extra time, the following features are also being considered for 5.0, or soon after in 5.x release:

- **Screen Readers**: Completion of support for B2B channel Spartacus storefront
- **Buy online pickup in store** ([SAP Commerce Cloud Accelerator Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ae75e2086691014a64bf7cdd7ed5fd6.html))
- **B2B Commerce Quotes** (requires API update released in 2105) ([SAP Commerce Cloud Accelerator Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/a795b4722f6942c091ef716c66ddb37d.html))
- **Product bundles** (requires SAP Commerce Cloud 2011) ([SAP Commerce Cloud Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b6eec0286691014a041e59dc69dc185.html))
- **B2B Registration** (requires backend API improvement planned for release in 2022)
- **B2B Future Stock** (requires backend API improvement planned for release in 2022)
- Further code splitting (modules to be determined)
- Performance improvements
- Extensibility of lazy-loaded components

### H1 2023 Plans

- **ASM customer list** ([SAP Commerce Cloud Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b571515866910148fc18b9e59d3e084.html))
- **ASM Anonymous Cart Binding** (requires release 2005)
- **ASM Search Autocomplete** (requires release 2005)
- **Potential Promotions**
- **Punchout support in Spartacus** ([SAP Commerce Cloud Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac40cf08669101486f5ce44920c3f91.html))
- **One app for running B2C and B2B stores**
- **Accessibility**: WCAG 2.0 Level AA Storefront Support
- **Command and Queries** extended throughout the rest of the product
- **B2B Multi-Dimensional Products** delayed from 5.0 (depends on API improvement not yet planned)

Other features related to Spartacus/Accelerator parity and architectural improvements are also in the plans but no timeline yet, stay tuned!

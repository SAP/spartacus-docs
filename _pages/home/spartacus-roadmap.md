---
title: Spartacus Roadmap
---

This document describes what what is planned for Spartacus for Q3 2021 and later.

*Last updated August 5, 2021 by Bill Marcotte, Senior Product Manager, Spartacus*

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

Some of the links provided in the following lists point to SAP Commerce Cloud Accelerator documentation, to give an idea of what the feature is about. These links are for context only. While we strive for feature parity, the Spartacus implementation of features may not work exactly as in Accelerator.
  
### Other Release Documentation

- For an overview of what was included in a specific release, see [{% assign linkedpage = site.pages | where: "name", "release-information.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/home/release-information.md %}).
- For information about features published in pre-release libraries, see [{% assign linkedpage = site.pages | where: "name", "pre-release-information.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/home/pre-release-information.md %}).
- For information on SAP Commerce Cloud, see the [SAP Commerce Cloud Roadmap](https://cxwiki.sap.com/pages/viewpage.action?spaceKey=general&title=Roadmap).
  
### Questions?

If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront).
  
For non-technical questions and roadmap feedback, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ).
  
## Release Date Notes

4.0 released! See [{% assign linkedpage = site.pages | where: "name", "release-information.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/home/release-information.md %}).

Current release plans are:
- 4.x: Every 6 weeks - new releases with new features end of Q2 and into Q3
- 5.0: Planned for December 2021

### Q3 2021

4.x:

- **B2B Inventory Display** (includes option to display actual stock number instead of "in stock") - For more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac35e1d866910148876ef95adde0c60.html)
- **B2B Import Products to Saved Cart** and **Export from Cart** (\*) (from/to files) - for more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/1a13b9c4f0fb4367a14006f77f479c86.html)
- **B2B Quick Order** (dedicated form and from cart page) - For more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/caf95981aa174660b3faf839a9dddbef.html)
- **Cart Validation** More formal checking of carts before you proceed to checkout, for example, check if a product is still in stock
- **Image Zoom** on Product Details page (will be released in an incubator library)
- **One app for running B2C and B2B stores**
- **Toast option when adding to cart** - Displays temporary confirmation message in top right corner, after adding to cart, instead of modal that must be closed
- **Product bundles** (requires SAP Commerce Cloud 2011) - for more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b6eec0286691014a041e59dc69dc185.html)
- **SAP Digital Payments** support

5.0:

- **Buy online pickup in store** - for more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ae75e2086691014a64bf7cdd7ed5fd6.html)
- **Accessibility - Screen Readers** support
- **Site map**
- **Code splitting for cart**

## Future Outlook - 2022 or later

The items in this section are planned for 2022 but do not yet have a specific date. APIs already support these features.

- **B2B Commerce Quotes** (requires API update released in 2105) - for more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/a795b4722f6942c091ef716c66ddb37d.html)
- **ASM customer list** - for more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b571515866910148fc18b9e59d3e084.html)
- **ASM Anonymous Cart Binding** (requires API introduced in 2005)
- **ASM Search Autocomplete** (requires API introduced in 2005)
- **Potential Promotions**
- **Self-service customer support** through the Customer Service Module (requires API update planned for 2105) - for more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/aa039c46e5eb4c7da752afc0e05947e5.html)
- **Buy it again** (add to cart from existing order)
- **Social sharing** of product information
- **B2B Order Form Builder** - for more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac1a3d586691014911dd58c04389cc3.html)
  
The following features are planned but depend on API updates, scheduled for the release-after-2105:
- **B2B Re-order**
- **B2B Multi-dimensional product support and order grid**
- **B2B Registration**

The following features are on our radar but depend on API updates not yet scheduled:
- **Punchout** - for more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1811/en-US/8ac40cf08669101486f5ce44920c3f91.html)
- **Captcha** - for more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac8663086691014ab34b77436f85412.html)
- **ASM Customer 360°** (requires API update not yet planned)
- **B2B Future Stock** (requires API update not yet planned) - for more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac331e086691014bfdb96ba9faf7c86.html)
- **B2B Account Summary** (requires API update not yet planned) for Commerce Org

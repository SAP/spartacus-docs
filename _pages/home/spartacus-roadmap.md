---
title: Spartacus Roadmap
---

This document describes what what is planned for Spartacus for Q4 2020 and later.

*Last updated December 8, 2020 by Bill Marcotte, Senior Product Manager, Spartacus*

Contents:

- [Disclaimer - Forward-Looking Statements](#disclaimer---forward-looking-statements)
- [Overview](#overview)
- [Features Planned for Version 3.0 / December](#features-planned-for-version-30---december)
- [Features Planned for Q1 2021](#features-planned-for-q1-2021)
- [Features Planned for Q2 2021](#features-planned-for-q2-2021)
- [Future Outlook](#future-outlook)
  
### Disclaimer - Forward-Looking Statements

*This document contains forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality.  This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence. The various documentation links provided point to SAP BTP or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented in Spartacus.*
  
## Overview

### General Release Information

We usually publish new Spartacus libraries every week. Each release may contain bug fixes, improvements, and new features.

When new features are available for release, normally we will publish a pre-release "next" version of the libraries with the new features, in order to get feedback. When the final, new, minor version is ready, we usually publish a release candidate (RC), with the final new x.y.0 a few days or weeks later.

Some of the links provided in the following lists point to SAP Commerce Cloud Accelerator documentation, to give an idea of what the feature is about. These links are for context only. While we strive for feature parity, the Spartacus implementation of features may not work exactly as in Accelerator.
  
### Other Release Documentation

- For an overview of what was included in a specific release, see [Release Information]({{ site.baseurl }}{% link _pages/home/release-information.md %}).
- For information about features published in pre-release libraries, see [Pre-Release Information]({{ site.baseurl }}{% link _pages/home/pre-release-information.md %}).
- For information on SAP Commerce Cloud, see the [SAP Commerce Cloud Roadmap](https://cxwiki.sap.com/pages/viewpage.action?spaceKey=general&title=Roadmap).
  
### Questions?

If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront).
  
For non-technical questions and roadmap feedback, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ).
  
  
## Features Planned for Q1 2021
  
### B2B Features

- **B2B Registration**
- **B2B Bulk Price List**
- **B2B Multi-dimensional product support** (requires API update)
- **Improvements to B2B Commerce Organization**

### Architecture

- **Performance improvements through code splitting / lazy loading** (update of existing codebase)
- **New events** for Event Service
- **Dynamic Theme Selection**
- **One app for running B2C and B2B stores**

### Integrations

- **SAP Variant Configuration and Pricing** (formerly known as CPQ)
  Initial version to include:
  - Single- or multilevel configurable products in your Commerce Spartacus storefront
  - Configuration page with the most commonly used characteristic types such as radio buttons, checkboxes, and images for characteristic values
  - Price summary at the bottom of the configuration page with the base price, the price of the selected options, and the overall total price of the configured product
  - Overview page with all user selections accessible at any time during configuration
  - Conflict handling
  For reference, see [Product Configuration with SAP Variant Configuration and Pricing](https://help.sap.com/viewer/80c3212d1d4646c5b91db43b84e9db47/latest/en-US).
- **SAP Customer Data Cloud** integration library (Login and Registration Support)
  - Provides authentication and consent management through CDC instead of what’s out-of-the-box SAP Commerce Cloud
  - For more information, see the [SAP Customer Data Cloud Integration Module Documentation](https://help.sap.com/viewer/50c996852b32456c96d3161a95544cdb/latest/en-US/4fc06a3539a940e6b707c0c543d44053.html)
  - CDC is previously known as Gigya
- **SAP Digital Payments Integration** - for more information, see the [SAP Digital Payments Add-On Integration Module documentation](https://help.sap.com/viewer/4f00a6453e4242bbac5b3cb82b616576/latest/en-US)
- **SAP Entitlement Management Integration** - for more information, see the [SAP Entitlement Management Integration Module documentation](https://help.sap.com/viewer/f1a442a5d4664fa08fee7b182df437f5/latest/en-US)
  
  
  
## Features Planned for Q2 2021

### B2B Features

- **B2B Saved Carts** - for more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/4d094e78a5494963b2d66148167f0553.html)
- **B2B Re-order**
- **B2B Quick Order** - for more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/caf95981aa174660b3faf839a9dddbef.html)
- **B2B Product Import and Export Cart** (\*) (from/to files) - for more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/1a13b9c4f0fb4367a14006f77f479c86.html)
- **B2B Inventory Display** - For more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac35e1d866910148876ef95adde0c60.html)
- **Accessibility Screen Reader** support

### Architecture

- **Tag Manager framework**
- Support for **Adobe Experience Platform Launch**
  
  
## Future Outlook - Q3 2021 and Later

The items in this section are on our future roadmap.

### Features

- **B2B Multi-Dimensional Products Order Grid**
- **B2B Order Form Builder** - for more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac1a3d586691014911dd58c04389cc3.html)
- **Image Zoom** on Product Details page (will be released in an incubator library)
- **Buy online pickup in store** - for more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ae75e2086691014a64bf7cdd7ed5fd6.html)
- **Assisted Service Module customer list** - for more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b571515866910148fc18b9e59d3e084.html)
- **Assisted Service Module anonymous cart binding** (requires API introduced in 2005)
- **Potential Promotions**
- **Product bundles** (requires SAP Commerce Cloud 2011) - for more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b6eec0286691014a041e59dc69dc185.html)
- **Captcha** (\*) - for more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac8663086691014ab34b77436f85412.html)
- **Self-service customer support** through the Customer Service Module (\*) - for more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/aa039c46e5eb4c7da752afc0e05947e5.html)
- Angular I18N support
- **Buy it again** (add to cart from existing order)
- **Social sharing** of product information
- **B2B Commerce Quotes** (\*) - for more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/a795b4722f6942c091ef716c66ddb37d.html)
- **B2B Future Stock** (\*) - for more information, see the [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac331e086691014bfdb96ba9faf7c86.html)
- **B2B Account Summary** (\*) for Commerce Org

Items listed above with **(\*)** require new OCC REST APIs, no date set yet; see general SAP Commerce Cloud roadmap.

### Architecture

- Support for **Google Tag Manager**
- **Site map**
- **Extensibility 2.0** - finer-grained extensibility
 

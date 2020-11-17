---
title: Spartacus Roadmap
---

This document describes what what is planned for Spartacus for Q4 2020 and later.

*Last updated October 15, 2020 by Bill Marcotte, Senior Product Manager, Spartacus*

Contents:

- [Disclaimer - Forward-Looking Statements](#disclaimer---forward-looking-statements)
- [Overview](#overview)
- [Features Planned for Version 3.0 / November](#features-planned-for-version-30--november)
- [Features Planned for the Rest of Q4 2020 and into Q1 2021](#features-planned-for-the-rest-of-q4-2020-and-into-q1-2021)
- [Future Outlook / Features Planned for 2021 and Later](#future-outlook--features-planned-for-2021-and-later)
  
### Disclaimer - Forward-Looking Statements

*This document contains forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality.  This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence. The various documentation links provided point to SAP Commerce Cloud platform or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented in Spartacus.*
  
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

## Features Planned for Version 3.0 / November

Release 3.0 will be the first release supporting B2B features.

### B2B Storefront Features planned for 3.0

- **B2B Powertools Store support**
- **B2B Checkout**
  - Allows customers to check out by account, besides credit card
  - Customers can enter a purchase order number that is saved with orders
  - If paying by account: cost center selection, shipping address restricted by cost center chosen), subject to approval process
  - For more information, see the [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac2500f8669101493e69e1392b970fd.html)
- **B2B Commerce Organization**
  - Also known as My Company
  - Self-service spending and organization management
  - Create and manage units, users, budgets, cost centers, purchase thresholds, user groups, and approvals)
  - For more information, see the [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac27d4d86691014a47588e9126fdf21.html)
- **B2B Scheduled Replenishment**
  - For more information, see the [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8c3aa31e86691014a3c085a0e9186e0c.html)
- **Updates to Order Details**
  - Includes B2B-specific information, such as approval table and cost center
- **B2B Inventory Display**
  - For more information, see the [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac35e1d866910148876ef95adde0c60.html)
- **Lazy loading for modules**
  - For better performance
  - Starting with B2B My Company module

**Note:** Spartacus B2B features require SAP Commerce Cloud 2005. Certain features (such as Commerce Org or Scheduled Replenishment) require OCC REST APIs introduced in 2005; and the Spartacus functionality will be implemented based on the non-conflicting B2B endpoints introduced in 2005.

### Architectural Features planned for 3.0

- **Angular 10**
- **Session Management** improvements
  - Separates OCC API integration from core Spartacus code, allowing use of adapters and connectors
  - Makes it easier to add your own Identity Provider
  - Improves security while reducing friction in the authentication and login user experience

### Integrations planned for 3.0 timeframe

- **Customer Data Cloud** integration library (Login and Registration Support)
  - Provides authentication and consent management through CDC instead of what’s out-of-the-box SAP Commerce Cloud
  - For more information, see the [SAP Customer Data Cloud Integration Module Documentation](https://help.sap.com/viewer/50c996852b32456c96d3161a95544cdb/1905/en-US/4fc06a3539a940e6b707c0c543d44053.html)
  - CDC is previously known as Gigya
  
## Features Planned for the Rest of Q4 2020 and into Q1 2021
  
### B2B Storefront Features

- **B2B Saved Carts** - for more information, see the [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/4d094e78a5494963b2d66148167f0553.html)
- **B2B Re-order**
- **B2B Quick Order** - for more information, see the [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/caf95981aa174660b3faf839a9dddbef.html)
- **B2B Bulk Price List**
- **B2B Multi-dimensional product support** (requires API updated to be included in release 2011)
- **B2B Product Import and Export Cart** (\*) (from/to files) - for more information, see the [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/1a13b9c4f0fb4367a14006f77f479c86.html)

### Core Storefront Features

- **Image Zoom** on Product Details page (will be released in an incubator library)
- **Accessibility Screen Reader support**
- **Buy online pickup in store**
  - For more information, see the [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ae75e2086691014a64bf7cdd7ed5fd6.html)
- **Assisted Service Module customer list**
  - For more information, see the [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b571515866910148fc18b9e59d3e084.html)
- **Assisted Service Module anonymous cart binding** (requires API introduced in 2005)
- **Potential Promotions**
- **Bundles** (requires new API planned for 2105 release)
  
### Architecture Features

- **New events** for Event Service
- **Site map**
- **Tag Manager framework**
- **Google Tag Manager Support**
  
## Future Outlook / Features Planned for 2021 and Later

The items in this section are on our future roadmap - not necessarily yet planned for a specific quarter.
  
### Architecture and Development Features

- Performance improvements through further implementation of lazy loading and with CMS
- Completion of events framework
- Extensibility improvements
  
### Core/B2C Storefront Features

- Captcha (\*)
  - For more information, see the [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac8663086691014ab34b77436f85412.html)
- New Accessibility features
- Buy it again (add to cart from existing order)
- Social sharing of product information
- Self-service customer support through the Customer Service Module (\*)
  - For more information, see the [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/aa039c46e5eb4c7da752afc0e05947e5.html)
- Configurable bundles (\*)  
  - For more information, see the [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b6eec0286691014a041e59dc69dc185.html)
- Payments Request API ([W3 Documentation](https://www.w3.org/TR/payment-request/))
- Credentials API
- Other PWA Features as defined in Google's [PWA Checklist](https://developers.google.com/web/progressive-web-apps/checklist) such as mobile notifications
- Angular I18N support
- Directionality (for right-to-left display support)
- Spartacus for China (similar to [Accelerator for China](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8b258c36866910148298d20518a62a16.html))
  
### B2B Storefront Features

- **B2B Order Form Builder**
  - For more information, see the [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac1a3d586691014911dd58c04389cc3.html)
- **B2B Multi-Dimensional Products Order Grid**
- **B2B Commerce Quotes** (\*)
  - For more information, see the [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/a795b4722f6942c091ef716c66ddb37d.html)
- **B2B Future Stock** (\*)
  - For more information, see the [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac331e086691014bfdb96ba9faf7c86.html)
- **B2B Account Summary** (\*) for Commerce Org

Some items listed above have **(\*)** because the feature requires new OCC REST APIs, no date set yet.

### Integrations

- **SAP Variant Configuration and Pricing** (formerly known as CPQ)
  Initial version to include:
  - Single- or multilevel configurable products in your Commerce Spartacus storefront
  - Configuration page with the most commonly used characteristic types such as radio buttons, checkboxes, and images for characteristic values
  - Price summary at the bottom of the configuration page with the base price, the price of the selected options, and the overall total price of the configured product
  - Overview page with all user selections accessible at any time during configuration
  - Conflict handling
  For reference, see [Product Configuration with SAP Variant Configuration and Pricing](https://help.sap.com/viewer/80c3212d1d4646c5b91db43b84e9db47/2005/en-US).

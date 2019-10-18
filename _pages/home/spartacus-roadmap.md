---
title: Spartacus Roadmap
---

*Last updated October 6, 2019 by Bill Marcotte, Senior Product Manager, Spartacus*

This document describes what what is planned for Spartacus for end of 2019 and into 2020.

If you have any questions, use the feedback channel of our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU). 
  
  
##### *Disclaimer - Forward-Looking Statements*

*This document contains forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality.  This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence.*

*The various documentation links provided point to SAP Commerce Cloud platform or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented.*
  
## Overview

We plan to release updates to the Spartacus libraries every two weeks. Each release will contain bug fixes as well as improvements to user experience and performance.

When new features are available for release, normally we will publish a pre-release "next" version of the libraries, in order to get feedback, and then we will release the final, new, minor version a few weeks later. For example, we plan to publish a pre-release 1.3 "next" in mid-October, and then 1.3.0 at the end of October.

The order of features shown in the roadmap below generally reflects the order of prioritization. For example, ASM and variants are high on the list because we are aiming to release those features in Q4 2019.

Some of the links provided point to SAP Commerce Cloud Accelerator documentation, to give an idea of what the feature is about. These links are for context only. While we strive for feature parity, the Spartacus implementation of features may not work exactly as in Accelerator.

B2B features are based on the B2B Accelerator [Powertools store](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/417df297eb39466288dd904e8acc426f.html). Most B2B support depends on new APIs that are scheduled for release in SAP Commerce during Q2 2020.
  
## Notes

Some items have notes, for example (1) or (2)

- (1): The feature requires new OCC REST APIs that are planned for the next SAP Commerce release, scheduled for May 2020. These features may be available sooner to customers using SAP Commerce Cloud hosting services.
- (2): The feature requires new OCC REST APIs, not yet planned.
  
## Planned for 1.3 (End of October 2019)
  
### Architecture and Development Features

- Storefront Self-Configuration (detection of languages, currencies, and other site settings through base site API)
- Schematics (for automatically setting up a Spartacus apps)
- Qualtrics intercept integration and example
  
### Core Storefront Features

- [Assisted Service Module (ASM) customer emulation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/8b571515866910148fc18b9e59d3e084.html)
- [Anonymous consent](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/a9f387f70d484c19971aca001dc71bc5.html)
- [Coupons](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/02a8521eb67b4866a632a1a5e79037e3.html?q=coupons)
  
## Planned for 1.4 (End of November 2019)
  
### Architecture and Development Features

- Performance improvements: Product Loading
- Fine-Grained Extensibility
  
### Core Storefront Features

- [Variants](https://help.sap.com/viewer/d0224eca81e249cb821f2cdf45a82ace/1905/en-US/8c143a2d8669101485208999541c383b.html) support, as seen in the Apparel store (not the same as B2B multi-dimensional support, as seen in the Powertools store)
  - Spartacus version of Apparel sample data (like Electronics-Spa)
- Favorites Wishlist (dedicated wishlist for bookmarking favorite products, does not add to cart)
- [Self-service cancellations](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/22e69b8fc4884d5eb58c39b97b3322fb.html) and [returns](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/2b6fea0f5f61481f86af205c7c7e9b61.html) <sup>(1)</sup>
- Improvements to Applied Promotions (per entry in cart)
- [Context-Driven Services](https://help.sap.com/viewer/product/CONTEXT-DRIVEN_SERVICES/SHIP/en-US) (CDS) and the associated Merchandising Component
- Accessibility (keyboarding)
- [Selective Cart](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/58837af020d346df84773bd2ea75fd69.html) (save items in cart for later)
- [Back-in-stock notifications](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/2ad0f5f1bbcc47dfbba4f5cd7c6394c1.html)
  
### B2B Storefront Features

- Powertools sample data modified to work with Spartacus
  
## Planned for 1.5 (January 2019)
  
Due to end-of-year holidays, we will likely release a 1.5-next with new features in the third week of December, with the final 1.5 release occurring in January. (To be confirmed in December)
  
### B2B Storefront Features
  
- [B2B Commerce Org](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ac27d4d86691014a47588e9126fdf21.html?q=commerce%20org%20my%20company) <sup>(1)</sup> (aka My Company management: units, users, budgets, cost centers, purchase threshholds, user groups, approvals, account summary) 
- [B2B Checkout](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ac2500f8669101493e69e1392b970fd.html) - check out by account, input purchase order, select cost center, shipping address restricted by cost center chosen, approval process 
  
## Planned for 2.0 (End of March 2020)
  
We plan to move to a new major (2.0) in Q1 2020, primarily due to support for Angular Ivy. The release of a new major version of Spartacus means that the code contains breaking changes. 

Some features may be released in a 1.x release depending on timing.
  
### Archictecture and Development Features

- Move to Angular 9
  - Schematics update for supporting migration
  - 3rd party dependencies updates
- Angular Ivy support (new compilation and rendering pipeline)
  - Smaller, simpler and faster
  - Better support for web components
  - Better performance on mobile devices
  - Less memory used
  - Tree shaking for smaller packages
- Angular I18N support
- Lazy Loading CMS components
- Session management
- Performance improvements : CMS
  
### Core Storefront Features

- [Customer coupons and management](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/7f8304a85bf24db0bfc5cf3b057ae322.html)
- Buy it again
- Accessibility features
  
### B2B Storefront Features

- [B2B Quick order](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/caf95981aa174660b3faf839a9dddbef.html)
- [B2B Scheduled replenishment](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/8c3aa31e86691014a3c085a0e9186e0c.html) <sup>(1)</sup>
  
## Future Outlook
  
The items in this section are on our future roadmap but not necessarily in Q2 2020 or another specific quarter.
  
### Archictecture and Development Features

- Support for SAP Commerce Domain Services (Cloud Cart and Cloud Search)
- Agnostic UI-framework (can swap out Bootstrap)
- Performance Improvements
- Angular 10 (scheduled for release Q4 2020)
- Schema.org support
- Dynamic Forms
- More Lazy Loading (e.g. lazy load below-the-folder components)
- Extend schematics to create CMS component
- PWA feature related to architecture e.g. improved 2G performance
  
### Core Storefront Features

- [Buy online pickup in store](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ae75e2086691014a64bf7cdd7ed5fd6.html)
- [Captcha](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ac8663086691014ab34b77436f85412.html) <sup>(1)</sup>
- Potential Promotions <sup>(1)</sup>
- [Assisted Service Module customer list](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/8b571515866910148fc18b9e59d3e084.html)
- [Assisted Service Module customer 360° view](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/8b571515866910148fc18b9e59d3e084.html) <sup>(1)</sup>
- Single-sign on integration with [SAP Customer Data Data from GIGYA](https://developers.gigya.com/display/GD/SAP+Commerce+Cloud)
- Self-service customer support ([Customer Service Module](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/aa039c46e5eb4c7da752afc0e05947e5.html))
- Forms user experience improvements
- Accessibility features
- Wishlists+
- Country-specific address forms
- PWA Features
  - Payments Request API ([W3 Documentation](https://www.w3.org/TR/payment-request/))
  - Credentials API
  - Mobile device notifications
  - Offline awareness
  - Other features related to PWA as defined in Google's [PWA Checklist](https://developers.google.com/web/progressive-web-apps/checklist)
- Phone number as ID
- [Configurable products](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/478f616a46f84d668f8cd42c0259cdf0.html)
- Credit-card auto-detect
- [Configurable bundles](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/8b6eec0286691014a041e59dc69dc185.html) <sup>(2)</sup>
- Spartacus for China (similar to [Accelerator for China](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8b258c36866910148298d20518a62a16.html)
  
### B2B Storefront Features

- [B2B Order Form Builder](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ac1a3d586691014911dd58c04389cc3.html)
- [B2B Saved Carts](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/4d094e78a5494963b2d66148167f0553.html)
- [B2B Future Stock](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ac331e086691014bfdb96ba9faf7c86.html) <sup>(1)</sup>, [Inventory Display](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ac35e1d866910148876ef95adde0c60.html) <sup>(1)</sup>, Bulk Price List <sup>(1)</sup>
- [B2B Product Import and Export Cart](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/1a13b9c4f0fb4367a14006f77f479c86.html) <sup>(1)</sup>  (using CSV files)
- B2B Multi-Dimensional product support  <sup>(2)</sup>
- Re-order <sup>(1)</sup>
- [B2B Commerce Quotes](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/a795b4722f6942c091ef716c66ddb37d.html) <sup>(2)</sup> and integrations with other quotation management systems  

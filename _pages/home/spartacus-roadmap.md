---
title: Spartacus Roadmap
---

*Last updated September 26, 2019 by Bill Marcotte, Senior Product Manager, Spartacus*

This document describes what what is planned for Spartacus for end of 2019 and into 2020.

If you have any questions, use the 'feedback' channel of our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU). 




##### *Disclaimer - Forward-Looking Statements*

*This document contains forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality.  This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence.*

*The various documentation links provided point to SAP Commerce Cloud platform or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented.*



# Overview

We plan to release updates to the Spartacus libraries every two weeks. Each release contains bug fixes as well as improvements to user experience and performance.

When new features are available for release, normally we will publish a pre-release "next" version of the libraries, in order to get feedback, and then we will release the final, new, minor version a few weeks later. For example, we plan to publish a pre-release 1.3 "next" in mid-October, and then 1.3.0 at the end of October.

The order of features shown in the roadmap below generally reflects the order of prioritization. For example, ASM and variants are high on the list because we are aiming to release those features in Q4 2019.

Some of the links provided point to SAP Commerce Cloud Accelerator documentation, to give an idea of what the feature is about. These links are for context only. While we strive for feature parity, the Spartacus implementation of features may not work exactly as in Accelerator.

B2B features are based on the B2B Accelerator [Powertools store](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/417df297eb39466288dd904e8acc426f.html). Most B2B support depends on new APIs that are scheduled for release in SAP Commerce during Q2 2020.



# Planned for End of October 2019 / 1.3

- [Assisted Service Module (ASM) customer emulation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/8b571515866910148fc18b9e59d3e084.html)
- [Anonymous consent](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/a9f387f70d484c19971aca001dc71bc5.html)
- Qualtrics intercept integration and example
- [Coupons](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/02a8521eb67b4866a632a1a5e79037e3.html?q=coupons)
- Self-configuration of languages, currencies, and other site settings through basesite API
- Schematics, for automatically setting up a Spartacus web apps
- Performance improvements

  

# Planned for End of November 2019 / 1.4

- [Variants](https://help.sap.com/viewer/d0224eca81e249cb821f2cdf45a82ace/1905/en-US/8c143a2d8669101485208999541c383b.html) support, as seen in the Apparel store (not the same as B2B multi-dimensional support, as seen in the Powertools store)

  - Spartacus version of Apparel sample data (like Electronics-Spa)

- Accessibility features related to keyboarding

- [Context-Driven Services](https://help.sap.com/viewer/product/CONTEXT-DRIVEN_SERVICES/SHIP/en-US) (CDS) and the associated Merchandising Component

- Applied promotions per cart entry

- [Selective Cart](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/58837af020d346df84773bd2ea75fd69.html) (save items in cart for later)

- Improvements to extendability

  

# Planned for Early January 2020 / 1.5

Due to end-of-year holidays, we will likely release a 1.5-next with new features in the third week of December, with the final 1.5 release occurring early-to-mid January.

- [B2B Commerce Org](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ac27d4d86691014a47588e9126fdf21.html?q=commerce%20org%20my%20company) <sup>(1)</sup> (aka My Company management: units, users, budgets, cost centers, purchase threshholds, user groups, approvals, account summary) 
  
  - [With related checkout support](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ac2500f8669101493e69e1392b970fd.html) - check out by account, input purchase order, select cost center, shipping address restricted by cost center chosen, approval process
  
- [Buy online pickup in store](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ae75e2086691014a64bf7cdd7ed5fd6.html)

- More performance improvements 

  

# Planned for Q1 2020

- [B2B Scheduled replenishment](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/8c3aa31e86691014a3c085a0e9186e0c.html) <sup>(1)</sup>
- [B2B Future Stock](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ac331e086691014bfdb96ba9faf7c86.html) <sup>(1)</sup>, [inventory display](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ac35e1d866910148876ef95adde0c60.html) <sup>(1)</sup>, bulk price list <sup>(1)</sup>
- [B2B Quick order](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/caf95981aa174660b3faf839a9dddbef.html)
- [B2B Order form builder](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ac1a3d586691014911dd58c04389cc3.html)
- [B2B Saved Carts](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/4d094e78a5494963b2d66148167f0553.html)
- [B2B import products through CSV files](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/1a13b9c4f0fb4367a14006f77f479c86.html) <sup>(1)</sup> for cart creation
- [Customer coupons and management](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/7f8304a85bf24db0bfc5cf3b057ae322.html)
- Favorites wish list
- [Back-in-stock notifications](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/2ad0f5f1bbcc47dfbba4f5cd7c6394c1.html)
- Improvements to inline form feedback
- More accessibility features

  

# Future Outlook: Q2 2020 and Later

### New Major Release Planned / Angular 9 (Ivy) Support

- Angular Ivy (smaller, simpler and faster)
  - Better support for web components
  - Better performance on mobile devices
  - Less memory used
  - Tree shaking for smaller packages
- Session management
- Lazy loading
- Custom types and interfaces
- Agnostic UI-framework (can swap out Bootstrap)
- Schema.org support

The release of a new major version of Spartacus means that the code contains breaking changes. 

  

### Other Features for Q2 2020 and Later

- [Captcha](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ac8663086691014ab34b77436f85412.html) <sup>(1)</sup>

- [Self-service cancellations](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/22e69b8fc4884d5eb58c39b97b3322fb.html) and [returns](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/2b6fea0f5f61481f86af205c7c7e9b61.html) <sup>(1)</sup>

- Self-service customer support ([Customer Service Module](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/aa039c46e5eb4c7da752afc0e05947e5.html))

- Rest of [Assisted Service Module](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/8b571515866910148fc18b9e59d3e084.html) functionality (customer list and 360° view)

- B2B multi-dimensional product support  <sup>(2)</sup>

- Single-sign on integration with [SAP Customer Data Data from GIGYA](https://developers.gigya.com/display/GD/SAP+Commerce+Cloud)

- Support for new Cloud Services (Cloud Cart, Cloud Checkout, Cloud Search, etc.)

- Payments Request API ([W3 Documentation](https://www.w3.org/TR/payment-request/))

- Phone number as ID

- Credentials API

- Mobile device notifications

- Offline awareness

- [Configurable products](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/478f616a46f84d668f8cd42c0259cdf0.html)

- [Configurable bundles](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/8b6eec0286691014a041e59dc69dc185.html) <sup>(2)</sup>

- More accessibility features

- Credit-card auto-detect

- Other features related to PWA as definedin Google's [PWA Checklist](https://developers.google.com/web/progressive-web-apps/checklist)

- Spartacus for China (similar to [Accelerator for China](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8b258c36866910148298d20518a62a16.html)

- [B2B Commerce Quotes](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/a795b4722f6942c091ef716c66ddb37d.html) <sup>(2)</sup> and integrations with other quotation management systems  

  

#### Notes

(1): The feature requires new OCC REST APIs that are planned for the next SAP Commerce release, scheduled for May 2020. These features may be available sooner to customers using SAP Commerce Cloud hosting services, through Cloud Extension Packs (CEPs).

(2): The feature requires new OCC REST APIs, not yet planned.

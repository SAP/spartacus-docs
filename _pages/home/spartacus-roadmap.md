---
title: Spartacus Roadmap
---

*Last updated December 3, 2019 by Bill Marcotte, Senior Product Manager, Spartacus*

This document describes what what is planned for Spartacus for end of 2019 and into 2020.

If you have any questions, use the feedback channel of our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU). 

  


#### *Disclaimer - Forward-Looking Statements*

*This document contains forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality.  This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence.*

*The various documentation links provided point to SAP Commerce Cloud platform or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented in Spartacus.*

  

#### General Release Information

We plan to publish new Spartacus libraries every two weeks. Each release may contain bug fixes, improvements to user experience, and new features.

When new features are available for release, normally we will publish a pre-release "next" version of the libraries with the new features, in order to get feedback. When the final, new, minor version is ready, we usually publish a release candidate (RC), with the final new 1.x.0 a  weeks later. For example, we will publish a few pre-release 1.4 "next" libraries in December, and then 1.4.0 will be released third week of December.

Some of the links provided in the following lists point to SAP Commerce Cloud Accelerator documentation, to give an idea of what the feature is about. These links are for context only. While we strive for feature parity, the Spartacus implementation of features may not work exactly as in Accelerator.

B2B features are based on the B2B Accelerator [Powertools store](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/417df297eb39466288dd904e8acc426f.html). Many B2B features depend on new APIs that are scheduled for release in SAP Commerce during Q2 2020 or later.

  

#### Notes
Some items have notes, for example **(1)** or **(2)**
- **(1)**: The feature requires new OCC REST APIs that are planned for the next SAP Commerce release, scheduled for May 2020. These features may be available sooner to customers using SAP Commerce Cloud hosting services.
- **(2)**: The feature requires new OCC REST APIs, not yet planned.

  
  

## Planned for 1.4 – December 2019

*Scheduled for approximately third week of December 2019*

  

#### Architecture and Development Features
- Performance improvements when loading product data
- Token revocation (requires November patch release of SAP Commerce 1905)
- Multi-cart handling (internal service)
- Custom component schematics
  

#### Core/B2C Storefront Features

- Product Variants support, as seen in the Apparel store 
  (not the same as B2B multi-dimensional support, as seen in the Powertools store) 
  [SAP Commerce Documentation](https://help.sap.com/viewer/d0224eca81e249cb821f2cdf45a82ace/latest/en-US/8c143a2d8669101485208999541c383b.html)
- Apparel sample data modified to work with Spartacus (requires latest spartacussampledataaddon)
- Wishlist (dedicated wishlist for bookmarking products)
- Self-service Cancellations and Returns<sup>(1)</sup>
  SAP Commerce Documentation: [Cancellations](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/22e69b8fc4884d5eb58c39b97b3322fb.html) [Returns](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/2b6fea0f5f61481f86af205c7c7e9b61.html) 
- Improvements to Applied Promotions (per entry in cart)
- Selective Cart (save items in cart for later)
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/58837af020d346df84773bd2ea75fd69.html) 
- Back-in-stock notifications
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/2ad0f5f1bbcc47dfbba4f5cd7c6394c1.html)
- Context-Driven Services (CDS) and the associated Merchandising Component
  [SAP Commerce Documentation](https://help.sap.com/viewer/product/CONTEXT-DRIVEN_SERVICES/SHIP/en-US) 

  

## Planned for 1.5 - January 2020



#### Keyboarding-Related Accessibility Features

- Full Keyboard Support (WCAG 2.0, 2.1.1, Level A, Keyboard; WCAG 2.0, 2.1.2, Level A, No Keyboard Trap)
- Consistent Navigation (WCAG 2.0, 3.2.3, Level AA, Consistent Navigation)
- Tabbing/Reading Order (WCAG 2.0, 2.4.3, Level A, Focus Order)
- Group Skipping (WCAG 2.0, 2.4.1, Level A, Bypass Blocks)
- Focus Visible (WCAG 2.0, 2.4.7, Level AA, Focus Visible)



## Planned for Rest of Q1 2020

*Exact dates to be determined*
  

#### Archictecture and Development Features
  
A new major (2.0) is planned for mid-Q1 2020, primarily due to planned support for Angular 9 and the new Ivy rendering engine. The release of a new major version of Spartacus means that the code contains breaking changes. Some features may be released earlier depending on timing.

For upgrading to Spartacus 2.0, we’re working on a transition that will easy as possible. Typically we expect the update process to span as little as one hour, to at most one day, if being done by an experienced Angular developer.
  
There will be an update command (on top of Angular’s update command) that should take care of most changes automatically, including low-level changes. However, the exception might be if code has been extended or replaced by customers. Not all updates will be taken care of automatically, so we will be looking for feedback as release candidates are published.
  
Note: One low-level area to avoid at the moment is the Cart, as it is going through a refactor for 2.0 release.

- Move to Angular 9 (aiming for February 2020)
  - Schematics update for supporting migration
  - 3rd party dependencies updates
- Angular Ivy support (new compilation and rendering pipeline)
  - Smaller, simpler and faster
  - Better performance on mobile devices
  - Less memory used
  - Tree shaking for smaller packages

Stretch for 2.0 release:
- Extensibility Improvements (Sproutlets)

- Session Management (for better handling of authentication)

- Fetch Multiple CMS

- Directionality (for right-to-left display support)

- Performance improvements: Incremental loading of CMS data, the ability to fetch multiple CMS components at once, lazy loading, and above-the-folder UI loading

- Removal of ng Bootstrap

- Angular I18N support

  

  

#### Core/B2C Storefront Features

- Buy it again (add to cart from existing order)


  

  

#### B2B Storefront MVP

- B2B Commerce Org <sup>(1)</sup> (also known as My Company management of units, users, budgets, cost centers, purchase threshholds, user groups, approvals) 
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac27d4d86691014a47588e9126fdf21.html?q=commerce%20org%20my%20company)
- B2B Checkout (check out by account, enter purchase order, select cost center, shipping address restricted by cost center chosen, subject to approval process)
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac2500f8669101493e69e1392b970fd.html)



  

## Future Outlook

The items in this section are on our future roadmap - not necessarily in Q2 2020 or another specific quarter, but order of priority indicates what we'll tackle first.

  

#### Archictecture and Development Features

- Support for SAP Commerce Cloud Cart, Cloud Search, and other SAP Commerce Cloud Services
- Performance Improvements
- Schema.org support
- Single-sign on integration with SAP Customer Data Data from GIGYA
  [SAP Documentation](https://developers.gigya.com/display/GD/SAP+Commerce+Cloud)
- Dynamic Forms
- PWA features related to architecture as defined in Google's [PWA Checklist](https://developers.google.com/web/progressive-web-apps/checklist) 
- Angular 10 support (scheduled for Q4 2020)

  

#### Core/B2C Storefront Features

- Buy online pickup in store
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ae75e2086691014a64bf7cdd7ed5fd6.html)
- Captcha <sup>(1)</sup>
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac8663086691014ab34b77436f85412.html) 
- Potential Promotions <sup>(1)</sup>
- Assisted Service Module customer list
  [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b571515866910148fc18b9e59d3e084.html)
- Customer Coupons
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/7f8304a85bf24db0bfc5cf3b057ae322.html)
- Accessibility features
- Payments Request API ([W3 Documentation](https://www.w3.org/TR/payment-request/))
- Credentials API
- PWA Features as defined in Google's [PWA Checklist](https://developers.google.com/web/progressive-web-apps/checklist) such as 
mobile notifications
- Credit-card auto-detect
- Spartacus for China (similar to [Accelerator for China](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8b258c36866910148298d20518a62a16.html))
- Assisted Service Module customer 360° view <sup>(2)</sup>
  [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b571515866910148fc18b9e59d3e084.html) 
- Self-service customer support through the Customer Service Module <sup>(2)</sup>
  [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/aa039c46e5eb4c7da752afc0e05947e5.html)

  

#### B2B Storefront Features

- Multi-Dimensional Products support
- B2B Quick Order
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/caf95981aa174660b3faf839a9dddbef.html)
- B2B Scheduled replenishment<sup>(1)</sup>
  [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8c3aa31e86691014a3c085a0e9186e0c.html) 
- B2B Saved Carts
  [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/4d094e78a5494963b2d66148167f0553.html?q=saved%20carts)
- B2B Future Stock<sup>(1)</sup>
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac331e086691014bfdb96ba9faf7c86.html) 
- Inventory Display<sup>(1)</sup>
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac35e1d866910148876ef95adde0c60.html) 
- Bulk Price List
- Re-order <sup>(1)</sup>
- B2B Order Form Builder
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac1a3d586691014911dd58c04389cc3.html)
- B2B Product Import and Export Cart<sup>(1)</sup> (from/to files)
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/1a13b9c4f0fb4367a14006f77f479c86.html) 
- Variant Configuration and Pricing
  [SAP Commerce Documentation](https://help.sap.com/viewer/50c996852b32456c96d3161a95544cdb/1905/en-US/528b7395bc314999a01e3560f2bdc069.html)
- B2B Commerce Quotes<sup>(2)</sup>
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/a795b4722f6942c091ef716c66ddb37d.html) 
- Configurable bundles <sup>(2)</sup>
  [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b6eec0286691014a041e59dc69dc185.html)




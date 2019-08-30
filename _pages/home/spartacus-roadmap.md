---
title: Spartacus Roadmap
---

*Last updated August 29, 2019 by Bill Marcotte, Senior Product Manager, Spartacus*

This document describes what what is planned for Spartacus for end of 2019 and first half of 2020.

If you have any questions, use the 'help' channel of our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTRiNTFkMDJlZjRmYTBlY2QzZTM3YWNlYzJkYmEwZDY2MjM0MmIyYzdhYmQwZDMwZjg2YTAwOGFjNDBhZDYyNzE). Feedback welcome!




##### *Disclaimer - Forward-Looking Statements*

*This document contains forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality.  This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence.*

*The various documentation links provided point to SAP Commerce Cloud platform or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented.*

Features listed are either available in a release, in a release candidate, or in a NEXT release. In all cases, we've tested the features and believe that we're done.



# Roadmap Overview

We plan to release updates to the Spartacus libraries every 2 weeks.

Every release will contain bug fixes as well as improvements to user experience and performance. 

The order shown generally reflects the order of prioritization. For example, guest checkout is high on the list because we will work on that soon after 1.0 release.

Some of the links provided point to SAP Commerce Cloud Accelerator documentation, to give an idea of what the feature is about. These links are for context only. While we strive for feature parity, the Spartacus implementation of features may not work exactly as in Accelerator.

B2B features are based on B2B Accelerator [Powertools store](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/417df297eb39466288dd904e8acc426f.html). Most B2B support depends on new APIs that are scheduled for end of 2019.



# Roadmap for Rest of 2019 and into 2020



#### End of Q3 2019 (end of September 2019)

- [Guest checkout](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8adb50aa866910149533e8c748b730c9.html?q=guest%20checkout)
- [Storefinder](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/e3f3bd4c1f394147bcd2a773691dd6de.html)
- [Consignment tracking](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/ab305c4f84b64554932b8431020a39ad.html), aka click-to-see-delivery-status
- Infinite scroll for search and category listings
- Express checkout (go straight to review tab if shipping address and payment method exists)

#### End of Q3 / Early Q4 2019

(end of September into October 2019)

- [Assisted Service Module customer emulation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/8b571515866910148fc18b9e59d3e084.html) (known as ASM)
- [Anonymous consent](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/a9f387f70d484c19971aca001dc71bc5.html), to allow experience tracking
- Accessibility features related to keyboarding
- [Coupons](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/02a8521eb67b4866a632a1a5e79037e3.html?q=coupons)
- Base site configuration awareness (what languages are available, for example)

#### Rest of 2019 into 2020

(but no definitive date yet)


- [Variant](https://help.sap.com/viewer/d0224eca81e249cb821f2cdf45a82ace/1905/en-US/8c143a2d8669101485208999541c383b.html) support, as seen in Apparel store (not the same as B2B multi-dimensional support, as seen in Powertools store) 
- Experience tracking for [Context-Driven Services](https://help.sap.com/viewer/product/CONTEXT-DRIVEN_SERVICES/SHIP/en-US) (CDS) and the merchandisingaddon extension ([documentation](https://help.sap.com/viewer/50c996852b32456c96d3161a95544cdb/1905/en-US/0f6e285439bb4652ae4c6456285095a4.html))
- Product preview from search and category results
- Applied promotions
- [Customer coupons and management](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/7f8304a85bf24db0bfc5cf3b057ae322.html)
- [Selective Cart](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/58837af020d346df84773bd2ea75fd69.html) (save items in cart for later)
- [Self-service cancellations](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/22e69b8fc4884d5eb58c39b97b3322fb.html) and [returns](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/2b6fea0f5f61481f86af205c7c7e9b61.html)
- [Buy online pickup in store](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ae75e2086691014a64bf7cdd7ed5fd6.html)
- Other accessibility features to be defined
- Partial usage of Spartacus storefront libraries
- Performance improvements such as through more cache-first networking
- [B2B Commerce Org](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ac27d4d86691014a47588e9126fdf21.html?q=commerce%20org%20my%20company) (aka My Company management: units, users, budgets, cost centers, purchase threshholds, user groups, approvals, account summary) 
  - [With related checkout support](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ac2500f8669101493e69e1392b970fd.html) - check out by account, input purchase order, select cost center, shipping address restricted by cost center chosen, approval process

#### 2020 and Beyond

- Cloud cart
- Cloud search
- [Captcha](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ac8663086691014ab34b77436f85412.html)
- Single-sign on integration with [SAP Customer Data Data from GIGYA](https://developers.gigya.com/display/GD/SAP+Commerce+Cloud)

- Favorites wish list
- [Back-in-stock notifications](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/2ad0f5f1bbcc47dfbba4f5cd7c6394c1.html)
- Rest of [Assisted Service Module](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/8b571515866910148fc18b9e59d3e084.html) functionality (customer list and 360° view)
- [B2B Scheduled replenishment](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/8c3aa31e86691014a3c085a0e9186e0c.html)
- [B2B Future Stock](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ac331e086691014bfdb96ba9faf7c86.html), [inventory display](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ac35e1d866910148876ef95adde0c60.html), bulk price list
- [B2B Early Login](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ac304ca866910148e908988466c0bd7.html)  (aka Secure portal)
- [B2B Quick order](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/caf95981aa174660b3faf839a9dddbef.html)
- [B2B Order form builder](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8ac1a3d586691014911dd58c04389cc3.html)
- [B2B Saved Carts](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/4d094e78a5494963b2d66148167f0553.html)
- [B2B import products through CSV files](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/1a13b9c4f0fb4367a14006f77f479c86.html) for cart creation
- B2B multi-dimensional product support
- Payments Request API ([W3 Documentation](https://www.w3.org/TR/payment-request/))
- Improvements to inline form feedback
- More Accessibility features (to be defined)
- Phone number as ID
- Credentials API
- Mobile device notifications
- Offline awareness
- [Configurable products](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/478f616a46f84d668f8cd42c0259cdf0.html)

- [Configurable bundles](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/8b6eec0286691014a041e59dc69dc185.html)
- Self-service customer support ([Customer Service Module](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/aa039c46e5eb4c7da752afc0e05947e5.html))
- Completion of Accessibility features
- Credit-card auto-detect
- Other features related to PWA as definedin Google's [PWA Checklist](https://developers.google.com/web/progressive-web-apps/checklist)
- Spartacus for China (similar to [Accelerator for China](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8b258c36866910148298d20518a62a16.html)
- Country-specific address forms

- [B2B Commerce Quotes](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/a795b4722f6942c091ef716c66ddb37d.html) and integrations with other quotation management systems

  

# Tentative for Next Major Release

The release of a new major of Spartacus means that the code contains breaking changes. Some of the topics we have planned for our next major are:

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

---
title: Release Information for Versions 1.0 of Spartacus for TUA Libraries
---

Final 1.0 released in Q3, 2020.

*Last updated Q3, 2020 by Deborah Cholmeley-Jones, Solution Owner, TUA Spartacus*

This document describes the following contents included in version 1.0 of Spartacus for TUA libraries.

- [Introduction](#introduction)
- [Release 1.0](#release-1.0)
- [About Spartacus Releases](#about-spartacus-releases)
- [How Spartacus is Versioned](#how-spartacus-is-versioned)
- [Upgrading Spartacus Libraries to a New Minor Version](#upgrading-spartacus-libraries-to-a-new-minor-version)
- [Future Releases](#future-releases)
  
  
  
### Introduction

This is the first release of the Spartacus storefront for the Telco & Utilities Accelerator (TUA). This document describes the contents of the TUA libraries.

**Note:** Spartacus for TUA 1.0 requires release 2003 (latest patch), Angular 8, and Spartacus 1.4 libraries. For more information, see [Installing the SAP Commerce Telco & Utilities Accelerator](https://help.sap.com/viewer/dc28ead55a454bc480940f159c96d323/2007/en-US/dc3ba9cdc12246df9e384e768b5a4cc8.html).

- For information on specific code changes for a particular release, see the [Development Release Notes](https://help.sap.com/viewer/62583a7386514befa5d2821f6f9a40e5/2007/en-US).  
- For information about features published in pre-release libraries, see [Pre-Relese Information](#tua-pre-release-information).  
- For information about upgrading, see [Upgrading Spartacus Libraries to a New Minor Version](#upgrading-spartacus-libraries-to-a-new-minor-version).  

If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU). Feedback welcome!
  
**Disclaimer - Forward-Looking Statements**

*This document contains or may contain forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality.  This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence.*

*The various documentation links provided point to SAP Commerce Cloud platform or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented in Spartacus.*
  
### Release 1.0

This is the first release of the Spartacus storefront for the Telco & Utilities Accelerator (TUA).  The TUA Spartacus storefront requires Telco & Utilities, release 2003 (latest patch) with Spartacus 1.4 libraries.  

With this release, the following storefront features are included:

- Core commerce Spartacus components for the overall storefront:
  - Login/Customer Registration/Forgot Password
  - My Account standard commerce features
  - APIs supporting offer-to-fulfill, including TM Forum APIs and OCC rest APIs
- TUA-specific functionality including:
  - Product Offering Search (Free Text, Facets, and Menu)
  - Product Offering Prices: Support of One-Time Charges, Recurring Charges, and Usage Charges. For more information, see [Pricing](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/ad4430d10fc3477096752d83f935faf9.html).
  - Simple Product Offerings (SPOs). For more information, see [Product Offerings](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/315410098c024e50adf4c43373761936.html) in the TUA Help portal.
    - Product Offering Details page
    - Product Offering Listing page
  - Configurable Guided Selling. For more information, see For more information, see [Configurable Guided Selling](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/fa22e16db2524c0bb9b12c6102ba1b5d.html) in the TUA Help portal.
    - Bundled Product Offerings
    - Purchase Wizard
  - Cart: New cart display and structure for TUA as prices are displayed differently from the core commerce. For more information, see [Cart](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/525a0a7eafbb4d3ab988872a21e0e3b3.html) in the TUA Help portal.
  - Checkout: New checkout display and structure for TUA. For more information, see [Order](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/2365910e452d4850a6b7b5d2b8583db9.html) in the TUA Help portal.
  - Order: New order display and structure for TUA. For more information, see [Order](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/2007/en-US/91a9faae27bb4a7f8baa46a57078cd61.html) in the TUA Help portal.

   
### About Spartacus Releases

- Libraries that are "released" are new, official, and tested Spartacus libraries available to the public (hosted on npmjs.com)
- We usually release new libraries every 2 weeks 
- A change in minor means we added new features, but they are configured to be off by default, so as not to cause compatibility issues. A new minor also means inclusion of changes or bug fixes that may affect compatibility, but these are also controlled by feature flags. So all significant changes are “opt-in”. See feature flag documentation for more information.
- We will normally publish pre-release libraries labelled 'next' a few weeks before a new minor release. The goal is to provide early access to new features and get feedback from the community.
- If you choose not to use a new feature, you should have no problems upgrading to a new Major.# with features flag set to a previous Major.#. If you do see a problem, please report a bug and we will assess and fix it. We encourage you to upgrade to the latest libraries frequently during development in order to take advantage of bug fixes and new features.
- To be able to use all functionality in Spartacus for TUA 1.*, release 1905 of SAP Commerce Cloud and 2003 of Telco and Utilities accelerator is required. The latest patch release is required or at least strongly recommended, as it usually contains bug fixes that affect Spartacus.  Spartacus 1.* has been tested with EC release 1905.11 and TUA 2003.2;  Spartacus features that rely on new APIs introduced in 2007 are not available. 
  
  
  
### How Spartacus is Versioned

Spartacus for TUA follows the same semantic versioning (Major.Minor.Patch) as Spartacus. For more information, see [Release Information]({{ site.baseurl }}{% link _pages/home/release-information.md %}).
  
  
  
### Upgrading Spartacus Libraries to a New Minor Version 

You can upgrade your Spartacus libraries to a new minor version, as follows:

1. In `package.json` set your @spartacus libraries to `~2.#.0`, where `#` is replaced with the release version number you wish to upgrade to.

**Note:** If you are upgrading from 1.x to the latest 1.5 release then upgrade to 2.x. In the `package.json`, set your @spartacus libraries to `~1.5.5`.

2. Delete the `node_modules` folder.
3. Run `yarn install`.


### Future Releases

For more information, see the [separate roadmap document]({{ site.baseurl }}{% link _pages/telco/spartacus-roadmap-for-tua.md %}). 
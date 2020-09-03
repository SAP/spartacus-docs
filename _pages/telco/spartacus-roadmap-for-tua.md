---
title: Roadmap for TUA Spartacus
---

*Last updated July 24, 2020 by Deborah Cholmeley-Jones, Solution Owner, TUA Spartacus*

This document describes what is planned for TUA Spartacus for Q2 2020 and later.

- For an overview of what was included in a specific release, see [Release Information]({{ site.baseurl }}{% link _pages/telco/telco-release-information.md %}).
- For information about features published in pre-release libraries, see [Pre-release Information]({{ site.baseurl }}{% link _pages/telco/tua-pre-release-information.md %}).  

Contents: 
- [Disclaimer - Forward-Looking Statements](#disclaimer---forward-looking-statements)
- [General Release Information](#general-release-information)
- [Planned for Rest of Q3 2020](#planned-for-rest-of-q3-2020)
- [Features planned for the second half of 2020](#features-planned-for-the-second-half-of-2020)
- [Future Outlook](#future-outlook)


### Disclaimer - Forward-Looking Statements

*This document contains forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality.  This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence.*

*The various documentation links provided point to SAP Commerce Cloud platform or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented in Spartacus.*

### General Release Information

We plan to publish new Spartacus libraries every two weeks. Each release may contain bug fixes, improvements to user experience, and new features.

When new features are available for release, normally we will publish a pre-release “next” version of the libraries with the new features, in order to get feedback. When the final, new, minor version is ready, we usually publish a release candidate (RC), with the final new x.y.0 a few days or weeks later.

**Note:** Links provided in the following sections point to SAP Commerce Cloud Telco & Utilities Accelerator Help portal, to give an idea of what the feature is about. These links are for context-only.  While we strive for feature parity, the Spartacus implementation of features may not work exactly as in Accelerator.

#### Questions?

If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). 

For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU). 

Feedback is welcome! 

### Planned for Rest of Q3 2020

The first TUA Spartacus major release (1.0) is planned for early Q3 2020. This release of the TUA Spartacus storefront requires Telco & Utilities Accelerator, release 2003 (latest patch) supported by SAP Commerce Cloud 1905, with Angular 8 and Spartacus 1.4 libraries. At a high level, this release includes the overall storefront, the ability to support simple product offerings and bundled product offerings, pricing (one-time charges, recurring charges, and usage charges), and configurable guided selling.  

#### Core B2C TUA Storefront Features/MVP 

- Product Offering Search (Free Text, Facets, Menu). For more information, see [Pricing](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/ad4430d10fc3477096752d83f935faf9.html).
- Product Offering Prices (One-Time Charges, Recurring Charges and Usage Charges). For more information, see [Product Offerings](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/315410098c024e50adf4c43373761936.html).
- Simple Product Offerings (SPOs). For more information, see [Create Simple Product Offering or Bundled Product Offering Prices](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/48680f49f884453f8596488073046631.html).
- Bundled Product Offerings (BPOs). For more information, see [Product Offerings](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/315410098c024e50adf4c43373761936.html).
- Configurable Guided Selling. For more information, see [Configurable Guided Selling](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/fa22e16db2524c0bb9b12c6102ba1b5d.html).

For more information on how pricing works for One Time Charges, Recurring Charges, and Usage Charges, see [Create Simple Product Offering or Bundled Product Offering Prices](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/48680f49f884453f8596488073046631.html).

### Features planned for the second half of 2020

The items in this section are on our future roadmap - not necessarily for any specific quarter, but order of priority indicates what we’ll tackle first.

#### My Subscriptions

For more information on the following topics, click the links of the corresponding topics to view the [TUA Help portal](https://help.sap.com/viewer/product/TELCO_ACCELERATOR/2007/en-US).

- View list of My Subscriptions - subscribed offerings. For more information, see [View List of my Subscriptions](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/f488da777e9b49c3882eed1b95efd215.html).
- View Consumption Details. For more information, see [View Consumption Details](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/ba5f222fb5814829bd74eaf6e6505a9f.html).
- Manage Product based on role/authorization. For more information, see [Manage Product based on role/authorization](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/1ab69d2074ea4735a68b32b14652d2b9.html).
- Display Product based on role/authorization. For more information, see [Manage Product based on role/authorization](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/1ab69d2074ea4735a68b32b14652d2b9.html).

#### Retention Process Flows

- Renewal
- Tariff Change
- Upgrade
- Cross-selling (Add-Ons)

For more information, see [Eligibility Policies Evaluation](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/7a0412703ebd4cd3b5bd0d882c72c202.html) and [Eligibility Policy in Action](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/341e50fcd20149d68735656c5c1b1fff.html).

#### Journey Management

- Journey Coordinator. For more information, see [Journey Coordinator](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/39a59f20c92f4a0090c7ef2d007d623c.html).
- Checkist Actions. For more information, see [Checklist Actions](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/2007/en-US/9fead1b7969b425fa1c15fb985324b42.html).

A new major (2.0) is planned 2H-2020, primarily due to planned support for Angular 9 and the new Ivy rendering engine.  TUA support for 2007 (latest patch) with SAP Commerce 2005 will be supported with 2.0.  The release of a new major version of Spartacus means that the code contains breaking changes - to be determined.

#### Move to Angular 9/Ivy

- Move to Angular 9 
    - Schematics update for supporting migration
    - Third party dependencies updates
- Angular Ivy support (new compilation and rendering pipeline)
    - Smaller, simpler, and faster
    - Better performance on mobile devices
    - Less memory used
    - Tree shaking for smaller packages

#### MVP B2C Features

- Composite Pricing. For more information, see [Composite Pricing](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/2e0fa8602fff440ba756e1a0a8390ea3.html).
- Price Alterations (Discounts). For more information, see [Price Alterations (Discounts)](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/61b21155624e4a498632964bc566e1eb.html).
- Grid pricing on Cart, Checkout and Order. For more information, see [Grid pricing on Cart, Checkout and Order](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/2007/en-US/91a9faae27bb4a7f8baa46a57078cd61.html).

#### Stretch Features

Additional retention scenarios based on contract terms.

### Future Outlook

The following features are in roadmap, but currently not planned for a specific quarter.

B2C Self-Care and Assurance supporting:

- Sales related process flows
- Assets
- View Bills
- Family Plans - stretch goal

### B2C Functionality

The following features are in roadmap, but currently not planned for a specific quarter:

- Fixed Bundled Product Offerings
- Retention Process Flows
    - Cancellation
    - Pre-Paid to Post-Paid / Post-Paid to Pre-Paid
    - Downgrade
    - Merge Accounts
    - Split Accounts
    - Suspend Subscription
    - Activate Service
    - Deactivate Service
    - Top-up Account
Automatic Cart Assignments 
Price Alterations - support for allowances and taxes
Policy based Pricing - stretch goal

#### B2B Storefront Features in the context of TUA 

- B2B Commerce Org: Also known as My Company management of units, users, budgets, cost centers, purchase threshholds, user groups, approvals. It requires SAP Commerce Cloud 2005. For more information, see [B2B Checkout and Order Process](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac2500f8669101493e69e1392b970fd.html) in the SAP Commerce Cloud documentation.
- B2B Checkout: Includes check out by account, enter purchase order, select cost center, shipping address restricted by cost center chosen, subject to approval process. For more information, see [B2B Checkout and Order Process](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/2005/en-US/8ac2500f8669101493e69e1392b970fd.html) in the SAP Commerce documentation.
- Product Configuration: For more information, see [Configurable Products](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/2005/en-US/478f616a46f84d668f8cd42c0259cdf0.html) in the SAP Commerce documentation.
- B2B Quick Order. For more information, see [B2B Quick Orders](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/2005/en-US/caf95981aa174660b3faf839a9dddbef.html) in the SAP Commerce documentation.
- B2B Saved Carts. For more information, see [Multiple Saved Carts](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/2005/en-US/caf95981aa174660b3faf839a9dddbef.html) in the SAP Commerce documentation.
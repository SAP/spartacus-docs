---
title: Roadmap for TUA Spartacus
---

*Last updated February 17, 2021 by Deborah Cholmeley-Jones, Solution Owner, TUA Spartacus*

This document describes what is planned for TUA Spartacus for Q1 2021 and later.

Contents:

- [Disclaimer - Forward-Looking Statements](#disclaimer---forward-looking-statements)
- [Overview](#overview)
- [Features Planned for Q1 2021](#features-planned-for-q1-2021)
- [Future Outlook / Features Planned for Q2 2021 and Later](#future-outlook--features-planned-for-q2-2021-and-later)

### Disclaimer - Forward-Looking Statements

*This document contains forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality.  This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence.*

*The various documentation links provided point to SAP BTP or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented in Spartacus.*

## Overview

### General Release Information

We typically try to publish new Spartacus libraries every two weeks.  Each release may contain bug fixes, improvements, and/or new features.

When new features are available for release, normally we will publish a pre-release “next” version of the libraries with the new features, in order to get feedback. When the final, new, minor version is ready, we usually publish a release candidate (RC), with the final new x.y.0 a few days or weeks later.

Some of the links provided in the following lists point to SAP Commerce Telco and Utilities Accelerator documentation, to give an idea of what the feature is about. These links are for context only. While we strive for feature parity, the Spartacus implementation of features may not work exactly as in Accelerator.

### Other Release Documentation

- For an overview of what was included in a specific release, see [TUA Release Information]({{ site.baseurl }}{% link _pages/telco/telco-release-information.md %}).
- For information about features published in pre-release libraries, see [TUA Pre-Release Information]({{ site.baseurl }}{% link _pages/telco/tua-pre-release-information.md %}).

### Questions?

If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront).

For non-technical questions and roadmap feedback, you can reach us on our dedicated #help-tua [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ).

## Features Planned for Q1 2021

### B2C Storefront Features Planned

- Support of the hierarchical cart in spartacus (pre-requisite for fixed bundled product offerings)
- Provide the ability for a customer to purchase a fixed Bundled Product Offerings
- One-Click Order Placement for activation/deactivation of services
- One-Click Top-Up Account
- One-Click Suspend service

### Journey Management

- Provide the ability for a customer to conduct a serviceability check for a product offering of interest. For more information, see [Serviceability](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2102/en-US/f17d331d62164ae686f2d4fdb437e9c4.html) in the TUA Help portal.
- Provide the ability for a customer to conduct a serviceability check for all product offerings that are available based on a premise address. For more information, see [Serviceability](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2102/en-US/f17d331d62164ae686f2d4fdb437e9c4.html) in the TUA Help portal.
- Provide the ability for a customer to conduct a contract termination (without assurance).

### Retention Process Flows

- **Contract Renewal:** For more information, see [Eligibility Policy in Action](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/341e50fcd20149d68735656c5c1b1fff.html).
- **Tariff Change - Upgrade:** For more information, see [Assignments to Existing Subscribed Products](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/2007/en-US/b0c9085e723a4f289df9d83d7b2a52ba.html).
- **Tariff Change - Upsell:** For more information, see [Assignments to Existing Subscribed Products](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/db4426fef46d4db5996f8ed8501052a4.html).
- **Cross-selling (Add-Ons)**

## Future Outlook / Features Planned for Q2 2021 and Later

The items in this section are on our future roadmap, not necessarily yet planned for a specific quarter.

Some features require new OCC REST APIs, not yet planned and still considered to be done.

### B2C Features

- **Price Alteration Credits:** For more information, see [Create Product Offerings from Product Specifications View](https://help.sap.com/viewer/62583a7386514befa5d2821f6f9a40e5/2011/en-US/1deb71eb8ac54f469ef558ac67dbf3e8.html)
- **PSCV pricing:** For more information, see [Create Product Offerings from Product Specifications View](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/9835174fd3b94550b41f0b72b5269231.html)
- **Grid pricing on Cart, Checkout, and Order:** For more information, see [Pricing at Cart and Order Level](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/2007/en-US/91a9faae27bb4a7f8baa46a57078cd61.html)

### B2C Asset and Subscription Services Management (customer product inventory) with Assurance (contractual terms to drive retention process flows)

- Roles and Permissions for managing assets and services
- B2B Asset and Subscription Services Management (CPI) with Assurance (contractual terms)
    - Activate Service
    - Deactivate Service
    - Top-Up Account
    - Pre-Paid to Post-Paid
    - Post-Paid to Pre-Paid
    - Tariff Change - Upgrade
    - Tariff Change - Cross-sell
    - Tariff Change - Downgrade
    - Merge Accounts
    - Split Accounts
    - Suspend Subscription
    - Cancel Subscription
    - Contract Termination
- Billing (View Bill, View Bill History)
- Pay Bill
- View consumption details

### Business to Business Storefront Supporting SMB Customers

- Roles and Permissions for managing assets and services (Service Provider, B2B Customer Admin, B2B Customer Employee, etc)
- Permissions Management 
- B2B Asset and Subscription Services Management (CPI) with Assurance (contractual terms)
- CPQ for Product Offering Configuration (SPO, BPO)
- Support of Frame Agreements and Call-Offs
- Automatic product offering creation based on Frame Agreement
- Ehanced rules engine or compatibility, eligibility and servicability
- Dashboard for managing assets and services (various views)
- Reporting capabiliites

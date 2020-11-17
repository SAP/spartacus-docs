---
title: Roadmap for TUA Spartacus
---

*Last updated October 28, 2020 by Deborah Cholmeley-Jones, Solution Owner, TUA Spartacus*

This document describes what is planned for TUA Spartacus for Q4 2020 and later.

Contents:

- [Disclaimer - Forward-Looking Statements](#disclaimer---forward-looking-statements)
- [Overview](#overview)
- [Features Planned for Version 2.0 / Q4 2020 and into Q1 2021](#features-planned-for-version-20--q4-2020-and-into-q1-2021)
- [Future Outlook / Features Planned for 2021 and Later](#future-outlook--features-planned-for-2021-and-later)

### Disclaimer - Forward-Looking Statements

*This document contains forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality.  This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence.*

*The various documentation links provided point to SAP Commerce Cloud platform or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented in Spartacus.*

## Overview

### General Release Information

We typically try to publish new Spartacus libraries every two weeks.  Each release may contain bug fixes, improvements, and/or new features.

When new features are available for release, normally we will publish a pre-release “next” version of the libraries with the new features, in order to get feedback. When the final, new, minor version is ready, we usually publish a release candidate (RC), with the final new x.y.0 a few days or weeks later.

### Other Release Documentation

- For an overview of what was included in a specific release, see [TUA Release Information]({{ site.baseurl }}{% link _pages/telco/telco-release-information.md %}).
- For information about features published in pre-release libraries, see [TUA Pre-Release Information]({{ site.baseurl }}{% link _pages/telco/tua-pre-release-information.md %}).

### Questions?

If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). 

For non-technical questions and roadmap feedback, you can reach us on our dedicated #help-tua [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ).

## Features Planned for Version 2.0 / Q4 2020 and into Q1 2021

Release 2.0 will be the first release supporting SAP Commerce Cloud 2005 and TUA 2007.

### B2C Storefront Features Planned for 1.x

- **Premise validation and meter id supporting switch provider or new customer** 
- **Cost Estimation**
- **Appointment scheduling for a bundled product offering** 

### B2C Storefront Features Planned for 2.0

- **Composite Pricing** - for more information, see [Composite Pricing](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/2e0fa8602fff440ba756e1a0a8390ea3.html)
- **Price Alteration Discounts** - for more information, see [Price Alterations (Discounts)](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/61b21155624e4a498632964bc566e1eb.html)
- **Fixed Bundled Product Offerings**
- **Hierarchal Cart**
- **One-Click Order** 

### Journey Management

- **SPO Serviceability** - for more information, see [Journey Checklist](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/39a59f20c92f4a0090c7ef2d007d623c.html)
- **Category Level Serviceability** 

### Retention Process Flows

- **Contract Renewal** - for more information, see [Eligibility Policy in Action](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/341e50fcd20149d68735656c5c1b1fff.html)
- **Tariff Change - Upgrade** - for more information, see [Assignments to Existing Subscribed Products](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/2007/en-US/b0c9085e723a4f289df9d83d7b2a52ba.html)
- **Tariff Change - Upsell** - for more information, see [Assignments to Existing Subscribed Products](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/db4426fef46d4db5996f8ed8501052a4.html)
- **Cross-selling (Add-Ons)**

### Architecture Features

- Angular 9 upgrade / Spartacus 2.0 
    
## Future Outlook / Features Planned for 2021 and Later

The items in this section are on our future roadmap - not necessarily yet planned for a specific quarter.

Some features require new OCC REST APIs, not yet planned and still considered TBD.

### B2C storefront features planned for 2.0

- **Price Alteration Credits** 
- **PSCV pricing** for more information, see [Create Product Offerings from Product Specifications View](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/a37d0f967d2c49d38314b328753c143e.html)
- **Grid pricing on Cart, Checkout and Order** for more information, see [Pricing at Cart and Order Level](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/2007/en-US/91a9faae27bb4a7f8baa46a57078cd61.html)
- **Automatic Cart Assignments**
- **Policy Based Pricing**

### B2C Self-Care Asset Management and Assurance

- Self-Care Process Flows
    - Activate Service
    - Deactivate Service
    - Top-Up Account
    - Pre-Paid to Post-Paid
    - Post-Paid to Pre-Paid
    - Tariff Change - Downgrade
    - Merge Accounts
    - Split Accounts
    - Suspend Subscription
    - Cancel Subscription
    - Contract Termination

### B2B Self-Care Asset Management and Assurance 

### Architecture Features

- Angular 10 upgrade / Spartacus 3.0
- Event driven processes

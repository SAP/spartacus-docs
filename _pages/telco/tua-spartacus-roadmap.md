---
title: Roadmap 2022 for TUA Spartacus
---

*Last updated January 9, 2022 by Deborah Cholmeley-Jones, Solution Owner, TUA Spartacus*

This document describes what what is planned for Spartacus for Q1 2022 and later.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

### Disclaimer - Forward-Looking Statements

*This document contains forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality.  This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence.*

*The various documentation links provided point to SAP BTP or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented in Spartacus.*

## Overview

### General Release Information

We usually publish new Spartacus libraries every week. Each release may contain bug fixes, improvements, and new features.

When new features are available for release, normally we will publish a pre-release “next” version of the libraries with the new features, in order to get feedback. When the final, new, minor version is ready, we usually publish a release candidate (RC), with the final new x.y.0 a few days or weeks later.

Some of the links provided in the following lists point to SAP Commerce Telco and Utilities Accelerator documentation, to give an idea of what the feature is about. These links are for context only. While we strive for feature parity, the Spartacus implementation of features may not work exactly as in Accelerator.

### Other Release Documentation

- For an overview of what was included in a specific release, see [TUA Release Information]({{ site.baseurl }}{% link _pages/telco/telco-release-information.md %}).
- For information about features published in pre-release libraries, see [TUA Pre-Release Information]({{ site.baseurl }}{% link _pages/telco/tua-pre-release-information.md %}).

### Questions?

If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront).

For non-technical questions and roadmap feedback, you can reach us on our dedicated #help-tua [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ).

## Future Outlook / Features Planned for Q1 2022 and Later

The items in this section are on our future roadmap, not necessarily yet planned for a specific quarter. Some features require new OCC REST APIs, not yet planned and still considered to be done.

### Technical Upgrade to Spartacus 4.0 Libraries / Angular 12
### B2C Storefront Features Planned

- Provide the ability for a customer to purchase a fixed Bundled Product Offering
- One-click Order Placement for services
- One-click activation/deactivation of services

### Retention Process Flows Without Assurance

- **Tariff Change - Upgrade:** For more information, see [Assignments to Existing Subscribed Products](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/latest/en-US/b0c9085e723a4f289df9d83d7b2a52ba.html).
- **Tariff Change - Upsell:** For more information, see [Assignments to Existing Subscribed Products](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/latest/en-US/b0c9085e723a4f289df9d83d7b2a52ba.html).
- **Tariff Change - Cross-Sell:** For more information, see [Assignments to Existing Subscribed Products](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/latest/en-US/b0c9085e723a4f289df9d83d7b2a52ba.html).

### Pricing Features

- **Price Alteration Credits:** For more information, see [Create Product Offerings from Product Specifications View](https://help.sap.com/viewer/62583a7386514befa5d2821f6f9a40e5/latest/en-US/1deb71eb8ac54f469ef558ac67dbf3e8.html).
- **Grid pricing on Cart, Checkout, and Order:** For more information, see [Pricing at Cart and Order Level](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/2007/en-US/91a9faae27bb4a7f8baa46a57078cd61.html).

### B2C Self-Care Asset Management and Assurance (next generation customer product inventory for customer self-management of assets (that is, subscriptions) with taking contractual terms into consideration)

TM Forum-compliant Customer Product Inventory to support retention-based purchase flows as well as services management:

- Renew contract (subscription)
- Tariff Change - upgrade
- Tariff Change - upsell
- Tariff Change - cross-sell
- Tariff Change - downgrade
- Tariff Change - regrade/move home
- Prepaid to Postpaid
- Postpaid to Prepaid
- Merge Accounts
- Split Accounts
- Cancel contract
- Terminate contract (move out)
- Place subscription "on hold"
- Suspend Subscription (via provider)
- Activate Service
- Deactivate Service
- Top-up Account

### TUA Business-to-Business Storefront 

- Enhanced Roles and Permissions Management
- B2B Self-Care Asset Management and Assurance

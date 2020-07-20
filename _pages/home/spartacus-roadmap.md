---
title: Spartacus Roadmap
---

*Last updated July 20, 2020 by Bill Marcotte, Senior Product Manager, Spartacus*

This document describes what what is planned for Spartacus for Q3 2020 and later.

- For an overview of what was included in a specific release, see [Release Information]({{ site.baseurl }}{% link _pages/home/release-information.md %}).
- For information about features published in pre-release libraries, see [Pre-Release Information]({{ site.baseurl }}{% link _pages/home/pre-release-information.md %}).
- For information on the future of SAP Commerce Cloud, see the [Roadmap](https://cxwiki.sap.com/pages/viewpage.action?spaceKey=general&title=Roadmap).

Contents:

- [Disclaimer - Forward-Looking Statements](#disclaimer---forward-looking-statements)
- [General Release Information](#general-release-information)
- [Planned for Q2 2020](#planned-for-q2-2020)
- [Planned for Q3 2020](#planned-for-q3-2020)
- [Features Planned for Q4 2020 and Later](#features-planned-for-q4-2020-and-later)
- [Future Outlook](#future-outlook)

### Disclaimer - Forward-Looking Statements

*This document contains forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality.  This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence.*

*The various documentation links provided point to SAP Commerce Cloud platform or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented in Spartacus.*
  
### General Release Information

We usually publish new Spartacus libraries every week. Each release may contain bug fixes, improvements, and new features.

When new features are available for release, normally we will publish a pre-release "next" version of the libraries with the new features, in order to get feedback. When the final, new, minor version is ready, we usually publish a release candidate (RC), with the final new x.y.0 a few days or weeks later.

Some of the links provided in the following lists point to SAP Commerce Cloud Accelerator documentation, to give an idea of what the feature is about. These links are for context only. While we strive for feature parity, the Spartacus implementation of features may not work exactly as in Accelerator.
  
#### Questions?

If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront).
  
For non-technical questions and roadmap feedback, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU).
  
### Planned for Q3 2020

#### Version 2.1: B2B My Company

Pre-release scheduled for end of July, release scheduled for mid-August

Release 2.1 will be the first release supporting B2B features.

- **B2B Commerce Org**  
  (also known as My Company management of units, users, budgets, cost centers, purchase thresholds, user groups, approvals) 
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac27d4d86691014a47588e9126fdf21.html?q=commerce%20org%20my%20company)
- **Updates to Order Details** to include B2B-specific information, such as approval table and cost center
- Lazy loading for modules, starting with B2B My Company
- **Image Zoom** on Product Details page (will be released in an incubator library)

Spartacus B2B features will require SAP Commerce Cloud 2005 - the Spartacus functionality will be implemented based on the non-conflicting B2B endpoints introduced in 2005.

#### 3.0

Pre-release scheduled for end of August, release scheduled for mid-September

- **Angular 10**
- **Session Management**
- **B2B Checkout** (check out by account, enter purchase order, select cost center, shipping address restricted by cost center chosen, subject to approval process)  
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac2500f8669101493e69e1392b970fd.html)
- **B2B Scheduled Replenishment** (SAP Commerce Cloud 2005 required)  
  [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8c3aa31e86691014a3c085a0e9186e0c.html) 
- **B2B Re-order**

Features to be included in a 3.x minor release, after 3.0 is released:

- **B2B Quick Order**  
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/caf95981aa174660b3faf839a9dddbef.html)
- **B2B Saved Carts**  
  [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/4d094e78a5494963b2d66148167f0553.html?q=saved%20carts)
- **B2B Inventory Display** (SAP Commerce Cloud 2005 required)  
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac35e1d866910148876ef95adde0c60.html) 
- **B2B Multi-dimensional product support** and **Order Grid**
- **B2B Bulk Price List**
- **Accessibility Screen Reader support**
- **New events** for Event Service
- **Buy online pickup in store**  
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ae75e2086691014a64bf7cdd7ed5fd6.html)


#### Other Features and Integrations planned for Q3 2020

- **Customer Data Cloud (Gigya) Login and Registration Support**
  For reference: [SAP Customer Data Cloud Integration Module Documentation](https://help.sap.com/viewer/50c996852b32456c96d3161a95544cdb/1905/en-US/4fc06a3539a940e6b707c0c543d44053.html)
- **SAP Variant Configuration and Pricing** (formerly known as CPQ)
  Initial version to include:
  - Single- or multilevel configurable products in your Commerce Spartacus storefront
  - Configuration page with the most commonly used characteristic types such as radio buttons, checkboxes, and images for characteristic values
  - Price summary at the bottom of the configuration page with the base price, the price of the selected options, and the overall total price of the configured product
  - Overview page with all user selections accessible at any time during configuration
  - Conflict handling
  For reference, see [Product Configuration with SAP Variant Configuration and Pricing](https://help.sap.com/viewer/80c3212d1d4646c5b91db43b84e9db47/2005/en-US).


### Future Outlook / Features Planned for 2021 and Later

The items in this section are on our future roadmap - not necessarily yet planned for a specific quarter.
  

#### Archictecture and Development Features

- Performance improvements through further implementation of lazy loading and with CMS
- Completion of Events framework and the implementation of additional events
- Extensibility improvements
  
#### Core/B2C Storefront Features

- Assisted Service Module customer list and other ASM improvements
  [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b571515866910148fc18b9e59d3e084.html)
- Captcha (\*)
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac8663086691014ab34b77436f85412.html) 
- Potential Promotions (\*)
- New Accessibility features
- Buy it again (add to cart from existing order)
- Social sharing of product information
- Spartacus for China (similar to [Accelerator for China](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8b258c36866910148298d20518a62a16.html))
- Self-service customer support through the Customer Service Module (\*)
  [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/aa039c46e5eb4c7da752afc0e05947e5.html)
- Configurable bundles (\*)  
  [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b6eec0286691014a041e59dc69dc185.html)
- Payments Request API ([W3 Documentation](https://www.w3.org/TR/payment-request/))
- Credentials API
- Other PWA Features as defined in Google's [PWA Checklist](https://developers.google.com/web/progressive-web-apps/checklist) such as mobile notifications
- Angular I18N support
- Directionality (for right-to-left display support)
  
#### B2B Storefront Features

- **B2B Product Import and Export Cart** (\*) (from/to files)  
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/1a13b9c4f0fb4367a14006f77f479c86.html) 
- **B2B Order Form Builder**
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac1a3d586691014911dd58c04389cc3.html)
- **B2B Commerce Quotes** (\*)
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/a795b4722f6942c091ef716c66ddb37d.html)
- **B2B Future Stock** (SAP Commerce Cloud 2005 required)  
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac331e086691014bfdb96ba9faf7c86.html) 

Some items listed above have **(\*)** because the feature requires new OCC REST APIs, no date set yet.

---
title: Spartacus Roadmap
---

This document describes what what is planned for Spartacus for Q1 2020 and later.

*Last updated February 27, 2020 by Bill Marcotte, Senior Product Manager, Spartacus*

- For an overview of what was included in a specific release, see [Release Information]({{ site.baseurl }}{% link _pages/home/release-information.md %}).
- For information about features published in pre-release libraries, see [Pre-Release Information]({{ site.baseurl }}{% link _pages/home/pre-release-information.md %}).

Contents:
- [Disclaimer - Forward-Looking Statements](#disclaimer---forward-looking-statements)
- [General Release Information](#general-release-information)
- [Planned for Rest of Q1 2020](#planned-for-rest-of-q1-2020)
- [Planned for Q2 2020](#planned-for-q2-2020)
- [Future Outlook](#future-outlook)



### Disclaimer - Forward-Looking Statements

*This document contains forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality.  This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence.*

*The various documentation links provided point to SAP Commerce Cloud platform or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented in Spartacus.*
  
  
  
### General Release Information

We plan to publish new Spartacus libraries every two weeks. Each release may contain bug fixes, improvements to user experience, and new features.

When new features are available for release, normally we will publish a pre-release "next" version of the libraries with the new features, in order to get feedback. When the final, new, minor version is ready, we usually publish a release candidate (RC), with the final new x.y.0 a  weeks later. For example, we will publish a few pre-release 1.5 "next" libraries in January 2020, and then 1.5.0 will be released in February.

Some of the links provided in the following lists point to SAP Commerce Cloud Accelerator documentation, to give an idea of what the feature is about. These links are for context only. While we strive for feature parity, the Spartacus implementation of features may not work exactly as in Accelerator.

B2B features are based on the B2B Accelerator [Powertools store](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/417df297eb39466288dd904e8acc426f.html). Many B2B features depend on new APIs that are scheduled for release in SAP Commerce during Q2 2020 or later.
  
  
  
#### Questions?

For non-technical questions and roadmap feedback, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU).

If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). 
  
  
  
### Planned for Rest of Q1 2020

*Exact dates to be determined*

A new major (2.0) is planned for end of Q1 2020 or early Q2, primarily due to planned support for Angular 9 and the new Ivy rendering engine. New Accessibility keyboarding features will also be part of the 2.0 release. The release of a new major version of Spartacus means that the code contains breaking changes.

#### Keyboarding-Related Accessibility Features

- Full Keyboard Support (WCAG 2.0, 2.1.1, Level A, Keyboard; WCAG 2.0, 2.1.2, Level A, No Keyboard Trap)
- Consistent Navigation (WCAG 2.0, 3.2.3, Level AA, Consistent Navigation)
- Tabbing/Reading Order (WCAG 2.0, 2.4.3, Level A, Focus Order)
- Focus Visible (WCAG 2.0, 2.4.7, Level AA, Focus Visible)

#### Move to Angular 9 / Ivy

- Move to Angular 9 (aiming for February 2020)
  - Schematics update for supporting migration
  - 3rd party dependencies updates
- Angular Ivy support (new compilation and rendering pipeline)
  - Smaller, simpler and faster
  - Better performance on mobile devices
  - Less memory used
  - Tree shaking for smaller packages

Other architecture changes that are stretch for 2.0 release (could be added to 2.x release):
- Session Management (for better handling of authentication)
- Persistent services
- Events
- Library structure for lazy loading
- Removal of ng Bootstrap
- Routing improvements
- Performance improvements

#### Notes for Upgrading to 2.0 ####

For upgrading to Spartacus 2.0, we’re working on a transition that will easy as possible, using Angular Schematics. Typically we hope the update process will take about a day, if being done by an experienced Angular developer. However, the exception might be if code has been extended or replaced by customers. Not all updates will be taken care of automatically, so we will be looking for feedback as release candidates are published.

Note: One low-level area to avoid at the moment is the Cart, as it is going through a refactor for 2.0 release.
  
 
  
### Planned for Q2 2020

#### B2B Storefront MVP

- **B2B Commerce Org** (SAP Commerce Cloud 2005 required)   
  (also known as My Company management of units, users, budgets, cost centers, purchase threshholds, user groups, approvals) 
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac27d4d86691014a47588e9126fdf21.html?q=commerce%20org%20my%20company)
- **B2B Checkout** (check out by account, enter purchase order, select cost center, shipping address restricted by cost center chosen, subject to approval process)  
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac2500f8669101493e69e1392b970fd.html)
  

B2B Stretch for Q2 2020 and into Q3:

- **B2B Quick Order**  
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/caf95981aa174660b3faf839a9dddbef.html)
- **B2B Scheduled Replenishment** (SAP Commerce Cloud 2005 required)  
  [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8c3aa31e86691014a3c085a0e9186e0c.html) 
- **B2B Saved Carts**  
  [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/4d094e78a5494963b2d66148167f0553.html?q=saved%20carts)
- **B2B Future Stock** (SAP Commerce Cloud 2005 required)  
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac331e086691014bfdb96ba9faf7c86.html) 
- **Inventory Display** (SAP Commerce Cloud 2005 required)  
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac35e1d866910148876ef95adde0c60.html) 
- **Bulk Price List**
- **Re-order** (SAP Commerce Cloud 2005 required)
- **Multi-Dimensional Products** 


#### Core/B2C Storefront Features

- **Buy online pickup in store**  
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ae75e2086691014a64bf7cdd7ed5fd6.html)
  

## Features planned for the second half of 2020

The items in this section are on our future roadmap - not necessarily for any specific quarter, but order of priority indicates what we'll tackle first.
  

#### Archictecture and Development Features

- Angular 10 support (Angular release currently scheduled for Q4 2020)
- Extensibility Improvements ("Sproutlets" - Outlets NG)
- Performance improvements with CMS
- Support for SAP Commerce Cloud Cart and Checkout
- Single-sign on integration with SAP Customer Data Data from GIGYA
  [SAP Documentation](https://developers.gigya.com/display/GD/SAP+Commerce+Cloud)
  
#### Core/B2C Storefront Features
- Assisted Service Module customer list  
  [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b571515866910148fc18b9e59d3e084.html)
- New Accessibility features
- Buy it again (add to cart from existing order)
- Social sharing of product information
- Spartacus for China (similar to [Accelerator for China](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8b258c36866910148298d20518a62a16.html))
  
#### B2B Storefront Features

- B2B features not yet implemented, such as B2B Order Form Builder  
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac1a3d586691014911dd58c04389cc3.html)
- Variant Configuration and Pricing
  [SAP Commerce Documentation](https://help.sap.com/viewer/50c996852b32456c96d3161a95544cdb/latest/en-US/528b7395bc314999a01e3560f2bdc069.html)
  
  
  
### Future Outlook

The following features are in our roadmap but currently not planned for a specific quarter.
- Support for other SAP Commerce Cloud Services
- Captcha <sup>(1)</sup>  
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac8663086691014ab34b77436f85412.html) 
- Potential Promotions <sup>(1)</sup>
- Assisted Service Module customer 360° view <sup>(2)</sup>  
  [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b571515866910148fc18b9e59d3e084.html) 
- Self-service customer support through the Customer Service Module <sup>(2)</sup>  
  [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/aa039c46e5eb4c7da752afc0e05947e5.html)
- Configurable bundles <sup>(2)</sup>  
  [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b6eec0286691014a041e59dc69dc185.html)
- Payments Request API ([W3 Documentation](https://www.w3.org/TR/payment-request/))
- Credentials API
- Other PWA Features as defined in Google's [PWA Checklist](https://developers.google.com/web/progressive-web-apps/checklist) such as mobile notifications
- Dynamic Forms
- B2B Product Import and Export Cart<sup>(1)</sup> (from/to files)  
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/1a13b9c4f0fb4367a14006f77f479c86.html) 
- B2B Commerce Quotes<sup>(2)</sup>  
  [SAP Commerce Documentation](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/a795b4722f6942c091ef716c66ddb37d.html)
- Angular I18N support
- Directionality (for right-to-left display support)

Some items have notes, for example **(1)** or **(2)**
- **(1)**: The feature requires new OCC REST APIs that are planned for the next SAP Commerce release, scheduled for May 2020. These features may be available sooner to customers using SAP Commerce Cloud hosting services.
- **(2)**: The feature requires new OCC REST APIs, not yet planned.

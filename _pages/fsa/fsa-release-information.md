---
title: Release Information for All Versions of FSA Spartacus Libraries
---

Contents:

- [Introduction](#introduction)
- [Release 1.0](#release-10)
- [About FSA Spartacus Releases](#about-fsa-spartacus-releases)
- [Future Releases](#future-releases)

## Introduction

This document describes what is included in all FSA for Spartacus 1.x libraries since 1.0. 

**Note: FSA Spartacus 1.x requires Spartacus 2.1 and Angular 9. For more information, see [Building FSA Spartacus storefront from libraries]({{ site.baseurl }}{% link _pages/fsa/install/building-the-fsa-storefront-from-libraries.md %}).**

- For information on specific code changes for a particular release, see the [Development Release Notes](https://github.com/SAP/spartacus-financial-services-accelerator/releases).
- If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ) over channel: *#help-fsa* . Feedback welcome!

**Disclaimer - Forward-Looking Statements**

*This document contains or may contain forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality. This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence.*

*The various documentation links provided point to SAP Commerce Cloud platform or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented in Spartacus.*

## Release 1.0

List of features delivered with 1.0:
- **Quotation and Application Process**
  : The Financial Services Accelerator guides customers through each step of the quotation / application process. At every step, customers are also provided with a summary of their choices. In this guided-selling processes, customers have general options: request a quote/application, save it for later review or issue the policy / contract right away. The Process itself is configurable and steps can be adjusted in different way for each product category.  
- **Dynamic Forms**
  : Highly flexible and secure web forms solution that enable customer to collect, store and transfer data provided by a customer during his engagement. 
- **Insurance & Banking My Account**
  : In the My Account area, Financial Services Accelerator allows customers to manage their personal data and payment details, as well as view information about quotes, applications, policies, documents associated to an insurance policy, a banking application or access their inbox messages. Customers can give or also revoke their consent to marketing activities as well as close their account.
- **Claims** - First Notice of Loss 
  : Customers can report claims online through a guided step-by-step process. The process relies on Dynamic Forms and is hence highly configurable.
- **Inbox**
  : All messages and documents provided by a financial service institution are made available to the customer via the Inbox in My Account. All messages can be grouped according to their content, sorted, and then displayed in different tabs.
- **Policy Change Process**
  : Insurance carriers can provide their customers with the possibility to adjust their policy online. Several sample processes for changing mileage, for adding or removing a coverage and adding additional driver are provided based on the sample Auto Insurance product.
- **Insurance Agent Capabilities**
  : Customers can search for agents either on map (integration to maps providers possible) or by any sorting category (Insurance type, Banking LoB, etc.). They can also reach out their agent of choice which results in a customer support ticket, for example, then can be pushed to the agent workplace.
- **Insurance and Banking**
  : Combination of both industries in one storefront offers companies the opportunity to offer both products at the same time, but still using different quotation and application processes.

## About FSA Spartacus Releases

- Libraries that are "released" are new, official, tested Spartacus libraries available to the public (hosted on npmjs.com)
- A change in minor means we added new features, but they are configured to be off by default, so as not to cause compatibility issues. A new minor also means inclusion of changes or bug fixes that may affect compatibility, but these are also controlled by feature flags. So all significant changes are “opt-in”. See feature flag documentation for more information.
- We will normally publish pre-release libraries labelled ‘next’ a few weeks before a new minor release. The goal is to provide early access to new features and get feedback from the community.
- If you choose not to use a new feature, you should have no problems upgrading to a new Major.# with features flag set to a previous Major.#. If you do see a problem, please report a bug and we’ll assess and fix it. We encourage you to upgrade to latest libraries frequently during development in order to take advantage of bug fixes and new features.
- To use all functionality in Spartacus 2.*, release 2005 of SAP Commerce Cloud and 2008 of Financial Services Accelerator is required.
- The latest patch release is required or at least strongly recommended, as it usually contains bug fixes that affect Spartacus

## Future Releases

See the [separate roadmap document]({{ site.baseurl }}{% link _pages/fsa/fsa-spartacus-roadmap.md %}).

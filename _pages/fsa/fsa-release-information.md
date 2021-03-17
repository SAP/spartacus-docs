---
title: Release Information for All Versions of FSA Spartacus Libraries
---

Contents:

- [Introduction](#introduction)
- [Release 2.0](#release-20)
- [Release 1.0](#release-10)
- [About FSA Spartacus Releases](#about-fsa-spartacus-releases)
- [Future Releases](#future-releases)

## Introduction

This document describes what is included in all FSA Spartacus since the initial 1.0 release. 

**Note: FSA Spartacus 2.x requires Spartacus 3.0 and Angular 9. For more information, see [Building FSA Spartacus storefront from libraries]({{ site.baseurl }}{% link _pages/fsa/install/building-the-fsa-storefront-from-libraries.md %}).**

- For information on specific code changes for a particular release, see the [Development Release Notes](https://github.com/SAP/spartacus-financial-services-accelerator/releases).
- If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). For non-technical questions, you can reach us on our *#help-fsa* channel of [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ). Feedback welcome!

**Disclaimer - Forward-Looking Statements**

*This document contains or may contain forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality. This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence.*

*The various documentation links provided point to SAP Commerce Cloud or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented in Spartacus.*

## Release 2.0
  
List of features delivered with 2.0:
- **Additional Policy Changes**
 : The Policy Change Process framework enables insurance carriers to provide their customers with the possibility to change their policy online. In addition to sample processes for changing mileage and adding coverage, customers can now add the additional driver and remove coverage. All sample processes are provided based on the Auto Insurance product.  The policy change can be initiated for effective policies, and the customer can choose one of the available policy changes. Once the process is started, customers can specify the desired change and then be presented with a simulated premium. The policy change can then be submitted or canceled if the simulated premium does not match the customer's expectation. The Policy Change Process is based on the User Request Framework, allowing business users to make changes in the process directly from Backoffice.  
- **Claims Integration Enhancements**  
  : The Financial Services Accelerator is seamlessly integrated with SAP Claims Management. When a first notice of loss is submitted via the Financial Services Accelerator, it reaches SAP Claims Management, and if all data is valid, a claim is created. Besides form data, the customer can upload documents, and the document data will be forwarded to the SAP Claims Management. General information about the claim, e.g., claim number, status, and claim handler information, is then sent back to Financial Services Accelerator as a response to the first notice of loss call.  
- **Document Upload**
 : Document upload offers the possibility to upload additional information in a certain process, which also helps banks and insurers to collect all needed information and documents during a process (e.g., application or quotations processes, claims process). The customer can upload one or more documents in the same process. During the document upload, customers can download or remove already uploaded documents. Two document storage strategies are provided:
   - SAP Commerce Cloud, financial services accelerator
   - External DMS by using provided integration mechanisms (prepackaged integration with SAP Cloud Platform Document Management available).
- **Invoice Payment**
  : During the quotation process, the customer can choose to pay either with a credit card or through an invoice in the Payment Details step. If an invoice method is selected, the customer proceeds to the Final Review step without adding any additional information. In the case of a credit card payment method, the customer first needs to register a new credit card.  
- **Order Splitting**
  : Order splitting allows orders to be broken down into several consignments interfaces, which permits separate billing and shipment of third-party products. The Order Splitting process in the Financial Services Accelerator is visible on the Auto Product sample when a customer decides to include winter tires into their auto policy. Once the order is submitted, for each set of order entries, a consignment is created. In this case, the order is split into two consignments - one for the policy itself, and the second for the third-party product. The policy is then processed via a policy management system. As the policy is issued, the customer can see its details in My Account > Policies. The third-party product is charged as a one-time payment and shipped to the customer. Customers are informed via email about the shipment and can track their order in the newly added Order History page in the 'My Account' area. This is also where customers can see all the details of the order they have created.  


## Release 1.0
*Release 1.0 libraries published December 18, 2020* 

List of features delivered with 1.0:
- **Quotation and Application Process**
 : The Financial Services Accelerator guides customers through each step of the quotation/application process. At every step, customers are provided with a summary of their choices. In this guided-selling processes, customers have general options: request a quote/application, save it for later review or issue the policy/contract right away. The Process itself is configurable and steps can be adjusted in different way for each product category.  
- **Dynamic Forms**
 : Highly flexible and secure web forms solution that enable customer to collect, store and transfer data provided by a customer during his engagement. 
- **Insurance & Banking My Account**
  : In the My Account area, Financial Services Accelerator allows customers to manage their personal data and payment details, as well as view information about quotes, applications, policies, documents associated to an insurance policy, a banking application or access their inbox messages. Customers can also give or revoke their consent to marketing activities as well as close their account.
- **Claims - First Notice of Loss**  
  : Customers can report claims online through a guided step-by-step process. The process relies on Dynamic Forms and is hence highly configurable.
- **Inbox**
  : All messages and documents provided by a financial service institution are made available to the customer via the Inbox in My Account. All messages can be grouped according to their content, sorted, and then displayed in different tabs.
- **Policy Change Process**
  : Insurance carriers can provide their customers with the possibility to adjust their policy online. Sample processes for changing mileage, adding or removing a coverage, and adding additional drivers are provided based on the sample Auto Insurance product.
- **Insurance Agent Capabilities**
  : Customers can search for agents either using a map (integration to maps providers possible) or by any sorting category (Insurance type, Banking LoB, etc.). They can also reach out to their agent of choice, resulting in a customer support ticket which is then being pushed to the agent's workplace.
- **Insurance and Banking Products**
  : Combining both industries in one storefront allows companies to simultaneously offer both products but still use different quotation and application processes.


## About FSA Spartacus Releases

- Libraries that are "released" are new, official, tested Spartacus libraries available to the public (hosted on npmjs.com).
- A minor change means we added new features, but they are configured to be off by default, not to cause compatibility issues. A new minor can also include changes or bug fixes that may affect compatibility, but feature flags also control these. So all significant changes are “opt-in”. See feature flag documentation for more information.
- We will normally publish pre-release libraries labelled ‘next’ a few weeks before a new minor release. The goal is to provide early access to new features and get feedback from the community.
- If you choose not to use a new feature, you should have no problems upgrading to a new Major.# with features flag set to a previous Major.#. If you do see a problem, please report a bug, and we’ll assess and fix it. We encourage you to upgrade to the latest libraries frequently during development in order to take advantage of bug fixes and new features.
- To use all functionalities in FSA Spartacus 2.*, release 2011 of SAP Commerce Cloud and 2102 of Financial Services Accelerator is required.
- The latest patch release is strongly recommended, as it usually contains bug fixes that affect Spartacus.

## Future Releases

See the [separate roadmap document]({{ site.baseurl }}{% link _pages/fsa/fsa-spartacus-roadmap.md %}).

---
title: Release Information for All Versions of FSA Spartacus Libraries
---

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Introduction

This document describes what is included in all FSA Spartacus libraries since the initial 1.0 release. 

**Note: FSA Spartacus 3.x requires Spartacus 3.4 and Angular 10. For more information, see [Building FSA Spartacus storefront from libraries]({{ site.baseurl }}{% link _pages/fsa/install/building-the-fsa-storefront-from-libraries.md %}).**

- For information on specific code changes for a particular release, see the [Development Release Notes](https://github.com/SAP/spartacus-financial-services-accelerator/releases).
- If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). For non-technical questions, you can reach us on our *#help-fsa* channel of [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ). Feedback welcome!

**Disclaimer - Forward-Looking Statements**

*This document contains or may contain forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality. This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence.*

*The various documentation links provided point to SAP Commerce Cloud or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented in Spartacus.*

## Release 3.0
*Release 3.0 libraries published September, 2021*

List of features delivered with 3.0:
- **[Enablement of Coupons and Discounts]({{ site.baseurl }}{% link _pages/fsa/features/fsa-coupons.md %})**
 : Customers can apply coupons during the quotation process and obtain a discount on the policy premium. When a customer adds the coupon code, the amount they saved is shown on the storefront. The customer can also remove the coupon during the quotation process. This process is also supported in the E2E Auto quotation process in integration with S4I and PQM. Customers can see their coupons in the dedicated section of the My Account area. 
- **[Product Discovery]({{ site.baseurl }}{% link _pages/fsa/features/fsa-product-discovery.md %})**
 : Product Discovery Enhancement enables customers to find the best suitable product for their needs using a questionnaire. Customers respond to the questions related to their insurance targets and, based on their answers, products are filtered. The ones that suit best are recommended, and customers can start the quotation process. The questionnaire is configurable and can be easily changed. Life and Savings products are used as examples for implementation, but other products can also be added.
- **[Claims Details Page]({{ site.baseurl }}{% link _pages/fsa/features/claims/claims-details-page.md %})**
 : This feature enables customers to see more details about their claims. Besides general information, customers can now see details about payments, persons involved, and associated documents.
- **Document Accessibility**
  : Customers can see all their received and uploaded documents at one glance on the My Documents page in the My Account area. Documents can be shown in two different accordions. Customers can download documents directly from this page.
- **Address Management**
 : Customers can manage their address at a central place in the My Account area. This address is then consistently used in quotation and application processes. If the customer adds an address during the quotation process, the address will be saved, and can later be changed in the My Account area.
- **Live Contract Integration**
 : The integration of the Financial Services Accelerator with LiveContract offers financial companies the possibility to create a new kind of sales channel, combining the advantages of an agent-driven approach with the flexibility and cost advantages of online communication. This integration enables agents to keep in contact with their customers in a personal and individual way. Both customers and agents can enter in person-to-person interaction, which gives them flexibility in discussions, and the ability to explain and discuss complex matters, unlike how it is done in artificial dialogs via chatbot. In addition to this, customers can now easily find the information about agent availability on the Find an Agent page. Besides agent data, customers can see if an agent is online or offline. For more information, see [Speak to an Agent]({{ site.baseurl }}{% link _pages/fsa/features/agents/fsa-speak-to-agent.md %}) and [Agent Availability]({{ site.baseurl }}{% link _pages/fsa/features/agents/fsa-agent-availability.md %}).
- **[Quote Details Page]({{ site.baseurl }}{% link _pages/fsa/features/fsa-quote-details-page.md %})**
 : The Quote Details page allows financial customers to view all the details related to their quote on a separate page in the Quotes & Applications section of the My Account area. 

## Release 2.0
*Release 2.0 libraries published March 17, 2021*
  
List of features delivered with 2.0:
- **Additional Policy Changes**
 : The Policy Change Process framework enables insurance carriers to provide their customers with the possibility to change their policy online. In addition to sample processes for changing mileage and adding coverage, customers can now add the additional driver and remove coverage. All sample processes are provided based on the Auto Insurance product.  The policy change can be initiated for effective policies, and the customer can choose one of the available policy changes. Once the process is started, customers can specify the desired change and then be presented with a simulated premium. The policy change can then be submitted or canceled if the simulated premium does not match the customer's expectation. The Policy Change Process is based on the User Request Framework, allowing business users to make changes in the process directly from Backoffice.  
- **Claims Integration Enhancements**  
  : The Financial Services Accelerator is seamlessly integrated with SAP Claims Management. When a first notice of loss is submitted via the Financial Services Accelerator, it reaches SAP Claims Management, and if all data is valid, a claim is created. Besides form data, the customer can upload documents, and the document data will be forwarded to the SAP Claims Management. General information about the claim, e.g., claim number, status, and claim handler information, is then sent back to Financial Services Accelerator as a response to the first notice of loss call.  
- **Document Upload**
 : Document upload offers the possibility to upload additional information in a certain process, which also helps banks and insurers to collect all needed information and documents during a process (e.g., application or quotations processes, claims process). The customer can upload one or more documents in the same process. During the document upload, customers can download or remove already uploaded documents. Two document storage strategies are provided:
    : - SAP Commerce Cloud, financial services accelerator
    : - External DMS by using provided integration mechanisms (prepackaged integration with SAP Document Management service available).
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

- Libraries that are "released" are new, official, tested FSA Spartacus libraries available to the public (hosted on npmjs.com).
- A major change means that we added new features that are based on the latest versions of SAP Commerce Cloud and Financial Services Accelerator.
- A minor change contains bug fixes and minor improvements, and they are configured not to cause any compatibility issues. 
- To use all functionalities of the latest FSA Spartacus release, the latest patch releases of SAP Commerce Cloud and Financial Services Accelerator are strongly recommended, as they usually contain bug fixes that affect FSA Spartacus.

## Future Releases

See the [separate roadmap document]({{ site.baseurl }}{% link _pages/fsa/fsa-spartacus-roadmap.md %}).

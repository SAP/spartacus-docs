---
title: FSA Agent Enablement
---

**Note**: This feature is introduced with version 4.0 of the FSA Spartacus libraries.

Financial Services Accelerator provides a framework that enables business users to execute processes on behalf of their customers.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Overview

Business users can help their customers buy insurance and banking products by performing actions in the portal on their behalf. 
To be able to act on behalf of a customer, business user needs to become a member of a Seller user group introduced for this occasion.
Every member of the Seller Group is defined as a **Seller** and can create new customers and perform actions on their behalf in the portal.


On-Behalf-Of Consent enables sellers to execute processes on behalf of their customers. 
When sellers creates a customer, they are automatically given the OBOConsent with full permissions to execute business actions in name of the created customer. 
Currently, the seller can prepare quotes for a customer and get a preview of their activities (get a list of created quotes, claims & policies). 
The central place of the On-Behalf-Of Consent feature is the Seller dashboard page. 

## Back-End Requirements

The On-Behalf-Of Framework is based on the On-Behalf-Of consent (`OBOConsent`) and a new user group named Seller Group (`sellergroup`).
For more details on the back-end implementation and requirements, see our documentation on the [SAP Help Portal](https://help.sap.com/viewer/a7d0f0c5faa44002bf81e1a9a91c77e2/latest/en-US/cbf7b289a4414090a26e23077e2e4e1f.html).   

## Seller Dashboard

To support this feature on the storefront, we have introduced the Seller Dashboard.
A content page with ID *seller-dashboard* has two content slots. 
The first content slot contains `SellerDashboardTitleParagraph` which is responsible for rendering the title of the page. 
The second content slot contains `SellerDashboardFlexComponent`, which is mapped to FSA Spartacus `SellerDashboardComponent`, responsible for rendering the seller dashboard details. 
`SellerDashboardComponent` displays seller's photo and personal details (name, e-mail, date of birth), as well as the paginated list of seller's customers. 

The Seller Dashboard page is guarded by the guards implemented by Spartacus, like `AuthGuard` and `CmsPageGuard`, and by a custom `SellerDashboardGuard`. 
SellerDashboardGuard will allow access to the page only if currently logged-in customer is part of the seller group user group. If not, no sufficient permissions global messages will be shown.

Page route: /seller-dashboard

![Seller Dashboard Preview]({{ site.baseurl }}/assets/images/fsa/OBO/seller-dashboard-overview.png)


### Creating Customer Account

![Accessing Chatbot from the Homepage]({{ site.baseurl }}/assets/images/fsa/chatbot/chatbot_homepage.png)


## Performing Actions On-Behalf-of the Customer




---
title: FSA Agent Enablement
---

**Note**: This feature is introduced with version 4.0 of the FSA Spartacus libraries.

Financial Services Accelerator provides a framework that enables business users to execute processes on behalf of their customers. 
For this purpose, we have introduced the On-Behalf-of (OBO) framework. 

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Overview

The On-Behalf-Of Framework is based on the On-Behalf-Of consent (`OBOConsent`), and a new user group named Seller Group (`sellergroup`).

Business users who wish to help their customers by performing actions in the portal on their behalf first need to be added to the Seller user group.
Every member of the Seller Group is defined as a **Seller** and can create new customers and perform actions on their behalf in the portal.

When sellers create customers, they are automatically given the `OBOConsent` with full permissions to execute business actions in name of the created customer. 
Currently, the seller can prepare quotes for a customer and get a preview of their activities and insured objects (quotes, policies, claims). 
The central place of the On-Behalf-Of Consent feature is the Seller dashboard page. 

For more information on back-end implementation, see [Agent Enablement](https://help.sap.com/viewer/a7d0f0c5faa44002bf81e1a9a91c77e2/latest/en-US/cbf7b289a4414090a26e23077e2e4e1f.html) documentation on the SAP Help Portal.   


## Seller Dashboard

To support this feature on the storefront, Seller Dashboard has been introduced.

![Seller Dashboard Preview]({{ site.baseurl }}/assets/images/fsa/OBO/seller-dashboard-overview.png)

### Components

Seller Dashboard is a content page with ID *seller-dashboard*, consisted of two content slots. 
The first content slot contains `SellerDashboardTitleParagraph` which is responsible for rendering the title of the page. 
The second content slot contains `SellerDashboardFlexComponent`, which is mapped to the FSA Spartacus `SellerDashboardComponent`, responsible for rendering the seller dashboard details. 
`SellerDashboardComponent` displays seller's photo and personal details (name, e-mail, date of birth), as well as the paginated list of seller's customers. 

![Seller Dashboard Content Slots]({{ site.baseurl }}/assets/images/fsa/OBO/seller-dashboard-content-slots.png)

### Guards

The Seller Dashboard page is guarded by the guards implemented by Spartacus, like `AuthGuard` and `CmsPageGuard`, and by a custom `SellerDashboardGuard`. 
`SellerDashboardGuard` will allow access to the page only if the currently logged-in customer is part of the seller user group. 
If not, the appropriate message is displayed, informing the user that they do not have sufficient permissions.



Page route: /seller-dashboard

## User Journey 

### Accessing the Seller Dashboard

After logging in, the seller can access the Dashboard by clicking the link in the upper right corner, next to the My Account. 

### Creating Customer Account

To create a new customer account, seller clicks the **ADD** button on the Dashboard

![Accessing Chatbot from the Homepage]({{ site.baseurl }}/assets/images/fsa/chatbot/chatbot_homepage.png)

### Performing Actions On-Behalf-of the Customer




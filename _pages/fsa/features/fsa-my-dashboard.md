---
title: FSA My Dashboard
---

**Note**: This feature is introduced with version 4.0 of the FSA Spartacus libraries.

Financial Services Accelerator introduces a single information place for customers called My Dashboard. 

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Overview

The On-behalf-of Framework is based on the on-behalf-of consent (`OBOConsent`), and a new user group named Seller Group (`sellergroup`).

To make use of this feature, business users first need to be added to the Seller Group. 
Every member of this user group is defined as a **Seller** and can create new customers and perform actions on their behalf in the portal.
Adding users to Seller Group is done through the Backoffice. 

When sellers create customers, they are automatically given the `OBOConsent` with full permissions to execute business actions in name of the created customer. 
Currently, the seller can prepare quotes for a customer and get a preview of their activities and insured objects (quotes, policies, claims). 
The central place of the OBO framework is the Seller Dashboard page. 

For more information on back-end implementation, see [Agent Enablement](https://help.sap.com/viewer/a7d0f0c5faa44002bf81e1a9a91c77e2/latest/en-US/cbf7b289a4414090a26e23077e2e4e1f.html) documentation on the SAP Help Portal. 

To support this feature on the storefront, a Seller Dashboard has been introduced.

## User Journey 

### Accessing the Dashboard

After logging in, the customer can access the Dashboard by clicking the **Dashboard** link in the upper right corner, next to **My Account**. 

![Accessing My Dashboard]({{ site.baseurl }}/assets/images/fsa/OBO/seller-dashboard-access-link.png)

After they land on the Dashboard, customer can see their personal details on the right, while in the Dashboard Options section on the left, they can see number of existing insurance objects, such as Quotes and Applications, Policies, and Claims. 

![My Dashboard Preview]({{ site.baseurl }}/assets/images/fsa/OBO/seller-dashboard-overview.png)

The page route is */dashboard*.

## Components

Dashboard is a content page (ID *my-dashboard*), which consists of two content slots. 
The first content slot contains `DashboardTitleParagraph` which is responsible for rendering the title of the page. 
The second content slot contains `DashboardFlexComponent`, which maps to the FSA Spartacus `SellerDashboardComponent`, responsible for rendering the seller dashboard details. 
`DashboardComponent` displays seller's photo and personal details (name, e-mail, date of birth), as well as the paginated list of seller's customers. 

![Seller Dashboard Content Slots]({{ site.baseurl }}/assets/images/fsa/OBO/seller-dashboard-content-slots.png)




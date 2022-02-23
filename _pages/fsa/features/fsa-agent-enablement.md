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

To make use of this feature, business users first need to be added to the Seller Group. 
Every member of this user group is defined as a **Seller** and can create new customers and perform actions on their behalf in the portal.
Adding users to Seller Group is done through the Backoffice. 

When sellers create customers, they are automatically given the `OBOConsent` with full permissions to execute business actions in name of the created customer. 
Currently, the seller can prepare quotes for a customer and get a preview of their activities and insured objects (quotes, policies, claims). 
The central place of the On-Behalf-Of Consent feature is the Seller Dashboard page. 

For more information on back-end implementation, see [Agent Enablement](https://help.sap.com/viewer/a7d0f0c5faa44002bf81e1a9a91c77e2/latest/en-US/cbf7b289a4414090a26e23077e2e4e1f.html) documentation on the SAP Help Portal. 

## Seller Dashboard

To support this feature on the storefront, Seller Dashboard has been introduced.

![Seller Dashboard Preview]({{ site.baseurl }}/assets/images/fsa/OBO/seller-dashboard-overview.png)

### Components

Seller Dashboard is a content page with ID *seller-dashboard*, consisted of two content slots. 
The first content slot contains `SellerDashboardTitleParagraph` which is responsible for rendering the title of the page. 
The second content slot contains `SellerDashboardFlexComponent`, which maps to the FSA Spartacus `SellerDashboardComponent`, responsible for rendering the seller dashboard details. 
`SellerDashboardComponent` displays seller's photo and personal details (name, e-mail, date of birth), as well as the paginated list of seller's customers. 

![Seller Dashboard Content Slots]({{ site.baseurl }}/assets/images/fsa/OBO/seller-dashboard-content-slots.png)

### Guards

The Seller Dashboard page is guarded by the guards implemented by Spartacus, like `AuthGuard` and `CmsPageGuard`, and by a custom `SellerDashboardGuard`. 
`SellerDashboardGuard` will allow access to the page only if the currently logged-in customer is part of the seller user group. 
If not, the appropriate message is displayed, informing the user that they do not have sufficient permissions.

## User Journey 

### Accessing the Seller Dashboard

After logging in, the business user with the seller role can access the Seller Dashboard by clicking the **Dashboard** link in the upper right corner, next to **My Account**. 

![Accessing Seller Dashboard]({{ site.baseurl }}/assets/images/fsa/OBO/seller-dashboard-access-link.png)

After they land on the Dashboard, sellers can see their personal details on the right, while in the Dashboard Options section on the left, they can see number of existing customers, as well as options for adding a new customer and previewing the list of existing customers. 

The page route is */seller-dashboard*.

### Creating Customer Account

To create a new customer account, seller clicks the **Add a Customer** button in the Dashboard Overview section.
The page route is */seller-dashboard/create-customer*.

![Adding New Customer]({{ site.baseurl }}/assets/images/fsa/OBO/seller-dashboard-add-customer.png)

After that, the seller fills in the form with customer data, such as customer name, e-mail address and date of birth.

![Create Customer Form]({{ site.baseurl }}/assets/images/fsa/OBO/seller-dashboard-create-customer-form.png)

After saving the changes, seller can see the newly created customer in their list of customers on the Dashboard.

![Customer List on the Seller Dashboard]({{ site.baseurl }}/assets/images/fsa/OBO/seller-dashboard-customer-list.png)

### Performing Actions On-Behalf-of the Customer

In the default implementation, besides creating an account for the customer, the seller can create quotes and applications. 
The quotation and application process is similar to the one initiated by the customer, except that the seller fills in the forms with data provided by the customer. 
After selecting the insurance type, the seller fills in the initial form, chooses the cover, adds options if required, and, on the ***Personal Details** step, enters customer personal information.
So far the steps follow the usual quotation and application procedure. 
On the **Quote Review step**, the seller is prompted to choose the customer for whom they wish to create the quote/application. 
The seller selects the customer by clicking the **Select** link next to the customer's name. 

![Customer List]({{ site.baseurl }}/assets/images/fsa/OBO/seller-customer-selected.png)

The seller can select only one customer. Clicking again on a **Select** link next to another customer deselects the previously selected customer.
After that, the seller confirms the quote, which then becomes bound.

The seller can create several quotes or applications for the same customer. 

The customer on whose behalf the seller was acting can then log in to their account, access the created quotes on the **Quotes and Applications** page of the **My Account** area.
The customer can then finish the checkout by entering the payment details.




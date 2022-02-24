---
title: FSA Agent Enablement
---

**Note**: This feature is introduced with version 4.0 of the FSA Spartacus libraries.

Financial Services Accelerator provides a framework that enables business users to execute processes on behalf of their customers. 
For this purpose, we have introduced the On-behalf-of Framework (OBO framework). 

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

### Accessing the Seller Dashboard

After logging in, the business user with the seller role can access the Seller Dashboard by clicking the **Dashboard** link in the upper right corner, next to **My Account**. 

![Accessing Seller Dashboard]({{ site.baseurl }}/assets/images/fsa/OBO/seller-dashboard-access-link.png)

After they land on the Dashboard, sellers can see their personal details on the right, while in the Dashboard Overview section on the left, they can see number of existing customers, as well as options for adding a new customer and previewing the list of existing customers. 

![Seller Dashboard Preview]({{ site.baseurl }}/assets/images/fsa/OBO/seller-dashboard-overview.png)


### Creating Customer Account

To create a new customer account, seller clicks the **Add a Customer** button in the Dashboard Overview section.

![Adding New Customer]({{ site.baseurl }}/assets/images/fsa/OBO/seller-dashboard-add-customer.png)

After that, the seller fills in the form with customer data, such as customer name, e-mail address and date of birth.

![Create Customer Form]({{ site.baseurl }}/assets/images/fsa/OBO/seller-dashboard-create-customer-form.png)

After saving the changes, seller can see the newly created customer in their list of customers on the Dashboard.

![Customer List on the Seller Dashboard]({{ site.baseurl }}/assets/images/fsa/OBO/seller-dashboard-customer-list.png)

### Performing Actions On-Behalf-of the Customer

In the default implementation, besides creating an account for the customer, the seller can create quotes and applications. 
The seller starts the quotation and application process, filling in the forms with data previously obtained from the customer. 
On the **Quote Review** step, the seller is prompted to select the customer for whom they wish to create the quote/application. 
The seller selects the customer by clicking the **Select** link next to the customer's name. 

![Customer List on Quote Review Step]({{ site.baseurl }}/assets/images/fsa/OBO/seller-customer-selected.png)

The seller can select only one customer at the time. 
Clicking again on the **Select** link next to another customer's name will deselect the previously selected customer.
After selecting the customer, the seller confirms the quote, which then becomes bound.
The system informs the seller that the quote has been successfully created with a toast message and returns them to the homepage.

![Toast Message Informing the Seller that the Quote is Created]({{ site.baseurl }}/assets/images/fsa/OBO/seller-creates-quote-for-customer-notification.png)

The seller can create as many quotes or applications for the customer as found necessary. 
After creating the quote, the seller can check if the quote they just created appears on the Customer Dashboard.
To do that, the seller navigates to Dashboard, opens the list of customers and selects the customer on whose behalf they just created the quote. 
Click on the arrow opens the Customer Dashboard, where the seller chooses to check customer's quotes and applications. 
The newly created quote appears in the list. 

![Seller Dashboard Preview]({{ site.baseurl }}/assets/images/fsa/OBO/seller-dashboard-overview.png)

The customer on whose behalf the seller was acting can then log in to their account and access the created quotes on the **Quotes and Applications** page of the **My Account** area.
The customer then retrieves the quote or application, enters payment details and completes the checkout.

## Components

### Seller Dashboard

Seller Dashboard is a content page with ID *seller-dashboard*, which consists of two content slots. 
The first content slot contains `SellerDashboardTitleParagraph` which is responsible for rendering the title of the page. 
The second content slot contains `SellerDashboardFlexComponent`, which maps to the FSA Spartacus `SellerDashboardComponent`, responsible for rendering the seller dashboard details. 
`SellerDashboardComponent` displays seller's photo and personal details (name, e-mail, date of birth), as well as the paginated list of seller's customers. 

![Seller Dashboard Content Slots]({{ site.baseurl }}/assets/images/fsa/OBO/seller-dashboard-content-slots.png)

`SellerDashboardComponent`, `SellerDashboardListComponent` and `CreateOBOCustomerComponent` are declared and exported in main `SellerDashboardModule`.

Page route: */seller-dashboard*.
Page route for Create Customer page: */seller-dashboard/create-customer*.

The Seller Dashboard page is guarded by the guards implemented by Spartacus, like `AuthGuard` and `CmsPageGuard`, and by a custom `SellerDashboardGuard`. 
`SellerDashboardGuard` will allow access to the page only if the currently logged-in customer is part of the seller user group. 
If not, the appropriate message is displayed, informing the user that they do not have sufficient permissions.

### Customer Dashboard

The Customer Dashboard page is used to display details about customers created by the seller. 
Content page with ID `user-profile` contains a content slot that contains `UserProfileFlexComponent` which is mapped to Spartacus `UserProfileComponent`, responsible for rendering the customer's details.  
The `UserProfileComponent` displays customer's personal details (name, e-mail, date of birth, and avatar), and it also displays the paginated list of customer's insurance objects (claims, quotes and applications, policies). 

`UserProfileComponent` is declared and exported in `UserProfileModule`.

Page route: */user-profile/:customerId*

Page is guarded by `AuthGuard` and `CmsPageGuard`.

Customer dashboard relies heavily on *My Dashboard* feature.
For more information, see [My Dashboard]({{ site.baseurl }}/pages/fsa/features/fsa-my-dashboard.png) documentation. 








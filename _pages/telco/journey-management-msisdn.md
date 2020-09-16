---
title: Journey Management - MSISDN
---

**Note:** This feature is introduced in version 1.1.0 of the TUA Spartacus libraries.

## Contents

- [Overview](#overview)
- [Business Requirement](#business-requirement)
- [Key Personas](#key-personas)
- [Business Use Case](#business-use-case)
- [Navigation Flow](#navigation-flow)
- [Requirements and Dependencies](#requirements-and-dependencies)
- [Configuring and Enabling MSISDN](#configuring-and-enabling-msisdn)
- [Handling Error Messages](#handling-error-messages)
- [Further Reading](#further-reading)

## Overview

Some product offerings require specific MSISDNs or the phone numbers to be reserved by the customers before placing the order. An `MSISDN (Mobile Station International Subscriber Directory Number)` is a number used to identify a mobile phone number internationally from the available MSISDNs. This number includes a country code and a National Destination Code, which identifies the subscriber's operator.

## Business Requirement

The `Journey Management - MSISDN` feature enables the customers who are browsing the TUA for SPA Storefront, to select a desired phone number (MSISDN) before adding the selected product or the service to the cart.

**Note:** The `Journey Management - MSISDN` feature applies to the product offerings or service plans for which a checklist policy for `MSISDN Reference` is configured at the backend by the Product Manager.

## Key Personas

- Customers
- Product Managers

## Business Use Case

A customer wants to purchase a service plan, for example, `Do More with Less` plan. Before adding the service plan to the cart, the `Select your desired Phone Number` screen is displayed, based on the checklist policy configured for MSISDN at the backend by the Product Manager. The customer is required to select a phone number from the available phone numbers.

The business use case includes the following steps:

1. The customer searches and selects a service plan; for example, `Do More with Less`, and clicks **Add to Cart** to add the service plan to the cart.
2. The `Select your desired Phone Number` screen displays the phone numbers based on the checklist actions configured for MSISDN at the backend by Product Manager, 
3. The customer selects a desired phone number from the available phone numbers, before adding the service plan to the cart.
4. The selected service plan is added to the cart.
5. The customer can update the selected phone number before proceeding to checkout the service plan.
6. The customer places an order for the service plan.

## Navigation Flow

1. Search and select the desired product offering or the service plan, for example, `Do More with Less`.

    <p align="center"><img src="/assets/images/telco/1MSISDN_Add_to_Cart.png"></p>

2. Click **Add to Cart**. The `Select your desired Phone Number` screen is displayed, based on the checklist policy configured for MSISDN at the backend by the Product Manager.

3. Select the desired phone number from the available phone numbers.

    **Note:** Top six available phone numbers are displayed.

    <p align="center"><img src="/assets/images/telco/2MSISDN_Select_Desired_Phone.png"></p>

4. Click **CONTINUE**. The selected phone number is added and displayed in the `Item(s) added to your cart` screen.

    <p align="center"><img src="/assets/images/telco/3MSISDN_Items_Added-to_Cart.png"></p>

5. Click **View Cart**. The cart displays all relevant details of the `Do More with Less` service plan with the phone number.

    <p align="center"><img src="/assets/images/telco/4MSISDN_Proceed_to_Checkout.png"></p>

6. Click the pencil icon to update the phone number. The `Select your desired Phone Number` screen is displayed. 

    **Notes:** The **UPDATE** button is disabled until you select a new phone number from the available phone numbers.

7. Select a new phone number and click **UPDATE**. The cart page displays the updated phone number.

    <p align="center"><img src="/assets/images/telco/5Updated_Appointment.png"></p>

8. Click **Proceed to Checkout** to place an order for the service plan.

9. Click **Account > Order History**.

10. Click the order number to check the phone number and other relevant details.

## Requirements and Dependencies

### Frontend Requirements and Dependencies

Your Angular development environment should include the following:

The `Ngx-spinner` library, version 8.03 for Angular CLI 8.0. The `Ngx-spinner` library is available:

Using npm:

     ```bash
     $ npm install ngx-spinner --save
     ```

Using yarn:

     ```bash
     $ yarn add ngx-spinner
     ```

### Backend Requirements and Dependencies

The checklist policy is configured by the Product Manager in the Backoffice to have the `Select your desired Phone Number` screen displayed to the customers to select the desired phone number, before adding the product offering to the cart. For more information, see [Configuring and Enabling MSISDN](#configuring-and-enabling-msisdn).

### Supported Backend Functionality

- [Product Catalog](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/552515309dd545e7b7878eb081b56453.html).
- [TUA Data Model for Entities exposed Via TMF and OCC APIs](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/552515309dd545e7b7878eb081b56453.html).
- [TUA Checklist](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/552515309dd545e7b7878eb081b56453.html).

|  Entity Exposed for Journey Checklist            	 |TMF and OCC API                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|TmaSubscriptionBase|[GET/subscriptionBase](https://help.sap.com/doc/c280898e0829413d838559088d5e4b5f/2007/en-US/index_TMF_V2.html#_listsubscriptionbase)            |The API displays a list of  retrieves the list of SubscriptionBase resources that a customer has access to            |
|TmaSubscribedProduct          |[GET /product/{productId}](https://help.sap.com/doc/c280898e0829413d838559088d5e4b5f/2007/en-US/index_TMF_V2.html#_productget)            |The API displays details of a subscribed product            |
|TmaSubscriptionUsage          |[GET /usageConsumptionReport](https://help.sap.com/doc/c280898e0829413d838559088d5e4b5f/2007/en-US/index_TMF_V2.html#_usageconsumptionreportfind)| The API requests the calculation of a new usage consumption report for a subscribed product |||

## Configuring and Enabling MSISDN

To configure and enable MSISDN reference from the Backoffice, follow the steps:

1. Log in to the **Backoffice**.
2. Navigate to **Catalog > Conditional Policies > Policy Statement > Checklist Action Statement > Configurable Psc Checklist Action Statement**. The `Checklist action type` component is displayed.
3. Click **Checklist action type**. The details are displayed in the following pane.
4. In the **PROPERTIES** tab:
    - In the **Checklist action type**, select `MSISDN`.
    - In the **Product Specification Characteristic**, select either the staged or online catalog.
5. In the **Product Offering**, select the product offering for configuring the MSISDN.

### Components

|  Component Name            	 |Status                         |Description                         |
|----------------|-------------------------------|-----------------------------|
|TmaLogicalResourceComponent|New            | The component interacts with the mock TMF API to fetch details of logical resource            |
|TmaLogicalResourceDisplayComponent          |New            |The component displays the LogicalResource in the **Add to Cart** popup, in the **Cart** page and in the **Order** page          |[GET /usageConsumptionReport](https://help.sap.com/doc/c280898e0829413d838559088d5e4b5f/2007/en-US/index_TMF_V2.html#_usageconsumptionreportfind)| The API requests the calculation of a new usage consumption report for a subscribed product |||

<!--### Sample Data

In progress.-->

## Handling Error Messages

The following table lists the common error responses to troubleshoot the error messages.

| Error   Message                                                                                    	| Description                                                                                                                           	|
|----------------------------------------------------------------------------------------------------	|---------------------------------------------------------------------------------------------------------------------------------------	|
| There is a problem in fetching Phone numbers. Please try again   later                             	| A   customer tried to add a product offering to the cart, but no phone numbers   are available for selection                          	|
| There is a problem in fetching Phone numbers. Please try again   later                             	| A   customer tried to update the existing phone number from the cart, but no   phone numbers are available for selection.             	|
| Something went wrong, Cannot add item to the cart                                                  	| A   customer is unable to proceed to checkout the cart after adding the product   offering and the desired phone number to the cart.  	|
| Phone number cannot be updated at the moment, you can continue   with your previous phone number   	| A   customer tried to update a phone number from the available phone numbers, but   unable to proceed to the cart page.               	|
| There is a problem in fetching Phone number details. Please try   again later                      	| Problem   in fetching details of the selected phone number of the customer in one   or more product entries on the cart page.     	|
| There is a problem in fetching Phone number details. Please try   again later                      	|      Problem in fetching details of the selected phone number of the   customer in the order confirmation page.                   	|
| There is a problem with selected Phone number. Please remove   this entry from the cart to proceed 	| A   customer selected a phone number from the available phone numbers, but the   number is not available.                             	|
| There is a problem with selected Phone number. Please remove   this entry from the cart to proceed 	| A   customer selected a phone number from the available phone numbers, but the   number is not available.                             	|

## Further Reading

For further reading, see [Standardization of the Names of the Service Plans](https://help.sap.com/viewer/62583a7386514befa5d2821f6f9a40e5/2007/en-US/1efef20cf9ab42b59f1bdb9004e67477.html) in the TUA Help portal.

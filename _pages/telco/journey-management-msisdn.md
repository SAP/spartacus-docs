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

1. A customer searches and selects a service plan; for example, `Do More with Less`, and clicks **Add to Cart** to add the service plan to the cart.
2. The `Select your desired Phone Number` screen displays the phone numbers based on the checklist actions configured for MSISDN at the backend by Product Manager, 
3. A customer selects a desired phone number from the available phone numbers, before adding the service plan to the cart.
4. The selected service plan is added to the cart.
5. A customer can update the selected phone number before proceeding to checkout the service plan.
6. A customer places an order for the service plan.
7. A customer can view the phone number and the order details from **Account >** `Order History` component.

## Navigation Flow

1. Log in to the TUA SPA Storefront.

    <p align="center"><img src="/assets/images/telco/Screenshot_2020-09-02 Login.png"></p>

2. Search and select the desired product offering or the service plan, for example, `Do More with Less`.

    <p align="center"><img src="/assets/images/telco/1MSISDN_Add_to_Cart.png"></p>

3. Click **Add to Cart**. The `Select your desired Phone Number` screen is displayed, based on the checklist policy configured for MSISDN at the backend by the Product Manager.

4. Select the desired phone number from the available phone numbers.

    **Note:** Top six available phone numbers are displayed.

    <p align="center"><img src="/assets/images/telco/2MSISDN_Select_Desired_Phone.png"></p>

5. Click **CONTINUE**. The selected phone number is added and displayed in the `Item(s) added to your cart` screen.

    <p align="center"><img src="/assets/images/telco/3MSISDN_Items_Added-to_Cart.png"></p>

6. Click **View Cart**. The cart displays all relevant details of the `Do More with Less` service plan with the phone number.

    <p align="center"><img src="/assets/images/telco/4MSISDN_Proceed_to_Checkout.png"></p>

7. Click the pencil icon to update the phone number. The `Select your desired Phone Number` screen is displayed. 

    **Notes:** The **UPDATE** button is disabled until you select a new phone number from the available phone numbers.

8. Select a new phone number and click 

**UPDATE**. The cart page displays the updated phone number.

    <p align="center"><img src="/assets/images/telco/5Updated_Appointment.png"></p>

9. Click **Proceed to Checkout** to place an order for the service plan.

10. Click **Account > Order History**.

11. Click the order number to confirm the phone number and other relevant details.

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

The checklist policy is configured by the Product Manager in the Backoffice to have the `Select your desired Phone Number` screen is displayed to the customers to select the desired phone number, before adding the product or the service offering to the cart. For more information, see [Configuring and Enabling MSISDN](#configuring-and-enabling-msisdn).

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

When the product offering is successfully configured for the `MSISDN Reference` feature, the `Select your desired Phone Number` screen is displayed before adding the product offering to the cart.

### Components

|  Component Name            	 |Status                         |Description                         |
|----------------|-------------------------------|-----------------------------|
|TmaLogicalResourceComponent|New            | The component interacts with the mock TMF API to fetch details of logical resource            |
|TmaLogicalResourceDisplayComponent          |New            |The component displays the LogicalResource in the **Add to Cart** popup, in the **Cart** page and in the **Order** page          |[GET /usageConsumptionReport](https://help.sap.com/doc/c280898e0829413d838559088d5e4b5f/2007/en-US/index_TMF_V2.html#_usageconsumptionreportfind)| The API requests the calculation of a new usage consumption report for a subscribed product |||

<!--### Sample Data

In progress.-->

## Handling Error Messages

The following table lists the common error responses:

| Error   Message                                                                                         	| Description                                                                                                                                                                                                                                                                                                                                  	|
|---------------------------------------------------------------------------------------------------------	|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
| Something went wrong. Could not add item to the shopping cart                                           	| A   server error message that is displayed on the Product   Offering Details screen. This error message is   displayed when a customer selects the desired phone number and clicks CONTINUE. As a result of this error   message, the phone number reservation does not happen, and the selected   product offering is not added to the cart 	|
| There is a problem in fetching Phone number details. Please try   again later                           	| A   server error message that is displayed on the Cart screen. As a result of this error message, the phone number   does not display and the Proceed to Checkout button is disabled; hence, the customer cannot proceed to   checkout the product offering                                                                                  	|
| There is a problem with the selected phone number. Please remove   this entry from the cart to checkout 	| A   server related error message that is displayed on the Cart screen. This error message is displayed when the phone number   is cancelled. As a result of this error message, the Proceed to Checkout button is   disabled; hence, the customer cannot proceed to checkout the product offering                                            	|
| There is a problem in fetching Phone numbers. Please try again   later                                  	| A   server error message that is displayed on the Cart screen. This error message is displayed when the customer   clicks the UPDATE   (Pencil icon)  on the Cart screen to update the existing   phone number                                                                                                                               	|
| Phone number cannot be updated at the moment. Continue with   previous selection                        	| A   server error message that is displayed on the Cart screen. This error message is displayed when the customer   tries to update the existing phone number.                                                                                                                                                                                	|
| There is a problem in fetching Phone number details. Please try   again later                           	| A   server error message that is displayed on the Shipping   Address screen. This error message is displayed   when the customer clicks Proceed to Checkout button on the Cart screen. As a result of this error message, the Place Order button is disabled;   hence, a customer cannot place an order                                      	|
| There is a problem with the selected phone number. Please remove   this entry from the cart to checkout 	| This   error message is displayed on the Review Order screen when the customer tries to place an order for the   selected product offering. This error message is displayed because the phone   number is cancelled. As a result of this error message, the Place Order button is disabled                                                   	|
| There is a problem in fetching Phone number details. Please try   again later                           	| This   error message is displayed on the Order Confirmation screen when the customer places an order for the selected   product offering                                                                                                                                                                                                     	|
| There is a problem in fetching Phone number details. Please try   again later                           	| This   error message is displayed on the Order History screen when the customer places an order for the selected   product offering and wants to confirm the order details from the Order History screen                                                                                                                                     	|

## Further Reading

For further reading, see the following topics in the TUA Help portal.

- [Checklist Policy](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/b685dbb837ca4ad7b6c86d0bbd8a7fd7.html).
- [Customer Inventory and Cart](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/2007/en-US/6d4fed0352f04fb8ba10846024854ea6.html).
- [Standardization of the Names of the Service Plans](https://help.sap.com/viewer/62583a7386514befa5d2821f6f9a40e5/2007/en-US/1efef20cf9ab42b59f1bdb9004e67477.html).

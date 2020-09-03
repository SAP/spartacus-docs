---
title: Journey Management - MSISDN
---

**Note:** This feature is introduced in version 1.1.0 of the TUA Spartacus libraries.

## Contents

- [Overview](#overview)
- [Key Personas](#key-personas)
- [Business Use Case](#business-use-case)
- [Navigation Flow](#navigation-flow)
- [Requirements and Dependencies](#requirements-and-dependencies)
- [Configuring and Enabling MSISDN](#configuring-and-enabling-msisdn)
- [Further Reading](#further-reading)

## Overview

The `Journey Management - MSISDN (Mobile Station International Subscriber Directory Number)` feature enables the customers browsing the telco and utilities accelerator for project "Spartacus" (TUA Spartacus) storefront to select an MSISDN, before adding the selected product offering or a service plan to the cart.

`MSISDN` is a number used to identify a mobile phone number internationally from the available MSISDNs. This number includes a country code and a National Destination Code, which identifies the subscriber's operator.

**Note:** The `Journey Management - MSISDN` feature applies to only those product offerings or service plans for which a checklist policy is configured at the backend by the Product Manager..

## Key Personas

- **Customers:** Customers who are interested in the product offerings and the different service plans.
- **Product Managers:** Backoffice users who manage the product catalog.

## Business Use Case

A customer wants to purchase a service plan. Before adding the chosen service plan to the cart, the `Select Your desired Phone Number` screen is displayed, based on the checklist policy configured at the backend by the Product Manager. The customer is required to select a phone number (MSISDN) from the available phone numbers.

The business use case includes the following steps:

1. The customer searches and selects a service plan; for example, Unlimited Starter Plan, and clicks **Add to Cart** to add the selected service plan to the cart.
2. Based on checklist actions configured for MSISDN at the backend by Product Manager, the `Select Your desired Phone Number` screen displays MSISDNs to the customer.
3. The customer selects the desired MSISDN from the available MSISDNs, before adding the service plan to the cart.
4. The selected service plan is added to the cart.
5. The customer can edit the MSISDN before proceeding to checkout the service plan.
6. The customer places an order for the service plan.

## Navigation Flow

- Search and select the desired service plan, for example, Unlimited Starter Plan.

<p align="center"><img src="/assets/images/telco/1MSISDN_Add_to_Cart.png"></p>

- Click **Add to Cart**. The `Select Your Desired Phone Number` screen is displayed, based on the checklist policy configured for MSISDN at the backend by the Product Manager.

    **Note:** The first MSISDN is preselected.

- Click an MSISDN from the available MSISDNs.

<p align="center"><img src="/assets/images/telco/2MSISDN_Select_Desired_Phone.png"></p>

- Click **CONTINUE**. The selected MSISDN is displayed in the `Item(s) added to your cart` screen.

<p align="center"><img src="/assets/images/telco/3MSISDN_Items_Added-to_Cart.png"></p>

- Click **View Cart**. The cart displays all relevant details of the service plan (Unlimited Starter Plan) with the MSISDN.

<p align="center"><img src="/assets/images/telco/4MSISDN_Proceed_to_Checkout.png"></p>

- Click the pencil icon to edit the MSISDN. The `Select a suitable MSISDN` screen is displayed. 
- Select a suitable MSISDN and click **Update**. The cart page displays the updated MSISDN.
- Click **Proceed to Checkout** to purchase the service plan.

## Requirements and Dependencies

### Frontend Requirements and Dependencies

In progress.

### Backend Requirements and Dependencies

The checklist policy must be configured to display the MSISDNs screen, for the customer to select the desired MSISDN.

### Supported Back End Functionality

- [Product Catalog](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/552515309dd545e7b7878eb081b56453.html).
- [Telco & Utilities Accelerator Data Model for Entities exposed Via TMF and OCC APIs](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/552515309dd545e7b7878eb081b56453.html).
- [Telco & Utilities Accelerator Checklist](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/552515309dd545e7b7878eb081b56453.html).

|  Entity Exposed for Journey Checklist            	 |TMF and OCC API                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|TmaSubscriptionBase|[GET/subscriptionBase](https://help.sap.com/doc/c280898e0829413d838559088d5e4b5f/2007/en-US/index_TMF_V2.html#_listsubscriptionbase)            |The API displays a list of  retrieves the list of SubscriptionBase resources that a customer has access to            |
|TmaSubscribedProduct          |[GET /product/{productId}](https://help.sap.com/doc/c280898e0829413d838559088d5e4b5f/2007/en-US/index_TMF_V2.html#_productget)            |The API displays details of a subscribed product            |
|TmaSubscriptionUsage          |[GET /usageConsumptionReport](https://help.sap.com/doc/c280898e0829413d838559088d5e4b5f/2007/en-US/index_TMF_V2.html#_usageconsumptionreportfind)| The API requests the calculation of a new usage consumption report for a subscribed product |||

## Configuring and Enabling MSISDN

To configure and enable MSISDN, follow the steps:

1. Log in to the **Backoffice**.
2. Navigate to **Catalog > Conditional Policies > Policy Statement > Checklist Action Statement > Configurable Psc Checklist Action Statement**. The `Checklist action type` page is displayed.
3. Click the **Checklist Action type**. The details are displayed in the following pane.
4. In the **PROPERTIES** tab, ensure that `MSISDN` is selected as the property in the Checklist Action Type field.
5. In the **Product Offering** field, select the product offering for configuring MSISDN.

### Components

|  Component Name            	 |Status                         |Description                         |
|----------------|-------------------------------|-----------------------------|
|TmaLogicalResourceComponent|New            |Interacts with the mock TMF API to fetch details of logical resource            |
|TmaLogicalResourceDisplayComponent          |New            |Displays the LogicalResource in the **Add to Cart** popup, in the **Cart** page and in the **Order** page          |[GET /usageConsumptionReport](https://help.sap.com/doc/c280898e0829413d838559088d5e4b5f/2007/en-US/index_TMF_V2.html#_usageconsumptionreportfind)| The API requests the calculation of a new usage consumption report for a subscribed product |||

### Sample Data

In progress.

## Further Reading

Consult the Telco & Utilities Accelerator Help Portal for more information on the following topics:

- [Standardization of the Names of the Service Plans](https://help.sap.com/viewer/62583a7386514befa5d2821f6f9a40e5/2007/en-US/1efef20cf9ab42b59f1bdb9004e67477.html)

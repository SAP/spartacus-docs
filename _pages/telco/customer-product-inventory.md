---
title: Customer Product Inventory (CPI)
---

**Note:** This feature is introduced in version 1.1.0 of the TUA Spartacus libraries.

## Contents

- [Overview](#overview)
- [Key Personas](#key-personas)
- [Navigation Flow](#navigation-flow)
- [Business Use Cases](#business-use-cases)
  - [Viewing All Subscriptions](#viewing-all-subscriptions)
  - [Viewing Details of Subscribed Products in a Tile Format](#viewing-details-of-subscribed-products-in-a-tile-format)
  - [Viewing the Usage Consumption of a Subscribed Product in Pie Charts](#viewing-the-usage-consumption-of-a-subscribed-product-in-pie-charts)
  - [Viewing Subscribed Products in a Grid or a Tabular Format](#viewing-subscribed-products-in-a-grid-or-a-tabular-format)
- [Requirements and Dependencies](#requirements-and-dependencies)
- [Configuring and Enabling Customer Product Inventory](#configuring-and-enabling-customer-product-inventory)
- [Further Reading](#further-reading)

## Overview

The Customer Product Inventory feature enables logged in customers who are browsing the telco and utilities accelerator for project "Spartacus" (TUA Spartacus) storefront to view their subscriptions-related information and subscribed products, as imported in the Telco & Utilities Accelerator from external systems.

## Key Personas

- Customers
- Product Managers

## Navigation Flow

From the **Account** menu drop-down, click **Subscriptions**. The `My Subscriptions` screen is displayed. The subscriptions show:

- Subscription ID. For example, 1040123111111.
- Number of subscribed offerings. For example, 2.
- Usage Details.

<p align="center"><img src="/assets/images/telco/navigation-flow.png"></p>

## Business Use Cases

### Viewing All Subscriptions

From the **Account** menu drop-down, click **Subscriptions**. All subscriptions are displayed.

<p align="center"><img src="/assets/images/telco/viewing-all-subscriptions.png"></p>

### Viewing Details of Subscribed Products in a Tile Format

1. From the **Account** menu drop-down, click **Subscriptions**. All subscriptions are displayed.
2. Click the header that shows the subscriber ID. For example, **1040123111111**. The subscribed products are displayed in a tile format.

**Note:** The subscriptions owner will see all subscription information, including contract information and pricing details. However, the subscriptions beneficiary will see limited subscriptions information. For example, no contract information and Pricing Details will be displayed. For more information on the backend configuration, see [Configuring and Enabling Customer Product Inventory](#configuring-and-enabling-customer-product-inventory).

**Subscriptions Beneficiary:**

<p align="center"><img src="/assets/images/telco/subscription-beneficiary.png"></p>

**Subscriptions Owner:**

<p align="center"><img src="/assets/images/telco/subscription-owner.png"></p>

### Viewing the Usage Consumption of a Subscribed Product in Pie Charts

1. From the **Account** menu drop-down, click **Subscriptions**. All subscriptions are displayed.
2. Click **Usage Details**. The usage consumption for a subscribed product is displayed in pie charts.
3. Click **Go back to the Subscriptions** to navigate to the My Subscriptions page.

<p align="center"><img src="/assets/images/telco/usage-consumption.png"></p>

### Viewing Subscribed Products in a Grid or a Tabular Format

1. From the **Account** menu drop-down, click **Subscriptions**. All subscriptions are displayed.
2. Click **Usage Details**. The usage consumption for a subscribed product is displayed in a grid or a tabular format.
3. Click **Go back to the Subscriptions** to navigate to the My Subscriptions page.

**Note:** The graphical representation of the usage consumption in the pie charts is displayed in a grid or a tabular format.

<p align="center"><img src="/assets/images/telco/tabular-format.png"></p>

## Requirements and Dependencies

### Frontend Requirements and Dependencies

There are no frontend requirements and dependencies for this feature.

### Backend Requirements and Dependencies

For more information, see [Customer Product Inventory](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/612f26c3d5f14248965ad908cf5952f6.html) in the TUA Help portal.

### Supported Backed Functionality

Customer Product Inventory feature involves mapping between subscriptions and users, covering the customer and billing account. It holds the data around a customer and their subscriptions. For more information, see TUA [Product Catalog](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/552515309dd545e7b7878eb081b56453.html) and [Customer Product Inventory](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/612f26c3d5f14248965ad908cf5952f6.html) in the TUA Help Portal.

|  Entity Exposed for CPI            	 |TM Forum API                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|TmaSubscriptionBase|[GET/subscriptionBase](https://help.sap.com/doc/c280898e0829413d838559088d5e4b5f/2007/en-US/index_TMF_V2.html#_listsubscriptionbase)            |The API displays a list of  retrieves the list of SubscriptionBase resources that a customer has access to            |
|TmaSubscribedProduct          |[GET /product/{productId}](https://help.sap.com/doc/c280898e0829413d838559088d5e4b5f/2007/en-US/index_TMF_V2.html#_productget)            |The API displays details of a subscribed product            |
|TmaSubscriptionUsage          |[GET /usageConsumptionReport](https://help.sap.com/doc/c280898e0829413d838559088d5e4b5f/2007/en-US/index_TMF_V2.html#_usageconsumptionreportfind)| The API requests the calculation of a new usage consumption report for a subscribed product |||

## Configuring and Enabling Customer Product Inventory

In progress.

### Components

In progress.

### Sample Data

In progress.

## Further Reading

Consult the TUA Help Portal for more information on the following topics:

- [TM Forum APIs](https://help.sap.com/viewer/f59b0ac006d746caaa5fb599b4270151/2007/en-US/d46b30b30eca4d4d8ddd20ad833d77f9.html)

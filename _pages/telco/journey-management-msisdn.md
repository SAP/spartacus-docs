---
title: Journey Management - MSISDN (Virtual Mobile Number)
---

**Note:** This feature is introduced in version 1.1.0 of the TUA Spartacus libraries.

## Contents

- [Overview](#overview)
- [Key Personas](#key-personas)
- [Navigation Flow](#navigation-flow)
- [Business Use Cases](#business-use-cases)
- [Requirements and Dependencies](#requirements-and-dependencies)
- [Configuring and Enabling Customer Product Inventory](#configuring-and-enabling-customer-product-inventory)
- [Further Reading](#further-reading)

## Overview

The Journey Management - MSISDN feature enables the customers browsing the TUA for SPA Storefront to select an MSISDN (Virtual Phone Number) from the available MSISDNs, before adding the selected product offering to the cart. Selecting of MSISDN will be mandatory for those product offerings for which a checklist policy as MSISDN is configured at the backend by the Product Manager.

## Key Personas

- Customers
- Product Managers

## Navigation Flow

Content development in progress.

## Business Use Cases

The following use cases are covered as part of the purchase journey:

1. The customer searches and selects a product offering; for example, an acquisition mobile plan, and clicks **Add to Cart** to add the selected product offering to the cat.
2. Based on checklist actions configured at the backend by Product Manager, the screen displays MSISDN (Virtual Mobile Numbers) to the customer.
3. The customer selects the desired MSISDN (Virtual Mobile Number) from the available MSISDNs, before adding the product offering to the cart.
4. The selected product offering (an acquisition mobile plan) is added to the cart.
5. The customer places an order for the product offering.

## Requirements and Dependencies

### Frontend Requirements and Dependencies

Content development in progress.

### Backend Requirements and Dependencies

Content development in progress.

### Supported Backed Functionality

- [Product Catalog](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/552515309dd545e7b7878eb081b56453.html).
- [TUA Data Model for Entities exposed Via TMF and OCC APIs](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/552515309dd545e7b7878eb081b56453.html).
- [TUA Checklist](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/552515309dd545e7b7878eb081b56453.html).

|  Entity Exposed for CPI            	 |TM Forum API                          |Description                         |
|----------------|-------------------------------|-----------------------------|
|TmaSubscriptionBase|[GET/subscriptionBase](https://help.sap.com/doc/c280898e0829413d838559088d5e4b5f/2007/en-US/index_TMF_V2.html#_listsubscriptionbase)            |The API displays a list of  retrieves the list of SubscriptionBase resources that a customer has access to            |
|TmaSubscribedProduct          |[GET /product/{productId}](https://help.sap.com/doc/c280898e0829413d838559088d5e4b5f/2007/en-US/index_TMF_V2.html#_productget)            |The API displays details of a subscribed product            |
|TmaSubscriptionUsage          |[GET /usageConsumptionReport](https://help.sap.com/doc/c280898e0829413d838559088d5e4b5f/2007/en-US/index_TMF_V2.html#_usageconsumptionreportfind)| The API requests the calculation of a new usage consumption report for a subscribed product |||

## Configuring and Enabling Customer Product Inventory

Content development in progress.

### Components

|  Component Name            	 |Status                         |Description                         |
|----------------|-------------------------------|-----------------------------|
|TmaLogicalResourceComponent|New            |Interacts with the mock TMF API to fetch details of logical resource            |
|TmaLogicalResourceDisplayComponent          |New            |Displays the LogicalResource in the **Add to Cart** popup, in the **Cart** page and in the **Order** page          |[GET /usageConsumptionReport](https://help.sap.com/doc/c280898e0829413d838559088d5e4b5f/2007/en-US/index_TMF_V2.html#_usageconsumptionreportfind)| The API requests the calculation of a new usage consumption report for a subscribed product |||

### Sample Data

Content development in progress.

## Further Reading

Consult the TUA Help Portal for more information on the following topics:

- Content development in progress.

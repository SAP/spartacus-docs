---
title: Subscribed Product Inventory
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.2 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

With this feature, Application Clients:

-   Retrieve Subscribed Product Inventory, Billing Account, and Agreement Details for a given customer based on a certain request.
-   View customer’s Subscribed Product Inventory information. The information could be of a particular subscribed product or a given an id, either all available, filtered by a related party or for a given id
-   View Subscribed Product Inventory list on a dedicated page
-   View each element details of the Subscribed Product Inventory list

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Prerequisites

To be updated if required

## Business Need

This feature enables Application Clients to view details about Subscribed Products Inventory, Billing Accounts, and Agreements on a dedicated web application.

## Business Use Case

**Viewing Subscribed Product Inventory**

While browsing the SPA store, customers can either view their Subscribed Product Inventory list or details of a specific subscribed product.

The **Account** menu is updated with the **Selfcare** option, which includes modules such as “Subscriptions”, “Billing Accounts”, “Billing Agreements”. Going forward, the **Selfcare** option will be enhanced further to include more modules.

To view the Subscribed Product Inventory:

1. Log in to the TUA Spartacus.
  
1. Navigate to **Account** -> **Selfcare**. 

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/selfcare-account-dropdown.png"></p>

1. The Selfcare page displays the following modules:

    -   Subscriptions
    -   Billing Accounts
    -   Billing Agreements

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/selfcare-homepg.png"></p>

1. Click **Subscriptions** to view the Subscribed Product Inventory details displayed in a tabular format, which includes Subscription name, status, and ID.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/subscriptions-page.png"></p>

1. Click the required subscription to view more details about it in a separate section that is displayed corresponding to the selected subscription. The section also includes **Billing Account**, **Billing Agreement**, and **Order Number**.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/selected-subscription-detail.png"></p>

1.  All BPO-related subscriptions have a dropdown icon next to it and can be easily identified from other subscriptions.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/bpo-type-subscriptions.png"></p>

1.  Click the required BPO subscription type to view more details. 

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/bpo-type-subscription-detail.png"></p>

1.  Click the required option listed in the section to view more details about it. In this case, click **Child Products** to view more details.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/child-product-details.png"></p>

## Feature Enablement

This feature is enabled to create a dedicated SPA that consumes the APIs provided by a Data Model in order to display all information related to the Subscribed Products Inventory, Billing Accounts, and Agreements. It is enabled through SPA 3.2 on top of Telco 2105.

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 3.2.0                                          	|
| Telco & Utilities Accelerator	             	| Version 2105 (latest patch)            	|
| SAP Commerce Cloud 	| Version 2011 (latest patch) 	|

## Configuring and Enabling Subscribed Product Inventory

To be updated if required.

## Supported Backend Functionality

To be updated if required.

## Components

| Component   Name                 	| Status  	| Description                                                                                                                                                                                                         	|
|----------------------------------	|---------	|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
|        	|      	|                	|
|               	|  	|                                                        	|
|              	|  	|                                                                                                                           	|
|  	|  	| 

## TM Forum APIs

To be updated if required

## Further Reading

For further reading, see the following topics in the TUA Help portal.

- [Customer Product Inventory](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2108/en-US/612f26c3d5f14248965ad908cf5952f6.html)
- [Examples of Customer Product Inventory](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2108/en-US/12f4acbd40164c88a4f09af8dfd89d3e.html)
- [Subscription Page](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2108/en-US/f488da777e9b49c3882eed1b95efd215.html)
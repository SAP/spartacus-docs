---
title: Customer Product Inventory
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.1 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Customers use the Customer Product Inventory (CPI) feature to view their existing subscriptions and subscribed products information.  Customers can manage their subscriptions with proper authorization.  Entries in the Customer Product Inventory are created and updated from backend systems once the product offerings have been provisioned.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Business Use Cases

### Viewing Subscriptions

From the **Account** drop-down menu, click **Subscriptions**. All subscriptions and respective subscribed products are displayed along with the contract start and end dates and status. Depending on user authorization, additional information about each subscribed product can be viewed and managed.

### Usage Consumption

If enabled, consumption information for each subscribed product can be viewed in either grid format, pie chart format or both. 


## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Recipe                                     	| b2c_telco_spa                                          	|
| Minimum version of backend TUA             	| TUA Release 2003 (latest patch is required)           	|
| Minimum   version of core commerce backend 	| SAP Commerce Cloud release 1905 (latest patch is recommended) 	|

## Supported Backend Functionality

The Customer Product Inventory contains all subscription information for a given cugstomer, the mapping between subscriptions and users, as well as the mapping of the customer and billing account.  For more information, see [Customer Product Inventory](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/612f26c3d5f14248965ad908cf5952f6.html) and TUA [Product Catalog](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/552515309dd545e7b7878eb081b56453.html) in the TUA Help Portal.

## Components

The following components must be enabled in the TUA backoffice to appear on the Spartacus TUA storefront:

| Component Name                    	| Status 	| Description                                                                                                                         	|
|-----------------------------------	|--------	|-------------------------------------------------------------------------------------------------------------------------------------	|
| SubscriptionBaseListComponent     	| New    	| Displays all subscription bases Ids of the user                                                                                     	|
| TmfProductComponent               	| New    	| Displays subscribed product details like subscribed product id, start   date, end date, status and action                           	|
| UsageConsumptionGridComponent     	| New    	| Displays usage consumption for subscriptionBase Ids in a grid format                                                                	|
| UsageConsumptionPieChartComponent 	| New    	| Displays usage consumption for subscriptionBase Ids in a Pie chart format   with usage in percentage is also displayed.             	|
| UsageConsumptionHeaderComponent   	| New    	| Displays usage consumption heading and navigation button to navigate to   the subscription list page from subscription details page 	|
| CartItemOneTimeChargeComponent    	| New    	| Displays one time charges for the cart entry                                                                                        	|
| CartItemRecurringChargeComponent  	| New    	| Displays recurring charges for the cart entry                                                                                       	|
| CartItemUsageChargeComponent      	| New    	| Displays usage charges for the cart entry                                                                                           	|

## TM Forum APIs

| Entity Exposed for   CPI 	| TUA API                                    	| Description                                                              	|
|--------------------------	|--------------------------------------------	|--------------------------------------------------------------------------	|
| TmaSubscriptionBase      	| GET /subscriptionBase                      	| Shows a list of of subscription base in the Subscription Details screen  	|
| TmaSubscribedProduct     	| GET/product/{productId}                    	| Shows a list of subscription products in the Subscription Details screen 	|
| TmaSubscriptionAccess    	| GET /subscriptionbase/{subscriptionBaseId} 	| Shows details of subscription base                                       	|
| TmaSubscriptionUsage     	| GET/usageConsumptionReport                 	| Shows the usage consumption for a subscriptionBase Id                    	|

For more information, see [TM Forum APIs](https://help.sap.com/viewer/f59b0ac006d746caaa5fb599b4270151/2007/en-US/d46b30b30eca4d4d8ddd20ad833d77f9.html).

## Further Reading

- [Subscribed Services and Usage](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/ba5f222fb5814829bd74eaf6e6505a9f.html)
- [Making Components Visible](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/2005/en-US/1cea3b2cb3334fc085dda9cc070ad6ac.html)

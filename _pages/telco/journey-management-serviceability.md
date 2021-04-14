---
title: Journey Management - Serviceability (Premise Details)
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.3 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

With this feature, customers are able to purchase Product Offerings that require a serviceability check to validate if the product offering is available for service at a given premise. As part of the purchase flow, customers will need to provide premise details including the premise address and meter id. The serviceability API performs the availability check of the offering at the premise location provided by the customer.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Prerequisites

The system performing the serviceability check for premise details should be up and running (for demonstration purposes, a mock service can be used).

For demonstration purposes, you can perform the following steps to start the mock service:

- Download SOAP UI 5.6.0 (or the version compatible with your Operating System)
- Download the ‘mock_services’ ZIP
- Import the TmuMockService-soapui-project.xml in SOAP UI
- Start the mock service ('Start minimized')
- Once the mock service is up and running, you can demo premise validation feature by using a valid address from the ones defined in the mock

**Important Note:** The mock service is **not recommended** for production environments as it is used exclusively for demonstration purposes only.

## Specific Business Use Case

A company wants to bring a new product offering to market and is rolling-out the product logistically as it requires installation. A customer lands on the storefront and is interested in purchasing this new product offering. The customer clicks the product offering to learn more. The customer wants to see if the product is available for purchase at his home. The customer proceeds to check the availability and provides his premise details including premise address and meter id. A serviceability check is executed to validate the information. 

If successful, the customer needs to indicate whether moving in or switching suppliers. If the customer is moving in, a desired contract start date is needed. If the customer is switching suppliers, the customer will need to provide the name of the previous service provider along with their desired contract start date. Once this is completed, the product offering can be added to the cart. The premise details, contract start date, and previous service provider information can be edited from the cart, and validations will be executed again.

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 1.x, < 2.0                                          	|
| Telco & Utilities Accelerator	             	| Version 2003 (latest patch)            	|
| SAP Commerce Cloud 	| Version 1905 (latest patch) 	|

## Configuring and Enabling Premise Validation

| Configuration             		   | Type: SPA or Backend  | Details                                                                                                                        |
|--------------------------------------|---------|------------------------------------------------------------------------------------------------------------------------------------|
| Define checklist actions for Product Offerings           | Backend | Commodity Product Offerings requiring premise details at the time of purchase should have the checklist actions defined for them in the TUA Commerce platform.                                                                          														  |
| **View details** instead of **Add to cart**	           | SPA     | Adding a new product type for which this button has to be displayed, the product specification has to be part of the configuration list.  	  |
| **Check availability** button in Product Details Page		   | SPA     | Check availability button is displayed for those product types for which the product specification is part of the configuration list (and for those that have the previous checklist actions defined).                                                                                      												  |
| Configure check availability URL       | SPA     | The availability check URL is configured in the corresponding premise lookup `config.ts` file.


-   Define checklist actions for Product Offerings:
    -   Installation Address - Requires the customer to provide the premise address
    -   Meter ID - Requires the customer to provide a gas or electric meter id
    -   Desired Contract Start Date - Requires customers to provide their desired contract start date
    -   Previous Service Provider - Requires the customer to provide the name of the previous service provider

-   **View details** instead of **Add to cart**: Configuration list
 ```typescript
productSpecificationForViewDetails: {
   'electricity',
        'gas'
}
```
-   **Check availability** button in PDP: Configuration list
 ```typescript
productSpecificationForViewDetails: {
   'electricity',
        'gas'
}
```
-   Configure check availability URL: 
 ```typescript
backend: {
        premiseLookup: {
          baseUrl: 'http://localhost:9003',
          prefix: '/premise/v1/'
        }
  }
```

## Components

| Component   Name             		   | Status  | Description                                                                                                                        |
|--------------------------------------|---------|------------------------------------------------------------------------------------------------------------------------------------|
| **Premise Details Components**           | 	     | Display of premise details, desired contract start date, and previous service provider. Also availability checks are accommodated in a set of premise details specific components.                                                                          														  |
| PremiseDetailsComponent	           | New     |  	  |
| PremiseDetailsFormComponent		   | New     |                                                                                      												  |
| PremiseDetailsDisplayComponent       | New     |
| PurchaseReasonComponent              | New	 |
| Contractstartdatecomponent           | New     |
| **Cart Components**		               |     	 | Cart components are updated so that they accommodate display and selection of purchase flow data and actions.                           |
| TmaAddedToCartDialogComponent        | Updated | 			  |
| TmaAddToCartComponent		           | Updated |  	  																	  |
| TmaCartDetailsComponent	           | Updated |    														  |
| TmaCartItemComponent		           | Updated | 																			  |
| TmaCartItemListComponent	           | Updated |    										  |
| TmaMiniCartComponent		           | Updated | 	  |
| **Order Components**			       |	     | 	Order components are updated to accommodate display of premise details including the desired contract start date and previous service provider. Both are stored on the order item.																																  |
| TmaOrderConfirmationItemsComponent   | Updated | 																																	  |
| TmaOrderDetailItemsComponent         | Updated | 																																	  |
| TmaReviewSubmitComponent	           | Updated | 																																	  |
| **Product Components**		           |  | In case the product offering type is part of the corresponding configuration for **View Details** button instead of **Add to Cart** then the customer will be redirected to Product Details Page instead of directly adding to the cart.																																	  |
| TmaProductGridItemComponent          | Updated | 	                                  |
| TmaProductListItemComponent          | Updated | 	  |
| TmaProductSummaryComponent           | Updated | 																																	  |


**Cart Components**

Cart components are updated to accommodate display and selection of purchase flow data and actions such as:

-   Displays additional information stored on cart items:
    -   Installation Address
    -   Meter ID
    -   Desired Contract start date
    -   Previous Service Provider   
-   Additional customer indicators: 
    -   Moving In - Default purchase option for this type of commodity product offering in the cart
    -   Switch supplier - Selection of switch supplier option displays an additional text input field for customers to enter name of the supplier they are switching from
-   Update of premise details for a cart item: Premise details include installation address and meter Id. This information can be updated for each cart item directly from the shopping cart. If the customer decides to update this information, the new premise details will be validated first and then updated for the cart item.

## Further Reading

For further reading, see the following topics in the TUA Help portal.

- [Journey Management](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/39a59f20c92f4a0090c7ef2d007d623c.html).
- [Configuring Checklist Actions](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/c3d274fb74074c70bec9cd6e9686d5a1.html).

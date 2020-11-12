---
title: Premise Validation
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.3 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Contents

- [Overview](#overview)
- [Prerequisite](#prerequisite)
- [Business Use Case](#business-use-case)
- [Frontend and Backend Dependencies](#frontend-and-backend-dependencies)
- [Configuring and Enabling Premise Validation](#configuring-and-enabling-premise-validation)
- [Components](#components)
- [Further Reading](#further-reading)

## Overview
With this feature, customers are able to purchase Product Offerings requiring serviceability check first for premise details (installation address and meter ID). Customers need to provide premise details such as installation address and a meter id. The serviceability API performs the availability check of the offering at the premise provided by the customer.

## Prerequisite

1. System performing the serviceability check for premise details should be up and running (for demo purposes, mock service can be used). 
    -   Starting the mock service (only for demo purposes) 
        -   Download SOAP UI 5.6.0 (or the version compatible with your Operating System)
        -   Download the ‘mock_services’ ZIP
        -   Import the TmuMockService-soapui-project.xml in SOAP UI
        -   Start the mock service ('Start minimized')
        -   Once Mock Service is up and running you can demo premise validation feature by using a valid address from the ones defined in the mock      

**Note:** This mock service is not recommended for production environments as its purpose is exclusively for demo purposes.

## Business Use Case

-   Display view details instead of add to cart in Product Listing Page (PLP) for a specific type of POs:
    -   On PLP, for the customer, the **View details** button will be displayed instead of the  **Add to cart** button
-   Purchase PO requiring availability check starting from Product Details Page:
    -   Customer lands on the PDP page of a PO requiring availability check. The **Availability Check** button is displayed in the PDP page.
    -   When the customer checks for the availability of the PO, the customer is requested to provide the premise details (address and meter ID). In order to have the premise details displayed for the customer, the PO must have the installation address and meter ID checklist actions defined for it.
    -   Availability check is performed against the provided premise details.
    -   Once premise details are provided, which is also displayed in the page, the customer has the option to update them and perform the check again.
    -   Once the premise details are valid, the customer is able to choose the desired purchase option (**Moving** or **Switching Suppliers**). The default option is **Moving**.
    -   **Moving** purchase option enables customer to provide the desired contract start date.
    -   **Switching Suppliers** purchase option enables customer to provide the desired contract change date and the name of the old supplier.
    -   Once the availability of the PO, for the provided premise details, is confirmed, the customer will be able to purchase the PO.


## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| Spartacus libraries, version 1.5                                          	|
| Telco & Utilities Accelerator	             	| Version 2003 (latest patch)            	|
| SAP Commerce 	| Version 1905 (latest patch) 	|

## Configuring and Enabling Premise Validation

| Configuration             		   | Type: SPA or Backend  | Details                                                                                                                        |
|--------------------------------------|---------|------------------------------------------------------------------------------------------------------------------------------------|
| Define checklist actions for POs           | Backend | POs requiring premise details at the time of purchase should have the following checklist actions defined for them in Commerce platform such as Installation Address, Meter ID, Contract Start Date, and Previous Service Provider.                                                                          														  |
| **View details** instead of **Add to cart**	           | SPA     | Adding a new product type for which this button has to be displayed, the product spec has to be part of the following config list.  	  |
| **Check availability** button in PDP		   | SPA     | Check availability button is displayed for those product types for which the product spec is part of the following config list (and for those that have the previous checklist actions defined).                                                                                      												  |
| Configure check availability URL       | SPA     | Availability check URL is configured in the corresponding premise lookup `config.ts` file.


-   **View details** instead of **Add to cart**: Config list
 ```typescript
productSpecificationForViewDetails: {
   'electricity',
        'gas'
}
```
-   **Check availability** button in PDP: Config list
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
| **Premise Details Components**           | 	     | Displays of premise details, contract start date and previous service provider, and also availability checks are accommodated in a set of premise details specific components.                                                                          														  |
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
| **Order Components**			       |	     | 	Order components are updated to accommodate display of premise details, contract start date, and previous service provider stored in an order item.																																  |
| TmaOrderConfirmationItemsComponent   | Updated | 																																	  |
| TmaOrderDetailItemsComponent         | Updated | 																																	  |
| TmaReviewSubmitComponent	           | Updated | 																																	  |
| **Product Components**		           |  | If POs require availability check, product components display **View Details** button instead of **Add To Cart** button that redirects customers to the Product Details Page.																																	  |
| TmaProductGridItemComponent          | Updated | 	                                  |
| TmaProductListItemComponent          | Updated | 	  |
| TmaProductSummaryComponent           | Updated | 																																	  |


**Cart Components**

Cart components are updated to accommodate display and selection of purchase flow data and actions such as:

-   Displays additional information stored on cart items:
    -   Contract start date
    -   Old supplier name
    -   Installation address
    -   Meter ID
-   Option for customers to select within desired actions:
    -   Moving in: This is the default purchase option of any of the commodity items in the cart.
    -   Switch supplier: Selection of switch supplier option displays an input field where customers can provide the old supplier name.
-   Updates premise details for a cart item: Installation address and meter ID can be updated for each cart item directly from shopping cart. Once the customer opts in for updating them, the new premise details are first validated and then updated for the cart item.

## Further Reading

For further reading, see the following topics in the TUA Help portal.

- [Journey Management](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/39a59f20c92f4a0090c7ef2d007d623c.html).
- [Configuring Checklist Actions](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/c3d274fb74074c70bec9cd6e9686d5a1.html).

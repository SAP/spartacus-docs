---
title: Premise Validation with Meter ID
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
- [Configuring and Enabling the Appointment in TUA](#configuring-and-enabling-the-appointment-in-tua)
- [Components](#components)
- [TM Forum APIs](#tm-forum-apis)
- [Further Reading](#further-reading)

## Overview
With this feature, customers purchase the required Product Offerings for which they need to check their availability of the POs at a specific location. Customers need to provide premise details such as installation address and a meter id. The serviceability API performs the availability check of the offering at the premise provided by the customer.


## Prerequisite

To test this feature using a mock service, please follow the set-up instructions below for soapUI:

1. 
2. 
3. 
4. 
5. 

## Business Use Case

A 



## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Recipe                                     	| b2c_telco_spa                                          	|
| Minimum version of backend TUA             	| TUA Release 2003 (latest patch is required)           	|
| Minimum   version of core commerce backend 	| SAP Commerce release 1905 (latest patch is recommended) 	|

## Configuring and Enabling Premise Validation

To be updated

## Components

| Component   Name             		   | Status  | Description                                                                                                                        |
|--------------------------------------|---------|------------------------------------------------------------------------------------------------------------------------------------|
| Premise Details Components           | 	     | Display of premise details, contract start date and previous service provider, and also availability checks are accommodated in a set of premise details specific components.                                                                          														  |
| PremiseDetailsComponent	           | New     |  	  |
| PremiseDetailsFormComponent		   | New     |                                                                                      												  |
| PremiseDetailsDisplayComponent       | New     |
| PurchaseReasonComponent              | New	 |
| Contractstartdatecomponent           | New     |
| Cart Components		               |     	 |                           |
| TmaAddedToCartDialogComponent        | Updated | Cart components are updated so that they accommodate display and selection of purchase flow data and actions such as:			  |
| TmaAddToCartComponent		           | Updated | • Display of additional information stored on cart items: 	  																	  |
| TmaCartDetailsComponent	           | Updated |    • Contract start date, Old supplier name, Installation address, Meter ID.														  |
| TmaCartItemComponent		           | Updated | • Option for customers to select within desired actions																			  |
| TmaCartItemListComponent	           | Updated |    • Moving in: This is the default purchase option of any of the commodity items in cart.										  |
| TmaMiniCartComponent		           | Updated | 	  • Switch supplier: Selection of switch supplier option displays an input field where customers can provide the old supplier name|
| 							           |		 | •	Update of premise details for a cart item: Installation address and meter ID can be updated for each cart item directly from shopping cart. Once the customer opts in for updating them, the new premise details are first validated and then updated for the cart item.																																	  |
| Order Components			           |	     | 	Order components are updated to accommodate display of premise details, contract start date, and previous service provider stored on an order item.																																  |
| TmaOrderConfirmationItemsComponent   | Updated | 																																	  |
| TmaOrderDetailItemsComponent         | Updated | 																																	  |
| TmaReviewSubmitComponent	           | Updated | 																																	  |
| Product Components		           |  | 																																	  |
| TmaProductGridItemComponent          | Updated | 	If POs require availability check, product components display the following:                                  |
| TmaProductListItemComponent          | Updated | 	'View Details' button instead of 'Add To Cart' button which redirects customers to Product Details Page  |
| TmaProductSummaryComponent           | Updated | 																																	  |



## TM Forum APIs

| API Name          	| API Endpoint                         	| Description                                                                                                                                                                                	|
|--------------------------------------	|----------------------------------	|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
| Tmf Resources#TMF-ChecklistActionAPI 	| /checklistAction                 	| Shows applicable list of checklist policies   for product offering                                                                                                                         	|
| TMF-646   (version 2.0.0)            	| POST appointment/searchTimeSlot  	| This operation creates a search time slot   entity. According to a set of criteria, it is used to retrieve available time   slots that are used after to book or reschedule an appointment 	|
| TMF-646   (version 2.0.0)            	| POST /appointment                	| Creates appointment for the customer                                                                                                                                                       	|
| TMF-646   (version 2.0.0)            	| GET /appointment/{id}            	| Fetches the  appointment details of a   customer                                                                                                                                           	|
| TMF-646   (version 2.0.0)            	| PATCH /appointment/{id}          	| Updates the appointment details of a customer                                                                                                                                              	|

For more information, see [TM Forum APIs](https://help.sap.com/viewer/f59b0ac006d746caaa5fb599b4270151/2007/en-US/d46b30b30eca4d4d8ddd20ad833d77f9.html).

## Further Reading

For further reading, see the following topics in the TUA Help portal.

- [Journey Checklist](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/39a59f20c92f4a0090c7ef2d007d623c.html).
- [Journey Checklist Policy Configurations](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/c3d274fb74074c70bec9cd6e9686d5a1.html).

---
title: Journey Management - Serviceability Check of a Product Offering (SPO)
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.0 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

The Journey Management - Serviceability Check of a Product Offering (SPO) feature provides the ability for a logged in (registered) customer to upfront verify if a selected simple product offering is serviceable (available) at the provided address or not, so that the customers can place orders for only those product offerings, which can be serviced at the provided address.

This feature takes into consideration the journey checklist policy for serviceability check, so that when the customer places an order for the product offering that requires serviceability check, the journey checklist policy validates the provided address to confirm if the selected product offering can be serviceable at the provided address or not.

## Prerequisites

The system performing the serviceability check of the provided installation address should be up and running (for demonstration purposes, a mock service can be used).

To start the mock service:
1. Download SOAP UI 5.6.0 (or the version compatible with your Operating System)
2. Download the 'mock_services' ZIP
3. Import the 'TmuMockService-soapui-project.xml' in SOAP UI
4. Start the mock service ('Start minimized')
5. When the mock service is up and running, you can demo the feature.

**Important:** The mock service is not recommended for production environments, but can be exclusively used for demonstration purposes only.

## Business Need

Earlier, when the customer added a product offering to the cart, and if the product offering required a serviceability check, the "Place Order" process only verified if the installation address is provided or not, instead of additionally verifying if the product offering is serviceable at the customer-provided address or not.

With this feature, in the SPA Storefront, when you add a product offering to the cart and as part of the checklist policy, if it requires installation address then then serviceability check is performed on the provided address. If the product offering is not serviceable at the provided address, then the product is not added to the cart. Hence, customer upfront knows if the product offering that they intend to buy can be serviceable at the provided address or not.

## Business Use Cases

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-7zrl{text-align:left;vertical-align:bottom}
.tg .tg-0lax{text-align:left;vertical-align:top}
</style>
<table class="tg">
<thead>
  <tr>
    <th class="tg-7zrl"><span style="font-weight:bold">Use Case</span></th>
    <th class="tg-7zrl"><span style="font-weight:bold">Steps</span></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-0lax">A customer wants to purchase 5G Internet plan from the address at which the product offering is serviceable</td>
    <td class="tg-0lax">1. Log in to the TUA  Spartacus.<br>2. Go to the <span style="font-style:italic">Broadband Category</span> page. The banner displays the new <span style="font-weight:bold">CHECK AVAILABILITY</span> button.<br>3. Click <span style="font-weight:bold">CHECK AVAILABILITY </span>on the banner to check availability of 5G in your area.<br>4. Type your postal address, with post code as 94121.   <br>5. Click <span style="font-weight:bold">Next</span>. The following screen confirms that the 5G Internet plan is available in the address and at the postal code you have provided in the <span style="font-style:italic">Check Availability</span> screen.<br>6. Click <span style="font-weight:bold">Add to Cart</span> to proceed. </td>
  </tr>
  <tr>
    <td class="tg-0lax">A customer wants to purchase 5G Internet plan from the address at which the product offering is not serviceable</td>
    <td class="tg-0lax">1. Log in to the TUA Spartacus.<br>2. Go to the <span style="font-style:italic">Broadband Category</span> page. The banner displays the new <span style="font-weight:bold">CHECK AVAILABILITY</span> button.  <br>3. Click <span style="font-weight:bold">CHECK AVAILABILITY</span> on the banner to check availability of 5G in your area.<br>4. Type your postal address, with post code as 94120.   <br>5. Click <span style="font-weight:bold">Next</span>. The following screen displays <span style="font-style:italic">The service is currently unavailable in the selected area for 5g Home Internet</span>. information message.</td>
  </tr>
</tbody>
</table>

## Feature Enablement

This feature is enabled via banner, as well as on the **Add to Cart** component for other product offerings, which require a serviceability check as per the journey checklist configuration.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/banner.png"></p>

 When you click **CHECK AVAILABILITY** button on the banner, the *Check Availability* screen is displayed to validate the provided site address:

 <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/check-availability.png"></p>
 
 If the selected product offering is serviceable at the provided site address, the following screen is displayed to confirm that the site address can be serviced.

 <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/availability-successful.png"></p> 

If the selected product offering is not serviceable at the provided site address, an information message is displayed that the selected product offering is not serviceable at the provided address.

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 1.x, 1.2x, < 3.0                                          	|
| Telco & Utilities Accelerator	             	| Version 2102 (latest patch)            	|
| SAP Commerce Cloud 	| Version 2011 (latest patch) 	|

## Configuring and Enabling Serviceability Check

For detailed information about configuring and enabling serviceability check, see [Configuring Checklist Actions](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/latest/en-US/c3d274fb74074c70bec9cd6e9686d5a1.html).

## Components

| Component   Name 	| Status 	| Description 	|
|-	|-	|-	|
| ServiceabilityFormComponent 	| New 	| This component wraps   the 'TmaAddressFormComponent' . The Check Availability button   performs serviceability check of the product offering. If the product   offering is serviceable at provided installation address then the   product details dialog component is rendered, else an error message is   displayed. 	|
| ServiceabilityBannerComponent 	| New 	| This component configures the   Telco & Utilties Storefront Banner and renders the banner image, product   (SPO and BPO), and the button's label information, which is configured in the   backend. 	|
| ProductDetailsDialogComponent 	| New 	| This component shows the product   details with the 'Add to Cart' button when the serviceability check is   successful. When the product offering added is successful, it redirects to   the cart page. 	|
| AddToCartServiceabilityComponent 	| New 	| This component adds the product   offering to the cart with the installation address provided by the customer,   with the default appointment (for example, CALL_TO_SCHEDULE option) if the   checklist action for Appointment is enabled. 	|
| JourneyChecklistStepComponent 	| Updated 	| This component is updated to   include serviceability check that is performed while adding  the   installation address. If the selected product offering is not serviceable,   and error message will be displayed. If the selected product offering is   serviceable, the installation address is saved in the system, and the   customer can navigate to the next step, which can be either add the selected   product offering to the cart or select an appointment. 	|
| TmaAddToCartComponent 	| Updated 	| This component now includes the   the name of the product offering and the installation area code in the   product attribute of type map. 	|
| TmaGuidedSellingCurrentSelectionComponent 	| Updated 	| This component now includes the   the name of the product offering and area code in the product attribute of   type map. 	|
| JourneyChecklistInstallationAddressComponent 	| Updated 	| This component is updated to   pick up the values from the local storage instead of adding the installation   address. 	|
| TmaAddressFormComponent 	| Updated 	| This component has updated the   input page by adding 'hasError'. 	|

## TM Forum APIs

| End Points 	| TMF API 	| Description 	|
|-	|-	|-	|
| GET /checklistAction 	| None 	| Shows applicable list of checklist policies for a product offering 	|
| GET   /productOfferingQualificationManagement /productOfferingQualification / 	| TMF-679 	| A mock SoapUI is exposed to   achieve the serviceability check. When the customer types the postal code   number in the 'Check Availability' screen, the mock data is returned. 	|
| POST
/productOrdering/productOrder 	| TMF620 	| Creates a product order entity and triggers the place order process. 	|
| POST
/{baseSiteId}/users/{userId}/orders 	| TMF620 	| Performs the checklist action before placing the order; that is, if a product offering is required to provide the installation address then before placing the order, it verifies if the installation address is provided for the product offering or not. 	|

## Further Reading

For further reading, see the following topics in the TUA Help portal.

- [Customer Product Inventory and Cart](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/latest/en-US/552515309dd545e7b7878eb081b56453.html).

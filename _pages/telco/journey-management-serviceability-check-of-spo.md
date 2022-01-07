---
title: Journey Management - Serviceability
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.0 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The feature enables customers to confirm the availability (serviceability) of product offerings at the specified address before placing an order, so that customers can place orders only for product offerings that are available (serviceable) at the specified address. The feature enhances customer experience as the customers can compare different product offerings, which are available at the specified address before placing an order.

To effectively filter the product offerings based on the address that includes the postal code specified by the customer, this feature implements the [Serviceabiity Checklist](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/latest/en-US/f17d331d62164ae686f2d4fdb437e9c4.html).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Prerequisites

The system performing the serviceability check of the specified installation address should be up and running (for demonstration purposes, a mock service can be used).

To start the mock service:
1. Download SOAP UI 5.6.0 (or the version compatible with your Operating System)
2. Download the 'mock_services' ZIP
3. Import the 'TmuMockService-soapui-project.xml' in SOAP UI
4. Start the mock service ('Start minimized')
5. When the mock service is up and running, you can demo the feature.

**Important:** The mock service is not recommended for production environments, but can be exclusively used for demonstration purposes only.

## Business Need

In the TUA Spartacus storefront, a new **CHECK AVAILABILITY** button is provided on the advertisement banner and in the broadband category page. The feature enables the customers to upfront confirm if the product offering is serviceable (available) at the specified address or not, before placing an order.

## Business Scenarios

For refer different Business Scenarios, see [Serviceabiity Checklist](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/latest/en-US/f17d331d62164ae686f2d4fdb437e9c4.html).

## Feature Enablement

This feature is enabled on the advertisement banner, by providing the **CHECK AVAILABILITY** button to check the availability of the single or multiple product offerings, which require a serviceability check as per the journey checklist configuration.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/banner.png" alt="Banner"></p>

 When you click **CHECK AVAILABILITY** button on the banner, the *Check Availability* screen is displayed to validate the provided site address:

 <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/check-availability.png" alt="Check Availability"></p>
 
 If the selected product offering is serviceable at the provided site address, the following screen is displayed to confirm that the site address can be serviced.

 <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/availability-successful.png" alt="Availability Successful"></p>

If the selected product offering is not serviceable at the provided site address, an information message: *The selected product offering is currently unavailable at the provided address. Please provide a different address to proceed*  is displayed.

To check the serviceability (availability) of a single or multiple product offerings at a specified address, click the **BROADBAND** menu and then click the **CHANGE ADDRESS** button.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/change-address.png" alt="Change Address Button"></p>

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 1.x, 1.2x, < 3.0                                          	|
| Telco & Utilities Accelerator	             	| Version 2102 (latest patch)            	|
| SAP Commerce Cloud 	| Version 2011 (latest patch) 	|

## Configuring and Enabling Serviceability Check

For detailed information about configuring and enabling serviceability check, see [Configuring Checklist Actions](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/latest/en-US/f17d331d62164ae686f2d4fdb437e9c4.html).

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

For further reading, see [Serviceability Checklist](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/latest/en-US/f17d331d62164ae686f2d4fdb437e9c4.html) in the TUA Help portal.

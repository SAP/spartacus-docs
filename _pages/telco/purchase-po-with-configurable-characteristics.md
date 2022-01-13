---
title: Purchase PO with Configurable Characteristics
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.2.0 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

This feature provides the ability for service providers to sell products that are more complex in nature. These products have a significant number of product specification characteristics with a number product specification characteristic values that can be configurable or static; and can also have dependencies between them.

Online customers can purchase such complex offerings standalone or within a bundle through configurable guided selling. By viewing the details of the product offering, customers can select the required purchase options that are assigned to the offerings, which may or may not have an impact on the final price.

While this feature is applicable for both B2C and B2B, the feature has been set-up for the B2B telco storefront. These complex product offerings can be purchased from the Product Details Page (PDP) page or through Configurable Guided Selling.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Business Need

The feature enables customer to visualize the entire list of characteristics for a product offering; not only the ones having a static or fixed assignment. For characteristics that have a configurable assignment, the customer can select their options and/or provide the corresponding value(s) to build the product to meet their specific needs. As the customer selects their options, the price as well as other options may be impacted.

Product offerings are offered to end customers in various contexts and are defined by respecting the definition of a specific type of product. For example, a GSM product offering is defined by respecting the characteristics of a GSM product.  A common set of characteristics for a GSM product offering is represented by the number of minutes, SMS, and data volume that is included in the offer and are considered static characteristics.

In this same example, there may also be some options that the customer may need to choose.  There may be an option for a customer to enter a special or favorite phone number when purchasing a new GSM postpaid offer.  At the product definition level, the favorite phone number is defined as a configurable characteristic of the product offering.  The product definition can support multiple configurable characteristics as well as mandatory characteristics.

In the B2B context, commercial product offerings are more intricate.  The number of configurable characteristics is considerably higher than B2C offers.

For configurable options:

-   A list of values may be provided for single selection or multiple selection
-   Customer input defined as:
    -   Free text input
    -   Numeric input
    -   Date input
-   Decision (TRUE/FALSE)

## Business Use Case

**A B2B customer would like to purchase a Satellite Service product offering requiring several configuration options and input**

**Satellite Service Definition**

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/satellite-service-example.png" alt="Satellite Service"></p>

The above image represents a Satellite Service product offering that has the following product specification characteristics and values assigned:

-   Static assignment of product specification characteristics:
    -   **Terminal Type**: The PO has the terminal type 'Portable'
    -   **Installation Type**: The installation type is 'Self Installation'
-   Configurable assignment of product specification characteristics:
    -   **Start Date**: Optional characteristic. Customer can provide a (service) start date during the purchase flow.
    -   **IP Address**: Mandatory characteristic. The value must be provided during the purchase flow.
    -   **Connected via**: Mandatory characteristic. Connectivity info must be provided during the purchase flow.  Customer can select up to 2 connectivity locations as per the product definition.
    -   **DHCP**: Customer is able to choose if he wants DHCP (TRUE/ FALSE)

## Feature Enablement

This feature is enabled through the B2B Telco SPA Store. It is implemented on top of TM Forum and OCC APIs of the SAP Telco & Utilities Accelerator (2105 version).

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 3.2.0                                          	|
| Telco & Utilities Accelerator	             	| Version 2105 (latest patch - 21.02)            	|
| SAP Commerce Cloud 	| Version 2011 (latest patch) 	|

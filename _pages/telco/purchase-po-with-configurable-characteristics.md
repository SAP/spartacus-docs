---
title: Purchase PO with Configurable Characteristics
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.2.0 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

A complex offering is a Product Offering (PO) with a significant number of Product Specification Characteristic (PSC) and Product Specification Characteristic Values (PSCVs), configurable or static, also with dependencies between them. These POs need to be purchased in B2B SPA from the Product Details Page (PDP) page or through Configurable Guided Selling.

Customers can purchase complex offerings, standalone or within a bundle, by viewing the details of the offerings and then select the required purchase options that are assigned to these offerings. Customers use this feature when they need to view product offering details or purchase offerings, either SPO or BPO.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Business Need

The feature enables customer to visualize the entire list of characteristics, not only the ones having a static assignment. For characteristics that have a configurable assignment to the PO, the customer can select and/or provide the corresponding value(s).

Commercial offers, (product offerings) are offered to end customers in various contexts, are defined by respecting the definition of a specific type of product. For instance, a GSM product offering is defined by respecting the characteristics of a GSM product. A common set of characteristics of a GSM voice offer is represented by the number of minutes, SMS, and data volume that are included in the offer. These are the static characteristics that define an offer.

Some characteristics are not necessarily static. Considering the GSM offer example, the 'favourite number' might be provided by the customer as input when purchasing a new GSM postpaid offer. At the product definition level, the 'favourite number' is defined as a configurable characteristic of the product offering (PO). It is also possible to have multiple other characteristics where the customer needs to provide and/or select the value while purchasing. Some values might be mandatory where the customer can proceed with purchasing the offer by providing only the value for those mandatory characteristics.

In the B2B context, commercial offers that are offered to B2B customers are much more complex. In such case, the number of configurable characteristics is considerably higher than the context of B2C offers. Though it is not necessarily a rule, the number of configurable characteristics, sometimes, depends on the industry itself.

This feature enables customers to purchase those POs having configurable characteristics by visualizing the list of configurable characteristics and provide or select the value for those where the value type is either of the following: 

-   Text input
-   Numeric input
-   Date input
-   Selection of values: Simple selection or multiple selection   
-   Decision (TRUE/FALSE)

## Business Use Case

**Purchase of a Satellite Service PO having characteristics for which customer has to provide input**

The following use case is about how a customer benefits from this feature in the context where a PO has multiple configurable characteristics.

**Satellite Service Definition**

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/satellite-service-example.png" alt="Satellite Service"></p>

The above image is of a Satellite Service PO that has the following PSCs and PSCVs assigned:

-   Static assignment of PSCs:
    -   **Terminal Type**: the PO has the terminal type 'Portable'
    -   **Installation Type**: the installation type is 'Self Installation'
-   Configurable assignment of PSCs:
    -   **Start Date**: start date is an optional characteristic, customer being able to provide it at purchase time
    -   **IP Address**: IP address is a mandatory characteristic and the value has to be provide by customer at purchase time
    -   **Connected via**: connectivity info must be provided at purchase time. Customer is able to select up to 2 connectivity locations as per the definition above
    -   **DHCP**: customer is able to choose if he wants DHCP or not (TRUE/ FALSE)


## Feature Enablement

This feature is enabled through the B2B Telco SPA Store. It is implemented on top of TM Forum and OCC APIs of the SAP Telco & Utilities Accelerator (2105 version).

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 3.2.0                                          	|
| Telco & Utilities Accelerator	             	| Version 2105 (latest patch - 21.02)            	|
| SAP Commerce Cloud 	| Version 2011 (latest patch) 	|

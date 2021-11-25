---
title: Purchase POs with Configurable Characteristics
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.2.0 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

A complex offering is a Product Offering (PO) with a significant number of Product Specification Characteristic Values (PSCs) and Product Specification Characteristic Values (PSCVs), configurable or static, also with dependencies between them. These POs need to be purchased in B2B SPA from the Product Details Page (PDP) page or through Configurable Guided Selling.

Customers can purchase complex offerings, standalone or within a bundle, by viewing the details of the offerings and then select the required purchase options that are assigned to these offerings. Customers use this feature to when they need to view PO details or purchase offerings, either SPO or BPO.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Prerequisites

To be updated

## Business Need

The feature allows customers to purchase offerings for which they need to select the desired characteristics.

## Business Use Case

**Static and Configurable Characteristics - Examples**

**Static PSCVU**

For products that are attached by characteristics to POs through those entities’ PSCVUs, it allows the Product Manager to define the minimum and maximum number of values that need to be selected or provided for that characteristic plus other values.

If PSCVUs where the minimum and maximum cardinality and the number of values is equal, then it refers to the static characteristic. The characteristic remains the same irrespective of the purchase of the Product Offering, and therefore it is the static characteristic.

In the following image, **Connect_100** has four characteristics with one value wherein the minimum and maximum will be equal to one as there is only one PSCV.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/static-pscvu.png" alt="Static PSCVU"></p>

**Configurable PSCVU**

If PSCVs assigned to a Product Offering has differences in minimum and maximum cardinality and number of values, then it refers to the configurable characteristic. In this case, the input and selection for those PSCVs needs to be provided by either the customer or from an external system.

An example of a configurable characteristic is where we have a list of values such as coverage areas, and the customer needs to select at least one but maximum two from four values.

For **Input Types**, there can be multiple selections, a list of values where the customer can select up to maximum cardinality, simple or single selection where the maximum cardinality is one and the customer is not able to select multiple values more than one, and there can also be Boolean text, number or date that the customer needs to select from. The Product Manager defines the PSCVs that are linked to a Product Offering.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/configurable=pscvu.png" alt="Configurable PSCVU"></p>

## Feature Enablement

This feature is enabled through the B2B Telco SPA Store. It is implemented on top of TM Forum and OCC APIs of the SAP Telco & Utilities Accelerator (2105 version).

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 3.2.0                                          	|
| Telco & Utilities Accelerator	             	| Version 2105 (latest patch - 21.02)            	|
| SAP Commerce Cloud 	| Version 2011 (latest patch) 	|

## Configuring and Enabling Purchase of POs

To be updated.

## Supported Backend Functionality

To be updated

## Components

The following components must be enabled in the TUA Backoffice to appear on the Spartacus TUA storefront:

| Component   Name                 	| Status  	| Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 	|
|----------------------------------	|---------	|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
|        	|      	|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         	|
|  	| New     	|  	|
|       	| New     	|  |
|               	| Updated 	|  |

## Further Reading

For further reading, see the following topics in the TUA Help portal.


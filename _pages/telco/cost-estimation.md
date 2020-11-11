---
title: Cost Estimation
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.3 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Contents

- [Overview](#overview)
- [Prerequisite](#prerequisite)
- [Business Use Case](#business-use-case)
- [Frontend Requirements and Dependencies](#frontend-requirements-and-dependencies)
- [Configuring and Enabling Cost Estimation](#configuring-and-enabling-cost-estimation)
- [Components](#components)
- [TM Forum APIs](#tm-forum-apis)

## Overview

Customers search for Product Offerings by the provided consumption, and for PO details, they have the estimated average cost in case the POs have the POP defined for 1 single usage unit.

Customers, who are interested in acquiring product offerings (such as commodity items - electricity, gas etc.) that need an availability check against the premise details (such as installation address and meter id), are able to purchase the corresponding POs by providing the premise details at the time of purchase.

For this, customers go to product catalog, search for product offerings that require availability check, view the product offering details and purchase it by providing the premise details.

## Prerequisite

To test this feature using a mock service, please follow the set-up instructions below for soapUI:

1. To be updated
2. ...
3. ...
4. ...
5. ...

## Business Use Case

To be updated.

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| To be updated                                     	| To be updated                                          	|
| To be updated             	| To be updated           	|
| To be updated 	| To be updated 	|

## Configuring and Enabling Cost Estimation

| Configuration             | Type: SPA or Backend  | Details                                                                                                                        |
|--------------------------------------|---------|------------------------------------------------------------------------------------------------------------------------------------|
| **Consumption Components**           |         | Renders display of discover by consumption CMS components.                                                                                   |
| TmaConsumptionComponent              | New     |                                                                           |
| TmaConsumptionDialogComponent        | New        |                                                                                     |
| TmaPoSearchByConsumptionComponent    | New     |                                         |
| TmaSliderOptionComponent             | New     |   |
| **Product Components**               |         | Product components are updated to display the average cost for a set of configured POs (by their type). If a PO has charge prices defined for more than 1 usage unit, the average cost is not displayed.  |
| TmaProductDetailsTabComponent        | Updated |                           |
| TmaProductGridItemComponent          | Updated |                           |

## Components

The following new and updated components must be enabled in the TUA backoffice to appear on the Spartacus TUA storefront:

| Component   Name             | Status  | Description                                                                                                                        |
|--------------------------------------|---------|------------------------------------------------------------------------------------------------------------------------------------|
| **Consumption Components**           |         | Renders display of discover by consumption CMS components.                                                                                   |
| TmaConsumptionComponent              | New     |                                                                           |
| TmaConsumptionDialogComponent        | New        |                                                                                     |
| TmaPoSearchByConsumptionComponent    | New     |                                         |
| TmaSliderOptionComponent             | New     |   |
| **Product Components**               |         | Product components are updated to display the average cost for a set of configured POs (by their type). If a PO has charge prices defined for more than 1 usage unit, the average cost is not displayed.  |
| TmaProductDetailsTabComponent        | Updated |                           |
| TmaProductGridItemComponent          | Updated |                           |
| TmaProductListComponent              | Updated |                           |
| TmaProductListItemComponent          | Updated |                           |
| TmaProductSummaryComponent           | Updated |                           |

## TM Forum APIs

To be updated


For more information, see [TM Forum APIs](https://help.sap.com/viewer/f59b0ac006d746caaa5fb599b4270151/2007/en-US/d46b30b30eca4d4d8ddd20ad833d77f9.html).


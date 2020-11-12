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
- [Frontend and Backend Dependencies](#frontend-and-backend-dependencies)
- [Configuring and Enabling Cost Estimation](#configuring-and-enabling-cost-estimation)
- [Components](#components)
- [Further Reading](#further-reading)

## Overview

Customers interested in purchasing goods or services are able to search for Product Offerings by providing their yearly consumption. Every PO in the result has the estimated average cost displayed in case the POs have the prices defined for maximum 1 usage unit (such as kWh, cubic meter and so on). Entire price information for the PO is also displayed.

Customers are also able to view the average cost and detailed price information in Product Details Page for a specific set of offers (configured to display the average cost).

This feature determines and displays the average cost for a PO considering the provided yearly consumption, and also displays the detailed price information.

**Average cost** for a PO is determined using the following algorithm:

**Average cost / year = PayNowPrices + YearlyRecurringCharges + (YearlyConsumption – YearlyIncluded) * UsageCharges**

<p align="center"><img src="/assets/images/telco/average-cost-algorithm.png"></p>

**Note:**

1. Average cost is determined using the algorithm presented in the previous picture, and it works with simple price information (such as one-time charges, recurring charges, and usage charges) for which the price has a fixed value and not a complex price formula.

2. Average cost is determined for those POs having prices defined for maximum 1 usage unit. In case the POs have prices defined for more than 1 usage unit (as seen in the sample below), the average cost cannot be properly determined, case in which it will not be displayed.

<p align="center"><img src="/assets/images/telco/average-cost-algorithm_2.png"></p>

Following are the detailed price information:

  - Contract duration
  - Cancellation fees
  - One-time fees
  - Recurring charges
  - Usage charges

## Prerequisite

1. Product offerings for which the average cost has to be displayed MUST have prices defined for maximum 1 usage unit (kWh, minutes, sms).
2. CMS components are properly defined in CMS system (for SAP Commerce, it is in content catalog).

## Business Use Case

- Discovery of product offerings by type and provided consumption:
    - In the homepage, customer is able to search for POs by selecting or providing yearly consumption (at the moment for electricity or gas POs but any type if PO can be configured in the CMS components)
    - A list of slider options are available for selecting the desired yearly consumption, or it can be manually provided.
    - List of POs provided in the search results page display the following:
        - Average cost calculated using the provided consumption (if the customer could not provide value for consumption, the default value will be used)
        - Option to view detailed prices
        - Option to view details of the PO
    - On the results listing page, customer is able to update the consumption and view the average cost corresponding to the newly provided input.
    - On the Product Details Page, in one of the POs in the results page, customer is also able to view the average cost for the provided consumption, view the detailed price information, and also update the consumption.
- Landing on a category page of POs for which average cost and detailed prices should be displayed.
    - Landing on a category page, listing POs for which average cost and detailed price information has to be displayed (such as electricity and gas), the following information is available for each of the PO listed:
        - Average cost calculated using the provided value of the consumption (if the customer could not provide value for consumption, the default value will be used)
        - Option to view detailed prices
        - Option to view details of the PO

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 1.5                                          	|
| Telco & Utilities Accelerator             	| Version 2003 (latest patch)           	|
| SAP Commerce 	| Version 1905 (latest patch) 	|

## Configuring and Enabling Cost Estimation

| Configuration             | Type: SPA or Backend  | Details                                                                                                                        |
|--------------------------------------|---------|------------------------------------------------------------------------------------------------------------------------------------|
| Define discover by consumption CMS components           | Backend (CMS) | Define corresponding discovery by consumption CMS components such as Consumption components and Slider option components.                                                                                   |
| Configure default consumption values for PO types and usage units              | SPA     | Customer consumption preferences are saved in `localStorage`. If customer is visiting the website for the first time or `localStorage` is emptied, default values are used that can be configured. In case the customer has provided a preferred consumption through the Consumption Component, it will be saved in the `localStorage` and that value will be used to calculate average cost.                                                                            |


-   Configure default consumption values for PO types and usage units: Consumption values are stored based on the product specification of the product offering and the `usageUnit` in the following format:

    ```sql
    consumption_<productSpecification>_<usage_Unit> : <value>
    ```

Example:

```typescript
consumption: {

    defaultValues: [

        { productSpecification: <string>, usageUnit: <string>, value: <string>},

        ...

        { productSpecification: <string>, usageUnit: <string>, value: <string>}

    ],

    default: <string>

}
```

## Components

The following new and updated components must be enabled in the TUA backoffice to appear on the Spartacus TUA storefront:

| Component   Name             | Status  | Description                                                                                                                        |
|--------------------------------------|---------|------------------------------------------------------------------------------------------------------------------------------------|
| **Consumption Components**           |         | Renders display of discovery by consumption CMS components.                                                                                   |
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

## Further Reading

For more information, see [TUA Pricing](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/ad4430d10fc3477096752d83f935faf9.html).


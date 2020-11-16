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
- [CMS Component Configuration for Anticipated Consumption](#cms-component-configuration-for-anticipated-consumption)
- [Components](#components)
- [Further Reading](#further-reading)

## Overview

This feature determines and displays the average cost for a product offering considering the provided yearly consumption entered by a customer. 

Certain types of product offerings (that is commodity products - electricity and gas) are charged by consumption.  In order for the customers to get an idea of how much these type of product offerings could potentially cost them on a monthly or yearly basis, customers need to provide additional information regarding their anticipated usage. Once the customer enters their anticipated annual consumption information, the search result list of all applicable product offerings are displayed.

Customers are able to view the average cost that each of the product offerings would cost them based on their anticipated usage. Additional pricing-related information for each product offering is available by expanding the offering. The products shown in the search result list must be properly configured for this scenario and have prices defined for maximum 1 usage unit (such as kWh, cubic meter and so on). The **Average Cost** for a product offering is determined using the following algorithm:

**Average Cost / Year = PayNowPrices + YearlyRecurringCharges + (YearlyConsumption – YearlyIncluded) * UsageCharges**

<p align="center"><img src="/assets/images/telco/average-cost-algorithm.png"></p>

**IMPORTANT NOTES:**

1. Average cost is determined using the algorithm presented in the above illustration. The calculation works with simple price information, such as one-time charges, recurring charges and usage charges, for which the price has a fixed value and not a complex price formula.

2. Average cost is determined for those product offerings that have prices defined **for a maximum of 1 usage unit**. In case the product offering has prices defined for more than 1 usage unit, the average cost cannot be properly determined, case in which it will not be displayed. Please see the following illustration.

<p align="center"><img src="/assets/images/telco/average-cost-algorithm_2.png"></p>


## Prerequisite

1. Product offerings for which the average cost has to be calculated and displayed must have prices defined for maximum 1 usage unit (kWh, minutes, sms and so on).
2. CMS components must be properly defined in the CMS system (in our case in SAP Commerce, in the content catalog).

## Business Use Case

**Use Case 1:   Discover product offerings by consumption from homepage**

Customer lands on the homepage and is able to search for product offerings by consumption.  Customer selects the desired option for gas or electricity and provides their annual consumption manually in the consumption input area. Alternatively, if a customer does not provide a value, a default value will be taken into consideration. Customer conducts the search, and search results with list of product offerings are presented.  For each product offering, the customer is able to see the average cost that was calcuated using their provided input.  For each product offering listed, the customer has the option to expand the row and view additional pricing-related information including the contract duration, one-time charges, recurring charges, and usage-based charges.  From the search results page or from the product details page, the customer has the ability to re-calculate the costs using a different anticipated consumption value.

**Use Case 2:   Customer lands on category page**

Customer accesses a category page (in this use case example, a commodity category of either electricity or gas).  As a result, the customer lands on the product listing page displaying the product offerings in that category.  If the cusotmer has not yet provided any personal consumption usage criteria, each offering shown will display pricing information based on the default value.   Customer will be able to view additional pricing-related information, view the details of a selected product offering or change the consumption criteria.

**Use Case 3:   Content Manager defines the CMS components enabling customers to search by consumption in backoffice tools**

A content manager wants to define and enable the cost estimation feature.  The content manager accesses the backoffice to create the necessary components including:
-   Component of type `SliderOptionComponent`
-   Component of type `PoSearchByConsumptionComponent` (note: Slider option components part of a `PoSearchByConsumptionComponent` are selected within the list of the  `SliderOptionComponent` objects)
-   Component of type `ConsumptionListComponent` (note: Search by consumption components part of a `ConsumptionListComponent` are selected within the list of the `PoSearchByConsumptionComponent` objects)

Content manager updates the homepage by including the desired `ConsumptionListComponent` objects in the corresponding slot.

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 1.x, < 2.0                                          	|
| Telco & Utilities Accelerator             	| Version 2003 (latest patch)           	|
| SAP Commerce 	| Version 1905 (latest patch) 	|

## Configuring and Enabling Cost Estimation

| Configuration             | Type: SPA or Backend  | Details                                                                                                                        |
|--------------------------------------|---------|------------------------------------------------------------------------------------------------------------------------------------|
| Define discover by consumption CMS components           | Backend (CMS) | Define corresponding discovery by consumption CMS components such as Consumption components and Slider option components.                                                                                   |
| Configure default consumption values for PO types and usage units              | SPA     | Customer consumption preferences are saved in `localStorage`. If customer is visiting the website for the first time or `localStorage` is emptied, default values that can be configured are used. In case the customer has provided a preferred consumption through the Consumption Component, it will be saved in the `localStorage` and that value will be used to calculate average cost.                                                                            |

Configure default consumption values for PO types and usage units: Consumption values are stored based on the product specification of the product offering and the `usageUnit` in the following format:

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

## CMS Component Configuration for Anticipated Consumption

The content manager will create CMS components for consumption (defined in `b2ctelcoaddon`). This is the list of CMS components that a content manager would need to define in CMS to enable the cost estimation feature.

| Component   Name             | Description  | Component Structure                                                                                                                        |
|--------------------------------------|---------|------------------------------------------------------------------------------------------------------------------------------------|
| SliderOptionComponent           | CMS component representing the predefined value and media associated to it defining a consumption option. A sample list of `SliderOptionComponent` objects is listed below: - 1000 kwh    | It extends `SimpleCMSComponent`.                                                                                   See [Attributes](#attributes)|
| PoSearchByConsumptionComponent              | CMS component defining a list of consumption options available for a specific usage unit, consumed in a specific amount of time and applicable to a specific type of POs.     | It extends `SimpleCMSComponent`.            See [Attributes](#attributes)                                                               |
| ConsumptionListingComponent        | CMS component defining a list of `PoSearchByConsumptionComponent` objects.        | It extends `SimpleCMSComponent`.  See [Attributes](#attributes)                                                                                    |

**SliderOptionComponent - Sample List**

Following is the sample list of `SliderOptionComponent` objects:

**1000 kwh**

-   uid: 1-person-option
-   name: 1 person
-   value: 1000

**2000 kwh**
-   uid: 2-persons-option
-   name: 2 persons
-   value: 1750

## Attributes

| Attribute   Name             | Type  | Description                                                                                                                        |
|--------------------------------------|---------|------------------------------------------------------------------------------------------------------------------------------------|
| **SliderOptionComponent**           |         | * - attributes are defined in super type                                                                                    |
| uid*              | String     | Unique identifier of the component                                                                          |
| name*        | String        | Name of the component                                                                                    |
| media    | Media     | Media item                                        |
| value        | Long        | Number representing the value of the option component                                                                                    |
| **PoSearchByConsumptionComponent**           |         | * - attributes are defined in super type                                                                                   |
| uid*              | String     | Unique identifier of the component                                                                          |
| name*        | String        | Name of the component                                                                                    |
| productSpecification        | `TmaProductSpecification`        | Product specification defining the type of offers available for search                                                                                    |
| usageUnit        | UsageUnit        | Usage unit defining the type of consumption                                                                                    |
| billingFrequency        | BillingFrequency        | Billing frequency defining the amount of time when the consumption was consumed (consumption value specified by the slider options)                                                                                    |
| sliderOptionComponents        | `List<SliderOptionComponent>`        | List of `SliderOptionComponent` objects. They represent the available consumption options available in the search component
| **ConsumptionListingComponent**           |         | * - attributes are defined in super type                                                                                   |
| uid*              | String     | Unique identifier of the component                                                                          |
| name*        | String        | Name of the component                                                                                    |
| searchByConsumptionComponents        | `List<PoSearchByConsumptionComponent>`        | List of `PoSearchByConsumptionComponent` objects                                                                                    |


Examples of how components can be defined in CMS as sample data:

**SliderOptionComponent components**

Electricity-specific slider option components

| Component UID                                	| Name                                                 	| Value                                                 	| Media                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| OnePersonElectricitySliderOption                                     	| 1 person/ 1000 kwh                                          	|1000                                     	|<img src="/assets/images/telco/electric-specific-slider-option-comp-1.png">                                     	|
| TwoPersonElectricitySliderOption             	| 2 person/ 2000 kwh           	|2000                                     	|<img src="/assets/images/telco/electric-specific-slider-option-comp-2.png">                                     	|
| ThreePersonElectricitySliderOption 	| 3 person/ 3500 kwh 	|3500                                     	|<img src="/assets/images/telco/electric-specific-slider-option-comp-3.png">                                     	|
| FourPersonElectricitySliderOption                                     	| 4 person/ 6000 kwh                                          	|6000                                     	|<img src="/assets/images/telco/electric-specific-slider-option-comp-4.png">                                     	|


Gas-specific slider option components

| Component UID                                	| Name                                                 	| Value                                                 	| Media                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| ThirtyM2GasSliderOption                                     	| 30 square meters/ 800 cubic meters                                          	|800                                     	|<img src="/assets/images/telco/gas-specific-slider-option-comp.png">                                     	|
| FiftyM2GasSliderOption             	| 50 square meters/ 1200 cubic meters                                     	|1200                                     	|<img src="/assets/images/telco/gas-specific-slider-option-comp.png">                                     	|
| OneHundredM2GasSliderOption 	| 100 square meters/ 2500 cubic meters 	|2500                                     	|<img src="/assets/images/telco/gas-specific-slider-option-comp.png">                                     	|
| OneHundredFiftyM2GasSliderOption                                     	| 150 square meters/ 4500 cubic meters                                          	|4500                                     	|<img src="/assets/images/telco/gas-specific-slider-option-comp.png">                                     	|
| OneHundredEightyM2GasSliderOption                                     	| 180 square meters/ 6000 cubic meters                                          	|6000                                     	|<img src="/assets/images/telco/gas-specific-slider-option-comp.png">                                     	|

**PoSearchByConsumptionComponent components**

Electricity search by consumption components

| Component UID                                	| Name                                                 	| Product specification                                                 	| Usage Unit                                                 	| Billing Frequency                                                 	| Slider option components                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| DiscoverPOByElectricityComponent                                     	| Electricity                                           	| electricity                                     	| kwh                                     	| year| OnePersonElectricitySliderOption, TwoPersonElectricitySliderOption, ThreePersonElectricitySliderOption, FourPersonElectricitySliderOption                                     	|

Gas search by consumption components

| Component UID                                	| Name                                                 	| Product specification                                                 	| Usage Unit                                                 	| Billing Frequency                                                 	| Slider option components                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| DiscoverPOByGasComponent                                     	| Gas                                           	| gas                                     	| cubic_meter                                     	| year| ThirtyM2GasSliderOption, FiftyM2GasSliderOption, OneHundredM2GasSliderOption, OneHundredFiftyM2GasSliderOption, OneHundredEightyM2GasSliderOption                                     	|

**ConsumptionListingComponent components**

Consumption listing component for electricity and gas

| Component UID                                	| Name                                                 	| Search by consumption components                                                 	| 
|--------------------------------------------	|--------------------------------------------------------	|
| UtilitiesPoSearchByConsumptionComponentList                                     	| UtilitiesPoSearchByConsumptionComponentList                                           	| DiscoverPOByElectricityComponent, DiscoverPOByGasComponent                                     	| 

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


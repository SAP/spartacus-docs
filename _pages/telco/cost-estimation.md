---
title: Cost Estimation
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.3 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

This feature determines and displays the average cost for a product offering considering the provided yearly consumption entered by a customer.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

Certain types of product offerings (that is, commodity products - electricity and gas) are charged by consumption. For customers to get an idea of how much these type of product offerings could potentially cost them on a monthly or yearly basis, customers will need to provide additional information regarding their anticipated usage. The estimated consumption entered by the customer is captured if third-party systems need to process it as illustrated in the following figures:

Electricity consumption:

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/electricity.png" alt="Electricity"></p>

Gas consumption:

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/gas.png" alt="Gas"></p>

When the customer selects or enters anticipated annual consumption information and clicks **Get Available Offers**, the product listing page displays all applicable product offerings based on the annual consumption as illustrated in the following figures:

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/update-your-consumption.png" alt="Update Your Consumption"></p>

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/update-consumption.png" alt="Update Consumption"></p>

Customers are able to view the average cost that each of the product offerings would cost them based on their anticipated usage. Additional pricing-related information for each product offering is available by expanding the offering. The products shown in the search result list must be properly configured for this scenario and have prices defined for maximum 1 usage unit (such as kWh and cubic meter for example). The **Average Cost** for a product offering is determined using the following algorithm:

**Average Cost / Year = PayNowPrices + YearlyRecurringCharges + (YearlyConsumption – YearlyIncluded) * UsageCharges**

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/average-cost-algorithm.png" alt="Average Cost Algorithm"></p>

**IMPORTANT NOTES:**

1. Average Cost is determined using the algorithm presented in the above illustration. The calculation works with simple price information, such as one-time charges, recurring charges, and usage charges, for which the price has a fixed value and not a complex price formula.

2. Average Cost is determined for those product offerings that have prices defined **for a maximum of 1 usage unit**. In case the product offering has prices defined for more than 1 usage unit, the average cost cannot be properly determined, case in which it will not be displayed. Please see the following illustration.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/average-cost-algorithm_2.png" alt="Average Cost Algorithm"></p>

## Prerequisites

1. Product offerings for which the average cost has to be calculated and displayed must have prices defined for maximum 1 usage unit (kWh, minutes, sms, etc).
2. CMS components must be properly defined in the CMS system (in our case in SAP Commerce Cloud, in the content catalog).

## Business Use Cases

**Use Case 1:   Discover product offerings by consumption from homepage**

Customer lands on the homepage and is able to search for product offerings by consumption.  Customer selects the desired option for gas or electricity and provides the annual consumption manually in the consumption input area. Alternatively, if a customer does not provide a value, a default value will be taken into consideration. Customer conducts the search, and search results with list of product offerings are presented. For each product offering, the customer is able to see the average cost that was calcuated using the provided input. For each product offering listed, the customer has the option to expand the row and view additional pricing-related information including the contract duration, one-time charges, recurring charges, and usage-based charges. From the search results page or from the Product Details Page, the customer has the ability to re-calculate the costs using a different anticipated consumption value.

**Use Case 2:   Customer lands on category page**

Customer accesses a category page (in this use case example, a commodity category of either electricity or gas).  As a result, the customer lands on the product listing page displaying the product offerings in that category.  If the customer has not yet provided any personal consumption usage criteria, each offering shown will display pricing information based on the default value.   Customer will be able to view additional pricing-related information, view the details of a selected product offering or change the consumption criteria.

**Use Case 3:   Content Manager defines the CMS components enabling customers to search by consumption in backoffice tools**

A Content Manager wants to define and enable the cost estimation feature.  The Content Manager accesses the Backoffice to create the necessary components including:
-   Component of type `SliderOptionComponent`
-   Component of type `PoSearchByConsumptionComponent` (**Note:** Slider option components part of a `PoSearchByConsumptionComponent` are selected within the list of the  `SliderOptionComponent` objects)
-   Component of type `ConsumptionListComponent` (**Note:** Search by consumption components part of a `ConsumptionListComponent` are selected within the list of the `PoSearchByConsumptionComponent` objects)

Content Manager updates the homepage by including the desired `ConsumptionListComponent` objects in the corresponding slot.

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 1.x, < 2.0                                          	|
| Telco & Utilities Accelerator             	| Version 2003 (latest patch)           	|
| SAP Commerce Cloud	| Version 1905 (latest patch) 	|

## Configuring and Enabling Cost Estimation

| Configuration             | Type: SPA or Backend  | Details                                                                                                                        |
|--------------------------------------|---------|------------------------------------------------------------------------------------------------------------------------------------|
| Define discover by consumption CMS components           | Backend (CMS) | Define corresponding discovery by consumption CMS components such as Consumption components and Slider option components.                                                                                   |
| Configure default consumption values for PO types and usage units              | SPA     | Customer consumption preferences are saved in `localStorage`. If the customer is visiting the website for the first time or `localStorage` is emptied, default values that can be configured are used. In case the customer has provided a preferred consumption through the Consumption Component, it is saved in the `localStorage` and that value is used to calculate average cost.                                                                            |

Configure default consumption values for PO types and usage units: Consumption values are stored based on the product specification of the product offering and the `usageUnit` in the following format:

    ```
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

The Content Manager creates CMS components for consumption (defined in `b2ctelcoaddon`). This is the list of CMS components that a Content Manager would need to define in CMS to enable the cost estimation feature.

| Component   Name             | Description  | Component Structure                                                                                                                        |
|--------------------------------------|---------|------------------------------------------------------------------------------------------------------------------------------------|
| SliderOptionComponent           | CMS component representing the predefined value and media associated to it defining a consumption option. See the sample list of `SliderOptionComponent` objects listed below the following table.     | It extends `SimpleCMSComponent`.                                                                                   See [Attributes](#attributes)|
| PoSearchByConsumptionComponent              | CMS component defining a list of consumption options available for a specific usage unit, consumed in a specific amount of time and applicable to specific type of POs.     | It extends `SimpleCMSComponent`.            See [Attributes](#attributes)                                                               |
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

Detailed sample data

Electricity specific slider option components

| Component UID                                	| Name                                                 	| Value                                                 	| Media                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| OnePersonElectricitySliderOption                                     	| 1 person/ 1000 kwh                                          	|1000                                     	|<img src="{{ site.baseurl }}/assets/images/telco/electric-specific-slider-option-comp-1.png" alt="Electric-Specific Slider Option Component 1">                                     	|
| TwoPersonElectricitySliderOption             	| 2 person/ 2000 kwh           	|2000                                     	|<img src="{{ site.baseurl }}/assets/images/telco/electric-specific-slider-option-comp-2.png" alt="Electric-Specific Slider Option Component 2">                                     	|
| ThreePersonElectricitySliderOption 	| 3 person/ 3500 kwh 	|3500                                     	|<img src="{{ site.baseurl }}/assets/images/telco/electric-specific-slider-option-comp-3.png" alt="Electric-Specific Slider Option Component 3">                                     	|
| FourPersonElectricitySliderOption                                     	| 4 person/ 6000 kwh                                          	|6000                                     	|<img src="{{ site.baseurl }}/assets/images/telco/electric-specific-slider-option-comp-4.png" alt="Electric-Specific Slider Option Component 4">                                     	|


Gas-specific slider option components

| Component UID                                	| Name                                                 	| Value                                                 	| Media                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| ThirtyM2GasSliderOption                                     	| 30 square meters/ 800 cubic meters                                          	|800                                     	|<img src="{{ site.baseurl }}/assets/images/telco/gas-specific-slider-option-comp.png" alt="Gas-Specific Slider Option Component">                                     	|
| FiftyM2GasSliderOption             	| 50 square meters/ 1200 cubic meters                                     	|1200                                     	|<img src="{{ site.baseurl }}/assets/images/telco/gas-specific-slider-option-comp.png" alt="Gas-Specific Slider Option Component">                                     	|
| OneHundredM2GasSliderOption 	| 100 square meters/ 2500 cubic meters 	|2500                                     	|<img src="{{ site.baseurl }}/assets/images/telco/gas-specific-slider-option-comp.png" alt="Gas-Specific Slider Option Component">                                     	|
| OneHundredFiftyM2GasSliderOption                                     	| 150 square meters/ 4500 cubic meters                                          	|4500                                     	|<img src="{{ site.baseurl }}/assets/images/telco/gas-specific-slider-option-comp.png" alt="Gas-Specific Slider Option Component">                                     	|
| OneHundredEightyM2GasSliderOption                                     	| 180 square meters/ 6000 cubic meters                                          	|6000                                     	|<img src="{{ site.baseurl }}/assets/images/telco/gas-specific-slider-option-comp.png" alt="Gas-Specific Slider Option Component">                                     	|

**PoSearchByConsumptionComponent components**

Detailed sample data

Electricity search by consumption components

| Component UID                                	| Name                                                 	| Product specification                                                 	| Usage Unit                                                 	| Billing Frequency                                                 	| Slider option components                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| DiscoverPOByElectricityComponent                                     	| Electricity                                           	| electricity                                     	| kwh                                     	| year| OnePersonElectricitySliderOption, TwoPersonElectricitySliderOption, ThreePersonElectricitySliderOption, FourPersonElectricitySliderOption                                     	|

Gas search by consumption components

| Component UID                                	| Name                                                 	| Product specification                                                 	| Usage Unit                                                 	| Billing Frequency                                                 	| Slider option components                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| DiscoverPOByGasComponent                                     	| Gas                                           	| gas                                     	| cubic_meter                                     	| year| ThirtyM2GasSliderOption, FiftyM2GasSliderOption, OneHundredM2GasSliderOption, OneHundredFiftyM2GasSliderOption, OneHundredEightyM2GasSliderOption                                     	|

**ConsumptionListingComponent components**

Detailed sample data

Consumption listing component for electricity and gas

| Component UID                                	| Name                                                 	| Search by consumption components                                                 	| 
|--------------------------------------------	|--------------------------------------------------------	|
| UtilitiesPoSearchByConsumptionComponentList                                     	| UtilitiesPoSearchByConsumptionComponentList                                           	| DiscoverPOByElectricityComponent, DiscoverPOByGasComponent                                     	| 

## Components

The following new and updated components must be enabled in the TUA Backoffice to appear on the Spartacus TUA storefront:

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

For further reading, see the following topic in the TUA Help portal:
-   [TUA Pricing](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/ad4430d10fc3477096752d83f935faf9.html)


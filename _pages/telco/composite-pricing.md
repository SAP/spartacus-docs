---
title: Pricing - Composite Pricing with Price Alteration
---

{% capture version_note %}
{{ site.version_note_part1 }} 2.0 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Contents

- [Business Use Case](#business-use-case)
- [Introducing Composite Pricing with Price Alteration Feature](#introducing-composite-pricing-with-price-alteration-feature)
- [Changes Implemented](#changes-implemented)
- [Creating and Configuring Composite Pricing for SPO in TUA](#creating-and-configuring-composite-pricing-for-spo-in-tua)
- [Components](#components)
- [TM Forum APIs](#tm-forum-apis)
- [Further Reading](#further-reading)

## Business Use Case

Customers browsing single product offerings (SPO) from TUA SPA storefront wants to view detailed composite pricing with price alteration in the following pages during the entire purchase journey:

| Page   Information 	| Eligible Prices 	|
|-	|-	|
| Product Listing Page (PLP) 	| Pay now, Recurring, One time Charges, and Usage Charges with Price   Alteration is displayed 	|
| Product Detail Page (PDP) 	| Pay now, Recurring, along with Price alteration is displayed 	|
| Add to Cart popup 	| Pay Now charge along with price alteration is displayed 	|
| Cart page 	| Pay now, Recurring, One time Charges, and Usage Charges, along with Price   alteration is displayed 	|
| Review Order page 	| Pay now, Recurring, One time Charges, and Usage charged, along with Price   alteration is displayed 	|
| Order Confirmation page 	| Pay now, Recurring, One time Charges, and Usage charged, along with Price   alteration is displayed 	|
| Order History page 	| Pay now, Recurring, One time Charges, and Usage charged, along with Price   alteration is displayed 	|
| CGS 	| Shows details similar to the Product Listing Page (PLP)  along with Price alteration in the cart 	|
| CPI 	| Shows the Order Prices as in Order Details 	|

## Introducing Composite Pricing with Price Alteration Feature

Composite Pricing brings forth a new way for handling operational processes for service providers that is clearer and more efficient. The underlying TUA data model has been enhanced to support the hierarchical structure of composite prices in a TM Forum compliant manner. Product Offering Prices are now hierarchal; that is, they can be grouped together and they are also re-usable.

With this feature, customers browsing single product offerings (SPO) in the TUA SPA store can view detailed pricing information, such as pay now charges, recurring and one time charges, and usage charges with price alterations in the following pages throughout the purchase journey.

- The Product Listing Page (PLP) (SPO)
- The Product Detail Page (PDP) (SPO)
- The Add to Cart popup (SPO)
- The Cart page (SPO)
- The Review Order page
- The Order Confirmation page (SPO), and
- The Order History page

For more information, see [Composite Pricing](#https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/2e0fa8602fff440ba756e1a0a8390ea3.html) in the TUA Help portal.

The Price Alteration - Discounts works on top of the Composite Pricing data model and enables the ability to offer fixed-price and percentage discounts at any level in the composite price structure, and for any type of charge including one-time charges, recurring charges, and usage-based charges. With price alteration discounts, customers can see discounts upfront before placing their order. For more information, see [Price Alteration Discounts](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/61b21155624e4a498632964bc566e1eb.html) in the TUA Help portal.

This feature is enabled through the Telco SPA store, implemented on top of TM Forum and OCC APIs and the Telco industry.

**Note:** With this feature, Some services from Angular, such as the minimum pricing is deprecated. TUA SPA is updated with Angular 9.

### Highest Priority Price Algorithm

If a single product offering has multiple eligible prices, the product offering with highest priority price is determined and displayed in the `Product Detail Page (PDP)`.

In the Product Details Page (PDP):

 - The highest priority `ProductOfferingPrice` that is configured for the product offering is displayed.
 - In case of same priority, first `ProductOfferingPrice` is displayed.

## Changes Implemented

The following changes are implemented as part of this feature:

| Change                              | Description                                                                                                                                                                           |
|-------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| End-point   changes                 | The OCC endpoints is changed from REST/V2 to OCC/V2 in the `app.modules.ts` to use commerce web services endpoints. No API-related changes from the previous release                    |
| Highest   Priority Price Algorithm  | If the product offering has   multiple eligible prices, the product offering with the highest priority price is determined and displayed                                                    |
| Product   Display Page (PDP)        | Displays the highest priority   SPO price                                                                                                                                             |
| Product   Listing Page (PLP)        | Displays the highest priority   price, which is also known as the Best Applicable Price                                                                                                |
| TUA   recipe changes                | With 2005, C5 addon changes will no longer be used. The recipe will be updated to use `b2ctelcocc` and `commercewebservices` extensions, instead of `ycommercewebservices` extension |

## Creating and Configuring Composite Pricing for SPO in TUA

The composite pricing with price alteration for a selected product offering is configured in the Backoffice by a Product Manager. For more information, see [Creating Composite Prices for a Simple Product Offering](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/2e0fa8602fff440ba756e1a0a8390ea3.html) and [Creating Price Row for a Price Context](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/edd790667fd54960a216646c85deb5a7.html) in the TUA Help portal.

## Components

The following new and updated components must be enabled in the TUA backoffice to appear on the Spartacus TUA storefront:

| Component   Name | Status | Description |
|-|-|-|
| Product Components |  |  |
| TmaProductSummaryComponent | Updated | Extends   `ProductSummaryComponent` to display information about the prices of the   Product Offering in the Product Details page.       The following is displayed: Price Charges (see `TmaPriceDisplayComponent`   for more information).            If a product offering has multiple prices, highest priority pricing will be   used to determine the price. |
| TmaProductDetailsTabComponent | Updated | Extends   `ProductDetailsTabComponent` to display detailed prices of the Product   Offering in product details tab on the Product Details page.            The following are displayed:      Contract Duration: The   contract duration is displayed in the following format:       Contract Duration:   `<contract term name>`            If a product offering does not have a contract term, recurring prices, or   usage charges, this section will not display. No charges will be shown in   this component. All product charges are shown in price tree in product   summary component. |
| Search Product   Components |  |  |
| TmaProductListItemComponent | Updated | Extends the   `ProductListItemComponent` to display information about the prices of the   product offering in the Product Grid Item Page.       The following is displayed: Price Charges (see `TmaPriceDisplayComponent`   for more information). |
| TmaProductGridItemComponent | Updated | Extends   `ProductGridItemComponent` to display information about the prices of the   product offering in the Product Grid Item page. The following is displayed:   Price Charges (see `TmaPriceDisplayComponent` for more information). |
| Product Price   Components |  |  |
| TmaUsageChargeComponent | Updated | Usage charge to display usage   charge details on the product page.       <value><currency> /<usageUnit> for <cycle start> to   <cycle end> <usageUnit> |
| TmaVolumeChargeComponent | Deleted | Usage charge as volume type   doesn't exist in composite pricing. Therefore, the relevant component is   deleted.  |
| TmaPerUnitChargeComponent | Deleted | Usage charge as volume type   doesn't exist in composite pricing. Therefore, the relevant component is   deleted.  |
| TmaOneTimeChargeComponent | Updated | One time charge component to   display one time charges on the product page.       <value><currency>   <billingEvent> |
| TmaRecurringChargeComponent | Updated | Recurring charges component to   display recurring charges on the product page.      <value><currency> <billingEvent> |
| TmaPriceDisplayComponent | New | Price Display Component to   display prices on the product pages. The component includes subsequent   product charge types components      <POP Name> (<UsageType>) Usage Type shown if applicable      Displays all the usage charges in the following way:      - one time charges (see `TmaOneTimeChargeComponent` for more   information)      - recurring charges (see `TmaRecurringChargeComponent` for more   information)      - usage charges (see `TmaUsageChargeComponent` for more information). For   alteration charges, see `TmaAlterationDetailsComponent` for more information |
| TmaAlterationDetailsComponent | New | Alteration Display Component to   display alterations charges on the product pages.      <value><currency> OFF <billingEvent> |
| Cart Components |  |  |
| TmaCartitemPriceDisplayComponent | New | Price Display Component to   display prices on the cart. It includes subsequent cart charge types   components      Hierarchical Price (<UsageType>) Usage Type shown if applicable      Displays all the usage charges in the following way:      - one time charges (see CartItemOneTimeChargeComponent for more   information)      - recurring charges (see CartItemRecurringChargeComponent for more   information)      - usage charges (see CartItemUsageChargeComponent for more   information)      - alteration charges (see CartItemAlterationsDetailsComponent for more   information) |
| CartItemOneTimeChargeComponent | Updated | One Time Charges component to   display one time charges on the cart Item.       <value><currency> <billingEvent> |
| CartItemRecurringChargeComponent | Updated | Recurring Charges component to   display recurring charges on the cart Item.      <value><currency> <billingEvent> |
| CartItemUsageChargeComponent | Updated | Usage Charges component to   display usages charges on the cart Item.       <value><currency> /<usageUnit> for <cycle start> to   <cycle end> <usageUnit> |
| CartItemAlterationsDetailsComponent | New | Alteration Display component to   display alterations charges on the cart item.      <value><currency> OFF <billingEvent> |
| TmaCartItemComponent | Updated | Cart item component that displays details for the cart items.   The component is updated to include cart price display component. |
| Guided Selling   Components |  |  |
| TmaGuidedSellingProductGridItemComponent | Updated | Guided Selling Grid component to   show product details in a grid. The component is updated to include the price   display component.      The following is displayed: Price Charges (see `TmaPriceDisplayComponent`   for more information) |
| TmaGuidedSellingProductListItemComponent | Updated | Guided Selling Grid component to   show product details in list. The component is updated to include price   display component.      The following is displayed: Price Charges (see `TmaPriceDisplayComponent`   for more information). |
| TmaGuidedSellingCurrentSelectionComponent | Updated | Guided Selling Current Selection   Component to show selected products. The component is updated to include   price display component.      The following is displayed: Price Charges (see `TmaPriceDisplayComponent`   for more information) |

## TM Forum APIs

| API Name          	| API Endpoint                         	| Description                                                                                                                                                                                	|
|--------------------------------------	|----------------------------------	|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
| Search 	| GET /occ/v2/telcospa/products/search                 	| Retrieves result for category and text search from SOLR                                                                                                                         	|
| Product Details            	| GET occ/v2/telcospa/products/{productCode}  	| Retrieves product details 	|
| Add to Cart            	| POST occ/v2/telcospa/users/{userId}/carts/{cartID}/entries                	| Adds a product to the cart                                                                                                                                                       	|
| Cart Details            	| GET occ/v2/telcospa/users/{userId}/carts/{cartID}            	| Retrieves the cart details                                                                                                                                           	|

For more information, see [API and YAML Documentation](https://help.sap.com/viewer/f59b0ac006d746caaa5fb599b4270151/2011/en-US/52cf34e46ce34672bc3e47bdabcbc838.html).

## Further Reading

For further reading, see the following topics in the TUA Help portal.

- [Composite Pricing](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/2e0fa8602fff440ba756e1a0a8390ea3.html).
- [Creating Composite Prices for a Simple Product Offering](#https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/cc31b2c3e2c049059766598fe0cd88de.html).
- [Price Alterations (Discounts)](#https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/61b21155624e4a498632964bc566e1eb.html).
- [Making Components Visible](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/2005/en-US/1cea3b2cb3334fc085dda9cc070ad6ac.html).

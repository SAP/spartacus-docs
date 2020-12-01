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

Customers browsing single product offerings (SPO) from TUA SPA storefront want to view detailed composite pricing with price alteration in the following pages during the entire purchase journey:

| Page   Information 	| Eligible Prices 	|
|-	|-	|
| Product Listing Page (PLP) 	| Pay now, Recurring, One time Charges, and Usage Charges with Price   Alteration is displayed 	|
| Product Detail Page (PDP) 	| Pay now, Recurring, along with Price alteration 	|
| Add to Cart popup 	| Pay Now charge along with price alteration 	|
| Cart page 	| Pay now, Recurring, One time Charges, and Usage Charges, along with Price alteration 	|
| Review Order page 	| Pay now, Recurring, One time Charges, and Usage charged, along with Price   alteration 	|
| Order Confirmation page 	| Pay now, Recurring, One time Charges, and Usage charged, along with Price   alteration 	|
| Order History page 	| Pay now, Recurring, One time Charges, and Usage charged, along with Price   alteration 	|
| CGS 	| Details similar to the Product Listing Page (PLP) along with Price alteration in the cart 	|
| CPI 	| The Order Prices as in Order Details 	|

## Introducing Composite Pricing with Price Alteration Feature

Composite Pricing brings forth a new way of handling operational processes for service providers that is clearer and more efficient. The underlying TUA data model has been enhanced to support the hierarchical structure of composite prices in a TM Forum compliant manner. Product offering prices are now hierarchal; that is, they can be grouped together and they are also re-usable.

With this feature, customers browsing single product offerings (SPO) in the TUA SPA store can view detailed product offering prices, such as pay now charges, recurring and one time charges, and usage charges with price alterations in the following pages throughout the purchase journey.

- The Product Listing Page (PLP) (SPO)
- The Product Detail Page (PDP) (SPO)
- The Add to Cart popup (SPO)
- The Cart page (SPO)
- The Review Order page
- The Order Confirmation page (SPO), and
- The Order History page

For more information, see [Composite Pricing](#https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/2e0fa8602fff440ba756e1a0a8390ea3.html) in the TUA Help portal.

The Price Alteration - Discounts works on top of the Composite Pricing data model and enables the ability to offer fixed-price and percentage discounts at any level in the composite price structure, and for any type of charge including one-time charges, recurring charges, and usage-based charges. With price alteration discounts, customers can see discounts upfront before placing their order. For more information, see [Price Alteration Discounts](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/61b21155624e4a498632964bc566e1eb.html) in the TUA Help portal.

This feature is enabled through the Telco SPA store and is implemented on top of TM Forum and OCC APIs.

**Note:** With this feature, TUA SPA is updated with Angular 9. Some services from Angular, such as the minimum pricing is deprecated.

### Highest Priority Price Algorithm

If a single product offering has multiple eligible prices, the product offering with highest [priority price](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/b5ea5881224d4960820a1cca3924b12d.html) is determined and displayed in the `Product Detail Page (PDP)`.

In the Product Details Page (PDP):

 - The highest priority `ProductOfferingPrice` that is configured for the product offering is displayed.
 - In case of same priority, first `ProductOfferingPrice` is displayed.

## Changes Implemented

The following changes are implemented as part of this feature:

| Change                              | Description                                                                                                                                                                           |
|-------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| End-point   changes                 | The OCC endpoints are changed from REST/V2 to OCC/V2 in the `app.modules.ts` to use commerce web services endpoints. No API-related changes from the previous release                    |
| Highest   Priority Price Algorithm  | If the product offering has multiple eligible prices, the product offering with the highest [priority price](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/b5ea5881224d4960820a1cca3924b12d.html) is determined and displayed                                                    |
| Product   Display Page (PDP)        | Displays the highest priority   SPO price                                                                                                                                             |
| Product   Listing Page (PLP)        | Displays the highest priority   price, which is also known as the Best Applicable Price                                                                                                |
| TUA   recipe changes                | With 2005, C5 addon changes will no longer be used. The recipe will be updated to use `b2ctelcocc` and `commercewebservices` extensions, instead of `ycommercewebservices` extension |

## Creating and Configuring Composite Pricing for SPO in TUA

The composite pricing with price alteration for a selected product offering is configured in the Backoffice by a Product Manager. For more information, see [Creating Composite Prices for a Simple Product Offering](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/2e0fa8602fff440ba756e1a0a8390ea3.html) and [Creating Price Row for a Price Context](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/edd790667fd54960a216646c85deb5a7.html) in the TUA Help portal.

## Components

The following figure illustrates hirarchical structure of composite pricing with price alteration of a product offering.

<p align="center"><img src="/assets/images/telco/composite-pricing-feature.png"></p>

The following new and updated components must be enabled in the TUA backoffice to appear on the Spartacus TUA storefront:

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
.tg .tg-pcvp{border-color:inherit;text-align:left;vertical-align:top}
</style>
<table class="tg">
<thead>
  <tr>
    <th class="tg-0pky"><span style="font-weight:bold">Component   Name</span></th>
    <th class="tg-0pky"><span style="font-weight:bold">Status</span></th>
    <th class="tg-0pky"><span style="font-weight:bold">Description</span></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-pcvp" colspan="3"><span style="font-weight:bold">Product Components</span></td>
  </tr>
  <tr>
    <td class="tg-0pky">TmaProductSummaryComponent</td>
    <td class="tg-0pky">Updated</td>
    <td class="tg-0pky">This component extends the <span style="font-style:italic">ProductSummaryComponent </span>to display information about the prices of the product offering in the Product Details Page (PDP).<br><br><span style="font-weight:bold">Displays:</span> Price Charges. For more information, see <span style="font-style:italic">TmaPriceDisplayComponent</span> component.<br><br><span style="font-weight:bold">Note:</span> If a product offering has multiple prices, highest priority pricing will be used to determine the price.</td>
  </tr>
  <tr>
    <td class="tg-pcvp">TmaProductDetailsTabComponent</td>
    <td class="tg-pcvp">Updated</td>
    <td class="tg-pcvp">This component extends the <span style="font-style:italic">ProductDetailsTabComponent</span> to display detailed prices of the product offering in the Product Details tab in the Product Details Page (PDP).<br><br><span style="font-weight:bold">Format:</span> Contract Duration: &lt;contract term name&gt; <br><span style="font-weight:bold">Example:</span> Contract Duration: 12 Months - monthly billing<br><span style="font-weight:bold">Displays:</span> Contract duration that indicates the duration of the contract<br>  <br><span style="font-weight:bold">Note:</span> If a product offering does not have a contract term, recurring prices, or usage charges, this section will not display. No charges will be shown in this component. All product charges are shown in a price tree in the Product Summary component.</td>
  </tr>
  <tr>
    <td class="tg-0pky" colspan="3"><span style="font-weight:bold">Search Product Components</span></td>
  </tr>
  <tr>
    <td class="tg-pcvp">TmaProductListItemComponent</td>
    <td class="tg-pcvp">Updated</td>
    <td class="tg-pcvp">This component extends the <span style="font-style:italic">ProductListItemComponent</span><span style="font-weight:bold;font-style:italic"> </span>to display information about the prices of the product offering in the Product List Item page.<br><br><span style="font-weight:bold">Displays:</span> Price Charges. For more information, see <span style="font-style:italic">TmaPriceDisplayComponent</span></td>
  </tr>
  <tr>
    <td class="tg-0pky">TmaProductGridItemComponent</td>
    <td class="tg-0pky">Updated</td>
    <td class="tg-0pky">This component extends the <span style="font-style:italic">ProductGridItemComponent</span> to display information about the prices of the product offering in the Product Grid Item<span style="font-weight:bold"> </span>page.<br><br><span style="font-weight:bold">Displays:</span> Price Charges. For more information, see <span style="font-style:italic">TmaPriceDisplayComponent</span></td>
  </tr>
  <tr>
    <td class="tg-pcvp" colspan="3"><span style="font-weight:bold">Product Price Components</span></td>
  </tr>
  <tr>
    <td class="tg-0pky">TmaUsageChargeComponent</td>
    <td class="tg-0pky">Updated</td>
    <td class="tg-0pky">A Usage Charge component to display the usage charge details in the Product<span style="font-weight:bold"> </span>pages. <br><br><span style="font-weight:bold">Format: </span>&lt;value&gt;&lt;currency&gt; /&lt;usageUnit&gt; for &lt;cycle start&gt; to &lt;cycle end&gt; &lt;usageUnit&gt;<br><span style="font-weight:bold">Example: </span>Inside "Per Minutes Charges (Charged By Each Respective Tier)" TmaPriceDisplayComponent, Usage Charge as 0.08 $ /minute for 1 to 100 minute for Product signatureUnlimitedPlan</td>
  </tr>
  <tr>
    <td class="tg-pcvp">TmaVolumeChargeComponent</td>
    <td class="tg-pcvp">Deleted</td>
    <td class="tg-pcvp">Usage charge as volume type does not exist in composite pricing.Therefore, the relevant component is deleted. </td>
  </tr>
  <tr>
    <td class="tg-0pky">TmaPerUnitChargeComponent</td>
    <td class="tg-0pky">Deleted</td>
    <td class="tg-0pky">Usage charge as volume type does not exist in composite pricing. Therefore, the relevant component is deleted. </td>
  </tr>
  <tr>
    <td class="tg-pcvp">TmaOneTimeChargeComponent</td>
    <td class="tg-pcvp">Updated</td>
    <td class="tg-pcvp">A One Time Charge component to display one time charges in the Product<span style="font-weight:bold"> </span>pages.<br><br><span style="font-weight:bold">Format:</span> &lt;value&gt;&lt;currency&gt;&lt;billingEvent&gt;<br><span style="font-weight:bold">Example: </span>Inside "Activation Charges" TmaPriceDisplayComponent, One Time Charge as 50.0 $ On Checkout for Product signatureUnlimitedPlan</td>
  </tr>
  <tr>
    <td class="tg-0pky">TmaRecurringChargeComponent</td>
    <td class="tg-0pky">Updated</td>
    <td class="tg-0pky">A Recurring Charges component to display recurring charges in the Product pages.<br><br><span style="font-weight:bold">Format:</span> &lt;value&gt;&lt;currency&gt; &lt;billingEvent&gt;<br><span style="font-weight:bold">Example:</span> Inside "Service Charges" TmaPriceDisplayComponent, Recurring Charges as 50.0 $ monthly for Product signatureUnlimitedPlan</td>
  </tr>
  <tr>
    <td class="tg-pcvp">TmaPriceDisplayComponent</td>
    <td class="tg-pcvp">New</td>
    <td class="tg-pcvp">A Price Display component to display prices in the Product<span style="font-weight:bold"> </span>pages. It includes subsequent product charge types components.<br><br><span style="font-weight:bold">Format:</span> &lt;POP Name&gt; (&lt;UsageType&gt;)<br><span style="font-weight:bold">Note: </span>Usage type is shown only if applicable<br><br>Displays all usage charges, such as: <br>- one time charges. For more information, see <span style="font-style:italic">TmaOneTimeChargeComponent</span><br>- recurring charges. For more information, see <span style="font-style:italic">TmaRecurringChargeComponent</span><br>- usage charges. For more information, see <span style="font-style:italic">TmaUsageChargeComponent </span><br><br><span style="font-weight:bold">Note: </span>For alteration charges, see <span style="font-style:italic">TmaAlterationDetailsComponent</span> for more information.</td>
  </tr>
  <tr>
    <td class="tg-0pky">TmaAlterationDetailsComponent</td>
    <td class="tg-0pky">New</td>
    <td class="tg-0pky">An Alteration Details component to display alterations charges in the Product pages.<br><br><span style="font-weight:bold">Format:</span> &lt;value&gt;&lt;currency&gt; OFF &lt;billingEvent&gt; : Without Cycle<br><span style="font-weight:bold">Examples: </span><br>-10.0 $ OFF On Checkout  for Product signatureUnlimitedPlan <br>-20.0 % OFF On Checkout for Product signatureUnlimitedPlan<br><br><span style="font-weight:bold">Format: </span>&lt;value&gt;&lt;currency&gt; OFF &lt;billingEvent&gt; for &lt;cycle start&gt; to &lt;cycle end&gt;: With Cycle<br><span style="font-weight:bold">Example:</span> -10.0 $ OFF monthly for 1 to 6  for Product signatureUnlimitedPlan</td>
  </tr>
  <tr>
    <td class="tg-pcvp" colspan="3"><span style="font-weight:bold">Cart Components</span></td>
  </tr>
  <tr>
    <td class="tg-0pky">TmaCartitemPriceDisplayComponent</td>
    <td class="tg-0pky">New</td>
    <td class="tg-0pky">A Price Display component to display prices on the cart. It includes subsequent cart charge types components. Hierarchical Price, in case no &lt;UsageType&gt;) is present.<br><br><span style="font-weight:bold">Examples:</span> <br>- Hierarchical Price for Product signatureUnlimitedPlan if added in the cart <br>- Hierarchical Price (Charged By &lt;UsageType&gt;) if UsageType is present<br><br><span style="font-weight:bold">Example: </span>Hierarchical Price (Charged By Each Respective Tier) for Product signatureUnlimitedPlan if Added in Cart <br><span style="font-weight:bold">Displays: </span>All usage charges, such as:<br>- one time charges. For more information, see <span style="font-style:italic">CartItemOneTimeChargeComponent</span><br>- recurring charges. For more information, see <span style="font-style:italic">CartItemRecurringChargeComponent</span><br>- usage charges. For more information, see <span style="font-style:italic">CartItemUsageChargeComponent</span><br>- alteration charges. For more information, see <span style="font-style:italic">CartItemAlterationsDetailsComponent</span></td>
  </tr>
  <tr>
    <td class="tg-pcvp">CartItemOneTimeChargeComponent</td>
    <td class="tg-pcvp">Updated</td>
    <td class="tg-pcvp">A One Time Charges component to display one time charges on the Cart Item.<br><br><span style="font-weight:bold">Format: </span>&lt;value&gt;&lt;currency&gt; &lt;billingEvent&gt;<br><span style="font-weight:bold">Example:</span> One Time Charge as 50.0 $ On Checkout for Product signatureUnlimitedPlan</td>
  </tr>
  <tr>
    <td class="tg-0pky">CartItemRecurringChargeComponent</td>
    <td class="tg-0pky">Updated</td>
    <td class="tg-0pky">A Recurring Charges component to display recurring charges on the cart Item.<br><br><span style="font-weight:bold">Format:</span> &lt;value&gt;&lt;currency&gt; &lt;billingEvent&gt;<br><span style="font-weight:bold">Example: </span>Recurring Charges as 50.0 $ monthly for Product signatureUnlimitedPlan</td>
  </tr>
  <tr>
    <td class="tg-pcvp">CartItemUsageChargeComponent</td>
    <td class="tg-pcvp">Updated</td>
    <td class="tg-pcvp">A Usage Charges component to display usages charges on the Cart Item.<br><br><span style="font-weight:bold">Format:</span> &lt;value&gt;&lt;currency&gt; /&lt;usageUnit&gt; for &lt;cycle start&gt; to   &lt;cycle end&gt; &lt;usageUnit&gt;<br><span style="font-weight:bold">Example:</span> Usage Charge as 0.08 $ /minute for 1 to 100 minute for Product signatureUnlimitedPlan</td>
  </tr>
  <tr>
    <td class="tg-0pky">CartItemAlterationsDetailsComponent</td>
    <td class="tg-0pky">New</td>
    <td class="tg-0pky">An Alteration Display component to display alterations charges on the Cart pages<br><br><span style="font-weight:bold">Format:</span> &lt;value&gt;&lt;currency&gt; OFF &lt;billingEvent&gt; : Without Cycle<br><span style="font-weight:bold">Examples:</span> <br>-10.0 $ OFF On Checkout  for Product signatureUnlimitedPlan <br>-20.0 % OFF On Checkout for Product signatureUnlimitedPlan<br><br><span style="font-weight:bold">Format:</span> &lt;value&gt;&lt;currency&gt; OFF &lt;billingEvent&gt; for &lt;cycle start&gt; to &lt;cycle end&gt;: With Cycle<br><span style="font-weight:bold">Example:</span> -10.0 $ OFF monthly for 1 to 6  for Product signatureUnlimitedPlan</td>
  </tr>
  <tr>
    <td class="tg-pcvp">TmaCartItemComponent</td>
    <td class="tg-pcvp">Updated</td>
    <td class="tg-pcvp">A Cart Item component that displays details of the cart items. It is updated to include the cart price display component.</td>
  </tr>
  <tr>
    <td class="tg-0pky" colspan="3"><span style="font-weight:bold">Guided Selling Components</span></td>
  </tr>
  <tr>
    <td class="tg-pcvp">TmaGuidedSellingProductGridItemComponent</td>
    <td class="tg-pcvp">Updated</td>
    <td class="tg-pcvp">A Guided Selling Grid component to show product details in a grid. It is updated to include price display component. It displays the price charges. For more information, see <span style="font-style:italic">TmaPriceDisplayComponent</span>.</td>
  </tr>
  <tr>
    <td class="tg-0pky">TmaGuidedSellingProductListItemComponent</td>
    <td class="tg-0pky">Updated</td>
    <td class="tg-0pky">A Guided Selling Grid component to show product details in a list. It is updated to include price display component. It displays the Price Charges. For more information, see <span style="font-style:italic">TmaPriceDisplayComponent</span>.<br></td>
  </tr>
  <tr>
    <td class="tg-pcvp">TmaGuidedSellingCurrentSelectionComponent</td>
    <td class="tg-pcvp">Updated</td>
    <td class="tg-pcvp">A Guided Selling Current Selection component to show selected products. It is updated to include price display component. It displays the price charges. For more information, see <span style="font-style:italic">TmaPriceDisplayComponent.</span><br></td>
  </tr>
</tbody>
</table>

## Further Reading

For further reading, see the following topics in the TUA Help portal.

- [Composite Pricing](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/2e0fa8602fff440ba756e1a0a8390ea3.html).
- [Creating Composite Prices for a Simple Product Offering](#https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/cc31b2c3e2c049059766598fe0cd88de.html).
- [Price Alterations (Discounts)](#https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/61b21155624e4a498632964bc566e1eb.html).
- [TUA APIs Documentation](https://help.sap.com/viewer/f59b0ac006d746caaa5fb599b4270151/2011/en-US/52cf34e46ce34672bc3e47bdabcbc838.html).
- [Making Components Visible](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/2005/en-US/1cea3b2cb3334fc085dda9cc070ad6ac.html).

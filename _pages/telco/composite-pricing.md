---
title: Pricing - Composite Pricing
---

{% capture version_note %}
{{ site.version_note_part1 }} 2.0 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Composite Pricing brings forth a new way of handling pricing information and supports recurring charges, one-time charges and usage-based charges that are built in a hierarchical tree structure.  Pricing displayed on the storefront is now based on the composite pricing structure.  Priority pricing is also supported to determine the applicable price for a customer in the case where there are multiple prices that a given customer is eligible for.  For more information, see [Composite Pricing](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/latest/en-US/2e0fa8602fff440ba756e1a0a8390ea3.html) in the TUA Help portal.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Business Use Case

Customers browsing the storefront are able to view detailed pricing information about a product offering. 

| Page   Information 	| Eligible Prices 	|
|-	|-	|
| Product Listing Page (PLP) 	| Pay now, Recurring, One time Charges, and Usage Charges with Price   Alteration is displayed 	|
| Product Detail Page (PDP) 	| Pay now, Recurring, along with Price alteration 	|
| Add to Cart popup 	| Pay Now charge along with price alteration 	|
| Cart page 	| Pay now, Recurring, One time Charges, and Usage Charges, along with Price alteration 	|
| Review Order page 	| Pay now, Recurring, One time Charges, and Usage charged, along with Price   alteration 	|
| Order Confirmation page 	| Pay now, Recurring, One time Charges, and Usage charged, along with Price   alteration 	|
| Order History page 	| Pay now, Recurring, One time Charges, and Usage charged, along with Price   alteration 	|
| Configurable Guided Selling (CGS) Page 	| Details are similar to the Product Listing Page (PLP) along with Price alteration in the cart 	|

The following figure illustrates the hierarchical structure of the composite pricing for Signature Unlimited Plan that is configured by the Administrator in the backoffice as an example.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/composite-pricing-feature.png" alt="Composite Pricing Feature"></p>


## Changes Implemented

The following changes are implemented as part of this feature:

| Change                              | Description                                                                                                                                                                           |
|-------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| End-point   changes                 | The OCC endpoints are changed from REST/V2 to OCC/V2 in the `app.modules.ts` to use commerce web services endpoints. No API-related changes from the previous release                    |
| Highest   Priority Price Algorithm  | If the product offering has multiple eligible prices, the product offering with the highest [priority price](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/b5ea5881224d4960820a1cca3924b12d.html) is determined and displayed                                                    |
| Product   Display Page (PDP) and Product Listing Page (PLP)      | Displays the highest priority   SPO price                                                                                                                                             |

## Creating and Configuring Composite Pricing in TUA

To create composite prices, see [Creating Composite Prices for a Simple Product Offering](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/2e0fa8602fff440ba756e1a0a8390ea3.html) in the TUA Help portal.

## Components

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
    <td class="tg-0pky">This component extends the <span style="font-style:italic">ProductSummaryComponent </span>to display information about the prices of the product offering in the <span style="font-weight:bold">Product Details Page</span> (PDP).<br><br><span style="font-weight:bold">Displays:</span> Price Charges. For more information, see <span style="font-style:italic">TmaPriceDisplayComponent</span> component.<br><br><span style="font-weight:bold">Note:</span> If a product offering has multiple prices, highest priority pricing will be used to determine the price.</td>
  </tr>
  <tr>
    <td class="tg-pcvp">TmaProductDetailsTabComponent</td>
    <td class="tg-pcvp">Updated</td>
    <td class="tg-pcvp">This component extends the <span style="font-style:italic">ProductDetailsTabComponent</span> to display detailed prices of the product offering in the <span style="font-style:italic">Product Details</span> tab on the <span style="font-weight:bold">Product Details Page</span> (PDP).<br><br><span style="font-weight:bold">Format:</span> Contract Duration: &lt;contract term name&gt; <br><span style="font-weight:bold">Example:</span> Contract Duration: 12 Months - monthly billing<br><span style="font-weight:bold">Displays:</span> Contract Duration indicates the duration of the contract<br>  <br><span style="font-weight:bold">Note:</span> If a product offering does not have a contract term, recurring prices, or usage charges, this section will not display. No charges will be shown in this component. All product charges are shown in a price tree in the Product Summary component.</td>
  </tr>
  <tr>
    <td class="tg-0pky" colspan="3"><span style="font-weight:bold">Search Product Components</span></td>
  </tr>
  <tr>
    <td class="tg-pcvp">TmaProductListItemComponent</td>
    <td class="tg-pcvp">Updated</td>
    <td class="tg-pcvp">This component extends the <span style="font-style:italic">ProductListItemComponent</span><span style="font-weight:bold;font-style:italic"> </span>to display information about the prices of the product offering in the <span style="font-weight:bold">Product Listing</span> <span style="font-weight:bold">Page (PLP)</span>.<br><br><span style="font-weight:bold">Displays:</span> Price Charges. For more information, see <span style="font-style:italic">TmaPriceDisplayComponent</span></td>
  </tr>
  <tr>
    <td class="tg-0pky">TmaProductGridItemComponent</td>
    <td class="tg-0pky">Updated</td>
    <td class="tg-0pky">This component extends the <span style="font-style:italic">ProductGridItemComponent</span> to display information about the prices of the product offering in the <span style="font-weight:bold">Product Grid Item </span>page.<br><br><span style="font-weight:bold">Displays:</span> Price Charges. For more information, see <span style="font-style:italic">TmaPriceDisplayComponent</span></td>
  </tr>
  <tr>
    <td class="tg-pcvp" colspan="3"><span style="font-weight:bold">Product Price Components</span></td>
  </tr>
  <tr>
    <td class="tg-0pky">TmaUsageChargeComponent</td>
    <td class="tg-0pky">Updated</td>
    <td class="tg-0pky">A Usage Charge component to display the usage charge details in the <span style="font-weight:bold">Product </span>pages. <br><br><span style="font-weight:bold">Format: </span>&lt;value&gt;&lt;currency&gt; /&lt;usageUnit&gt; for &lt;cycle start&gt; to &lt;cycle end&gt; &lt;usageUnit&gt;<br><span style="font-weight:bold">Example: </span>Inside "Per Minutes Charges (Charged By Each Respective Tier)" TmaPriceDisplayComponent, Usage Charge as 0.08 $ /minute for 1 to 100 minute for Product signatureUnlimitedPlan</td>
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
    <td class="tg-pcvp">A One Time Charge component to display one time charges in the <span style="font-weight:bold">Product </span>pages.<br><br><span style="font-weight:bold">Format:</span> &lt;value&gt;&lt;currency&gt;&lt;billingEvent&gt;<br><span style="font-weight:bold">Example: </span>Inside "Activation Charges" TmaPriceDisplayComponent, One Time Charge as 50.0 $ On Checkout for Product signatureUnlimitedPlan</td>
  </tr>
  <tr>
    <td class="tg-0pky">TmaRecurringChargeComponent</td>
    <td class="tg-0pky">Updated</td>
    <td class="tg-0pky">A Recurring Charges component to display recurring charges in the <span style="font-weight:bold">Product</span> pages.<br><br><span style="font-weight:bold">Format:</span> &lt;value&gt;&lt;currency&gt; &lt;billingEvent&gt;<br><span style="font-weight:bold">Example:</span> Inside "Service Charges" TmaPriceDisplayComponent, Recurring Charges as 50.0 $ monthly for Product signatureUnlimitedPlan</td>
  </tr>
  <tr>
    <td class="tg-pcvp">TmaPriceDisplayComponent</td>
    <td class="tg-pcvp">New</td>
    <td class="tg-pcvp">A Price Display component to display prices in the <span style="font-weight:bold">Product</span> pages. It includes subsequent product charge types components.<br><br><span style="font-weight:bold">Format: </span>&lt;POP Name&gt; In Case No &lt;UsageType&gt;) is present<br><span style="font-weight:bold">Example:</span> Activation Charges for Product signatureUnlimitedPlan<br><br><span style="font-weight:bold">Format:</span> &lt;POP Name&gt; (Charged By &lt;UsageType&gt;) if  UsageType  is present<br><span style="font-weight:bold">Example:</span> Per MB Charges (Charged By Highest Applicable Tier) for Product signatureUnlimitedPlan <br><br>Displays all usage charges, such as: <br>- one time charges. For more information, see TmaOneTimeChargeComponent<br>- recurring charges. For more information, see TmaRecurringChargeComponent<br>- usage charges. For more information, see TmaUsageChargeComponent <br></td>
  </tr>
  <tr>
    <td class="tg-0pky" colspan="3"><span style="font-weight:bold">Cart Components</span></td>
  </tr>
  <tr>
    <td class="tg-pcvp">TmaCartitemPriceDisplayComponent</td>
    <td class="tg-pcvp">New</td>
    <td class="tg-pcvp">A Price Display component to display prices on the cart and it includes subsequent cart charge types components. Hierarchical Price, in case no &lt;UsageType&gt;) is present.<br><br><span style="font-weight:bold">Format:</span> Hierarchical Price In Case No &lt;UsageType&gt;) is present<br><span style="font-weight:bold">Example:</span> Hierarchical Price for Product signatureUnlimitedPlan if Added in Cart<br><br><span style="font-weight:bold">Format:</span> Hierarchical Price (Charged By &lt;UsageType&gt;) if  UsageType  is present<br><span style="font-weight:bold">Example:</span> Hierarchical Price (Charged By Each Respective Tier)for Product signatureUnlimitedPlan  if Added in Cart <br><span style="font-weight:bold">Displays: </span>All usage charges, such as:<br>- one time charges. For more information, see <span style="font-style:italic">CartItemOneTimeChargeComponent</span><br>- recurring charges. For more information, see <span style="font-style:italic">CartItemRecurringChargeComponent</span><br>- usage charges. For more information, see <span style="font-style:italic">CartItemUsageChargeComponent</span><br></td>
  </tr>
  <tr>
    <td class="tg-0pky">CartItemOneTimeChargeComponent</td>
    <td class="tg-0pky">Updated</td>
    <td class="tg-0pky">A One Time Charges component to display one time charges on the <span style="font-weight:bold">Cart</span> Item.<br><br><span style="font-weight:bold">Format: </span>&lt;value&gt;&lt;currency&gt; &lt;billingEvent&gt;<br><span style="font-weight:bold">Example:</span> One Time Charge as 50.0 $ On Checkout for Product signatureUnlimitedPlan</td>
  </tr>
  <tr>
    <td class="tg-pcvp">CartItemRecurringChargeComponent</td>
    <td class="tg-pcvp">Updated</td>
    <td class="tg-pcvp">A Recurring Charges component to display recurring charges on the <span style="font-weight:bold">Cart</span> Item.<br><br><span style="font-weight:bold">Format:</span> &lt;value&gt;&lt;currency&gt; &lt;billingEvent&gt;<br><span style="font-weight:bold">Example: </span>Recurring Charges as 50.0 $ monthly for Product signatureUnlimitedPlan</td>
  </tr>
  <tr>
    <td class="tg-0pky">CartItemUsageChargeComponent</td>
    <td class="tg-0pky">Updated</td>
    <td class="tg-0pky">A Usage Charges component to display usages charges on the <span style="font-weight:bold">Cart</span> Item.<br><br><span style="font-weight:bold">Format:</span> &lt;value&gt;&lt;currency&gt; /&lt;usageUnit&gt; for &lt;cycle start&gt; to   &lt;cycle end&gt; &lt;usageUnit&gt;<br><span style="font-weight:bold">Example:</span> Usage Charge as 0.08 $ /minute for 1 to 100 minute for Product signatureUnlimitedPlan</td>
  </tr>
  <tr>
    <td class="tg-pcvp">TmaCartItemComponent</td>
    <td class="tg-pcvp">Updated</td>
    <td class="tg-pcvp">A Cart Item component that displays details of the cart items. It is updated to include TmaCartItemPriceDisplayComponent, if applicable.<br><span style="font-weight:bold">Format:</span> &lt;discounted value&gt; <br><span style="font-weight:bold">Example:</span> $50 $32 for Product signatureUnlimitedPlan.</td>
  </tr>
  <tr>
    <td class="tg-0pky">TmaAddedToCartDialogComponent</td>
    <td class="tg-0pky">Updated</td>
    <td class="tg-0pky">Added to the Cart dialog to show the entries added to the cart. This component is updated to show the formatted pay now price of the cart for composite pricing.</td>
  </tr>
  <tr>
    <td class="tg-pcvp">TmfProductComponent</td>
    <td class="tg-pcvp">Updated</td>
    <td class="tg-pcvp">Displays the prices of subscription order. This component is updated to include the <span style="font-style:italic">TmaCartItemPriceDisplayComponent</span>.</td>
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
  <tr>
    <td class="tg-0pky">TmaGuidedSellingAddedToCartDialogComponent</td>
    <td class="tg-0pky">Updated</td>
    <td class="tg-0pky">Guided Selling added to the Cart dialog to show the entries added to cart. This component is updated to show the formatted pay now price of the cart for composite pricing.</td>
  </tr>
</tbody>
</table>

## Further Reading

For further reading, see the following topics in the TUA Help portal.

- [Creating Composite Prices for a Simple Product Offering](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/cc31b2c3e2c049059766598fe0cd88de.html).
- [Pricing - Price Alteration Discounts]({{ site.baseurl }}{% link _pages/telco/price-alteration-discounts.md %}).
- [TUA APIs Documentation](https://help.sap.com/viewer/f59b0ac006d746caaa5fb599b4270151/2011/en-US/52cf34e46ce34672bc3e47bdabcbc838.html).
- [Making Components Visible](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/2005/en-US/1cea3b2cb3334fc085dda9cc070ad6ac.html).

---
title: Pricing - Price Alteration Discounts
---

{% capture version_note %}
{{ site.version_note_part1 }} 2.0 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The Price Alterations in the form of Discounts works on top of the Composite Pricing data model and enables the ability to offer fixed-price and percentage discounts at any level in the composite price structure, and for any type of charge including one-time charges, recurring charges, and usage-based charges. With price alteration - discounts, customers can see discounts upfront before placing their order. For more information, see [Price Alteration Discounts](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/61b21155624e4a498632964bc566e1eb.html) in the TUA Help portal.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Business Use Case

Customers browsing the storefront want to view detailed pricing information of a product offering.

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

The following figure illustrates the hierarchical structure of the price alteration discounts for Signature Unlimited Plan that is configured by the Administrator in the backoffice as an example.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/price-alteration-discounts.png" alt="Price Alteration Discounts"></p>

## Changes Implemented

The following changes are implemented as part of this feature:

| Change                                                      	| Description                                                                                                                                                      	|
|-------------------------------------------------------------	|------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
| End-point   changes                                         	| The OCC endpoints will change   from REST/V2 to OCC/V2 in the `app.modules.ts` to use commerce webservices   endpoints. No API-related changes from the previous 	|
| Highest   priority price algorithm                          	| If the product offering has   multiple eligible prices, the one with the highest priority price will be   determined and displayed                               	|
| Product   Display Page (PDP) and Product Listing Page (PDP) 	| Displays the highest priority   SPO price                                                                                                                        	|

## Creating and Configuring Price Alteration Discounts in TUA

To create and configure price alterations discounts, see [Price Alteration Discounts](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/61b21155624e4a498632964bc566e1eb.html) in the TUA Help portal.

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
    <td class="tg-pcvp" colspan="3"><span style="font-weight:bold">Search Product Components</span></td>
  </tr>
  <tr>
    <td class="tg-0pky">TmaProductListItemComponent</td>
    <td class="tg-0pky">Updated</td>
    <td class="tg-0pky">This component extends the <span style="font-style:italic">ProductListItemComponent</span><span style="font-weight:bold;font-style:italic"> </span>to display information about the prices of the product offering in the <span style="font-weight:bold">Product Listing</span> <span style="font-weight:bold">Page (PLP)</span>.<br><br><span style="font-weight:bold">Displays:</span> Price Charges. For more information, see <span style="font-style:italic">TmaPriceDisplayComponent</span></td>
  </tr>
  <tr>
    <td class="tg-pcvp">TmaProductGridItemComponent</td>
    <td class="tg-pcvp">Updated</td>
    <td class="tg-pcvp">This component extends the <span style="font-style:italic">ProductGridItemComponent</span> to display information about the prices of the product offering in the <span style="font-weight:bold">Product Grid Item </span>page.<br><br><span style="font-weight:bold">Displays:</span> Price Charges. For more information, see <span style="font-style:italic">TmaPriceDisplayComponent</span></td>
  </tr>
  <tr>
    <td class="tg-0pky" colspan="3"><span style="font-weight:bold">Product Price Components</span></td>
  </tr>
  <tr>
    <td class="tg-pcvp">TmaPriceDisplayComponent</td>
    <td class="tg-pcvp">New</td>
    <td class="tg-pcvp">A Price Display component to display prices in the <span style="font-weight:bold">Product</span> pages. It includes subsequent product charge types components.<br><br><span style="font-weight:bold">Format: </span>&lt;POP Name&gt; In Case No &lt;UsageType&gt;) is present<br><span style="font-weight:bold">Example:</span> Activation Charges for Product signatureUnlimitedPlan<br><br><span style="font-weight:bold">Format:</span> &lt;POP Name&gt; (Charged By &lt;UsageType&gt;) if  UsageType  is present<br><span style="font-weight:bold">Example:</span> Per MB Charges (Charged By Highest Applicable Tier) for Product signatureUnlimitedPlan <br><br>Displays all usage charges, such as: - alteration charges. For more information, see TmaAlterationDetailsComponent</td>
  </tr>
  <tr>
    <td class="tg-0pky">TmaAlterationDetailsComponent</td>
    <td class="tg-0pky">New</td>
    <td class="tg-0pky">An Alteration Display component to display alterations charges in the <span style="font-weight:bold">Product</span> pages.<br><br><span style="font-weight:bold">Format:</span> &lt;value&gt;&lt;currency&gt; OFF &lt;billingEvent&gt; : Without Cycle<br><span style="font-weight:bold">Examples: </span><br>-10.0 $ OFF On Checkout  for Product signatureUnlimitedPlan <br>-20.0 % OFF On Checkout for Product signatureUnlimitedPlan<br><br><span style="font-weight:bold">Format: </span>&lt;value&gt;&lt;currency&gt; OFF &lt;billingEvent&gt; for &lt;cycle start&gt; to &lt;cycle end&gt;: With Cycle<br><span style="font-weight:bold">Example:</span> -10.0 $ OFF monthly for 1 to 6  for Product signatureUnlimitedPlan</td>
  </tr>
  <tr>
    <td class="tg-pcvp" colspan="3"><span style="font-weight:bold">Cart Components</span></td>
  </tr>
  <tr>
    <td class="tg-0pky">TmaCartitemPriceDisplayComponent</td>
    <td class="tg-0pky">New</td>
    <td class="tg-0pky">A Price Display component to display prices on the cart and it includes subsequent cart charge types components. Hierarchical Price, in case no &lt;UsageType&gt;) is present.<br><br><span style="font-weight:bold">Format:</span> Hierarchical Price In Case No &lt;UsageType&gt;) is present<br><span style="font-weight:bold">Example:</span> Hierarchical Price for Product signatureUnlimitedPlan if Added in Cart<br><br><span style="font-weight:bold">Format:</span> Hierarchical Price (Charged By &lt;UsageType&gt;) if  UsageType  is present<br><span style="font-weight:bold">Example:</span> Hierarchical Price (Charged By Each Respective Tier)for Product signatureUnlimitedPlan  if Added in Cart <br><span style="font-weight:bold">Displays: </span>All usage charges, such as: alteration charges. For more information, see <span style="font-style:italic">CartItemAlterationsDetailsComponent</span></td>
  </tr>
  <tr>
    <td class="tg-pcvp">CartItemAlterationsDetailsComponent</td>
    <td class="tg-pcvp">New</td>
    <td class="tg-pcvp">An Alteration Details component to display alterations charges on the <span style="font-weight:bold">Cart</span> pages<br><br><span style="font-weight:bold">Format:</span> &lt;value&gt;&lt;currency&gt; OFF &lt;billingEvent&gt; : Without Cycle<br><span style="font-weight:bold">Examples:</span> <br>-10.0 $ OFF On Checkout  for Product signatureUnlimitedPlan <br>-20.0 % OFF On Checkout for Product signatureUnlimitedPlan<br><br><span style="font-weight:bold">Format:</span> &lt;value&gt;&lt;currency&gt; OFF &lt;billingEvent&gt; for &lt;cycle start&gt; to &lt;cycle end&gt;: With Cycle<br><span style="font-weight:bold">Example:</span> -10.0 $ OFF monthly for 1 to 6  for Product signatureUnlimitedPlan</td>
  </tr>
  <tr>
    <td class="tg-0pky">TmaCartItemComponent</td>
    <td class="tg-0pky">Updated</td>
    <td class="tg-0pky">A Cart Item component that displays details of the cart items. It is updated to include TmaCartItemPriceDisplayComponent and to show pay now prices with alterations, if applicable.<br><span style="font-weight:bold">Format:</span> &lt;discounted value&gt; <br><span style="font-weight:bold">Example:</span> $50 $32 for Product signatureUnlimitedPlan.</td>
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
</tbody>
</table>

## Further Reading

For further reading, see the following topics in the TUA Help portal.

- [Price Alterations](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/8863e0400d5448a480c1d330826b92dd.html).
- [Creating Price Row for a Price Context](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2011/en-US/edd790667fd54960a216646c85deb5a7.html).
- [Pricing - Composite Pricing]({{ site.baseurl }}{% link _pages/telco/composite-pricing.md %})
- [TUA APIs Documentation](https://help.sap.com/viewer/f59b0ac006d746caaa5fb599b4270151/2011/en-US/52cf34e46ce34672bc3e47bdabcbc838.html).
- [Making Components Visible](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/2005/en-US/1cea3b2cb3334fc085dda9cc070ad6ac.html).

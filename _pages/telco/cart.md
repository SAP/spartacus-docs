---
title: Cart
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.0 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The cart works differently in TUA Spartacus than in core Commerce Spartacus and needs to support product offerings as well as the complex pricing structure to support multiple types of charges including one-time charges, recurring charges, and usage-based charges.   Amongst various charges, for the cart, Customers need to be aware of the pay now charges upon checkout as well as the monthly recurring charge commitment.

**Note:**  With TUA Spartacus 3.0, the cart will leverage the [Complex Industry Cart](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2102/en-US/33005fa795d2425282ffe769737e27e7.html).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Components

- `TmaAddedToCartDialogComponent` extends `AddedToCartDialogComponent` to display Pay on Checkout price of the Product Offering and Cart total price in add to cart pop-up when the product is added to cart.
    - Pay On Checkout: pay on checkout price is displayed as a sum of the total pay now one-time charge prices. 
    - Cart Total: price displayed is the subtotal cart price, which is a sum of each product Pay On Checkout price.
- `TmaCartItemListComponent` extends `CartItemListComponent` to display Pay on Checkout label in the Cart.
    - Pay On Checkout: column label respective to the pay on checkout price.
- `TmaCartItemComponent` extends `CartItemComponent` to display Pay on Checkout price and the other prices of the Product Offering in the Cart.
    - Pay On Checkout: pay on checkout price is displayed as a sum of the total pay now, one time charge prices.
    - Other Prices: rest of the prices are displayed below the item description on two columns:
        - first column: Recurring charges and One-time charges
        - second column: Usage charges
    - Recurring prices: prices are displayed on different rows and each price contains:
        - Months label
        - Cycles: the period of time, when there is no cycle end is displayed as 'onwards'
        - price and currency
        - billing frequency
    - One-time charges: prices are displayed on different rows and each price contains:
        - price and currency 
        - billing time description
    - Usage Charges: prices are displayed on different rows and each price contains:
        - Tiers: the tier start and end
        - price and currency
        - unit of measure
- `TmaOrderSummaryComponent` extends `OrderSummaryComponent` to display Subtotal, Delivery cost, and Pay on Checkout Total price in the Cart.
    - Subtotal: price displayed is the subtotal cart price, which is a sum of each product Pay On Checkout price.
    - Estimated shipping: delivery cost which is taken from the cart costs or 'TBD' if the delivery information and delivery mode are not provided.
    - Pay On Checkout Total: price displayed is the total cart price, which is a sum of the subtotal cart price and the cart costs prices (for example, delivery cost, discounts and so on.)

## Further Reading

For more information, see [Complex Pricing on Cart Level](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/525a0a7eafbb4d3ab988872a21e0e3b3.html) in the TUA Help portal.

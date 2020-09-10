---
title: Order
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

The order display and structure for TUA differs from core commerce as product offering prices include one-time charges, recurring charges, and usage charges.

The Order Review allows customers to browse through their orders and see price details of the cart and cart item of the selected order, the Order Summary displays the final price of the order after discounts and other charges before proceeding to checkout, and the Order Confirmation displays the detailed information of the placed order. 

## Order Confirmation Components 

- `TmaOrderConfirmationItemsComponent` extends `OrderConfirmationItemsComponent` display Pay on Checkout and other prices of the Product Offering in the Order History. Information displayed is the same as for `TmaCartItemComponent`.
- `TmaOrderConfirmationTotalsComponent` extends `OrderConfirmationTotalsComponent` to display Subtotal, Delivery cost, and Pay on Checkout Total price on the Order Confirmation. Information displayed is the same as for `TmaOrderSummaryComponent`, and the only difference is that the Delivery Cost is always displayed.

## Further Reading

For more information, see [Pricing at Cart and Order Level](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/2007/en-US/91a9faae27bb4a7f8baa46a57078cd61.html) in the TUA Help portal.

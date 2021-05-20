---
title: Order
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.0 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The order works differently in TUA Spartacus than in core Commerce Spartacus and needs to support product offerings as well as the complex pricing structure to support multiple types of charges including one-time charges, recurring charges, and usage charges.

The Order Review allows customers to browse through their orders and see price details of the cart and cart item of the selected order, the Order Summary displays the final price of the order after discounts and other charges before proceeding to checkout, and the Order Confirmation displays the detailed information of the placed order.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Components

- `TmaOrderConfirmationItemsComponent` extends `OrderConfirmationItemsComponent` display Pay on Checkout and other prices of the Product Offering in the Order History. Information displayed is the same as for `TmaCartItemComponent`.
- `TmaOrderConfirmationTotalsComponent` extends `OrderConfirmationTotalsComponent` to display Subtotal, Delivery cost, and Pay on Checkout Total price on the Order Confirmation. Information displayed is the same as for `TmaOrderSummaryComponent`, and the only difference is that the Delivery Cost is always displayed.

## Further Reading

For more information, see [Pricing at Cart and Order Level](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/2007/en-US/91a9faae27bb4a7f8baa46a57078cd61.html) in the TUA Help portal.

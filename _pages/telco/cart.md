---
title: Cart
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

Cart is redesigned to offer composite price structure support for allowing multiple types of charges in a cart. When an order is placed, all charges are passed over to the order (that is one-time charges, recurring charges) so that the charges can be sent to third-party systems for further processing such as billing and fulfillment.

## Pricing in Cart Page

The Added To Cart Dialog Component is updated to display the sum of the Pay Now prices of that Product Offering and The Pay Now total for the items in the cart. The Cart Item component is updated to display prices configured in the for the Product Offering:

- Sum of Pay Now prices 
- Recurring Charges 
- Usage Charges 
- Sum of Cancellation Fees 
- Sum of On First Bill Fees

The Order Summary Component is updated to display the sum of the Pay Now prices of the items present in the cart.

## Further Reading

For more information, see [Complex Pricing on Cart Level](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/525a0a7eafbb4d3ab988872a21e0e3b3.html) in the TUA Help portal.
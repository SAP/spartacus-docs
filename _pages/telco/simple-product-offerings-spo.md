---
title: Simple Product Offerings (SPOs)
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

A Product Offering (PO) represents how the Product Specification is sold and contains the market details over a particular period of time. When customers select Products from the `ProductCatalog` (be it an online website or a brochure), it is the Product Offering’s details that they are looking at and which are reflected in what they agree to contractually.

The Product Listing page displays the list of products along with their price and other details.

In the Product Details page, the minimum price algorithm is used to determine the minimum price for the product offering (the algorithm is the same as in the backend). The product summary component is updated to include not only the sum of the pay now prices, but the recurring charges as well.

The product details tab component is updated to include contract duration, usage charges, the sum of on first bill charges and the sum of cancellation fees.

**Note:** These are displayed only if such prices are configured for the Product Offering in the Backoffice.

## Further Reading

For more information, see [Product Offerings](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/315410098c024e50adf4c43373761936.html) in the TUA Help portal.
---
title: Pricing - Subscription Rate Plan
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

This feature enables customers to browse through the Telco SPA Store and purchase Product Offerings from a dedicated Product Catalog.

A Product Offering includes the specification of a product and also the market details of the product offering for a particular period of time. When customers select a particular product from the `ProductCatalog`, either from an online portal or from a brochure, the details of the selected product offering is displayed for the customers, which allows them to check and confirm before purchasing.

## Product Price Components

- `TmaOneTimeChargeComponent` displays one-time charges as:
    - main area display: displays the price list provided in the input in the following format:
      - `<billing event>: <currency> <sum of the prices>`
      - If the Product Offering has no pay now prices 0 will be displayed for the value. If the price has no billingEvent 'Pay Now' will be displayed.
    - not main area display: displays the price list provided in the input in the following format:
      - `<currency><sum of cancellation fees> - <billing event>` 
- `TmaRecurringChargeComponent` displays recurring charges as:
    - In case of one recurring charge for the entire contract term: 
      - Recurring Charges: `<currency> <value> /<billingFrequency>`
    - In case of multiple recurring charges:
      - Recurring Charges: `<currency> <value> /<mo/yr/qr> <for first/for next/for last> <duration> <month/months>`
    - If the Product Offering has no recurring prices, this section is not displayed.
- `TmaUsageChargeComponent` displays all the usage charges as:
    - each respective tier usage charges
    - highest applicable tier usage charges
    - not applicable tier usage charges
    - volume usage charges
- `TmaPerUnitChargeComponent` displays per unit usage charges in the following format:
    - each respective tier usage charge prices/not applicable usage charge prices: `<usage charge name>, Charges Each Respective Tier:`
      - From `<usage charge tier start>` to  `<usage charge tier end>: <currency> <price> / <usage unit>` each
      - From `<maximum tier end + 1>` onwards: `<currency> <price> / <usage unit>` each (**For overage prices)
    - highest applicable tier usage charge prices: `<usage charge name>`, Charges Each Respective Tier:
      - From `<usage charge tier start>` to `<usage charge tier end>`: `<currency> <price> / <usage unit>` each
      - From `<maximum tier end + 1>` onwards `<currency> <price> / <usage unit>` each (**For overage prices)
    - If the usage charge has no name, 'Per Unit' will be displayed instead.
- `TmaVolumeChargeComponent` displays volume usage charges in the format mentioned below:
    - volume usage charges: `<usage charge name>`, Charges:
      - From `<usage charge tier start>` up to `<usage charge tier end> <usage unit>: <currency> <price>`
      - From `<maximum tier end + 1> <usage unit>` onwards `<currency> <price>` (**For overage prices)

## Further Reading

For more information, see [Subscription Rate Plan](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/2007/en-US/8e591e48aa604b2f8c4a0d9804c6d6f5.html) in the TUA Help Portal.
---
title: Product Offering Prices
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

## Minimum Price Algorithm

If the product offerings have multiple eligible prices, minimum price algorithm is used to determine the minimum price: 

- Only recurring charges and one-time charges are taken into consideration when determining minimum price.
- The first defined recurring charges are compared. Price that has the smaller recurring charge will be the minimum price.
- If the recurring charges are equal, the first price will be the minimum price.
- If neither price has recurring charges, one-time charges are compared. 
- The first defined one-time charges are compared. Price that has the smaller one-time charge will be the minimum price. 
- If one of the prices does not have recurring charges or one-time charges, the value for the recurring charge or one-time charge is interpreted as 0 by the algorithm.

## Configuration 

The client application allows customers to configure certain variables that are exposed through `TmaB2cStorefrontModule`, in order to make the application more flexible. These values can be configured in `app.module.ts` in the imports section under `TmaB2cStorefrontModule.withConfig({ ... })` config. 

#### Configurable Variables
`billingFrequency` – list of billing frequency and their value in months. Used for converting billing frequency string into their value in months.

#### Syntax
Billing Frequency

```ts
billingFrequency: [
  {
    key: <string>,
    value: <number>,
  },
  ...
  {
    key: <string>,
    value: <number>,
  }
],
```

#### Default values
Billing Frequency

```ts
billingFrequency: [
  {
    key: 'yearly',
    value: 12,
  },
  {
    key: 'year',
    value: 12,
  },
  {
    key: 'annually',
    value: 12,
  },
  {
    key: 'annual',
    value: 12,
  },
  {
    key: 'monthly',
    value: 1,
  },
  {
    key: 'month',
    value: 1,
  },
  {
    key: 'quarterly',
    value: 3,
  },
  {
    key: 'quarter',
    value: 3,
  },
],
```

## Further Reading

For more information, see [Pricing](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/ad4430d10fc3477096752d83f935faf9.html) in the TUA Help Portal.
---
title: Product Offering Prices
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

This feature enables customers to browse through the Telco SPA Store and purchase Product Offerings from a dedicated Product Catalog.

A Product Offering (PO) represents how the Product Specification is sold and contains the market details over a particular period of time. When customers select Products from the `ProductCatalog` (be it an online website or a brochure), it is the Product Offering’s details that they are looking at and which are reflected in what they agree to contractually.

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

For more information, see [Pricing](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/ad4430d10fc3477096752d83f935faf9.html) in the TUA Help portal.
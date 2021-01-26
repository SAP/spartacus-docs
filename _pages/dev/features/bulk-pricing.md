---
title: Bulk Pricing
feature:
  - name: Bulk Pricing
    spa_version: 3.2
    cx_version: 2005
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.3 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

B2B Bulk Pricing allows users to be notified about potential saving opportunities that exist when purchasing specific products in bulk. By displaying a pricing table on the product's detail page, users are made aware of different price tiers based on quantity purchased.

## CMS Component

B2B Bulk Pricing, is driven by CMS. To have this CMS component, an ImpEx similar to this can be used:

```sql
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;ProductSummarySlot;Summary for product details;ProductImagesComponent,ProductIntroComponent,ProductSummaryComponent,VariantSelector,BulkPricingTableComponent,AddToCart,ConfigureProductComponent

INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;BulkPricingTableComponent;BulkPricingTableComponent;BulkPricingTableComponent
```

## Configuring

No special configuration is required.

## Extending

No special extensibility is available for this feature.

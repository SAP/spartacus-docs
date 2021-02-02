---
title: Bulk Pricing
feature:
  - name: Bulk Pricing
    spa_version: 3.2
    cx_version: 2005
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

B2B Bulk Pricing allows users to see potential savings for specific products when they are purchased in bulk. A pricing table is displayed on the product details page that lists the different price tiers for the product, based on the quantity that is purchased.

## CMS Component

B2B Bulk Pricing is driven by CMS. You can add the bulk pricing table to your product pages using ImpEx similar to the following:

```text
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

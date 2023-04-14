---
title: Future Stock
feature:
- name: Future Stock
  spa_version: 6.0
  cx_version: 2205
---

{% capture version_note %}
{{ site.version_note_part1 }} 6.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The future stock feature allows you to see the future availability of a product on the product details page. You need to be logged in to see it.  When you click on the `Future availability` button, an accordion expands and displays a list of future availabilities for the product. If the list is not available, the following message is displayed: "The product has no future availability information".

The following is an example of the `Future Availability` dropdown accordion that appears in the product summary:

![Future Stock Example]({{ site.baseurl }}/assets/images/future-stock-feature.png)

## Requirements

The future stock feature requires SAP Commerce Cloud 2205 or newer.

## Enabling Future Stock

The future stock feature can be enabled by installing the `@spartacus/product` feature library. For more information, see [Installing Additional Composable Storefront Libraries](https://help.sap.com/docs/SAP_COMMERCE_COMPOSABLE_STOREFRONT/eaef8c61b6d9477daf75bff9ac1b7eb4/e38d45609de04412920a7fc9c13d41e3.html?locale=en-US#loioaa76b408d0324aea889aeeaed899144a).

### CMS Components

The future stock feature is CMS driven, and consists of the `FutureStockComponent` CMS component.

You can configure the future stock feature by using SmartEdit to display the `FutureStockComponent` component in Spartacus, or you can manually add the component to a content slot using ImpEx.

If you are using the [Spartacus Sample Data Extension]([link](https://help.sap.com/docs/SAP_COMMERCE_COMPOSABLE_STOREFRONT/eaef8c61b6d9477daf75bff9ac1b7eb4/edc7f3a95ac4424b9cc5077d86a62e36.html?locale=en-US#loioedc7f3a95ac4424b9cc5077d86a62e36)), the `FutureStockComponent` component is already enabled. However, if you decide not to use the sample data extension, you can enable the component through ImpEx.

### Adding the CMS Component Manually

This section describes how to add the `FutureStockComponent` CMS component to Spartacus using ImpEx.

**Note:** The `$contentCV` variable that is used throughout the following ImpEx examples, and which stores information about the content catalog, is defined as follows:

```text
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]
```

You can create the `FutureStockComponent` CMS component with the following ImpEx:

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef
;;FutureStockComponent;Future Stock Component;FutureStockComponent;FutureStockComponent
```

You can add the `FutureStockComponent` CMS component to the `ProductSummarySlot` slot with the following ImpEx:

```text
UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)[mode=append]
;;ProductSummarySlot;FutureStockComponent
```

## Configuring

No special configuration is needed

## Extending

No special extensibility is available for this feature.

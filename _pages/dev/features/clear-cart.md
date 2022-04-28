---
title: Clear Cart
feature:
- name: Clear Cart
  spa_version: 5.0
  cx_version: 1905
---

{% capture version_note %}
{{ site.version_note_part1 }} 5.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The clear cart feature allows users to quickly clear their active shopping cart. This feature works for both registered users and anonymous users.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Enabling Clear Cart

Clear cart is CMS-driven and consists of one CMS component, called the `ClearCartComponent`.

You can enable the clear cart feature by installing the `@spartacus/cart` feature library and inserting the CMS component through ImpEx.

If you are using version 5.0 or newer of the `spartacussampledata` extension, the `ClearCartComponent` is already enabled. If you wish to enable the clear cart feature and you are are not using the `spartacussampledata` extension, you can create the clear cart CMS component using ImpEx, as described in the following section.

For more information about the `spartacussampledata` extension, see [{% assign linkedpage = site.pages | where: "name", "spartacussampledata-extension.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/spartacussampledata-extension.md %}).

For more information about installing libraries, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

### Adding the Clear Cart CMS Component Manually

You can add the `ClearCartComponent` CMS component to Spartacus using ImpEx.

**Note:** The `$contentCV` variable that is used in the following ImpEx examples, and which stores information about the content catalog, is defined as follows:

```text
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]
```

1. Create the `ClearCartComponent` with the following ImpEx:

   ```text
   INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef
   ;;ClearCartComponent;Clear Cart Component;ClearCartComponent;ClearCartComponent
   ```

1. Enable the `ClearCartComponent` by inserting the CMS component in the `Cart Page` slot with the following ImpEx:

   ```text
   INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
   ;;TopContentSlot-cartPage;Top content for Cart Slot;AddToSavedCartsComponent,CartComponent,ClearCartComponent,SaveForLaterComponent,ImportExportOrderEntriesComponent
   ```

## Configuring

No special configuration is needed for this feature.

## Extending

No special extensibility is available for this feature.

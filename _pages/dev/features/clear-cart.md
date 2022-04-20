---
title: Clear Cart
feature:
  - name: Clear Cart
    spa_version: 5.0
    cx_version: 2105
---

{% capture version_note %}
{{ site.version_note_part1 }} 5.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The clear cart feature allows users to quickly clear their active shopping cart. This feature works for registered as well as guest users.

---

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

---

## Enabling Clear Cart
You can enable clear cart by installing the `@spartacus/cart` feature library and inserting the CMS component through ImpEx. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

### CMS Component

Clear cart is CMS-driven and consists of the following CMS component:

- `ClearCartComponent`

If you are using the version 5.0 or greater of [{% assign linkedpage = site.pages | where: "name", "spartacussampledata-extension.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/spartacussampledata-extension.md %}), the clear cart component is already enabled. However, if you decide not to use the `spartacussampledata` extension, you can enable clear cart through ImpEx.

**Note:** The `$contentCV` variable that is used throughout the following ImpEx examples, and which stores information about the content catalog, is defined as follows:

```text
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]
```

#### Adding Clear Cart CMS Component Manually

This section describes how to add the clear cart CMS component to Spartacus using ImpEx.

You can enable the **Clear Cart** component by adding the CMS data with the following ImpEx:

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef
;;ClearCartComponent;Clear Cart Component;ClearCartComponent;ClearCartComponent
```

You can add the **Clear Cart** component by inserting the CMS component in the **Cart Page** slot with the following ImpEx:

```text
INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;TopContentSlot-cartPage;Top content for Cart Slot;AddToSavedCartsComponent,CartComponent,ClearCartComponent,SaveForLaterComponent,ImportExportOrderEntriesComponent
```
## Configuring

No special configuration is needed for this feature.

## Extending

No special extensibility is available for this feature.

---
title: B2B Reorder
---

In the B2B storefront, you can use the **Reorder** button to add all of the items from a previous order to your cart.

The **Reorder** button appears on the **Order Details** page, which you can access by selecting **Order History** from the **My Account** menu, and then selecting any order.

The following is an example of the **Reorder** button, which appears by default at the bottom of the **Order Details** page:

<img src="{{ site.baseurl }}/assets/images/SPRT_Reorder_Feature.png" alt="B2B Reorder Button" width="800" border="1px" />

**Note:** When you use the reorder feature, the active cart is replaced by a new cart that contains only the items from the order you are viewing on the **Order Details** page. Any items that were previously in your cart are effectively removed.

## Enabling Reorder

You can enable the reorder feature by installing the `@spartacus/order` feature library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

### CMS Components

The reorder feature is CMS driven, and consists of the `AccountOrderDetailsReorderComponent` CMS component.

You can configure the reorder feature by using SmartEdit to display the `AccountOrderDetailsReorderComponent` component in Spartacus, or you can manually add the component to a content slot using ImpEx.

If you are using the [spartacussampledata extension]({{ site.baseurl }}{% link _pages/install/spartacussampledata-extension.md %}), the `AccountOrderDetailsReorderComponent` component is already enabled. However, if you decide not to use the sample data extension, you can enable the component through ImpEx.

#### Adding the CMS Component Manually

This section describes how to add the `AccountOrderDetailsReorderComponent` CMS component to Spartacus using ImpEx.

**Note:** The `$contentCV` variable that is used throughout the following ImpEx examples, and which stores information about the content catalog, is defined as follows:

```text
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]
```

You can create the `AccountOrderDetailsReorderComponent` CMS component with the following ImpEx:

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef
;;AccountOrderDetailsReorderComponent;Account Order Details Reorder Component;AccountOrderDetailsReorderComponent;AccountOrderDetailsReorderComponent
```

You can add the `AccountOrderDetailsReorderComponent` CMS component to the `BodyContent-orderdetail` slot with the following ImpEx:

```text
UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)[mode=append]
;;BodyContent-orderdetail;AccountOrderDetailsReorderComponent
```

## Configuring

No special configuration is required.

## Extending

No special extensibility is available for this feature.

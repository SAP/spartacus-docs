---
title: QuickBuy
---

Intro description of what QuickBuy is. Supports ApplePay and GooglePay.

List the storefront pages that support QuickBuy.

## Enabling QuickBuy

Is there a feature lib to install for QuickBuy? if so...

To enable QuickBuy, install the `@spartacus/quickbuy` feature library (???). For more information, see [Installing Additional Composable Storefront Libraries](link).

### CMS Components

<!-- Sample text (taken from _pages/dev/features/scheduled-replenishment.md)

If you are using the `spartacussampledata` extension to build your storefront, it includes all of the CMS data that is required for the QuickBuy feature, and it is enabled by default. If you are not using the `spartacussampledata` extension, you need to add the CMS components manually. For more information, see the following section. -->

### Adding the CMS Components Manually

<!-- Sample text!! Verify that it is accurate if you decided to include it!! (taken from _pages/dev/features/scheduled-replenishment.md)

**Note:** The `$contentCV` variable, which stores information about the content catalog, and which is used throughout the ImpEx in the following procedures, is defined as follows:

```text
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]

The following procedure describes how to enable checkout components for open payment framework, which is necessary if you are not using the `spartacussampledata` extension to build your storefront. -->

Provide ImpEx examples here...

## Configuring QuickBuy

You can configure QuickBuy to use both ApplePay and GooglePay...

### Configuring QuickBuy for ApplePay

Procedure

### Configuring QuickBuy for GooglePay

Procedure

### Configuring the Back End Link

Procedure

### Overwriting hardCodes Information

Procedure

<!-- If it makes sense to merge the steps for "Configuring the Back End Link" and "Overwriting hardCodes" into a single procedure (such as "Additional Configuration"), we can do that too. But if each procedure would contain multiple steps, then it make make sense to keep them as separate procedures, as they are laid out here. -->

## Extending QuickBuy

Is there anything partners can do to extend QuickBuy?

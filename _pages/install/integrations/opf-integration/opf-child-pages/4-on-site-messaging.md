---
title: On-site Messaging
---

On-site messaging is a feature that highlights available financing options on the Product Details page and the cart page. For example, you can display a banner or a button with a financing recommendation, such as splitting the total cart amount into three separate payments.

On-site messaging consists of an HTML chunk that is injected into the Product Details page or the cart page.

Before enabling on-site messaging in Spartacus, you must first enable the functionality in SAP Commerce Cloud. For more information, see [On-site Messaging](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/0996ba68e5794b8ab51db8d25d4c9f8a/2fac59c9bd7b41de8a5f3c0d7eda0e12.htm).

## Enabling On-Site Messaging

On-site messaging functionality is added to your storefront app when you install the open payment framework library, as described in [Enabling Open Payment Framework in Spartacus](link-to-section-in-1-open-payment-framework-in-spartacus.md).

### CMS Components

The on-site messaging feature is CMS-driven and consists of the `OpfCtaScriptsComponent` component.

**Note:** The order confirmation scripts feature also uses the `OpfCtaScriptsComponent` component. On-site messaging is enabled when the `OpfCtaScriptsComponent` component is enabled on the Product Details page or the cart page. Order confirmation scripts are enabled when the `OpfCtaScriptsComponent` component is enabled on the Order Details page or the Order Confirmation page.

If you are using the [Spartacus Sample Data Extension](link), the `OpfCtaScriptsComponent` component is already enabled. However, if you decide not to use the `spartacussampledata` extension, you can enable the `OpfCtaScriptsComponent` component manually through ImpEx.

### Adding CMS Components Manually

To add on-site messaging to the Product Details page and the cart page, import the following ImpEx:

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;OpfCtaScriptsComponent;Opf Cta Scripts Component;OpfCtaScriptsComponent

# Add CTA script to PDP content slot
UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(uid,$contentCV)
;;ProductSummarySlot;Site Context Slot;true;ProductImagesComponent, ProductIntroComponent, QualtricsEmbeddedFeedbackComponent, ProductSummaryComponent, VariantSelector, ConfigureProductComponent, AddToWishListComponent, StockNotificationComponent, OpfCtaScriptsComponent, AddToCart

# Add CTA script to cart content slot
UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(uid,$contentCV)
;;TopContent-cartPage;Top content for Cart Slot;true;OpfCtaScriptsComponent, AddToSavedCartsComponent, CartComponent, ClearCartComponent, SaveForLaterComponent, ImportExportOrderEntriesComponent
```

**Note:** The `$contentCV` variable that is used in the above ImpEx example, and which stores information about the content catalog, is defined as follows:

```text
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]
```

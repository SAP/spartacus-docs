---
title: Order Confirmation Scripts
---

Order confirmation scripts display a post-order feedback / instructions to the customer. Examples include outputting bank details or voucher codes for delayed payment methods like Boletto, or outputting to customer direct debit mandates.

Call-to-action (CTA) scripts, such as order confirmation scripts, consist of a bundle of HTML snippets with JS/CSS resource files being injected into Spartacus pages.

For more information on order confirmation scripts in the back end, see https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/0996ba68e5794b8ab51db8d25d4c9f8a/7e0fed03903743a8b961ec5ffaa1c272.html.

## Enabling Order Confirmation Scripts

You can enable order confirmation scripts by installing the `@spartacus/opf` OPF library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

### CMS Components

Order confirmation scripts are CMS-driven and consist of the following CMS component:

-`OpfCtaScriptsComponent`

Order confirmation scripts and on-site messaging both use the CTA scripts CMS component, `OpfCtaScriptsComponent`. The order confirmation scripts feature is enabled when the `OpfCtaScriptsComponent` CMS component is enabled on the Order Confirmation or Order Details pages. The on-site messaging feature is enabled when the `OpfCtaScriptsComponent` CMS component is enabled on the Product Details or Cart pages.

You can configure order confirmation scripts by using SmartEdit to display the CTA scripts component in Spartacus, or you can manually add it to content slots using ImpEx.

If you are using the [{% assign linkedpage = site.pages | where: "name", "spartacussampledata-extension.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/spartacussampledata-extension.md %}), the CTA scripts component is already enabled. However, if you decide not to use the `spartacussampledata` extension, you can enable the CTA scripts component through ImpEx.

**Note:** The `$contentCV` variable, which stores information about the content catalog, and which is used throughout the ImpEx in the following procedures, is defined as follows:

```text
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]
```

### Adding CMS Components Manually

This section describes how to add the CTA scripts CMS component to Spartacus using ImpEx.

Add the CTA scripts CMS component to the Order Confirmation and Order Details pages with the following ImpEx:

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;OpfCtaScriptsComponent;Opf Cta Scripts Component;OpfCtaScriptsComponent

UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(uid,$contentCV)
;;ProductSummarySlot;Site Context Slot;true;ProductImagesComponent, ProductIntroComponent, QualtricsEmbeddedFeedbackComponent, ProductSummaryComponent, VariantSelector, ConfigureProductComponent, AddToWishListComponent, StockNotificationComponent, OpfCtaScriptsComponent, AddToCart
;;TopContent-cartPage;Top content for Cart Slot;true;OpfCtaScriptsComponent, AddToSavedCartsComponent, CartComponent, ClearCartComponent, SaveForLaterComponent, ImportExportOrderEntriesComponent
```


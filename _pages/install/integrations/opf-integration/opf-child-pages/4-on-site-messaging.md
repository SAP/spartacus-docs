---
title: On-Site Messaging
---

The open payment framework supports on-site messaging that highlights available finance options. For example, you can use on-site messaging to display a banner advertising financial options such as 'Pay in three installments of X amount'.

Call-to-action (CTA) scripts, such as those used for on-site messaging, consist of a bundle of HTML snippets with JS/CSS resource files being injected into Spartacus pages.

For more information on configuring on-site messaging in the back end, see
https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/0996ba68e5794b8ab51db8d25d4c9f8a/2fac59c9bd7b41de8a5f3c0d7eda0e12.htm.

## Enabling On-Site Messaging

You can enable on-site messaging by installing the `@spartacus/opf` OPF library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

### CMS Components

On-site messaging is CMS-driven and consists of the following CMS component:

-`OpfCtaScriptsComponent`

Order confirmation scripts and on-site messaging both use the CTA scripts CMS component. The order confirmation scripts feature is enabled when the `OpfCtaScriptsComponent` CMS component is on the Order Confirmation or Order Details pages. The on-site messaging feature is enabled when the `OpfCtaScriptsComponent` CMS component is on the Product Details or Cart pages.

You can configure on-site messaging by using SmartEdit to display the CTA scripts component in Spartacus, or you can manually add it to content slots using ImpEx.

If you are using the [{% assign linkedpage = site.pages | where: "name", "spartacussampledata-extension.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/spartacussampledata-extension.md %}), the CTA scripts component is already enabled. However, if you decide not to use the `spartacussampledata` extension, you can enable the CTA scripts component through ImpEx.

### Adding CMS Components Manually

This section describes how to add the CTA scripts CMS component to Spartacus using ImpEx.

Add the CTA scripts CMS component to the Cart and Product Details pages as follows:

```sql
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]

INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;OpfCtaScriptsComponent;Opf Cta Scripts Component;OpfCtaScriptsComponent

UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(uid,$contentCV)
;;ProductSummarySlot;Site Context Slot;true;ProductImagesComponent, ProductIntroComponent, QualtricsEmbeddedFeedbackComponent, ProductSummaryComponent, VariantSelector, ConfigureProductComponent, AddToWishListComponent, StockNotificationComponent, OpfCtaScriptsComponent, AddToCart
;;BodyContent-orderConfirmation;Body Content Slot for Order Confirmation;true;OpfCtaScriptsComponent, OrderConfirmationThankMessageComponent, OrderConfirmationShippingComponent, OrderConfirmationPickUpComponent, ExportOrderEntriesComponent, OrderConfirmationBillingComponent, OrderConfirmationTotalsComponent, OrderConfirmationContinueButtonComponent
```
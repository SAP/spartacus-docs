---
title: Order Confirmation Scripts
---

Order Confirmation Scripts display a post-order feedback / instructions to the customer. Examples include outputting bank details or voucher codes for delayed payment methods like Boletto, or to output to customer direct debit mandates.
It can be enabled on Confirmation and Order details pages.
Call-To-Action Scripts consists of a bundle of 'HTML snippet with JS/CSS resource files' beeing injected into Spartacus page.
When rendered it can take shape of 'outputting bank details', 'Voucher code for next Purchase' or output to customer direct debit mandates.

## Enabling Order Confirmation Scripts

Order Confirmation Scripts feature is automatically added when installing OPF lib `@spartacus/opf`.
It is CMS-based, note order-confirmation-scripts and on-site messaging use the same CMS component:
For clarity:
Order-Confirmation-Scripts feature is enabled when OpfCtaScriptsComponent CMS component is on Confirmation and/or order details pages.
On-site Messaging feature is enabled when OpfCtaScriptsComponent CMS component is on PDP and/or Cart pages.

### CMS Components

If you are using the `spartacussampledata` extension to build your storefront, it includes all of the CMS data that is required for the QuickBuy feature, and it is enabled by default. If you are not using the `spartacussampledata` extension, you need to add the CMS components manually. For more information, see the following section.

### Adding the CMS Components Manually

OpfCtaScriptsComponent CMS Component is in charge of displaying Order Confirmation Scripts.
below impex, add the CMS cpomonent within Confirmation page and Order details page.
Note CTA stands for Call-To-Action.

**Note:** The `$contentCV` variable, which stores information about the content catalog, and which is used throughout the ImpEx in the following procedures, is defined as follows:

$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]

The following procedure describes how to enable CTA components for open payment framework, which is necessary if you are not using the `spartacussampledata` extension to build your storefront.

INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;OpfCtaScriptsComponent;Opf Cta Scripts Component;OpfCtaScriptsComponent

UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(uid,$contentCV)
;;ProductSummarySlot;Site Context Slot;true;ProductImagesComponent, ProductIntroComponent, QualtricsEmbeddedFeedbackComponent, ProductSummaryComponent, VariantSelector, ConfigureProductComponent, AddToWishListComponent, StockNotificationComponent, OpfCtaScriptsComponent, AddToCart
;;TopContent-cartPage;Top content for Cart Slot;true;OpfCtaScriptsComponent, AddToSavedCartsComponent, CartComponent, ClearCartComponent, SaveForLaterComponent, ImportExportOrderEntriesComponent

### Configuring the Back End Link

https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/0996ba68e5794b8ab51db8d25d4c9f8a/2fac59c9bd7b41de8a5f3c0d7eda0e12.html

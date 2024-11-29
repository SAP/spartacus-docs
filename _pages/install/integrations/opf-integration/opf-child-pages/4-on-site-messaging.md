---
title: On-site Messaging
---

On-site messaging highlights available finance option on Product Details page and Cart page.
It is a piece of HTML injected with spartacus page. As an examplem it can show a banner or button with financial advertisement such 'Pay in three parts of x amount'.

It is supported on PDP and cart page.

## Enabling On-site Messaging

On-site Messaging Scripts feature is automatically added when installing OPF lib `@spartacus/opf`.
It is CMS-based, note order-confirmation-scripts and on-site messaging use the same CMS component:
For clarity:
Order-Confirmation-Scripts feature is enabled when OpfCtaScriptsComponent CMS component is on Confirmation and/or order details pages.
On-site Messaging feature is enabled when OpfCtaScriptsComponent CMS component is on PDP and/or Cart pages.

### CMS Components

If you are using the `spartacussampledata` extension to build your storefront, it includes all of the CMS data that is required for the QuickBuy feature, and it is enabled by default. If you are not using the `spartacussampledata` extension, you need to add the CMS components manually. For more information, see the following section.

### Adding the CMS Components Manually

OpfCtaScriptsComponent CMS Component is in charge of displaying On-site Messaging.
below impex, add the CMS cpomonent within Confirmation page and Order details page.
Note CTA stands for Call-To-Action.

$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]

The following procedure describes how to enable CTA components for open payment framework, which is necessary if you are not using the `spartacussampledata` extension to build your storefront.

INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;OpfCtaScriptsComponent;Opf Cta Scripts Component;OpfCtaScriptsComponent

UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(uid,$contentCV)
;;ProductSummarySlot;Site Context Slot;true;ProductImagesComponent, ProductIntroComponent, QualtricsEmbeddedFeedbackComponent, ProductSummaryComponent, VariantSelector, ConfigureProductComponent, AddToWishListComponent, StockNotificationComponent, OpfCtaScriptsComponent, AddToCart
;;BodyContent-orderConfirmation;Body Content Slot for Order Confirmation;true;OpfCtaScriptsComponent, OrderConfirmationThankMessageComponent, OrderConfirmationShippingComponent, OrderConfirmationPickUpComponent, ExportOrderEntriesComponent, OrderConfirmationBillingComponent, OrderConfirmationTotalsComponent, OrderConfirmationContinueButtonComponent

### Configuring the Back End Link

https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/0996ba68e5794b8ab51db8d25d4c9f8a/2fac59c9bd7b41de8a5f3c0d7eda0e12.htm

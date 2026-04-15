---
title: Order Confirmation Scripts (CTA Scripts)
---

Order confirmation scripts, also known as Call-to-Action (CTA) scripts, display feedback or instructions to customers after an order has been placed. For example, an order confirmation message might provide bank details or voucher codes for a delayed payment method, such as Boleto. Another example is providing customers with a direct debit mandate.

Order confirmation scripts consist of a bundle that includes an HTML snippet with JS and CSS resource files.

Order confirmation scripts can be enabled on the Order Details page and the Order Confirmation page.

Before enabling order confirmation scripts in Spartacus, you must first enable them in SAP Commerce Cloud. For more information, see [Order Confirmation Scripts](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/0996ba68e5794b8ab51db8d25d4c9f8a/7e0fed03903743a8b961ec5ffaa1c272.html).

## Enabling Order Confirmation Scripts

The functionality for order confirmation scripts is added to your storefront app when you install the open payment framework library, as described in [Enabling Open Payment Framework in Spartacus](link-to-section-in-1-open-payment-framework-in-spartacus.md).

### CMS Components

The order confirmation scripts feature is CMS-driven and consists of the `OpfCtaScriptsComponent` component.

**Note:** The on-site messaging feature also uses the `OpfCtaScriptsComponent` component. Order confirmation scripts are enabled when the `OpfCtaScriptsComponent` component is enabled on the Order Details page or the Order Confirmation page. On-site messaging is enabled when the `OpfCtaScriptsComponent` component is enabled on the Product Details page or the cart page.

If you are using the [Spartacus Sample Data Extension](link), the `OpfCtaScriptsComponent` component is already enabled. However, if you decide not to use the `spartacussampledata` extension, you can enable the `OpfCtaScriptsComponent` component manually through ImpEx.

### Adding CMS Components Manually

To add order confirmation scripts to the Order Details page and the Order Confirmation page, import the following ImpEx:

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;OpfCtaScriptsComponent;Opf Cta Scripts Component;OpfCtaScriptsComponent

# Add CTA script order confirmation content slot
UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(uid,$contentCV)
;;BodyContent-orderConfirmation;Body Content Slot for Order Confirmation;true;OpfCtaScriptsComponent, OrderConfirmationThankMessageComponent, OrderConfirmationShippingComponent, OrderConfirmationPickUpComponent, ExportOrderEntriesComponent, OrderConfirmationBillingComponent, OrderConfirmationTotalsComponent, OrderConfirmationContinueButtonComponent

# Add CTA script to OPF order details page content slot
UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(uid,$contentCV)
;;BodyContent-orderdetail;Body Content Slot for My Account Order Details;true;OpfCtaScriptsComponent,AccountOrderDetailsSimpleOverviewComponent,AccountOrderDetailsGroupedItemsComponent,ExportOrderEntriesComponent,AccountOrderDetailsBillingComponent,AccountOrderDetailsTotalsComponent,AccountOrderDetailsActionsComponent
```

**Note:** The `$contentCV` variable that is used in the above ImpEx example, and which stores information about the content catalog, is defined as follows:

```text
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]
```

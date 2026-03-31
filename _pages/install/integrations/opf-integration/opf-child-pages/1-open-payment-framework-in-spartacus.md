---
title: SAP Open Payment Framework in Spartacus
---

Open payment framework allows you to quickly integrate your preferred digital payment service providers in Spartacus, and removes the need to code, integrate, and deploy extensions to the SAP Commerce Cloud codebase.

Open payment framework requires SAP Commerce Cloud 2211.30 or newer. Before integrating open payment framework with Spartacus, you need to configure open payment framework in SAP Commerce Cloud. For more information, see [Open Payment Framework](link to backend OPF docs).

## Enabling Open Payment Framework in Spartacus

To enable open payment framework, install the `@spartacus/opf` integration library. For more information, see [Installing Additional Composable Storefront Libraries](link).

Open payment framework provides the following parameters when you use schematics to install the `opf` library:

- `--opfBaseUrl`
- `--commerceCloudPublicKey`

The following is an example of installing the `opf` library using schematics with these parameters:

```bash
ng add @spartacus/opf --opfBaseUrl=https://my_opf_server --commerceCloudPublicKey=my_public_key_value
```

If you do not define the parameters, the value for each undefined parameter is set with a placeholder.

For more information about `--opfBaseUrl` and `--commerceCloudPublicKey`, see [Configuring Open Payment Framework Core Functionality](#configuring-open-payment-framework-core-functionality).

## CMS Components

Open payment framework is CMS-driven. If you are using the [Spartacus Sample Data Extension](link), the open payment framework CMS components are already enabled. However, if you decide not to use the `spartacussampledata` extension, you can enable the open payment framework CMS components manually through ImpEx.

Open payment framework requires three CMS elements to work properly: content pages, content slots, and page-slot relations. If you are not using the Spartacus Sample Data Extension, you can add each of these elements manually, as described in the following sections.

Content pages define the checkout pages users navigate to. Content slots are areas where components are placed within pages. Page-slot relations connect pages to slots and define the layout structure. Each ImpEx script is prepended with the following variables:

```text
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]
```

The `$contentCatalog` defines which content catalog to work with, and `$contentCV` (content catalog version) specifies the version of that catalog. These variables ensure that all the OPF components, pages, and slots are created in the correct catalog and version. You need to customize these variables to match your specific content catalog.

### Creating Content Pages

To implement the OPF components in your Spartacus storefront, you first create the actual checkout page that users navigate to during the OPF flow. This page is accessible through a specific route, such as `/checkout/opf-payment-and-review`, and uses the standard Spartacus checkout template structure. The page definition includes the template type, routing, and approval status that Spartacus needs to properly render the checkout experience.

The following is an example ImpEx script for adding an "OPF Checkout Payment And Review" content page:

```text
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]

# Add OPF ContentPages
INSERT_UPDATE ContentPage;$contentCV[unique=true];uid[unique=true];name;masterTemplate(uid,$contentCV);label;title[lang=en];defaultPage[default='true'];approvalStatus(code)[default='approved'];homepage[default='false']
;;OpfCheckoutPaymentAndReview;Opf Checkout Payment And Review;MultiStepCheckoutSummaryPageTemplate;/checkout/opf-payment-and-review;Checkout Payment and Review;true;check;false
```

### Creating Content Slots

After creating a content page, you need to create the content slots that hold the various checkout components. These slots are specifically designed for the OPF checkout flow, and include areas for delivery address selection, delivery mode selection, and the main payment and review section. Each slot is configured with the appropriate components that are displayed when users reach that step in the checkout process.

The following is an example ImpEx script for adding OPF content slots for delivery address, delivery mode, and the payment and review section:

```text
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]

# Add OPF ContentSlots (create new slots for OPF checkout flow)
INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;BodyContentSlot-checkoutOpfDeliveryAddress;Body Content Slot for Checkout OPF Delivery Address;CheckoutDeliveryAddressComponent
;;BodyContentSlot-checkoutOpfDeliveryMode;Body Content Slot for Checkout OPF Delivery Mode;CheckoutDeliveryModeComponent
;;BodyContentSlot-checkoutOpfPaymentAndReview;Body Content Slot for Checkout OPF Payment And Review;CheckoutProgressComponent,CheckoutProgressMobileTopComponent,OpfCheckoutPaymentAndReviewComponent,CheckoutProgressMobileBottomComponent,OpfExplicitTermsAndConditionsComponent
```

### Creating Page-Slot Relations

After creating a content page and adding the necessary content slots, you need to establish the connections between the pages and the slots to define the layout structure. This step determines which slots appear on which pages, as well as where they are positioned. For example, the main content area contains the primary checkout components, while the sidebar holds the order summary and payment details. These relations ensure that when users visit a checkout page, all the necessary components appear in the correct locations with the proper layout.

The following is an example ImpEx script for setting up these page-slot relations:

```text
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]

# Add OPF Page and ContentSlot relations
INSERT_UPDATE ContentSlotForPage;$contentCV[unique=true];uid[unique=true];position[unique=true];page(uid,$contentCV)[unique=true];contentSlot(uid,$contentCV)[unique=true]
;;SideContent-opfCheckoutDeliveryAddress;SideContent;OpfCheckoutDeliveryAddress;SideContentSlot-checkoutPaymentDetails
;;SideContent-CheckoutOpfDeliveryMode;SideContent;CheckoutOpfDeliveryMode;SideContentSlot-checkoutPaymentDetails
;;SideContent-CheckoutOpfPaymentAndReview;SideContent;CheckoutOpfPaymentAndReview;SideContentSlot-checkoutPaymentDetails
;;BodyContent-opfCheckoutDeliveryAddress;BodyContent;OpfCheckoutDeliveryAddress;BodyContentSlot-checkoutOpfDeliveryAddress
;;BodyContent-CheckoutOpfDeliveryMode;BodyContent;CheckoutOpfDeliveryMode;BodyContentSlot-checkoutOpfDeliveryMode
;;BodyContent-CheckoutOpfPaymentAndReview;BodyContent;CheckoutOpfPaymentAndReview;BodyContentSlot-checkoutOpfPaymentAndReview
```

### OPF Component Overview

The components listed below work together with the CMS structure described above. Each component is designed to be placed in specific content slots and pages to provide the complete OPF functionality experience. The storefront uses these CMS components for mapping with specific front-end components.

The following table describes each OPF-specific CMS component and where to add it:

| Component | Purpose | Where to Add | ImpEx Example | Slot Assignment Example |
| --- | --- | --- | --- | --- |
| `OpfCheckoutPaymentAndReviewComponent` | Handles payment selection and review in the checkout flow | Checkout payment and review page | `INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType`<br>`;;OpfCheckoutPaymentAndReviewComponent;OpfCheckoutPaymentAndReview;OpfCheckoutPaymentAndReview` | `INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)`<br>`;;BodyContentSlot-checkoutOpfPaymentAndReview;CheckoutProgressComponent,CheckoutProgressMobileTopComponent,OpfCheckoutPaymentAndReviewComponent,CheckoutProgressMobileBottomComponent,OpfExplicitTermsAndConditionsComponent` |
| `OpfCtaScriptsComponent` | Injects payment provider scripts for on-site messaging and order confirmation | Product Details Page, Cart Page, Order Confirmation Page, Order Details Page | `INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType`<br>`;;OpfCtaScriptsComponent;Opf Cta Scripts Component;OpfCtaScriptsComponent`                                                            | `UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid,$contentCV)`<br>`;;ProductSummarySlot;ProductImagesComponent, ProductIntroComponent, ProductSummaryComponent, VariantSelector, ConfigureProductComponent, AddToWishListComponent, StockNotificationComponent, OpfCtaScriptsComponent, AddToCart`<br>`;;BodyContent-orderConfirmation;OpfCtaScriptsComponent, OrderConfirmationThankMessageComponent, OrderConfirmationShippingComponent, OrderConfirmationPickUpComponent, ExportOrderEntriesComponent, OrderConfirmationBillingComponent, OrderConfirmationTotalsComponent, OrderConfirmationContinueButtonComponent` |
| `OpfQuickBuyButtonsComponent` | Displays Google Pay and Apple Pay buttons | Cart Page | `INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType`<br>`;;OpfQuickBuyButtonsComponent;Opf Quick Buy Buttons Component;OpfQuickBuyButtonsComponent` | `UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid,$contentCV)`<br>`;;CenterRightContentSlot-cartPage;CartTotalsComponent, CartApplyCouponComponent, CartQuickOrderFormComponent, OpfQuickBuyButtonsComponent, CartProceedToCheckoutComponent` |
| `OpfExplicitTermsAndConditionsComponent` | Shows explicit Terms and Conditions checkbox (optional) | Checkout payment and review page | `INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;visible`<br>`;;OpfExplicitTermsAndConditionsComponent;OpfExplicitTermsAndConditionsComponent;OpfExplicitTermsAndConditionsComponent;false` | `INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)`<br>`;;BodyContentSlot-checkoutOpfPaymentAndReview;CheckoutProgressComponent,CheckoutProgressMobileTopComponent,OpfCheckoutPaymentAndReviewComponent,CheckoutProgressMobileBottomComponent,OpfExplicitTermsAndConditionsComponent` |

The following section provides an example ImpEx script that adds all the above data to a specific content catalog.

### Complete OPF-Only ImpEx Script

The following example script includes all the necessary ImpEx statements to create a complete OPF setup:

```text
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]

# Add OPF CMSFlexComponents
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;OpfCheckoutPaymentAndReviewComponent;OpfCheckoutPaymentAndReview;OpfCheckoutPaymentAndReview
;;OpfCtaScriptsComponent;Opf Cta Scripts Component;OpfCtaScriptsComponent
;;OpfQuickBuyButtonsComponent;Opf Quick Buy Buttons Component;OpfQuickBuyButtonsComponent

# Add OPF Explicit T&C CMSFlexComponent as invisible (optional)
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;visible
;;OpfExplicitTermsAndConditionsComponent;OpfExplicitTermsAndConditionsComponent;OpfExplicitTermsAndConditionsComponent;false

# Add OPF ContentSlots (create new slots for OPF checkout flow)
INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;BodyContentSlot-checkoutOpfDeliveryAddress;Body Content Slot for Checkout OPF Delivery Address;CheckoutDeliveryAddressComponent
;;BodyContentSlot-checkoutOpfDeliveryMode;Body Content Slot for Checkout OPF Delivery Mode;CheckoutDeliveryModeComponent
;;BodyContentSlot-checkoutOpfPaymentAndReview;Body Content Slot for Checkout OPF Payment And Review;CheckoutProgressComponent,CheckoutProgressMobileTopComponent,OpfCheckoutPaymentAndReviewComponent,CheckoutProgressMobileBottomComponent,OpfExplicitTermsAndConditionsComponent

# Add OPF ContentPages
INSERT_UPDATE ContentPage;$contentCV[unique=true];uid[unique=true];name;masterTemplate(uid,$contentCV);label;title[lang=en];defaultPage[default='true'];approvalStatus(code)[default='approved'];homepage[default='false']
;;OpfCheckoutPaymentAndReview;Opf Checkout Payment And Review;MultiStepCheckoutSummaryPageTemplate;/checkout/opf-payment-and-review;Checkout Payment and Review;true;check;false

# Add OPF Page and ContentSlot relations
INSERT_UPDATE ContentSlotForPage;$contentCV[unique=true];uid[unique=true];position[unique=true];page(uid,$contentCV)[unique=true];contentSlot(uid,$contentCV)[unique=true]
;;SideContent-opfCheckoutDeliveryAddress;SideContent;OpfCheckoutDeliveryAddress;SideContentSlot-checkoutPaymentDetails
;;SideContent-CheckoutOpfDeliveryMode;SideContent;OpfCheckoutDeliveryMode;SideContentSlot-checkoutPaymentDetails
;;SideContent-CheckoutOpfPaymentAndReview;SideContent;OpfCheckoutPaymentAndReview;SideContentSlot-checkoutPaymentDetails
;;BodyContent-opfCheckoutDeliveryAddress;BodyContent;OpfCheckoutDeliveryAddress;BodyContentSlot-checkoutOpfDeliveryAddress
;;BodyContent-CheckoutOpfDeliveryMode;BodyContent;OpfCheckoutDeliveryMode;BodyContentSlot-checkoutOpfDeliveryMode
;;BodyContent-CheckoutOpfPaymentAndReview;BodyContent;OpfCheckoutPaymentAndReview;BodyContentSlot-checkoutOpfPaymentAndReview

# Add OPF components to existing content slots (append mode)
# Add CTA scripts to Product Details Page
UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid,$contentCV)
;;ProductSummarySlot;ProductImagesComponent, ProductIntroComponent, ProductSummaryComponent, VariantSelector, ConfigureProductComponent, AddToWishListComponent, StockNotificationComponent, OpfCtaScriptsComponent, AddToCart

# Add CTA scripts to Order Confirmation Page
UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid,$contentCV)
;;BodyContent-orderConfirmation;OpfCtaScriptsComponent, OrderConfirmationThankMessageComponent, OrderConfirmationShippingComponent, OrderConfirmationPickUpComponent, ExportOrderEntriesComponent, OrderConfirmationBillingComponent, OrderConfirmationTotalsComponent, OrderConfirmationContinueButtonComponent

# Add CTA scripts to Order Details Page
UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid,$contentCV)
;;BodyContent-orderdetail;OpfCtaScriptsComponent, AccountOrderDetailsSimpleOverviewComponent, AccountOrderDetailsGroupedItemsComponent, ExportOrderEntriesComponent, AccountOrderDetailsBillingComponent, AccountOrderDetailsTotalsComponent, AccountOrderDetailsActionsComponent

# Add CTA scripts and Quick Buy buttons to Cart Page
UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid,$contentCV)
;;TopContent-cartPage;OpfCtaScriptsComponent, AddToSavedCartsComponent, CartComponent, ClearCartComponent, SaveForLaterComponent, ImportExportOrderEntriesComponent
;;CenterRightContentSlot-cartPage;CartTotalsComponent, CartApplyCouponComponent, CartQuickOrderFormComponent, OpfQuickBuyButtonsComponent, CartProceedToCheckoutComponent
```

## Configuring Open Payment Framework

To ensure optimal performance and functionality, you need to configure open payment framework, as described in the following procedures:

- [Configuring Open Payment Framework Core Functionality](#configuring-open-payment-framework-core-functionality)
- [Configuring the Payment Option Info Message](#configuring-the-payment-option-info-message)
- [Configuring Checkout](#configuring-checkout)
- [Configuring Terms and Conditions](#configuring-terms-and-conditions)
- [Configuring Payment Routing](#configuring-payment-routing)
- [Configuring Quick Buy](#configuring-quick-buy)

## Configuring Open Payment Framework Core Functionality

To establish a connection between SAP Commerce Cloud and the open payment framework functionality in Spartacus, you need to add the following configuration in `opf-feature.module.ts` :

```ts
provideConfig(<OpfConfig>{
  opf: {
    opfBaseUrl: '<URL TO COMMERCE CLOUD ADAPTER>',
    commerceCloudPublicKey: '<COMMERCE CLOUD PUBLIC KEY>',
  },
}),
```

The configuration properties are described as follows:

- `opfBaseUrl` is the URL to the Commerce Cloud Adapter.
- `commerceCloudPublicKey` is the public key provided by open payment framework. It is used by Commerce Cloud Adapter to establish a connection to the correct SAP Commerce Cloud configuration.

For more information, see [Set up Connection with SAP Commerce Cloud Adapter](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/0996ba68e5794b8ab51db8d25d4c9f8a/feb92426c3044e5eab67059795b5c14d.html?locale=en-US#set-up-connection-with-sap-commerce-cloud-adapter).

## Configuring Local Payment Service Provider Resources

To improve performance and reduce loading times, you can configure local payment service provider (PSP) resources. This allows you to host JavaScript and CSS files locally instead of loading them from external sources.

### Configuration Example

The following example shows how to configure local PSP resources for different payment providers:

```ts
provideConfig(<OpfConfig>{
  opf: {
    localPspResources: {
      123: { // Example paymentOptionId for Adyen
        jsFiles: ['/assets/adyen-payment.js'],
        cssFiles: ['/assets/adyen-styles.css']
      },
      456: { // Example paymentOptionId for Stripe
        jsFiles: ['/assets/stripe-payment.js'],
        cssFiles: ['/assets/stripe-styles.css']
      }
    }
  },
}),
```

### Configuration Properties

Set the values of the following properties to configure local PSP resources:

- `localPspResources`: An object where each key is a payment option ID (number) and the value contains the following:
  - `jsFiles`: An array of JavaScript file paths to load locally.
  - `cssFiles`: An array of CSS file paths to load locally.

You obtain the payment option IDs from the open payment framework workbench. When configured, these local resources are loaded instead of the default external resources, resulting in faster page load times and improved user experience.

## Configuring the Payment Option Info Message

To enhance accessibility, a message is displayed when users select a payment option. This message provides a brief explanation of the payment process, which helps users understand whether they will be redirected to a secure, external page, or complete the payment directly on the current page.

### Default Behavior

The info message is visible by default and uses the following default translation key label:

```json
"opfCheckout": {

  // ...

  "defaultPaymentInfoMessage": "You are about to make a payment. Depending on the option selected, you will either be redirected to a secure external page or complete the process directly within this page",
}
```

### Customizing Payment Option Labels

You can use the `paymentInfoMessagesMap` to customize labels for each payment option. The following configuration is an example:

```ts
provideConfig(<OpfConfig>{
  opf: {
    paymentInfoMessagesMap: {
      213: 'opfCheckout.payPalPaymentInfoMessage', // Message key for payment method ID 213
    },
    enableInfoMessage: true
  },
}),
```

In the above example, `213` is the configuration ID of the payment provider. These IDs can be obtained from the open payment framework workbench. The corresponding `opfCheckout.payPalPaymentInfoMessage` label key must be defined in a localization file, such as `opfCheckout.json`.

For more information on localization in Spartacus, see [Internationalization (i18n)](https://help.sap.com/docs/SAP_COMMERCE_COMPOSABLE_STOREFRONT/eaef8c61b6d9477daf75bff9ac1b7eb4/775e61ed219c4999852d43be5244e94a.html?locale=en-US&version=2211).

### Toggling Visibility

To disable the info message globally for all payment options, set `enableInfoMessage` to `false` in the configuration, as shown in the following example:

```ts
provideConfig(<OpfConfig>{
  opf: {
    enableInfoMessage: false
  },
}),
```

## Content Security Policy Support

Open payment framework supports Content Security Policy (CSP) compliance for Payment Service Provider (PSP) scripts. When PSP scripts are provided in `SEPARATE` mode, the framework runs scripts using CSP-compliant methods that avoid inline script violations. In this mode, JavaScript and CSS resources are provided separately, with their own URLs and Subresource Integrity hashes. Scripts are run using `<script>` elements with `textContent` instead of inline scripts, and script context is passed through a global `window.OpfContext` variable, allowing the original script hash to remain unchanged for CSP verification. This ensures that open payment framework PSP scripts work correctly with strict CSP policies, while maintaining security through subresource integrity (SRI) hashes. The framework automatically handles running CSP-compliant scripts when the `htmlContentMode` property is set to `SEPARATE` in the dynamic script configuration.

### Configuring Your Content Security Policy

To enable CSP support for open payment framework PSP scripts, you need to configure a Content Security Policy `<meta>` tag in your `index.html` file. The CSP policy should allow scripts from all sources (`*`) and include specific SHA hashes for the open payment framework scripts. You can obtain the SHA hash values from the open payment framework workbench.

The following is an example of a CSP `<meta>` tag configuration in `index.html`:

```html
<meta
  http-equiv="Content-Security-Policy"
  content="script-src * 'sha384-abc123def456ghi789jkl012mno345pqr678stu901vwx234yz5678901234567890' 'sha384-xyz789abc123def456ghi789jkl012mno345pqr678stu901vwx234yz567890'"
/>
```

In this example, `script-src *` allows scripts from all external sources. Multiple SRI hashes can be included, one for each open payment framework PSP script that needs to be run. In this case, `'sha384-abc123def456ghi789jkl012mno345pqr678stu901vwx234yz5678901234567890'` and `'sha384-xyz789abc123def456ghi789jkl012mno345pqr678stu901vwx234yz567890'` are example SRI hashes for open payment framework PSP scripts, which you obtain from the open payment framework workbench.

When you are setting up your own CSP `<meta>` tag configuration, remember to replace the SHA hash values in the example with the actual SHA hash values obtained from the open payment framework workbench for your specific payment provider scripts. You can include multiple SRI hashes in the CSP `<meta>` tag, separated by spaces.

**Note:** Scripts without a defined SRI hash in the CSP policy will be blocked from running. Ensure that all open payment framework PSP scripts that need to run have their corresponding SHA hashes included in the CSP policy.

By running CSP-compliant scripts with SHA hashes, you can avoid using `'unsafe-eval'` in your CSP policy, which improves security by preventing dynamically evaluated code from running.

## Configuring Checkout

The open payment framework feature library supports run-time adjustment of the checkout flow based on the `paymentProvider` property. For more information, see [Multiple Checkout Flows](loio7c83b24b00f746a591aab48d58d6abc5) and [Setting a paymentProvider value in SAP Commerce Cloud](loioa0a8551f2c0649729a9f00c6ee53b97d).

**Note:** When configuring multiple checkout flows for open payment framework, the value for the flow key object must be `OPF`. Any other flow key values, such as `OPF-guest`, or any other variations, will not work because the back end expects `OPF` as the specific identifier to properly process payment transactions. Support for other flow key values (such as `OPF-guest`) was removed, so only the `OPF` flow key is currently supported.

### Pickup-in-Store Support in Open Payment Framework

The open payment framework supports pickup-in-store functionality through a flexible outlet-based architecture. Open payment framework is not directly dependent on the `pickup-in-store` library. You can provide your own custom component for displaying pickup items by registering it with the `OPF_CHECKOUT_PICKUP_ITEMS` outlet.

If you have the `pickup-in-store` library installed, you can use the existing `PickUpItemsDetailsComponent` by adding the following code to your providers array:

```ts
provideOutlet({
  id: CartOutlets.OPF_CHECKOUT_PICKUP_ITEMS,
  position: OutletPosition.REPLACE,
  component: PickUpItemsDetailsComponent,
}),
```

## Configuring B2B Checkout

B2B checkout in the open payment framework is disabled by default. When enabled, it overrides the existing B2C checkout configuration. To enable support for B2B checkout, you can install the feature using schematics, as follows:

```bash
ng add @spartacus/opf --skip-confirmation --no-interactive --features "OPF-B2B-Checkout"
```

### Adding B2B Checkout CMS Components Manually Using ImpEx

B2B checkout follows the same CMS structure as described in the [CMS Components](#cms-components) section above, but introduces additional complexity to accommodate business-specific requirements. The B2B implementation uses a content catalog that reflects a typical B2B site structure.

The key difference in B2B checkout is the introduction of a dedicated payment type selection page. The `OpfCheckoutPaymentTypeComponent` CMS component is placed on a separate `OpfCheckoutPaymentType` content page, creating a distinct step where users first choose their payment method before proceeding to delivery address and final review. This separation allows for more complex payment workflows that are common in B2B scenarios, where different payment types might require different validation or processing steps.

**Note:** B2B checkout currently does not support CTA and Quick Buy functionality.

The following example ImpEx script includes all the necessary CMS components, content slots, pages, and relations that you need for setting up a B2B OPF checkout:

```text
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]
$siteResource=jar:de.hybris.platform.spartacussampledata.constants.SpartacussampledataConstants&/spartacussampledata/import/contentCatalogs/powertoolsContentCatalog

# Add OPF CMSFlexComponents
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;OpfCheckoutPaymentAndReviewComponent;OpfCheckoutPaymentAndReview;OpfB2bCheckoutPaymentAndReview
;;OpfCheckoutPaymentTypeComponent;OpfCheckoutPaymentType;OpfCheckoutPaymentType
;;OpfCheckoutDeliveryAddressComponent;OpfCheckoutDeliveryAddress;OpfCheckoutDeliveryAddress
;;OpfCheckoutReviewComponent;OpfCheckoutReview;OpfCheckoutReview

# Add OPF Explicit T&C CMSFlexComponent as invisible
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;visible
;;OpfExplicitTermsAndConditionsComponent;OpfExplicitTermsAndConditionsComponent;OpfExplicitTermsAndConditionsComponent;false

# Add OPF ContentSlots
INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid,$contentCV)
;;BodyContentSlot-checkoutOpfPaymentAndReview;Body Content Slot for Checkout OPF Payment And Review;CheckoutProgressComponent,CheckoutProgressMobileTopComponent,OpfCheckoutPaymentAndReviewComponent,CheckoutProgressMobileBottomComponent,OpfExplicitTermsAndConditionsComponent
;;CenterRightContentSlot-cartPage;Center Right Content Slot for Cart Page;CartTotalsComponent,CartApplyCouponComponent,CartQuickOrderFormComponent,CartProceedToCheckoutComponent
INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid,$contentCV)
;;BodyContentSlot-checkoutOpfPaymentType;Body Content Slot for OPF Checkout Payment Type;CheckoutProgressComponent,CheckoutProgressMobileTopComponent,OpfCheckoutPaymentTypeComponent,CheckoutProgressMobileBottomComponent
;;CenterRightContentSlot-cartPage;Center Right Content Slot for Cart Page;CartTotalsComponent,CartApplyCouponComponent,CartQuickOrderFormComponent,CartProceedToCheckoutComponent
INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid,$contentCV)
;;BodyContentSlot-checkoutOpfDeliveryAddress;Body Content Slot for OPF Delivery Address;CheckoutProgressComponent,CheckoutProgressMobileTopComponent,OpfCheckoutDeliveryAddressComponent,CheckoutProgressMobileBottomComponent
;;CenterRightContentSlot-cartPage;Center Right Content Slot for Cart Page;CartTotalsComponent,CartApplyCouponComponent,CartQuickOrderFormComponent,CartProceedToCheckoutComponent
INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid,$contentCV)
;;BodyContentSlot-checkoutOpfReview;Body Content Slot for OPF Checkout Review;CheckoutProgressComponent,CheckoutProgressMobileTopComponent,OpfCheckoutReviewComponent,CheckoutProgressMobileBottomComponent,OpfExplicitTermsAndConditionsComponent
;;CenterRightContentSlot-cartPage;Center Right Content Slot for Cart Page;CartTotalsComponent,CartApplyCouponComponent,CartQuickOrderFormComponent,CartProceedToCheckoutComponent

# Add OPF ContentPages
INSERT_UPDATE ContentPage;$contentCV[unique=true];uid[unique=true];name;masterTemplate(uid,$contentCV);label;title[lang=en];defaultPage[default='true'];approvalStatus(code)[default='approved'];homepage[default='false']
;;OpfCheckoutPaymentAndReview;Opf Checkout Payment And Review;MultiStepCheckoutSummaryPageTemplate;/checkout/opf-payment-and-review;Checkout Payment and Review;true;check;false
;;OpfCheckoutPaymentType;Opf Checkout Payment Type;MultiStepCheckoutSummaryPageTemplate;/checkout/opf-payment-type;Checkout Payment Type;true;check;false
;;OpfCheckoutDeliveryAddress;Opf Checkout Delivery Address;MultiStepCheckoutSummaryPageTemplate;/checkout/opf-delivery-address;Checkout Delivery Address;true;check;false
;;OpfCheckoutReview;Opf Checkout Review;MultiStepCheckoutSummaryPageTemplate;/checkout/opf-review;Checkout Review;true;check;false

# Add OPF Page and ContentSlot relation
INSERT_UPDATE ContentSlotForPage;$contentCV[unique=true];uid[unique=true];position[unique=true];page(uid,$contentCV)[unique=true];contentSlot(uid,$contentCV)[unique=true]
;;SideContent-CheckoutOpfPaymentAndReview;SideContent;OpfCheckoutPaymentAndReview;SideContentSlot-checkoutPaymentDetails
;;BodyContent-CheckoutOpfPaymentAndReview;BodyContent;OpfCheckoutPaymentAndReview;BodyContentSlot-checkoutOpfPaymentAndReview
INSERT_UPDATE ContentSlotForPage;$contentCV[unique=true];uid[unique=true];position[unique=true];page(uid,$contentCV)[unique=true];contentSlot(uid,$contentCV)[unique=true]
;;SideContent-OpfCheckoutPaymentType;SideContent;OpfCheckoutPaymentType;SideContentSlot-checkoutPaymentDetails
;;BodyContent-OpfCheckoutPaymentType;BodyContent;OpfCheckoutPaymentType;BodyContentSlot-checkoutOpfPaymentType
INSERT_UPDATE ContentSlotForPage;$contentCV[unique=true];uid[unique=true];position[unique=true];page(uid,$contentCV)[unique=true];contentSlot(uid,$contentCV)[unique=true]
;;SideContent-OpfCheckoutDeliveryAddress;SideContent;OpfCheckoutDeliveryAddress;SideContentSlot-checkoutPaymentDetails
;;BodyContent-OpfCheckoutDeliveryAddress;BodyContent;OpfCheckoutDeliveryAddress;BodyContentSlot-checkoutOpfDeliveryAddress
INSERT_UPDATE ContentSlotForPage;$contentCV[unique=true];uid[unique=true];position[unique=true];page(uid,$contentCV)[unique=true];contentSlot(uid,$contentCV)[unique=true]
;;SideContent-OpfCheckoutReview;SideContent;OpfCheckoutReview;SideContentSlot-checkoutPaymentDetails
;;BodyContent-OpfCheckoutReview;BodyContent;OpfCheckoutReview;BodyContentSlot-checkoutOpfReview
```

### Configuring B2B OCC Endpoints

To enable B2B checkout functionality in the open payment framework, you need to provide a B2B-specific OCC endpoint configuration. Add the following configuration to your `app.module.ts`:

```ts
provideConfig(defaultOpfB2bCheckoutOccEndpointsConfig);
```

This configuration overrides the standard payment-authorized order placement endpoint with a B2B-specific implementation that uses the format `orgUsers/${userId}/orders?fields=FULL` for placing orders after successful payment transactions.

### Troubleshooting the OPF Checkout Flow Selection

If you have customized your checkout configuration (for example, by combining B2B checkout steps with OPF checkout flows), you might observe that OPF checkout is not picked up even though OPF is configured as the base store payment provider. This typically happens when multiple modules provide a checkout configuration object, and your setup effectively overwrites parts of it (for example, steps overwriting flows), depending on the config-provider order and the merge behavior. This is not necessarily an out-of-the-box Spartacus issue, but it can happen in customized setups.

The following are symptoms you may see that are caused by this issue:

- The checkout uses the "default" flow instead of the OPF flow.
- The `baseStore.paymentProvider` is set (for example, to OPF), but the corresponding `checkout.flows[OPF]` is missing at runtime.

You can regain full control over which checkout flow is used by overriding `CheckoutFlowOrchestratorService`. In the following example, only an OPF flow is returned when the base store payment provider matches an OPF flow, and otherwise it falls back to standard Spartacus behavior. As a result, it will not force an OPF flow in local or development environments, or in non-OPF base stores.

```ts
import { Injectable } from '@angular/core';
import { CheckoutFlowOrchestratorService } from '@spartacus/checkout/base/components';
import { CheckoutFlow, CheckoutConfig } from '@spartacus/checkout/base/root';
import { defaultOpfB2bCheckoutConfig } from '@spartacus/opf/b2b-checkout/root';

@Injectable()
export class OpfCheckoutFlowOrchestratorService extends CheckoutFlowOrchestratorService {
  override getCheckoutFlow(): CheckoutFlow | undefined {
    const paymentProvider = this.paymentProviderName;

    if (paymentProvider) {
      const opfCheckout = (defaultOpfB2bCheckoutConfig as CheckoutConfig).checkout;
      const opfFlow = opfCheckout?.flows?.[paymentProvider];
      if (opfFlow) {
        return opfFlow;
      }
    }

    return super.getCheckoutFlow();
  }
}
```

After you have overridden the `CheckoutFlowOrchestratorService`, you provide the custom service in your OPF module, as shown in the following example:

```ts
import { CheckoutFlowOrchestratorService } from '@spartacus/checkout/base/components';

providers: [
  {
    provide: CheckoutFlowOrchestratorService,
    useClass: OpfCheckoutFlowOrchestratorService,
  },
];
```

## Configuring Terms and Conditions

On the open payment framework **Checkout Payment and Review** page, the following modes are available for handling Terms and Conditions:

- **Explicit Terms and Conditions** displays a checkbox and a message at the top of the page. Payment options remain disabled (grayed out) until the user accepts the Terms and Conditions by selecting the checkbox.
- **Implicit Terms and Conditions** shows only a message at the top of the checkout review step. Payment options are always enabled, regardless of user interaction. This is the default mode.

### Switching Between Modes

The mode for Terms and Conditions is determined by the CMS configuration, as follows:

- **Explicit Mode** is enabled when the `OpfExplicitTermsAndConditionsComponent` is present on the CMS page and the `visible` property for this component is set to `true`.
- **Implicit Mode** is displayed by default when the `OpfExplicitTermsAndConditionsComponent` is either not present in the CMS page, or the component's `visible` property is set to `false`.

To switch to **Explicit Mode**, update the CMS component's `visible` property to `true`. This can be done at any time in Backoffice.

### CMS Components for Terms and Conditions

If you are using the [Spartacus Sample Data Extension](link), the open payment framework CMS component for Terms and Conditions is already enabled. However, if you decide not to use the `spartacussampledata` extension, you can enable the Terms and Conditions CMS component manually through ImpEx.

### Adding the Terms and Conditions CMS Component Manually

You can add the Terms and Conditions CMS data manually through ImpEx.

**Note:** The `$contentCV` variable, which stores information about the content catalog, and which is used in the following example, is defined as follows:

```text
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]
```

To add all of the necessary CMS-related data for open payment framework Terms and Conditions, import the following ImpEx:

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;visible
;;OpfExplicitTermsAndConditionsComponent;OpfExplicitTermsAndConditionsComponent;OpfExplicitTermsAndConditionsComponent;false

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;BodyContentSlot-checkoutOpfPaymentAndReview;Body Content Slot for Checkout OPF Payment And Review;CheckoutProgressComponent,CheckoutProgressMobileTopComponent,OpfCheckoutPaymentAndReviewComponent,CheckoutProgressMobileBottomComponent,OpfExplicitTermsAndConditionsComponent
```

## Configuring Payment Routing

You can use routing to configure different payment verification workflows. This is done by setting specific paths for each payment verification scenario that you want to configure.

You can define custom routes for payment verification processes, as shown in the following example:

```ts
provideConfig(<RoutingConfig>{
  routing: {
    routes: {
      paymentVerificationResult: {
        paths: ['opf/payment-verification-redirect/result'],
      },
      paymentVerificationCancel: {
        paths: ['opf/payment-verification-redirect/cancel'],
      },
    },
  },
}),
```

In the above example, the `paymentVerificationResult` specifies where users are redirected if the payment verification is successful, and the `paymentVerificationCancel` specifies where users are redirected if the payment verification is canceled.

## Compliance With the Payment Card Industry Data Security Standard (PCI DSS)

For OPF payment options where payment details are entered into the user interface of the Payment Service Provider (PSP), such as a PSP-hosted iframe or a PSP-hosted payment page, Spartacus and OPF do not receive or process any raw cardholder data. Instead, Spartacus and OPF work with PSP results, such as tokens and payment authorization outcomes. Spartacus also does not directly manipulate the CSS of credit card input fields. Instead, the styling is controlled by the PSP UI.

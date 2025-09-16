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

### Adding the CMS Components Manually Using ImpEx

To add all of the necessary CMS components and related data for open payment framework, import the following ImpEx:

```text
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]
$siteResource=jar:de.hybris.platform.spartacussampledata.constants.SpartacussampledataConstants&/spartacussampledata/import/contentCatalogs/electronicsContentCatalog

# Add OPF CMSFlexComponents
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;OpfCheckoutPaymentAndReviewComponent;OpfCheckoutPaymentAndReview;OpfCheckoutPaymentAndReview
;;OpfCheckoutProgressComponent;Opf Checkout Progress Component;OpfCheckoutProgress
;;OpfCtaScriptsComponent;Opf Cta Scripts Component;OpfCtaScriptsComponent
;;OpfQuickBuyButtonsComponent;Opf Quick Buy Buttons Component;OpfQuickBuyButtonsComponent

# Add OPF Explicit T&C CMSFlexComponent as invisible
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;visible
;;OpfExplicitTermsAndConditionsComponent;OpfExplicitTermsAndConditionsComponent;OpfExplicitTermsAndConditionsComponent;false

# Add OPF ContentSlots
INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;BodyContentSlot-checkoutDeliveryMode;Checkout Delivery Mode Slot;CheckoutProgressComponent,CheckoutProgressMobileTopComponent,CheckoutDeliveryModeComponent,CheckoutProgressMobileBottomComponent
;;BodyContentSlot-checkoutOpfDeliveryAddress;Body Content Slot for Checkout OPF Delivery Address;OpfCheckoutProgressComponent,CheckoutDeliveryAddressComponent
;;BodyContentSlot-checkoutOpfDeliveryMode;Body Content Slot for Checkout OPF Delivery Mode;OpfCheckoutProgressComponent,CheckoutDeliveryModeComponent
;;BodyContentSlot-checkoutOpfPaymentAndReview;Body Content Slot for Checkout OPF Payment And Review;CheckoutProgressComponent,CheckoutProgressMobileTopComponent,OpfCheckoutPaymentAndReviewComponent,CheckoutProgressMobileBottomComponent,OpfExplicitTermsAndConditionsComponent
;;CenterRightContentSlot-cartPage;Center Right Content Slot for Cart Page;CartTotalsComponent,CartApplyCouponComponent,CartQuickOrderFormComponent,OpfQuickBuyButtonsComponent,CartProceedToCheckoutComponent

# Add OPF ContentPages
INSERT_UPDATE ContentPage;$contentCV[unique=true];uid[unique=true];name;masterTemplate(uid,$contentCV);label;title[lang=en];defaultPage[default='true'];approvalStatus(code)[default='approved'];homepage[default='false']
;;OpfCheckoutPaymentAndReview;Opf Checkout Payment And Review;MultiStepCheckoutSummaryPageTemplate;/checkout/opf-payment-and-review;Checkout Payment and Review;true;check;false

# Add OPF Page and ContentSlot relation
INSERT_UPDATE ContentSlotForPage;$contentCV[unique=true];uid[unique=true];position[unique=true];page(uid,$contentCV)[unique=true];contentSlot(uid,$contentCV)[unique=true]
;;BodyContent-opfCheckout;BodyContent;OpfCheckout;BodyContentSlot-checkout
;;SideContent-opfCheckout;SideContent;OpfCheckout;SideContentSlot-checkoutPaymentDetails
;;SideContent-opfCheckoutDeliveryAddress;SideContent;OpfCheckoutDeliveryAddress;SideContentSlot-checkoutPaymentDetails
;;SideContent-CheckoutOpfDeliveryMode;SideContent;OpfCheckoutDeliveryMode;SideContentSlot-checkoutPaymentDetails
;;SideContent-CheckoutOpfPaymentAndReview;SideContent;OpfCheckoutPaymentAndReview;SideContentSlot-checkoutPaymentDetails
;;BodyContent-opfCheckoutDeliveryAddress;BodyContent;OpfCheckoutDeliveryAddress;BodyContentSlot-checkoutOpfDeliveryAddress
;;BodyContent-CheckoutOpfDeliveryMode;BodyContent;OpfCheckoutDeliveryMode;BodyContentSlot-checkoutOpfDeliveryMode
;;BodyContent-CheckoutOpfPaymentAndReview;BodyContent;OpfCheckoutPaymentAndReview;BodyContentSlot-checkoutOpfPaymentAndReview

# Add CTA script to PDP content slot
UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(uid,$contentCV)
;;ProductSummarySlot;Site Context Slot;true;ProductImagesComponent, ProductIntroComponent, QualtricsEmbeddedFeedbackComponent, ProductSummaryComponent, VariantSelector, ConfigureProductComponent, AddToWishListComponent, StockNotificationComponent, OpfCtaScriptsComponent, AddToCart

# Add CTA script order confirmation content slot
UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(uid,$contentCV)
;;BodyContent-orderConfirmation;Body Content Slot for Order Confirmation;true;OpfCtaScriptsComponent, OrderConfirmationThankMessageComponent, OrderConfirmationShippingComponent, OrderConfirmationPickUpComponent, ExportOrderEntriesComponent, OrderConfirmationBillingComponent, OrderConfirmationTotalsComponent, OrderConfirmationContinueButtonComponent

# Add CTA script to OPF order details page content slot
UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(uid,$contentCV)
;;BodyContent-orderdetail;Body Content Slot for My Account Order Details;true;OpfCtaScriptsComponent,AccountOrderDetailsSimpleOverviewComponent,AccountOrderDetailsGroupedItemsComponent,ExportOrderEntriesComponent,AccountOrderDetailsBillingComponent,AccountOrderDetailsTotalsComponent,AccountOrderDetailsActionsComponent

# Add CTA script to cart content slot
UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(uid,$contentCV)
;;TopContent-cartPage;Top content for Cart Slot;true;OpfCtaScriptsComponent, AddToSavedCartsComponent, CartComponent, ClearCartComponent, SaveForLaterComponent, ImportExportOrderEntriesComponent
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

## Configuring Checkout

The open payment framework feature library supports run-time adjustment of the checkout flow based on the `paymentProvider` property. For more information, see [Multiple Checkout Flows](loio7c83b24b00f746a591aab48d58d6abc5) and [Setting a paymentProvider value in SAP Commerce Cloud](loioa0a8551f2c0649729a9f00c6ee53b97d).

## Configuring B2B Checkout

B2B checkout in the open payment framework is disabled by default. When enabled, it overrides the existing B2C checkout configuration. To enable support for B2B checkout, you can install the feature using schematics, as follows:

```bash
ng add @spartacus/opf --skip-confirmation --no-interactive --features "OPF-B2B-Checkout"
```

### Adding the B2B Checkout CMS Components Manually Using ImpEx

You can use ImpEx to add the B2B checkout CMS data manually.

To add all of the necessary CMS components and related data for the open payment framework B2B checkout, import the following ImpEx:

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

---
title: Open Payment Framework in Spartacus
---

The Open Payment Framework is a framework that allows merchants to integrate their preferred Payment Service Provider quickly and efficiently through configurations.

If you have not already done so, you need to configure open payment framework in SAP Commerce Cloud before integrating with Spartacus. For more information, see [Open Payment Framework](link to backend docs).

## Enabling Open Payment Framework in Spartacus

To enable open payment framework, install the `@spartacus/opf` integration library (???). For more information, see [Installing Additional Composable Storefront Libraries](link).

### CMS Components

Certain features of OPF, including the payment and review page or the call-to-action scripts, necessitate specific sample data configurations on the backend.

If your storefront is built using the `spartacussampledata` extension, it includes all required CMS data for the OPF feature.

#### Adding the CMS Components Manually

If you are not using the `spartacussampledata` extension, you must add the necessary CMS components manually. Follow the instructions below to configure sample data for Open Payment Framework.

```
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

In order to ensure the optimal performance and functionality of the OPF feature within the app, specific configurations need to be set up.

The Open Payment Framework integration offers various configuration options. You can customize the following aspects:

- OPF Base Configuration
- OPF Checkout Configuration
- OPF Payment Routing Configuration
- OPF Quick Buy Configuration

### Configuring the OPF Base

This configuration is essential for establishing a connection between CCv2 and OPF, enabling the use of OPF with the Spartacus application.

```ts
provideConfig(<OpfConfig>{
  opf: {
    opfBaseUrl: '<URL TO COMMERCE CLOUD ADAPTER>',
    commerceCloudPublicKey: '<COMMERCE CLOUD PUBLIC KEY>',
  },
}),
```

Below are explanations of the configuration properties:

- **opfBaseUrl**: This denotes the URL to the Commerce Cloud Adapter.

- **commerceCloudPublicKey**: This is the public key provided by OPF. It is used to establish a connection to the correct CCv2 configuration on the Commerce Cloud Adapter's side.

#### Configuring Payment Option Info message

To enhance accessibility, an informational message is displayed when a user selects a payment option. This message provides a brief explanation of the payment process, helping users understand whether they will be redirected to a secure external page or complete the payment directly on the current page.

##### Default Behavior

The info message is visible by default and uses the default translation key label:
`opfCheckout.defaultPaymentInfoMessage`:
_"You are about to make a payment. Depending on the option selected, you will either be redirected to a secure external page or complete the process directly within this page."_

##### Customizing Labels

Per **Payment Option** Labels can be customized for each payment option using the following configuration:

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

- **213** in this example is the configuration ID of the payment provider. These IDs can be obtained from the OPF workbench.
- The corresponding label key (e.g., `opfCheckout.payPalPaymentInfoMessage`) must be defined in the localization file (e.g., `opfCheckout.json`).
<!-- Would be good to reference here to the Spartacus translations and how to use translation keys -->

##### Toggling Visibility

For All Payment Options To disable the info message globally for all payment options, set `enableInfoMessage` to `false` in the configuration:

```ts
provideConfig(<OpfConfig>{
  opf: {
    enableInfoMessage: false
  },
}),
```

### Configuring OPF Checkout

The OPF feature library supports run-time adjustment of the checkout flow based on the `paymentProvider` property. Learn more about this feature here [{% assign linkedpage = site.pages | where: "name", "extending-checkout.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/routes/extending-checkout.md %}).

<!-- Please reference here to the: Multiple Checkout Flows section in _pages/dev/routes/extending-checkout.md file -->

#### Configuring Terms and Conditions

On the Opf Checkout Payment & Review page, two modes are available for handling Terms and Conditions:

**Explicit Terms and Conditions** Displays a checkbox and an informational message at the top of the page.
Payment options remain disabled (grayed out) until the user accepts the T&C by selecting the checkbox.

**Implicit Terms and Conditions** Shows only an informational message at the top of the checkout review step.
Payment options are always enabled, regardless of user interaction. This is the default mode.

##### Switching Between Modes

The mode for Terms and Conditions is determined by the CMS configuration:

**Explicit Mode**: Enabled when the `OpfExplicitTermsAndConditionsComponent` is present on the CMS page and its `visible` property is set to `true`.

**Implicit Mode**: Displayed by default when the `OpfExplicitTermsAndConditionsComponent` is either not present in the CMS page or has its `visible` property set to `false`.

To switch to **Explicit Mode**, update the CMS component's `visible` property to `true`. This can be done at any time using the Backoffice UI.

##### CMS Components for Terms and Conditions

If your storefront is built using the `spartacussampledata` extension, it includes all required CMS data for the Open Payment Framework integration, including the Terms and Conditions configuration, which is enabled by default.

##### Adding the Terms and Conditions CMS Components Manually

If you are not using the `spartacussampledata` extension, you must add the necessary CMS components manually. Follow the instructions below to configure the Terms and Conditions components for the Open Payment Framework.

**Note:** The `$contentCV` variable, which stores information about the content catalog, and which is used throughout the ImpEx in the following procedures, is defined as follows:

```
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]
```

The following procedure describes how to enable terms and conditions components for open payment framework, which is necessary if you are not using the `spartacussampledata` extension to build your storefront.

```
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;visible
;;OpfExplicitTermsAndConditionsComponent;OpfExplicitTermsAndConditionsComponent;OpfExplicitTermsAndConditionsComponent;false

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;BodyContentSlot-checkoutOpfPaymentAndReview;Body Content Slot for Checkout OPF Payment And Review;CheckoutProgressComponent,CheckoutProgressMobileTopComponent,OpfCheckoutPaymentAndReviewComponent,CheckoutProgressMobileBottomComponent,OpfExplicitTermsAndConditionsComponent
```

### Configuring the OPF Payment Routing

This configuration is particularly useful for integrating and tailoring payment verification workflows in an application that utilizes the Open Payment Framework (OPF) with Spartacus.

By modifying the paths in this configuration, you can control how and where the application redirects users during specific payment verification scenarios.

The provided code snippet modifies the routing configuration in a Spartacus application, defining custom routes for payment verification processes. Here is what can be configured:

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

#### Route Definitions

**paymentVerificationResult**: Specifies the path to redirect the user after a successful payment verification. In this example, the path is `opf/payment-verification-redirect/result`.

**paymentVerificationCancel**: Specifies the path to redirect the user if the payment verification is canceled. Here, the path is `opf/payment-verification-redirect/cancel`.

#### Customizability

Developers can adapt these routes to align with their application's URL structure, ensuring a seamless and coherent user navigation experience.

### Configuring OPF Quick Buy

Currently, the Quick Buy feature in OPF integration supports only ApplePay and GooglePay.

By modifying this snippet, you can configure the integration of GooglePay as a payment provider for the Quick Buy feature in an application. Below are the configurable aspects:

```ts
provideConfig(<OpfQuickBuyConfig>{
  providers: {
    'googlePay': {
      resourceUrl: 'https://pay.google.com/gp/p/js/pay.js',
    } as OpfQuickBuyGooglePayProvider,
  },
}),
```

**resourceUrl** Specifies the external script or API endpoint required for the payment provider to function. This can be updated if the provider releases a new script version, changes its URL, or requires a custom endpoint for specific regions.

You can configure additional payment providers by extending the providers object with their respective names and settings. For example, include ApplePay, PayPal, or other custom payment gateways.

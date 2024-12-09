---
title: Quick Buy
---

Quick Buy is a CMS-based feature that can display Google Pay and Apple Pay buttons on the cart page. Quick Buy allows users to easily purchase items in their cart, whether they are logged in or checking out as a guest.

Before enabling Quick Buy in Spartacus, you must first enable the Quick Buy functionality in SAP Commerce Cloud. For more information, see [Configure Quick Buy for Google Pay](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/0996ba68e5794b8ab51db8d25d4c9f8a/712bd315f3ff433f9580e55eabd1fcca.html) and [Configure Quick Buy for Apple Pay](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/0996ba68e5794b8ab51db8d25d4c9f8a/1f1b1a6072594d41867cb19e6677526f.html).

## Enabling Quick Buy in Spartacus

Quick Buy functionality is added to your storefront app when you install the open payment framework library, as described in [Enabling Open Payment Framework in Spartacus](link-to-section-in-1-open-payment-framework-in-spartacus.md).

For a seamless installation, you can use the `--opfGooglePayApiUrl` schematics parameter. For more information, see [Configuring Quick Buy for Google Pay](#configuring-quick-buy-for-google-pay).

### CMS Components

Quick Buy is CMS-driven and consists of the `OpfQuickBuyButtonsComponent` component.

If you are using the [Spartacus Sample Data Extension](link), the Quick Buy component is already enabled. However, if you decide not to use the `spartacussampledata` extension, you can enable the Quick Buy CMS component manually through ImpEx.

### Adding CMS Component Manually

To add all of the necessary CMS data for Quick Buy, import the following ImpEx:

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;OpfQuickBuyButtonsComponent;Opf Quick Buy Buttons Component;OpfQuickBuyButtonsComponent

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;CenterRightContentSlot-cartPage;Center Right Content Slot for Cart Page;CartTotalsComponent,CartApplyCouponComponent,CartQuickOrderFormComponent,OpfQuickBuyButtonsComponent,CartProceedToCheckoutComponent
```

**Note:** The `$contentCV` variable that is used in the above ImpEx example, and which stores information about the content catalog, is defined as follows:

```text
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]
```

## Configuring Quick Buy for Apple Pay

With Quick Buy for Apple Pay, you can configure the styling of the Apple Pay button, and you can modify the credit card parameters, as described in the following sections.

Quick Buy for Apple Pay is supported in the Safari web browser. For more information, see [Apple Pay on the Web](https://developer.apple.com/documentation/apple_pay_on_the_web) in the official Apple developer documentation.

### Modifying the Styling of the Apple Pay Button

By default, Quick Buy provides a black Apple Pay button with the text “Buy with” and the Apple Pay logo.

You can modify the styling of the Apple Pay button by extending the `%cx-opf-apple-pay` placeholder selector and overwriting the `apple-pay-button` class.

For more information on CSS placeholder selectors in Spartacus, see [Component Styles](https://help.sap.com/docs/SAP_COMMERCE_COMPOSABLE_STOREFRONT/eaef8c61b6d9477daf75bff9ac1b7eb4/a95f88362b1a4ecf998047c93ab7bc12.html#loio23416cbcc1da4c9eaf513999dde8b7de).

For more information about the available types of Apple Pay buttons, see [Displaying Apple Pay Buttons Using CSS](https://developer.apple.com/documentation/apple_pay_on_the_web/displaying_apple_pay_buttons_using_css) in the official Apple developer documentation.

### Modifying Credit Card Parameters for Apple Pay

The card parameters configuration for Apple Pay is hard-coded in the `ApplePayService` class in `apple-pay.service.ts`. You can modify the configuration by extending `ApplePayService` and overwriting the following object:

```ts
  protected readonly defaultApplePayCardParameters: any = {
    shippingMethods: [],
    merchantCapabilities: ['supports3DS'],
    supportedNetworks: ['visa', 'masterCard', 'amex', 'discover'],
    requiredShippingContactFields: ['email', 'name', 'postalAddress'],
    requiredBillingContactFields: ['email', 'name', 'postalAddress'],
  };
```

For more information on extending services in Spartacus, see https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/aa417173fe4a4ba5a473c93eb730a417/465a25442fd64a1ab33d98362d66d25b.html?q=extend%2520service.

## Configuring Quick Buy for Google Pay

To complete the configuration of Quick Buy for Google Pay, you need to define the Google Pay API URL, as described in the following section. You can also modify the credit card parameters for Google Pay, as described below.

### Defining the Google Pay API URL

You need to define the Google Pay API URL, in one of the following ways:

- When installing the open payment framework library with schematics, you can use the `--opfGooglePayApiUrl` parameter, as shown in the following example:
   ```text
   --opfGooglePayApiUrl=https://pay.google.com/gp/p/js/pay.js
   ```

- Alternatively, after installing the open framework library, you can replace the following placeholder in `opf-feature.module.ts`:

```ts
provideConfig(<OpfQuickBuyConfig>{
providers:{
  googlePay: {
    resourceUrl: "PLACEHOLDER_GOOGLE_PAY_API_URL" // replace the placeholder here
}
}
}),
```

### Modifying Credit Card Parameters for Google Pay

The card parameters configuration for Google Pay is hard-coded in the `OpfGooglePayService` class in `google-pay.service.ts`. You can modify the configuration by extending `OpfGooglePayService` and overwriting the following object:

```ts
  protected readonly defaultGooglePayCardParameters: any = {
    allowedAuthMethods: ['PAN_ONLY', 'CRYPTOGRAM_3DS'],
    allowedCardNetworks: [
      'AMEX',
      'DISCOVER',
      'INTERAC',
      'JCB',
      'MASTERCARD',
      'VISA',
    ],
    billingAddressRequired: true,
    billingAddressParameters: {
      format: 'FULL',
    },
  };
```

For more information on extending services in Spartacus, see https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/aa417173fe4a4ba5a473c93eb730a417/465a25442fd64a1ab33d98362d66d25b.html?q=extend%2520service.

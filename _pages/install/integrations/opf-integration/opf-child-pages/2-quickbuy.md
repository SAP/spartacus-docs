---
title: Quick Buy
---

The open payment framework supports quick buy options for Google Pay and Apple Pay. Quick buy allows guest and logged in users to quickly checkout ...purchase items in their cart using Google Pay and Apple Pay. 

For more information on configuring quick buy in the back end, see https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/0996ba68e5794b8ab51db8d25d4c9f8a/712bd315f3ff433f9580e55eabd1fcca.html and
https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/0996ba68e5794b8ab51db8d25d4c9f8a/1f1b1a6072594d41867cb19e6677526f.html.

## Enabling Quick Buy

You can enable quick buy by installing the `@spartacus/opf` OPF library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries). 

For a seamless installation, you can use schematics parameters. For more information, see how to use --opfGooglePayApiUrl in 'Configuring Quic kBuy for GooglePay'.

### CMS Components

Quick buy is CMS-driven and consists of the following CMS component:

-`OpfQuickBuyButtonsComponent`

You can configure quick buy by using SmartEdit to display the quick buy component in Spartacus, or you can manually add it to content slots using ImpEx.

If you are using the [{% assign linkedpage = site.pages | where: "name", "spartacussampledata-extension.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/spartacussampledata-extension.md %}), the quick buy component is already enabled. However, if you decide not to use the `spartacussampledata` extension, you can enable the quick buy component through ImpEx.

**Note:** The `$contentCV` variable that is used throughout the following ImpEx examples, and which stores information about the content catalog, is defined as follows:

```text
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]
```

### Adding CMS Component Manually

This section describes how to add the quick buy CMS component to Spartacus using ImpEx.

You can enable quick buy by adding the Quick Buy button component to the Cart page/You can enable the checkout components for open payment framework with the following ImpEx:

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;OpfQuickBuyButtonsComponent;Opf Quick Buy Buttons Component;OpfQuickBuyButtonsComponent

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;CenterRightContentSlot-cartPage;Center Right Content Slot for Cart Page;CartTotalsComponent,CartApplyCouponComponent,CartQuickOrderFormComponent,OpfQuickBuyButtonsComponent,CartProceedToCheckoutComponent
```

## Configuring Quick Buy

### Configuring Quick Buy for Apple Pay

The open payment framework enables you to implement an express checkout for your customers using Apple Pay.

#### Browser Support

Quick buy for Apple Pay is available on Safari. For more information, see https://developer.apple.com/documentation/apple_pay_on_the_web.

#### Modifying the Quick Buy Button

You can modify the appearance of the Apple Pay quick buy button. By default, the quick buy button is black with a 'Buy with Apple Pay' label. The default values of the Apple Pay button style are as follows:

-`webkit-appearance`: `apple-pay-button`
-`apple-pay-button-type`: `buy`
-`apple-pay-button-style`: `black`

To modify the Apple Pay button, you extend the style with the `%cx-opf-apple-pay` placeholder selector and overwrite the `apple-pay-button` class with the desired values.

For the list of attributes and possible values for the Apple Pay quick buy button, see https://developer.apple.com/documentation/apple_pay_on_the_web/displaying_apple_pay_buttons_using_css.

For more information on creating CSS placeholder selectors, see
https://help.sap.com/docs/SAP_COMMERCE_COMPOSABLE_STOREFRONT/eaef8c61b6d9477daf75bff9ac1b7eb4/a95f88362b1a4ecf998047c93ab7bc12.html#loio23416cbcc1da4c9eaf513999dde8b7de.

#### Modifying Card Parameters

By default, the card parameters configuration is hard coded with `ApplePayService`. You can overwrite it by extending `ApplePayService` and overwriting the following object:

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

### Configuring Quick Buy for Google Pay

#### Adding the Google Pay API URL

You must define the Google Pay API URL during configuration. There are several ways to do it.

1. When installing the OPF library, use schematics with the `opfGooglePayApiUrl` parameter, for example:
   `--opfGooglePayApiUrl=https://pay.google.com/gp/p/js/pay.js`

2. After installing the OPF library, replace the following placeholder in `opf-feature.module.ts`:

```ts
provideConfig(<OpfQuickBuyConfig>{
providers:{
  googlePay: {
    resourceUrl: "PLACEHOLDER_GOOGLE_PAY_API_URL"
}
}
}),
```

#### Modifying Card Parameters

The card parameters configuration is hardcoded on the `OpfGooglePayService` service. You can customize the default card parameters configuration by extending `OpfGooglePayService` and overwriting the following object:

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
  };
```

For more information on extending services in Spartacus, see https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/aa417173fe4a4ba5a473c93eb730a417/465a25442fd64a1ab33d98362d66d25b.html?q=extend%2520service.



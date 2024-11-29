---
title: QuickBuy
---

Quick Buy is a CMS based feature which display GooglePay and ApplePay buttons.
Quick Buy is available on Cart page.
Available for Guest and login users.

## Enabling QuickBuy

QuickBuy feature is automatically added when installing OPF lib `@spartacus/opf`.
For seemless install, schematics parameters can be used, see how to use --opfGooglePayApiUrl in 'Configuring QuickBuy for GooglePay' section

### CMS Components

If you are using the `spartacussampledata` extension to build your storefront, it includes all of the CMS data that is required for the QuickBuy feature, and it is enabled by default. If you are not using the `spartacussampledata` extension, you need to add the CMS components manually. For more information, see the following section.

### Adding the CMS Components Manually

OpfQuickBuyButtonsComponent is the CMS Compoonent responsible to display QuickBuy.

**Note:** The `$contentCV` variable, which stores information about the content catalog, and which is used throughout the ImpEx in the following procedures, is defined as follows:

$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]

The following procedure describes how to enable checkout components for open payment framework, which is necessary if you are not using the `spartacussampledata` extension to build your storefront.

INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;OpfQuickBuyButtonsComponent;Opf Quick Buy Buttons Component;OpfQuickBuyButtonsComponent

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;CenterRightContentSlot-cartPage;Center Right Content Slot for Cart Page;CartTotalsComponent,CartApplyCouponComponent,CartQuickOrderFormComponent,OpfQuickBuyButtonsComponent,CartProceedToCheckoutComponent

## Configuring QuickBuy

### Configuring QuickBuy for ApplePay

- Modify button appearance
  Overwrite `cx-opf-apple-pay.apple-pay-button` CSS class within \_opf-apple-pay.scss:
  Default values are
  -webkit-appearance: -apple-pay-button;
  -apple-pay-button-type: buy;
  -apple-pay-button-style: black;
  For attributes list, see:: https://developer.apple.com/documentation/apple_pay_on_the_web/displaying_apple_pay_buttons_using_css

### Configuring QuickBuy for GooglePay

GooglePayApi url must be be defined in configuration.
Directly within schematics with parameter 'opfGooglePayApiUrl', eg:
--opfGooglePayApiUrl=https://pay.google.com/gp/p/js/pay.js

Alternatively, replace below placeHolder in in opf-feature.module.ts:
provideConfig(<OpfQuickBuyConfig>{
providers:
{
googlePay: {
resourceUrl: "PLACEHOLDER_GOOGLE_PAY_API_URL"
}
}
}),

### Configuring the Back End Link

Procedure

### Overwriting hardCodes Information

Procedure

<!-- If it makes sense to merge the steps for "Configuring the Back End Link" and "Overwriting hardCodes" into a single procedure (such as "Additional Configuration"), we can do that too. But if each procedure would contain multiple steps, then it make make sense to keep them as separate procedures, as they are laid out here. -->

## Extending QuickBuy

Is there anything partners can do to extend QuickBuy?

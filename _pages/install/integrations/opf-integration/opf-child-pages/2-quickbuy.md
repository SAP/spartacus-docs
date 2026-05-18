---
title: Quick Buy
---

Quick Buy is a CMS-based feature that can display Google Pay and Apple Pay buttons on the cart page. Quick Buy allows users to easily purchase items in their cart, whether they are logged in or checking out as a guest.

Starting with Spartacus version 221121.10, Quick Buy now also supports services such as PayPal. This functionality is described in [CTA Quick Buy](#cta-quick-buy), below.

Before enabling Quick Buy in Spartacus, you must first enable the Quick Buy functionality in SAP Commerce Cloud. For more information, see [Configure Quick Buy for Google Pay](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/0996ba68e5794b8ab51db8d25d4c9f8a/712bd315f3ff433f9580e55eabd1fcca.html) and [Configure Quick Buy for Apple Pay](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/0996ba68e5794b8ab51db8d25d4c9f8a/1f1b1a6072594d41867cb19e6677526f.html).

## Enabling Quick Buy in Spartacus

Quick Buy functionality is added to your storefront app when you install the open payment framework library, as described in [Enabling Open Payment Framework in Spartacus](link-to-section-in-1-open-payment-framework-in-spartacus.md).

### CMS Components

Quick Buy is CMS-driven and consists of the `OpfQuickBuyButtonsComponent` component. If you are using CTA Quick Buy for services such as PayPal, CTAs are rendered through the `OpfCtaQuickBuyButtons` CMS component.

If you are using the [Spartacus Sample Data Extension](link), the Quick Buy component is already enabled. However, if you decide not to use the `spartacussampledata` extension, you can enable the Quick Buy CMS component manually through ImpEx.

### Adding CMS Component Manually

To add all of the necessary CMS data for Quick Buy, import the following ImpEx:

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;OpfQuickBuyButtonsComponent;Opf Quick Buy Buttons Component;OpfQuickBuyButtonsComponent
;;OpfCtaQuickBuyButtons;Opf Quick Buy CTA Buttons Component;OpfCtaQuickBuyButtons

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;CenterRightContentSlot-cartPage;Center Right Content Slot for Cart Page;CartTotalsComponent,CartApplyCouponComponent,CartQuickOrderFormComponent,OpfCtaQuickBuyButtons,OpfQuickBuyButtonsComponent,CartProceedToCheckoutComponent
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

The card parameters for Apple Pay are configurable through the `OpfQuickBuyConfig`. You can override the default configuration by using `provideConfig`:

```ts
provideConfig(<OpfQuickBuyConfig>{
  providers: {
    applePay: {
      resourceUrl:
        "https://applepay.cdn-apple.com/jsapi/1.latest/apple-pay-sdk.js",
      cardParameters: {
        shippingMethods: [],
        merchantCapabilities: ["supports3DS"],
        supportedNetworks: ["visa", "masterCard", "amex", "discover"],
        requiredShippingContactFields: ["email", "name", "postalAddress"],
        requiredBillingContactFields: ["email", "name", "postalAddress"],
      },
    },
  },
});
```

For more information on providing configuration in Spartacus, see [Global Configuration in Composable Storefront](https://help.sap.com/docs/SAP_COMMERCE_COMPOSABLE_STOREFRONT/eaef8c61b6d9477daf75bff9ac1b7eb4/b547483f90a7422abf7c597b454af4b2.html?locale=en-US).

## Configuring Quick Buy for Google Pay

The Google Pay configuration, including the environment, payment request parameters, and card parameters, is configurable through the `OpfQuickBuyConfig`. You can override the default configuration by using `provideConfig`:

```ts
provideConfig(<OpfQuickBuyConfig>{
  providers: {
    googlePay: {
      resourceUrl: "https://pay.google.com/gp/p/js/pay.js",
      environment: "TEST",
      paymentRequest: {
        apiVersion: 2,
        apiVersionMinor: 0,
        merchantInfo: {
          merchantId: "",
          merchantName: "Example Merchant",
        },
        emailRequired: true,
        shippingAddressRequired: true,
        shippingOptionRequired: true,
        shippingAddressParameters: {
          phoneNumberRequired: false,
        },
        callbackIntents: [
          "PAYMENT_AUTHORIZATION",
          "SHIPPING_ADDRESS",
          "SHIPPING_OPTION",
        ],
      },
      cardParameters: {
        allowedAuthMethods: ["PAN_ONLY", "CRYPTOGRAM_3DS"],
        allowedCardNetworks: [
          "AMEX",
          "DISCOVER",
          "INTERAC",
          "JCB",
          "MASTERCARD",
          "VISA",
        ],
        billingAddressRequired: true,
        billingAddressParameters: {
          format: "FULL",
        },
      },
    },
  },
});
```

For more information on providing configuration in Spartacus, see [Global Configuration in Composable Storefront](https://help.sap.com/docs/SAP_COMMERCE_COMPOSABLE_STOREFRONT/eaef8c61b6d9477daf75bff9ac1b7eb4/b547483f90a7422abf7c597b454af4b2.html?locale=en-US).

## CTA Quick Buy

In addition to the Google Pay and Apple Pay buttons provided by the `OpfQuickBuyButtonsComponent`, starting with Spartacus version 221121.10, OPF also provides a “Quick Buy” call-to-action (CTA) button for the product details page and the cart page. This CTA Quick Buy, which can be used with services such as PayPal, is separate from the wallet Quick Buy implementation in `@spartacus/opf/quick-buy`.

Spartacus renders Quick Buy CTAs through the `OpfCtaQuickBuyButtons` CMS component. Place this component on the relevant CMS page where you want the PayPal CTA to appear, such as the product details page or the cart.

When the page loads, Spartacus requests the CTA payload based on where the customer is in the storefront (for example, the product details page or the cart). In the OPF Workbench, ensure that your payment provider is configured to return CTA scripts for the matching CTA script location. Otherwise, the component has nothing to render.

### Configuring the Payment Provider in the OPF Workbench

To ensure the CTA script location matches where the CTA Quick Buy component is rendered in Spartacus, verify the configuration in the OPF Workbench as follows:

1. Log in to the OPF Workbench.
2. Select **Payment Integrations**.
3. Select the integration that you want to configure, and then choose **Show Details**.

   ![OPF Workbench - Payment Integrations]({{ site.baseurl }}/assets/images/opf/quickbuy/workbench-quickbuy-cta-step-1.png)

4. In the **Authorization** panel, select **Edit**.

   ![OPF Workbench - Integration details]({{ site.baseurl }}/assets/images/opf/quickbuy/workbench-quickbuy-cta-step-2.png)

5. In the **Authorization** tab, select **Payment Call-to-Action Configuration** from the dropdown menu.

   ![OPF Workbench - Edit authorization]({{ site.baseurl }}/assets/images/opf/quickbuy/workbench-quickbuy-cta-step-3.png)

6. In the **Consumer Facing Component Assignment** field, select **Cart Button** to display the script in the Quick Buy component on the cart page, and then click **Save**.

   ![OPF Workbench - Payment Call-to-Action Configuration]({{ site.baseurl }}/assets/images/opf/quickbuy/workbench-quickbuy-cta-step-4.png)

7. Ensure that your CTA configuration is enabled in the **Enablement** section.

OPF returns the CTA content as HTML, along with the JavaScript and CSS resource URLs. Spartacus renders the CTA Quick Buy container, loads the provided resources, and runs them in the browser to display.

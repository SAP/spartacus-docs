---
title: SAP Open Payment Framework Integration
feature:
  - name: Open Payment Framework Integration
    spa_version: [NOT_SPECIFIED_YET]
    cx_version: 2211
---

{% capture version_note %}
{{ site.version_note_part1 }} [NOT_SPECIFIED_YET] {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The Open Payment Framework provides merchants with a streamlined way to connect their chosen Payment Service Provider using configurations.

For more information, see [Open Payment Framework in a Nutshell](https://help.sap.com/docs/SAP_UPSCALE_COMMERCE/0160c41e0de84b218d05bc1185213d1d/5efc3463b4504d27bb9c4fbbb95a4ccc.html?locale=en-US#open-payment-framework-in-a-nutshell) on the SAP Help Portal.

---

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
  {:toc}

---

## Requirements

To integrate SAP Open Payment Framework with Composable Storefront, you must have SAP Commerce Cloud 2211 or newer.

## Composable Storefront Integration with Payment Service Provider

The Composable Storefront offers a versatile integration with the Open Payment Framework. Depending on the configurations set within the Open Payment Framework, the Composable Storefront can adapt its behavior to present different user experience (UX) patterns during the payment process.

### UX Patterns

Here are the distinct UX patterns that the Composable Storefront can render based on the configurations:

- **Gateway Page**: In this mode, consumers are redirected to a page that is hosted by the Payment Service Provider. Consumers finalize their payment on the trusted platform of the Payment Service Provider, ensuring a secure transaction experience.

- **iFrame**: This pattern involves displaying an embedded iframe on the page.
  It allows consumers to complete their payment within the iframe without navigating away from the main site.

- **Hosted Fields**: The pattern where hosted fields are displayed directly on the page. Consumers can finish their payment seamlessly within these hosted fields, offering a streamlined experience without redirection.

#### Support for 3DS

It is important to note that all the above UX patterns support 3DS (3-D Secure) authentication. This means that consumers will benefit from an additional layer of security during the payment process, regardless of which UX pattern they encounter.

## Backend Configuration

### Sample data

Certain features of OPF, including the payment and review page or the call-to-action scripts, necessitate specific sample data configurations on the backend.

If the OPF features do not function correctly, import the following impex script into the backend system:

```
[FINAL IMPEX SCRIPT WILL BE HERE]
```

Proper slot configuration via impex script is essential for the optimal functioning of some OPF features. Always ensure that the script is accurate and has been imported successfully.

## Adding the Open Payment Framework Integration to Composable Storefront

To add the OPF integration to Composable Storefront, you install the `@spartacus/opf` library.

You can either [install the OPF library during initial setup of your Spartacus project](#installing-the-opf-library-during-the-initial-setup-of-composable-storefront), or you can [add the OPF library to an existing Composable Storefront project](#adding-the-opf-library-to-an-existing-composable-storefront-project).

### Installing the OPF Library During the Initial Setup of Composable Storefront

1. Follow the steps for setting up your Composable Storefront project, as described in [{% assign linkedpage = site.pages | where: "name", "building-the-spartacus-storefront-from-libraries.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/frontend/building-the-spartacus-storefront-from-libraries.md %}).
1. While setting up your project using schematics, when you are asked which Storefront features you would like to set up, choose `Open Payment Framework Integration`.

### Adding the OPF Library to an existing Composable Storefront Project

If you already have a Storefront project up and running, you can add the OPF library to your project by running the following command from the root directory of your storefront app:

```bash
ng add @spartacus/opf
```

This command uses schematics to modify your application and add the modules needed to launch the library.

#### OPF Library Subdivision

The OPF library is designed to be modular and efficient by dividing it into two distinct sub-libraries. This approach ensures optimal performance and seamless user experiences.

Currently is split into the following sub-libraries:

- **@spartacus/opf/base**: This sub-library contains the foundational elements of the OPF. It provides the core functionalities that are essential for the library to operate.

- **@spartacus/opf/checkout**: Specifically tailored for functionalities associated with the checkout process in the OPF. It is lazy loaded only when a customer navigates to the checkout page. This ensures that these functionalities are not loaded preemptively, saving resources until they are absolutely necessary.

## Storefront Configuration

### Commerce Cloud Adapter Configuration

In order to ensure the optimal performance and functionality of the OPF feature within the app, specific configurations need to be set up.

Incorporate the following configuration settings in your application to make sure the OPF feature functions correctly:

```ts
provideConfig(<OpfConfig>{
  opf: {
    baseUrl: '<URL TO COMMERCE CLOUD ADAPTER>',
    commerceCloudPublicKey: '<COMMERCE CLOUD PUBLIC KEY>',
  },
}),
```

Below are explanations of the configuration properties:

- **baseUrl**: This denotes the URL to the Commerce Cloud Adapter.

- **commerceCloudPublicKey**: This is the public key provided by OPF. It is used to establish a connection to the correct CCv2 configuration on the Commerce Cloud Adapter's side.

### Routing Configuration

To configure routing for payment verification in your application, use the following configuration structure:

```ts
provideConfig(<RoutingConfig>{
  routing: {
    routes: {
      paymentVerificationResult: {
        paths: ['redirect/success'],
      },
      paymentVerificationCancel: {
        paths: ['redirect/failure'],
      },
    },
  },
}),
```

Here are detailed explanations of the properties within the configuration:

- **paymentVerificationResult**: A route configuration that relates to the successful result of a payment verification.

- **paymentVerificationCancel**: A route configuration that relates to the cancellation or failure of a payment verification.

Setting up the routing configurations accurately is critical to ensuring users are directed to the appropriate paths based on the outcomes of their payment verification processes. Always ensure the values provided are in line with the application's routing strategy.

For more comprehensive information or troubleshooting, please refer to [{% assign linkedpage = site.pages | where: "name", "route-configuration.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/routes/route-configuration.md %}).

### OPF Checkout Configuration

The OPF feature library supports run-time adjustment of the checkout flow based on the `paymentProvider` property. Learn more about this feature here [{% assign linkedpage = site.pages | where: "name", "route-configuration.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/routes/extending-checkout.md %}).

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

The SAP Commerce Open Payment Framework, which is delivered as an enrichment to the SAP Commerce Cloud payment toolkit, is a SaaS solution for managing your payment integrations in an intuitive and effective way. The Open Payment Framework allows you to integrate your preferred digital payment service providers faster than before, and removes the need to code, integrate and deploy extensions to the Commerce codebase.

For more information, see [Open Payment Framework](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/0996ba68e5794b8ab51db8d25d4c9f8a/f3d565da0d524b8081c861b4f5dea359.html?locale=en-US).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Requirements

To integrate SAP Open Payment Framework with Spartacus, you need Spartacus 2211.x or newer, as well as SAP Commerce Cloud 2211.x or newer.

## Spartacus Integration with Payment Service Providers

Spartacus provides a range of distinct user experience (UX) patterns that you can choose from when integrating with Open Payment Framework.

The following are the UX patterns that Spartacus can render based on the configurations in Open Payment Framework:

- **Gateway Page**: Redirects customers to a page that is hosted by the payment service provider. Customers finalize their payment on the trusted platform of the payment service provider, which ensurers a secure transaction experience.

- **iFrame**: Displays an embedded iframe on the page. This allows customers to complete their payment within the iframe without navigating away from the main site.

- **Hosted Fields**: Displays hosted fields directly on the page. Customers can finish their payment seamlessly within the hosted fields, which provides a streamlined experience without redirection.

**Note:** All of these UX patterns support 3-D Secure (3DS) authentication. This means that customers benefit from an additional layer of security during the payment process, regardless of which UX pattern they encounter.

## Backend Configuration

Certain Open Payment Framework features, including the payment and review pages, as well as the call-to-action scripts, require specific sample data to be present in the back end.

To ensure that Open Payment Framework features function correctly, import the following ImpEx script into SAP Commerce Cloud:

```
[ADD FINAL IMPEX SCRIPT HERE]
```

**Note:** Using the ImpEx script to obtain the correct slot configuration is essential for ensuring the optimal functioning of certain OPF features. Always ensure that the script is accurate and has been imported successfully.

## Adding the Open Payment Framework Integration to Spartacus

You add the Open Payment Framework integration to Spartacus by installing the `@spartacus/opf` library.

If you have not yet set up your Spartacus app, you use the Spartacus schematics to select `Open Payment Framework Integration` when choosing which features to include in your storefront app.

If you already have a storefront project up and running, you can add the `opf` library to your project by running the following command from the root directory of your storefront app:

```bash
ng add @spartacus/opf
```

This command uses schematics to modify your application and add the modules that are needed to launch the `opf` library.

### Open Payment Framework Library Subdivision

The `opf` library is divided into two distinct sub-libraries ensure optimal performance and a seamless user experiences.

The `opf` library is split into sub-libraries as follows:

- **@spartacus/opf/base** contains the foundational elements of the Open Payment Framework integration. It provides the core functionalities that are essential for the library to operate.

- **@spartacus/opf/checkout** is specifically tailored to functionalities that are associated with the checkout process in the Open Payment Framework. This sub-library is lazy-loaded only when a customer navigates to the checkout page. This lazy-loading ensures that the checkout functionalities are not loaded preemptively, which saves using resources until they are absolutely necessary.

## Storefront Configuration

The following sections describe how to configure Spartacus to work with the Commerce Cloud adapter, and how to configure the routing to work with Open Payment Framework.

### Commerce Cloud Adapter Configuration

An essential part of the Open Payment Framework architecture is the Commerce Cloud Adapter. To ensure that Spartacus can communicate with the Commerce Cloud Adapter, you need to set values for the `baseUrl` and the `commerceCloudPublicKey` properties, as shown in the following example:

```ts
provideConfig(<OpfConfig>{
  opf: {
    baseUrl: '<URL TO COMMERCE CLOUD ADAPTER>',
    commerceCloudPublicKey: '<COMMERCE CLOUD PUBLIC KEY>',
  },
}),
```

The following is a description of the Commerce Cloud Adapter configuration properties:

- `baseUrl` is the URL to the Commerce Cloud Adapter. This URL has the same domain as your workbench URL, which is provided to you by an SAP administrator. For more information, contact your SAP administrator for Open Payment Framework.

- `commerceCloudPublicKey` is the public key provided by Open Payment Framework. This key is used to establish a connection with the correct SAP Commerce Cloud configuration that communicates with the Commerce Cloud Adapter. For more information about generating the `commerceCloudPublicKey`, see [Configure Client in Open Payment Framework Workbench](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/0996ba68e5794b8ab51db8d25d4c9f8a/abd0dcd86a5d472e8fd6d22bff28e9c4.html?locale=en-US&state=DRAFT).

For more information on the Commerce Cloud Adapter, see [Open Payment Framework Integration with SAP Commerce Cloud](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/0996ba68e5794b8ab51db8d25d4c9f8a/6ee8de9190054ed2aa215029a8c5cdc2.html?locale=en-US&state=DRAFT).

### Routing Configuration

Setting up accurate routing configuration for Open Payment Framework is critical to ensuring users are directed to the appropriate paths based on the outcomes of their payment verification processes. Always ensure the values provided are in line with the routing strategy of your storefront application.

The following is an example of the routing configuration for Open Payment Framework:

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

For more information about routing in Spartacus, see [{% assign linkedpage = site.pages | where: "name", "route-configuration.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/routes/route-configuration.md %}).

### Open Payment Framework Checkout Configuration

The Open Payment Framework library supports run-time adjustment of the checkout flow based on the `paymentProvider` property. For more information, see [Multiple Checkout Flows]({{ site.baseurl }}{% link _pages/dev/extending-checkout.md %}#multiple-checkout-flows).

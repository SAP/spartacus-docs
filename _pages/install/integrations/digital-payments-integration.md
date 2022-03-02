---
title: SAP Digital Payments Integration
feature:
- name: SAP Digital Payments Integration
  spa_version: 4.1
  cx_version: 2011* or 2105*
---

{% capture version_note %}
{{ site.version_note_part1 }} 4.1 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

SAP Digital Payments integration is an out-of-the-box alternative to current custom payment service provider (PSP) integrations. This integration uses SAP Digital Payments with ready-to-use PSP connectivity.

For more information, see [SAP Digital Payments Integration](https://help.sap.com/viewer/50c996852b32456c96d3161a95544cdb/1808/en-US/1431af6defa14619a8eeccffe45bad7f.html) on the SAP Help Portal.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Requirements

To integrate SAP Digital Payments with Spartacus, you must have one of the following:

- SAP Commerce Cloud 2105, along with SAP Commerce Cloud, Integration Extension Pack 2108 or later
- SAP Commerce Cloud 2011, along with SAP Commerce Cloud, Integration Extension Pack 2102 or later

## Enabling SAP Digital Payment Integration in Spartacus

To enable SAP Digital Payments Integration in Spartacus, you need to configure both the Commerce Cloud back end, and the Spartacus front end.

### Configuring the Back End for SAP Digital Payments Integration

The following steps describe how to configure the Commerce Cloud back end for integration with SAP Digital Payments.

1. Follow the steps for [{% assign linkedpage = site.pages | where: "name", "installing-sap-commerce-cloud.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/backend/installing-sap-commerce-cloud.md %}).
1. Enable the SAP Digital Payments Extensions.
For more information, see [SAP Digital Payments Integration](https://help.sap.com/viewer/5c14e3b8bb034c6eb641a71627210557/v1808/en-US/1431af6defa14619a8eeccffe45bad7f.html) on the SAP Help Portal.
1. Build and update the system so that the new functionality provided by the SAP Digital Payments integration extensions is available.
This step also creates sample CMS data for the `electronics-spaContentCatalog` content catalog.

### Configuring Spartacus for SAP Digital Payments Integration (version < 5.0)

Perform the following steps after you have set up your Spartacus Storefront. For more information, see [{% assign linkedpage = site.pages | where: "name", "building-the-spartacus-storefront-from-libraries.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/frontend/building-the-spartacus-storefront-from-libraries.md %}).

1. Install the SAP Digital Payments integration library by running the following command from within the root directory of your storefront application:

   ```text
   ng add @spartacus/digital-payments
   ```

   When you run this command, the schematics create a module for the Digital Payments integration that includes all of the required imports and configuration.

   **Note:** To install the Digital Payments integration library using schematics, your app structure needs to match the Spartacus reference app structure. For more information, see [{% assign linkedpage = site.pages | where: "name", "reference-app-structure.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/reference-app-structure.md %}).

   Alternatively, you can create the module manually and import it into your application, as shown in the following example:

   ```ts
   import { NgModule } from '@angular/core';
   import { I18nConfig, provideConfig } from "@spartacus/core";
   import { DigitalPaymentsModule, dpTranslationChunksConfig, dpTranslations } from "@spartacus/digital-payments";
   
   @NgModule({
     declarations: [],
     imports: [
       DigitalPaymentsModule
     ],
     providers: [provideConfig(<I18nConfig>{
       i18n: {
         resources: dpTranslations,
         chunks: dpTranslationChunksConfig,
       },
     })]
   })
   export class DigitalPaymentsFeatureModule { }
   ```

1. Build and start the storefront app to verify your changes.

### Configuring Spartacus for SAP Digital Payments Integration (version >= 5.0)

From 5.0, a new entry point was created in Digital Payments for assets. The Digital Payments feature can be lazy loaded.

Perform the following steps after you have set up your Spartacus Storefront. For more information, see [{% assign linkedpage = site.pages | where: "name", "building-the-spartacus-storefront-from-libraries.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/frontend/building-the-spartacus-storefront-from-libraries.md %}).

1. Install the SAP Digital Payments integration library by running the following command from within the root directory of your storefront application:

   ```text
   ng add @spartacus/digital-payments
   ```

   When you run this command, the schematics create a module for the Digital Payments integration that includes all of the required imports and configuration.

   **Note:** To install the Digital Payments integration library using schematics, your app structure needs to match the Spartacus reference app structure. For more information, see [{% assign linkedpage = site.pages | where: "name", "reference-app-structure.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/reference-app-structure.md %}).

   Alternatively, you can create the module manually and import it into your application, as shown in the following example:

   ```ts
   import { NgModule } from '@angular/core';
   import { CHECKOUT_FEATURE } from '@spartacus/checkout/base/root';
   import { CmsConfig, I18nConfig, provideConfig } from '@spartacus/core';
   import {
     dpTranslationChunksConfig,
     dpTranslations,
   } from '@spartacus/digital-payments/assets';
   @NgModule({
     providers: [
       provideConfig(<CmsConfig>{
         featureModules: {
           [CHECKOUT_FEATURE]: {
             module: () =>
               import('@spartacus/digital-payments').then(
                 (m) => m.DigitalPaymentsModule
               ),
           },
         },
       }),
       provideConfig(<I18nConfig>{
         i18n: {
           resources: dpTranslations,
           chunks: dpTranslationChunksConfig,
           fallbackLang: 'en',
         },
       }),
     ],
   })
   export class DigitalPaymentsFeatureModule {}
   ```

1. Build and start the storefront app to verify your changes.

  **Note:** `DigitalPaymentsModule` is a wrapper module which imports `CheckoutModule`. So, we want `DigitalPaymentsModule` to override `CheckoutModule` for feature "Checkout". To do so:
   1. config the feature "CHECKOUT_FEATURE" for Digital Payments lazy loading
   2. import `DigitalPaymentsFeatureModule` after `CheckoutFeatureModule`

### Configuring SAP Digital Payments with B2B checkout (version >= 5.0)

Schematics installing the Digital Payments integration library will automatically generate the `DigitalPaymentsFeatureModule`, which works with our base checkout feature. To make Digital Payments work with B2B or Schedule Replenishement checkout, you can create the wrapper module manually, and update `DigitalPaymentsFeatureModule`.

    Digital Payments with B2B Checkout:

    ```ts
    import { NgModule } from '@angular/core';
    import { CheckoutB2BModule } from '@spartacus/checkout/b2b';
    import { DigitalPaymentsModule } from '@spartacus/digital-payments';

    @NgModule({
      imports: [DigitalPaymentsModule, CheckoutB2BModule],
    })
    export class B2BDigitalPaymentsModule {}
    ```

    In `DigitalPaymentsFeatureModule`, update the feature configuration as:

    ```ts
    provideConfig(<CmsConfig>{
      featureModules: {
        [CHECKOUT_FEATURE]: {
          module: () =>
            import('./b2b-digital-payments.module').then(
              (m) => m.B2BDigitalPaymentsModule
            ),
        },
      },
    }),
    ```

    Digital Payments with Scheduled Replenishment Checkout:

    ```ts
    import { NgModule } from '@angular/core';
    import { CheckoutScheduledReplenishmentModule } from '@spartacus/checkout/scheduled-replenishment';
    import { DigitalPaymentsModule } from '@spartacus/digital-payments';

    @NgModule({
      imports: [DigitalPaymentsModule, CheckoutScheduledReplenishmentModule],
    })
    export class ReplenishmentDigitalPaymentsModule {}
    ```

    In `DigitalPaymentsFeatureModule`, update the feature configuration as:

    ```ts
    provideConfig(<CmsConfig>{
      featureModules: {
        [CHECKOUT_FEATURE]: {
          module: () =>
            import('./replenishment-digital-payments.module').then(
              (m) => m.ReplenishmentDigitalPaymentsModule
            ),
        },
      },
    }),
    ```

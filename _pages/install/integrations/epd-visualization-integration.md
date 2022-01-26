---
title: SAP Enterprise Product Development Visualization Integration
feature:
- name: SAP Enterprise Product Development Visualization Integration
  spa_version: 4.3
  cx_version: 2105
---

{% capture version_note %}
{{ site.version_note_part1 }} 4.3 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The SAP Enterprise Product Development Visualization integration provides capabilities for viewing 2D and 3D content within a Spartacus storefront, allowing for visual spare part picking.

For more information, see [Integrating Visualization with SAP Commerce Cloud](https://help.sap.com/viewer/eea9df7c0c9545cc82768477a98e56ac/Cloud/en-US) on the SAP Help Portal.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Requirements

The SAP Enterprise Product Development Visualization integration requires release 2105 of SAP Commerce Cloud, as well as a SAP Enterprise Product Development subscription. For more information, see [SAP Enterprise Product Development](https://help.sap.com/viewer/product/PLM_EPD/Cloud/en-US?task=discover_task) on the SAP Help Portal.

## Enabling the SAP Enterprise Product Development Visualization Integration in Spartacus

To enable the SAP Enterprise Product Development Visualization integration, you need to configure the following:

- [Spartacus](#configuring-spartacus)
- [SAP Commerce Cloud](#configuring-sap-commerce-cloud)
- [The back end for SAP Enterprise Product Development Visualization](#configuring-the-sap-enterprise-product-development-visualization-back-end)

### Configuring Spartacus

The following sections describe how to [configure Spartacus with schematics](#configuring-spartacus-using-schematics), as well as how to [configure Spartacus manually](#configuring-spartacus-manually). For information about customizing the default configuration, see [Default and Custom Configurations](#default-and-custom-configurations).

#### Configuring Spartacus Using Schematics

You can install and configure the SAP Enterprise Product Development Visualization integration using Spartacus schematics. To take advantage of the automatic setup provided by Spartacus schematics, you need to ensure that your storefront application adheres to the app structure introduced with Spartacus 3.2. For more information, see [{% assign linkedpage = site.pages | where: "name", "reference-app-structure.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/reference-app-structure.md %}).

To use schematics to perform a full configuration, run the following command from within the root directory of your storefront application:

```bash
ng add @spartacus/schematics --baseSite=powertools-epdvisualization-spa
```

If you are using a SAP Commerce Cloud server that is not a local server, the base URL of the Commerce Cloud OCC back end can be specified with a `baseUrl` command line argument. The following is an example:

```bash
ng add @spartacus/schematics --baseSite=powertools-epdvisualization-spa --baseUrl=https://my-cc-server.example.com
```

When you are prompted to choose which feature modules to include, ensure that the `EPD Visualization Integration` feature is included (along with any other features that you require).

Later, when you are prompted with `[EPD Visualization] What is the base URL (origin) of your EPD Fiori Launchpad? e.g. https://mytenant.epd.cfapps.eu20.hana.ondemand.com`, enter the [origin](https://developer.mozilla.org/en-US/docs/Glossary/Origin) portion of the URL that you use to access the EPD Fiori Launchpad for your tenant.

After you have provided this information, the schematic will configure the SAP Enterprise Product Development Visualization integration for Spartacus.

If you want to add the EPD Visualization integration library to an existing storefront application without performing a full configuration, it is possible to execute just the schematic for the EPD Visualization integration library with the following command:

```bash
ng add @spartacus/epd-visualization
```

It is not possible to specify the base site for the storefront or the SAP Commerce Cloud OCC back end URL when running the `@spartacus/epd-visualization` schematic on its own. Information on how to manually update these values is provided in the following section.

When using the `powertools-epdvisualization-spa` site, check the `src/app/spartacus/spartacus-configuration.module.ts` file and ensure the `providers` array includes `provideConfig(defaultB2bOccConfig)` and `provideConfig(defaultB2bCheckoutConfig)` as described in the following section.

#### Configuring Spartacus Manually

If you do not wish to use the schematics, you can manually add the SAP Enterprise Product Development Visualization integration library into your application, as follows.

1. Add a feature module file for the SAP Enterprise Product Development Visualization integration library to your application, as shown in the following example:

   ```ts
   import { NgModule } from '@angular/core';
   import { I18nConfig, provideConfig } from "@spartacus/core";
   import { EpdVisualizationModule } from "@spartacus/epd-visualization";
   import { epdVisualizationTranslationChunksConfig, epdVisualizationTranslations } from "@spartacus/epd-visualization/assets";
   import { EpdVisualizationConfig, EpdVisualizationRootModule } from "@spartacus/epd-visualization/root";

   @NgModule({
     declarations: [],
     imports: [
       EpdVisualizationRootModule,
       EpdVisualizationModule
     ],
     providers: [provideConfig(<I18nConfig>{
       i18n: {
         resources: epdVisualizationTranslations,
         chunks: epdVisualizationTranslationChunksConfig,
       },
     }),
     provideConfig(<EpdVisualizationConfig>{
       epdVisualization: {
         ui5: {
           bootstrapUrl: "https://sapui5.hana.ondemand.com/1.97.0/resources/sap-ui-core.js"
         },

         apis: {
           baseUrl: "https://epd-acc-eu20-consumer.epdacc.cfapps.eu20.hana.ondemand.com"
         }
       }
     })
     ]
   })
   export class EpdVisualizationFeatureModule { }
   ```

1. Include the `EpdVisualizationFeatureModule` module in the `import` array of the `@NgModule` decorator in the `spartacus-features.module.ts` file.

1. Create a `src/styles/spartacus/epd-visualization.scss` file containing the following:

   ```scss
   @import "@spartacus/epd-visualization";
   ```

1. To use the `powertools-epdvisualization-spa` site created by the `epdvisualizationspartacussampledata` extension, ensure that the `@NgModule` decorator in the `src/app/spartacus/spartacus-configuration.module.ts` has the following:

   - a `providers` array that includes `provideConfig(defaultB2bOccConfig)` and `provideConfig(defaultB2bCheckoutConfig)`
   - a `baseSite` value of `powertools-epdvisualization-spa` in the `context` object of the `SiteContextConfig` configuration.

   The following is an example:

   ```typescript
   import { NgModule } from '@angular/core';
   import { translationChunksConfig, translations } from "@spartacus/assets";
   import { FeaturesConfig, I18nConfig, OccConfig, provideConfig, SiteContextConfig } from "@spartacus/core";
   import { defaultB2bCheckoutConfig, defaultB2bOccConfig } from "@spartacus/setup";
   import { defaultCmsContentProviders, layoutConfig, mediaConfig } from "@spartacus/storefront";

   @NgModule({
     declarations: [],
     imports: [
     ],
     providers: [provideConfig(layoutConfig), provideConfig(mediaConfig), ...defaultCmsContentProviders, provideConfig(<OccConfig>{
       backend: {
         occ: {
           baseUrl: 'https://localhost:9002',
         }
       },
     }), provideConfig(<SiteContextConfig>{
       context: {
         currency: ['USD'],
         language: ['en'],
         baseSite: ['powertools-epdvisualization-spa'],
       },
     }), provideConfig(<I18nConfig>{
       i18n: {
         resources: translations,
         chunks: translationChunksConfig,
         fallbackLang: 'en'
       },
     }), provideConfig(<FeaturesConfig>{
       features: {
         level: '4.3'
       }
     }), provideConfig(defaultB2bOccConfig), provideConfig(defaultB2bCheckoutConfig)]
   })
   export class SpartacusConfigurationModule { }
   ```

#### Default and Custom Configurations

The default configuration for the SAP Enterprise Product Development Visualization integration library is provided in `epd-visualization-default-config.ts`. The values in this configuration can be overridden, but otherwise do not need to be specified. The following is an example:

```ts
import { EpdVisualizationConfig } from '../config/epd-visualization-config';

export function getEpdVisualizationDefaultConfig(): EpdVisualizationConfig {
  return {
    epdVisualization: {
      usageIds: {
        folderUsageId: {
          name: 'CommerceCloud-Folder',
          keys: [
            {
              name: 'Function',
              value: 'Online',
            },
          ],
        },
        productUsageId: {
          name: 'CommerceCloud-SparePart',
          source: 'CommerceCloud',
          category: 'SpareParts',
          keyName: 'ProductCode',
        },
      },
      visualPicking: {
        productReferenceType: 'SPAREPART',
      },
    },
  };
}
```

Information about the options defined by the `EpdVisualizationConfig` can be found in `epd-visualization-config.ts` in the `epd-visualization` library. The following is an example:

```ts
import { Injectable } from '@angular/core';
import { Config } from '@spartacus/core';
import { UsageId } from '../models/usage-ids/usage-id';
import { UsageIdDefinition } from '../models/usage-ids/usage-id-definition';

@Injectable({
  providedIn: 'root',
  useExisting: Config,
})
export abstract class EpdVisualizationConfig implements Config {
  /**
   * This field introduces a namespace for EPD Visualization to avoid collisions when configuration merging occurs.
   */
  public epdVisualization?: EpdVisualizationInnerConfig;
}

export interface EpdVisualizationInnerConfig {
  /**
   * UI5 configuration
   */
  ui5?: Ui5Config;
  /**
   * SAP Enterprise Product Development Visualization API endpoint configuration.
   */
  apis?: VisualizationApiConfig;
  /**
   * SAP Enterprise Product Development Visualization Usage ID configuration.
   */
  usageIds?: UsageIdConfig;
  /**
   * Configuration for the visual picking scenario.
   */
  visualPicking?: VisualPickingConfig;
}

export interface Ui5Config {
  /**
   * This is the URL that SAPUI5 is bootstrapped from.
   * The value that is configured by default in a given Spartacus release is the SAPUI5 version supported for that Spartacus release.
   *
   * Important: Please check the *End of Cloud Provisioning* column in https://sapui5.hana.ondemand.com/versionoverview.html
   * When the Cloud Provisioning period ends for a particular SAPUI5 version, that version will no longer be available on https://sapui5.hana.ondemand.com
   */
  bootstrapUrl: string;
}

export interface VisualizationApiConfig {
  /**
   * This is the base URL that is used to access the EPD Visualization APIs.
   * Use the origin portion of the URL for your EPD Fiori Launchpad.
   * i.e. https://mytenantsubdomain.epd.cfapps.eu20.hana.ondemand.com
   */
  baseUrl: string;
}

export interface UsageIdConfig {
  /**
   * Folders in the configured SAP EPD Visualization tenant that have anonymous access enabled and have this Usage ID
   * value applied will be searched for visualizations.
   * This configuration option allows for a separation between staging visualization data and production visualization data.
   */
  folderUsageId: UsageId;

  /**
   * Defines the EPD Visualization usage ID to use to refer to a product in SAP Commerce Cloud.
   * This Usage ID is used on:
   * - Visualizations to allow a visualization to be linked with a product.
   *   This allows a visualization to be found and loaded for the current product in a product details page.
   * - Scene nodes to allow a scene node to be linked with a product.
   *   This allows two way linking between scene nodes and products (which typically represent spare parts).
   */
  productUsageId: UsageIdDefinition;
}

export interface VisualPickingConfig {
  /**
   * This is the type of product reference to list for the active product (typically SPAREPART)
   */
  productReferenceType: string;
}

declare module '@spartacus/core' {
  interface Config extends EpdVisualizationConfig {}
}
```

### Configuring SAP Commerce Cloud

The `epdvisualizationspartacussampledata` extension configures sample catalogs and sites that demonstrate the usage of the SAP Enterprise Product Development Visualization integration.

The `epdvisualizationspartacussampledata` extension is available as a downloadable asset of [@spartacus/epd-visualization](https://github.com/SAP/spartacus/releases?q=epd-visualization&expanded=true) integration library releases in the Spartacus GitHub repository.

To create a database that includes the required sample data, add the `epdvisualizationspartacussampledata` extension in a suitable Commerce Cloud development environment.

The following steps describe how to configure SAP Commerce Cloud with sample data for the SAP Enterprise Product Development Visualization integration.

1. Follow the steps for [{% assign linkedpage = site.pages | where: "name", "installing-sap-commerce-cloud.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/backend/installing-sap-commerce-cloud.md %}). As previously noted, ensure that you are using SAP Commerce Cloud 2105 or newer.
1. Add the `epdvisualizationspartacussampledata` extension to the `localextensions.xml` file of your Commerce Cloud server.
1. Install the `epdvisualizationspartacussampledata` to your storefront as described in [Installing the epdvisualizationspartacussampledata Extension](#installing-the-epdvisualizationspartacussampledata-extension).
1. Build and deploy, which includes initializing the database. This will create a new database (destroying the existing one), which contains the sample data for the SAP Enterprise Product Development Visualization integration.

When the `epdvisualizationspartacussampledata` extension is initialized, it creates the following:

- Sample CMS data in the `powertools-epdvisualization-spaContentCatalog` and `electronics-epdvisualization-spaContentCatalog` content catalogs
- `powertools-epdvisualization-spa` and `electronics-epdvisualization-spa` sites that use these content catalogs
- Product data in the `powertoolsProductCatalog` that corresponds to 2D and 3D data that can be imported and prepared for use in visual spare part picking.

#### Installing the epdvisualizationspartacussampledata Extension

Run the following command to install the `epdvisualizationspartacussampledata` extension in SAP Commerce Cloud:

```bash
ant addoninstall -Daddonnames="epdvisualizationspartacussampledata" -DaddonStorefront.yacceleratorstorefront="<your storefront extension>"
```

For a SAP Commerce Cloud server, you can install the `epdvisualizationspartacussampledata` extension by adding the following entry (along with any required comma separator characters) to the `storefrontAddons` array in the `core-customize/manifest.json` file:

```json
{
    "addon": "epdvisualizationspartacussampledata",
    "storefront": "yacceleratorstorefront",
    "template": "yacceleratorstorefront"
}
```

### Configuring the SAP Enterprise Product Development Visualization Back End

The following help topic and its subtopics describe the configuration required in the SAP Enterprise Product Development tenant: [Configure Visualization Backend](https://help.sap.com/viewer/eea9df7c0c9545cc82768477a98e56ac/Cloud/en-US/2a9de0ae0d4245c4b6599fe9cf66d51f.html)

The following help topic describes how to prepare visualizations in the SAP Enterprise Product Development system: [Prepare Visualizations for Storefront Part Picking](https://help.sap.com/viewer/eea9df7c0c9545cc82768477a98e56ac/Cloud/en-US/d981e39ae1bb40a2b97cb93ff039b0be.html)

The following topic provides specific information related to creating and preparing visualizations that correspond with the sample product data created by the `epdvisualizationspartacussampledata` extension: [Prepare Sample Visualizations](https://help.sap.com/viewer/eea9df7c0c9545cc82768477a98e56ac/Cloud/en-US/ba46273cec114d0393ad3ad798a9be61.html)

## Accessing the Sample Data

When your back end and front end have been appropriately configured, built and deployed, you can access 2D and 3D samples in the `powertools-epdvisualization-spa` site within your storefront.

You can find each sample by searching for its product code in the search input in the header area.

To find the 3D sample, search for `CX704`.

To find the 2D sample, search for `CX704_2D`.

It is also possible to find these products by clicking on the `Lathes` item in the navigation menu.

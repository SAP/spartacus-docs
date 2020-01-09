---
title: Context-Driven Merchandising Carousels
---

**Note:** This feature is part of the Context-Driven Merchandising module introduced in Spartacus version 1.5.

## Overview

Context-Driven Merchandising carousels enable a Spartacus storefront to display the results of Context-Driven Merchandising in the form of a product carousel.

For more details on Context-Driven Merchandising, see [the dedicated documentation](https://help.sap.com/viewer/26c27f420a2946e19aaf1518849f932d/SHIP/en-US/fda52c18718648dcbd57515e7c6fefaf.html).

## Requirements

Context-Driven Merchandising carousels require the `merchandisingaddon` and `profiletagaddon` extensions. Once you install the extensions, follow the steps in [Merchandising Configuration Setup](https://help.sap.com/viewer/50c996852b32456c96d3161a95544cdb/latest/en-US/57bd76612cea4fddb2d62d2b29d0effb.html#loio57bd76612cea4fddb2d62d2b29d0effb) and [Catalog Synchronization Configuration](https://help.sap.com/viewer/50c996852b32456c96d3161a95544cdb/latest/en-US/a13f4af6daa24d66b4c9a2b0e5544160.html#loioa13f4af6daa24d66b4c9a2b0e5544160) to synchronize a product catalog with Context-Driven Services. 

**Note:** If you have SAP Commerce patch version 1905.8 or later, follow the instructions in [Product Directory Configuration](https://help.sap.com/viewer/50c996852b32456c96d3161a95544cdb/latest/en-US/a13f4af6daa24d66b4c9a2b0e5544160.html#loio6f59fb60a3fd43f89c08e8ba28b9e2a2).

For comprehensive information on Context-Driven Merchandising, see [Context-Driven Merchandising](https://help.sap.com/viewer/26c27f420a2946e19aaf1518849f932d/SHIP/en-US/fda52c18718648dcbd57515e7c6fefaf.html) and [Context-Driven Merchandising module](https://help.sap.com/viewer/50c996852b32456c96d3161a95544cdb/latest/en-US/3bf7fa520667450499d3e04560659568.html).

## Enabling Context-Driven Merchandising Carousels

Context-Driven Merchandising carousels are part of the Spartacus Context-Driven Services module. To enable the carousels, include the Context-Driven Services module in your root module with the following configuration:
```ts
CdsModule.forRoot({
  cds: {
    tenant: <YOUR_CONTEXT_DRIVEN_SERVICES_TENANT>,
    baseUrl: <BASE_CONTEXT_DRIVEN_SERVICES_ENVIRONMENT_URL>,
    endpoints: {
      strategyProducts: '/strategy/${tenant}/strategies/${strategyId}/products',
    },
    profileTag: {
      javascriptUrl: <PROFILE_TAG_JS_FILE_URL>,
      configUrl: <PROFILE_TAG_CONFIG_FILE_URL>,
    },
  },
})
```

## Configuring
The complete carousel configuration is a two-step process that involves module and individual carousel configuration.

### Configuring the Module
To learn how to configure Context-Driven Merchandising carousels as part of the Context-Driven Services module, see [Enabling Context-Driven Merchandising Carousels](#enabling-context-driven-merchandising-carousels).

### Configuring an Individual Carousel
When you configure the module, add the Context-Driven Merchandising carousel to a storefront page through SmartEdit. Use the component type name **SAP CONTEXT-DRIVEN MERCHANDISING**. 

After you add the component to the page, the component editor appears. Use the editor to define the following component settings:
- **Name:** Specify a unique name of your carousel.
- **Background Color:** Specify the color of the background behind the products in the carousel. Enter the HEX value, such as `#000000`. If you do not specify the background color, the storefront global value for the `--cx-color-backgroud` variable will be used.
- **Number to Display:** Specify the maximum number of products the carousel can retrieve from Merchandising. If the number of products exceeds the size of the carousel, the user will need to use scrolling arrows to see all products.
- **Scroll Type:** For Spartacus Context-Driven Merchandising carousels, the only available scroll type is **one**. This enables the user to scroll the products one by one upon clicking the scrolling arrow.
- **Strategy:** Select the Merchandising strategy to be used in the carousel.
- **Text Color:** Specify the text color in the carousel. Enter the HEX value, such as `#FFFFFF`. If you do not specify the text color, the storefront global value for the `--cx-color-text` variable will be used.
- **Title Name:** Specify the title of the carousel. If you do not specify the title, the field will be left empty.

## Extending
No special extensibility is available for this feature.
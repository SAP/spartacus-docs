---
title: Context-Driven Services Integration
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.5 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

The SAP Commerce Cloud, Context-Driven Services solution provides real-time customer experience personalization for SAP Commerce. You can integrate Context-Driven Services with your Spartacus Storefront, including the Profile Tag and the Merchandising Carousel features.

For more information, see [SAP Commerce Cloud, Context-Driven Services](https://help.sap.com/viewer/product/CONTEXT-DRIVEN_SERVICES/SHIP/en-US) on the SAP Help Portal.

## Requirements

To integrate Context-Driven Services with Spartacus, release **1905.9** of Commerce Cloud is required.

Also, the Anonymous Consent feature in Spartacus needs to be enabled. For more information, see [Anonymous Consent]({{ site.baseurl }}{% link _pages/dev/features/anonymous-consent.md %}).

## Enabling Context-Driven Services in Spartacus

To enable Context-Driven Services in Spartacus, you need to configure both the Commerce Cloud back end, and the Spartacus front end.

### Configuring the Back End for Context-Driven Services

The following steps describe how to add custom headers to your CORS settings, as well as how to define a consent template that allows events to be sent.

1. Add the `x-profile-tag-debug` and `x-consent-reference` custom headers to `corsfilter.commercewebservices.allowedHeaders`.

    If you are using the Assisted Service Module, add these custom headers to `corsfilter.assistedservicewebservices.allowedHeaders` as well.

    **Note:** The `corsfilter.commercewebservices.allowedHeaders` setting is for SAP Commerce Cloud version 2005 or newer. For SAP Commerce Cloud version 1905 or older, use `corsfilter.ycommercewebservices.allowedHeaders` instead.

    For more information, see [Configuring CORS](https://sap.github.io/spartacus-docs/installing-sap-commerce-cloud/#configuring-cors).

2. Define a consent template with an ID of `PROFILE`, which will allow events to be sent.

    You can define the consent template by importing the following ImpEx:

    ```sql
    $lang=en
    INSERT_UPDATE ConsentTemplate;id[unique=true];name[lang=$lang];description[lang=$lang];version[unique=true];baseSite(uid)[unique=true,    default=electronics-spa];exposed
    ;PROFILE;"Allow SAP Commerce Cloud, Context-Driven Services tracking";"We would like to store your browsing behavior so that our website can dynamically present you with a personalized browsing experience and our customer support agents can provide you with contextual customer support.";1;;true
    ```

### Configuring Spartacus for Context-Driven Services

You can carry out all of the following steps after you have set up your Spartacus Storefront. For more information, see [Building the Spartacus Storefront from Libraries]({{ site.baseurl }}{% link _pages/install/building-the-spartacus-storefront-from-libraries.md %}).

1. Install the Context-Driven Services library by running the following command from within the root directory of your storefront app:

    ```bash
    npm i @spartacus/cds
    ```

1. Import the Context-Driven Services module by adding the following line below the existing import statements at the top of `app.module.ts`:

    ```ts
    import { CdsModule } from '@spartacus/cds';
    ```

1. Add the `CdsModule` to `app.module.ts`.

    The following is an example:

    ```ts
    @NgModule({
      imports: [
        CdsModule.forRoot({
          cds: {
            tenant: 'my-tenant',
            baseUrl: 'https://api.us.context.cloud.sap',
            endpoints: {
              strategyProducts: '/strategy/${tenant}/strategies/${strategyId}/products',
            },
            merchandising: {
              defaultCarouselViewportThreshold: 80,
            }
            profileTag: {
              javascriptUrl: 'https://tag.static.us.context.cloud.sap/js/profile-tag.js',
              configUrl:
                'https://tag.static.stage.context.cloud.sap/config/my-config123',
            },
          },
        }),
        ...
    ```
    The following is a summary of the parameters of the `CdsModule`:

    - **tenant:** Set this to your testing or production tenant, as required. For more information, see [Tenant Provisioning](https://help.sap.com/viewer/4c392ae9f85b412cac24f5618fe7fc0a/SHIP/en-US/9001aa58037747b9a5dcd788bf67d237.html).
    - **baseUrl:** Replace the value shown in the example with the base URL of your Context-Driven Services environment.
    - **strategyProducts:** Set this value as shown in the example.
    - **defaultCarouselViewportThreshold:** With Commerce Cloud 1905.14 or newer, you can configure the percentage of the merchandising carousel that needs to be in the viewport for carousel view events to be sent to Context-Driven Services. If you are using an older version of Commerce Cloud, you can use this setting to provide the same functionality, but it will be applied to all carousels in the storefront, rather than individual carousels that you specify. If no value is provided, a default of 80% is used. In this case, 80% of the carousel needs to be in the viewport for view events to trigger.
    - **javascriptUrl:** Specify the URL of the Profile Tag version you wish to use. It is recommended that you use the URL for the latest version of Profile Tag (for example, `http://tag.static.us.context.cloud.sap/js/profile-tag.js`). For more information, see [Deciding Which Profile Tag Link to Use](https://help.sap.com/viewer/9e39964ec48c4335ad5d3d01f9d231fd/SHIP/en-US/2f49c91ca16344de951921e1be50c025.html) on the SAP Help Portal.
    - **configUrl:** Specify the URL of the Profile Tag configuration that you have created in Context-Driven Services. For more information, see [Profile Tag Overview](https://help.sap.com/viewer/9e39964ec48c4335ad5d3d01f9d231fd/SHIP/en-US/44cb2bd7706a48c6a3b915078d2c384d.html) on the SAP Help Portal.
    - **allowInsecureCookies:** This is an optional parameter (not show in the example above) that specifies whether Profile Tag should set insecure cookies. The default value is `false`. If you are running on HTTP, set this parameter to `true`. For example, if you are using a local back end, `allowInsecureCookies` must be set to `true`. In production, it should always be set to `false`.
    - **gtmId:** This is an optional parameter (not show in the example above) that is used to integrate Profile Tag with Google Tag Manager. For more information, see [Profile Tag](https://help.sap.com/viewer/9e39964ec48c4335ad5d3d01f9d231fd/SHIP/en-US/3bccaa4bd20441fd88dcfc1ade648591.html) on the SAP Help Portal.

## Profile Tag

To enable Profile Tag, create a CMSFlexComponent called `ProfileTagComponent` in the catalog, and place it in the footer. You can do this by importing the following ImpEx:

```sql
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef;
;;ProfileTagComponent;ProfileTag Spartacus Component;ProfileTagComponent;ProfileTagComponent;

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)[mode=append]
;;FooterSlot;ProfileTagComponent
```

This ImpEx creates the component in the Staged catalog. To publish it, run a sync, or replace `Staged` with `Online` in the ImpEx.

## Context-Driven Merchandising

Context-Driven Merchandising carousels enable a Spartacus storefront to display the results of Context-Driven Merchandising in the form of a product carousel.

For more information, see [Context-Driven Merchandising](https://help.sap.com/viewer/26c27f420a2946e19aaf1518849f932d/SHIP/en-US/fda52c18718648dcbd57515e7c6fefaf.html) and [Context-Driven Merchandising Module](https://help.sap.com/viewer/50c996852b32456c96d3161a95544cdb/latest/en-US/3bf7fa520667450499d3e04560659568.html) on the SAP Help Portal.

### Requirements for Enabling Context-Driven Merchandising

Context-Driven Merchandising carousels require the `merchandisingaddon` and `profiletagaddon` extensions. Once you install the extensions, follow the steps in [Merchandising Configuration Setup](https://help.sap.com/viewer/50c996852b32456c96d3161a95544cdb/latest/en-US/57bd76612cea4fddb2d62d2b29d0effb.html#loio57bd76612cea4fddb2d62d2b29d0effb) and [Catalog Synchronization Configuration](https://help.sap.com/viewer/50c996852b32456c96d3161a95544cdb/latest/en-US/a13f4af6daa24d66b4c9a2b0e5544160.html#loioa13f4af6daa24d66b4c9a2b0e5544160) to synchronize a product catalog with Context-Driven Services.

It is also recommended to follow the instructions in [Product Directory Configuration](https://help.sap.com/viewer/50c996852b32456c96d3161a95544cdb/latest/en-US/a13f4af6daa24d66b4c9a2b0e5544160.html#loio6f59fb60a3fd43f89c08e8ba28b9e2a2).

### Adding a Merchandising Carousel with ImpEx

If you know your `strategyId`, you can add a Merchandising carousel through ImpEx. The following is an example:

```sql
# Homepage carousel
# Create the CMS Component
INSERT_UPDATE MerchandisingCarouselComponent;$contentCV[unique=true];uid[unique=true];name;title;numberToDisplay;strategy;&componentRef
;;HomepageE2EMerchandisingCarousel;Homepage E2E Merchandising Carousel;Homepage E2E Merchandising Carousel;10;00000000-0000-0000-0000-000000000000;HomepageE2EMerchandisingCarousel

# Add the component to the slot
INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid,$contentCV)
;;Section2CSlot-Homepage;HomepageE2EMerchandisingCarousel

# Category Page carousel
# Create the CMS Component
INSERT_UPDATE MerchandisingCarouselComponent;$contentCV[unique=true];uid[unique=true];name;title;numberToDisplay;strategy;&componentRef
;;CategoryPageE2EMerchandisingCarousel;Category Page E2E Merchandising Carousel;Category Page E2E Merchandising Carousel;10;00000000-0000-0000-0000-000000000000;CategoryPageE2EMerchandisingCarousel

# Add the component to the slot
INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid,$contentCV)
;;BottomHeaderSlot;CategoryPageE2EMerchandisingCarousel

# SLR Page carousel
# Create the CMS Component
INSERT_UPDATE MerchandisingCarouselComponent;$contentCV[unique=true];uid[unique=true];name;title;numberToDisplay;strategy;&componentRef
;;SLRCategoryPageE2EMerchandisingCarousel;SLR Category Page E2E Merchandising Carousel;SLR Category Page E2E Merchandising Carousel;10;00000000-0000-0000-0000-000000000000;SLRCategoryPageE2EMerchandisingCarousel

# Add the component to the slot
INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid,$contentCV)
;;SLRCamerasBottomHeaderSlot;SLRCategoryPageE2EMerchandisingCarousel
```

**Note:** The above ImpEx includes examples of locations where you can create and place the carousel in a slot, but you are not limited to these locations. You can place the CMS component in any slot that allows it.

### Adding a Merchandising Carousel with SmartEdit

If you have followed the [SmartEdit Setup Instructions for Spartacus]({{ site.baseurl }}{% link _pages/install/smartEdit-setup-instructions-for-spartacus.md %}), you can use SmartEdit to add a Context-Driven Merchandising carousel to a page, as follows:

1. Launch SmartEdit.

2. Edit the page you want to add a Merchandising carousel to.

3. Click the **+ Component** button in SmartEdit.

   You should see the **SAP CONTEXT-DRIVEN MERCHANDISING** carousel component. If you do not see it, use the search box.

4. Drag and drop the component onto a content slot on the page.

   If the component does not drop in the **Basic Edit** mode, switch to the **Advanced Edit** mode using the dropdown in SmartEdit.

5. Fill in the fields of the configuration window that appears.

   For the **Number to Display** field, specify the number of products you wish to display in the carousel. If the number of products exceeds the size of the carousel, the user will need to use scrolling arrows to see all products.

   For the **Scroll Type** field, the only available scroll type is **one**. This enables the user to scroll the products one by one upon clicking the scrolling arrow.

   For the **Strategy** field, select a configured Merchandising strategy to be used in the carousel.

   For the **Viewport Percentage** field, enter the percentage of the carousel that needs to be in the viewport for carousel view events to be sent to Context-Driven Services.
   
   **Note:** This configuration option is only available in Commerce Cloud version 1905.14 or newer. If you are using an older version of Commerce Cloud, you can use this setting to provide the same functionality, but it will be applied to all carousels in the storefront, rather than individual carousels that you specify.

6. Click **Save** for the Merchandising carousel to appear on the page you are editing.

## Context-Driven Services Shell Application

**Note:** The Context-Driven Services Shell Application is for developers who are contributing to the Spartacus library sources. In other words, it is only available if you have cloned the Spartacus library sources and are working with a contributor set-up of Spartacus. For more information, see [Contributor Setup]({{ site.baseurl }}{% link _pages/contributing/contributor-setup.md %})

The following steps describe how to run the Context-Driven Services Shell Application:

1. Run the following command to execute the library builds:

    ```bash
    yarn build:core:lib:cds
    ```

2. Run the following command to start the shell:

    ```bash
    yarn start:cds
    ```

3. Run the following command to perform unit tests:

    ```bash
    yarn test:cds
    ```

    When you run these commands, the browser opens, and you can see the progress of the tests with detailed information, including whether the tests pass.

4. Run the following command to perform end-to-end tests. You can do this either manually or automatically.

    To run the tests manually, run the following commands:

    ```bash
    yarn start:cds
    yarn e2e:cy:cds:run:vendor
    ```

    **Note:** To run the end-to-end test in headless mode, make sure you have your Spartacus instance running before executing the end-to-end command.

    To run the tests automatically, run the following command:

    ```bash
    yarn e2e:cy:cds:start-open
    ```

    **Note:** When using this command, you do not need to separately start a Spartacus instance; it is already done as part of the command. To run the Cypress end-to-end tests for Context-Driven Services in Spartacus, select `merchandising-carousel.e2e-spec.ts` in the Cypress user interface.

## Other Commands for Context-Driven Services

All other Context-Driven Services commands have `:cds` as part of their name, and can be found in the `package.json` file of the Spartacus source code.

## Limitations

Login flow is currently not fully supported.

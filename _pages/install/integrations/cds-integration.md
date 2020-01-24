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

1. Add the `x-profile-tag-debug` and `x-consent-reference` custom headers to `corsfilter.ycommercewebservices.allowedHeaders`. 

    If you are using the Assisted Service Module, add these custom headers to `corsfilter.assistedservicewebservices.allowedHeaders` as well.

    For more information, see [Configuring CORS](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/installing-sap-commerce-cloud/#configuring-cors).

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
    npm i @spartacus/cds@1.0.0-next.0
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
            profileTag: {
              javascriptUrl: 'https://tag.static.us.context.cloud.sap/js/profile-tag.js/profile-tag.js',
              configUrl:
                'https://tag.static.stage.context.cloud.sap/config/my-config123',
            },
          },
        }),
        ...
    ```
    The following is a summary of the settings of the `CdsModule`:

    - **tenant:** Set this to your testing or production tenant, as required. For more information, see [Tenant Provisioning](https://help.sap.com/viewer/49cbe38e90db448eae460907a97d177b/SHIP/en-US).
    - **baseUrl:** Replace the value shown in the example with the base URL of your Context-Driven Services environment.
    - **strategyProducts:** Set this value as show in the example.
    - **javascriptUrl:** For information on setting the `javascriptUrl`, see [Profile Tag](https://help.sap.com/viewer/8a676837bd4245f69cc8a2fbdae2b945/SHIP/en-US/3bccaa4bd20441fd88dcfc1ade648591.html) on the SAP Help Portal.
    - **configUrl:** For information on setting the `configUrl`, see [Profile Tag](https://help.sap.com/viewer/8a676837bd4245f69cc8a2fbdae2b945/SHIP/en-US/3bccaa4bd20441fd88dcfc1ade648591.html) on the SAP Help Portal.

1. Configure your `environment.ts` file by providing your `occBaseUrl`. The following example shows the `occBaseUrl` set a locally-installed back end:

    ```ts
    export const environment = {
      production: false,
      occBaseUrl: 'https://dev-com-14.accdemo.b2c.ydev.hybris.com:9002',
    };
    ```

## Profile Tag

### CMS Component

To enable Profile Tag, create a CMSFlexComponent called `ProfileTagComponent` in the catalog, and place it in the footer. To accomplish this, use the following ImpEx.

```
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef;
;;ProfileTagComponent;ProfileTag Spartacus Component;ProfileTagComponent;ProfileTagComponent;

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)[mode=append]
;;FooterSlot;ProfileTagComponent
```

This will create the component in the 'Staged' catalog. To publish it, run a sync, or replace 'Staged' with 'Online'.

### Configuration

Profile Tag has the following configuration interface:

```
interface ProfileTagConfig {
  javascriptUrl?: string;
  configUrl?: string;
  allowInsecureCookies?: boolean;
  gtmId?: string;
}
```

**Parameters:**
- `javascriptUrl`: This is the URL of the Profile Tag version you wish to use. `http://tag.static.us.context.cloud.sap/js/profile-tag.js` will use the latest version.
- `configUrl`: This is the URL of the configuration you created in the Profile Tag UI.
- `allowInsecureCookies`: This is an optional parameter that specifies whether Profile Tag should set insecure cookies. The default value is `false`. If you are running on HTTP, setting this parameter to true is requried. In production, it should always be set to false.
- `gtmId`: This is an optional parameter used for Profile Tag integration with Google Tag Manager. For more information, refer to the [Profile Tag](https://help.sap.com/viewer/8a676837bd4245f69cc8a2fbdae2b945/SHIP/en-US/3bccaa4bd20441fd88dcfc1ade648591.html) documentation.

## Context-Driven Merchandising

3. Configure `data-smartedit-allow-origin` in your `index.html` storefrontapp. For example, `<YOUR_STOREFRONT_ORIGIN>`.

### CMS Component

Once you use the `b2c_acc_plus` recipe in your SAP Commerce storefront and configure Merchandising according to the instructions in [Context-Driven Merchandising Module](https://help.sap.com/viewer/50c996852b32456c96d3161a95544cdb/1905/en-US/5c53aa7a578e48f186817211b4c87e72.html), Merchandising is ready to work with Spartacus out of the box.

To add a Context-Driven Merchandising carousel to a page, follow these steps:

1. Launch SmartEdit.
2. Edit the page you want to add a Merchandising carousel to.
3. Click the **+ Component** button in SmartEdit. You should see the **SAP Context-Driven Merchandising Carousel** component. If you do not see it, use the search box.
4. Drag and drop the component onto a content slot on the page. If the component does not drop in the 'Basic Edit' mode, switch to the 'Advanced Edit' mode using the dropdown in SmartEdit.
5. Fill in the fields of the configuration window that appears. Select a configured strategy from the **Strategy** dropdown menu.
6. Click **Save** for the Merchandising carousel to appear on the page you are editing.


If you know your `strategyId` and want to add the Merchandising carousel yourself, use the following ImpEx example.

```
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

**Note:** The above snippet includes examples of locations where you can create and place the carousel in a slot. You can place the CMS component in any slot that allows it.

## Context-Driven Services Shell Application

Follow these steps to run the Context-Driven Services Shell Application:

1. Run the following command to execute the library builds:
```
yarn build:core:lib:cds
```
2. Run the following command to start the shell:
```
yarn start:cds
```
3. Run the following command to perform unit tests:
```
yarn test:cds
```
When you run these commands, the browser opens, and you can see the progress of the tests with detailed information, including whether the tests pass.
4. Run the following command to perform end-to-end tests. You can do this either manually or automatically. 
- Manually:
```
yarn start:cds
yarn e2e:cy:cds:run:vendor
```
**Note:** To run the end-to-end test in the headless mode, make sure you have your Spartacus instance running before executing the end-to-end command.
- Automatically:
```
yarn e2e:cy:cds:start-open
```
**Note:** When using this command, you do not need to separately start a Spartacus instance as it is already done as part of the command. To run the Cypress end-to-end tests for Context-Driven Services integration, select `merchandising-carousel.e2e-spec.ts` in the Cypress user interface.

## Other Commands for Context-Driven Services

All other Context-Driven Services commands can be found in `package.json` and have `:cds` as part of their name.

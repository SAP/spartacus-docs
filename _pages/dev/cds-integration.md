# Spartacus Context-Driven Services

Spartacus Storefront is a package that you can include in your application to add storefront features that support [Context-Driven Services](https://help.sap.com/viewer/product/CONTEXT-DRIVEN_SERVICES/SHIP/en-US).

## Using Spartacus Context-Driven Services

To start using Spartacus Context-Driven Services, follow these steps:
1. Include the `CdsModule` in your `app.module.ts` file.
2. Configure your `environment.ts` file.
  - Provide your storefront URL in `occBaseUrl`. For example, `https://<YOUR_STOREFRONT_ORIGIN>`.
  - Provide the configuration specific to Context-Driven Services. The `default-cds-config.ts` file serves as a good example. Provide your Context-Driven Services tenant in the `tenant` line and update the environment in the `baseUrl` line to the Context-Driven Services environment your tenant is provisioned in. The available environments are `stage`, `eu`, and `us`.
3. Configure `data-smartedit-allow-origin` in your `index.html` storefrontapp. For example, `<YOUR_STOREFRONT_ORIGIN>`.

## Context-Driven Services Module

To enable the Context-Diven Services module in Spartacus, add it to the list of imports in your root module, and create a CDSConfig by calling the `withConfig` method. See the following example for referene:

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

## Context-Driven Merchandising

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

**Note:** The above snippet includes examples of locations where you can create and place the carousel in a slot. You can place the CMS component in any slot if it allows it.

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

## Backend Requirements

### Headers

Add the `x-profile-tag-debug` and `x-consent-reference` custom headers to:
- `corsfilter.ycommercewebservices.allowedHeaders`
- `corsfilter.assistedservicewebservices.allowedHeaders` if ASM is used.
For more information, see [Configuring CORS](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/installing-sap-commerce-cloud/#configuring-cors).

### Consent

For the events do be sent, you must define the ID Profile in the backend. To accomplish this, use the following ImpEx:

```
INSERT_UPDATE ConsentTemplate;id[unique=true];name[lang=en];description[lang=$lang];version[unique=true];baseSite(uid)[unique=true,default=exampleUid];exposed
;PROFILE;"Allow SAP Commerce Cloud, Context-Driven Services tracking";"We would like to store your browsing behaviour so that our website can dynamically present you with a personalised browsing experience and our customer support agents can provide you with contextual customer support.";1;;true
```

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

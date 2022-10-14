---
title: SAP Customer Data Cloud Integration
feature:
- name: Customer Data Cloud Integration
  spa_version: 3.2
  cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

SAP Customer Data Cloud allows you to enable customized registration and login, and also manage user profile and consent.

For more information see, [SAP Customer Data Cloud Integration](https://help.sap.com/viewer/b6a1e8b75222421a8faf0269e8fbd0dc/latest/en-US) and [SAP Customer Identity](https://developers.gigya.com/) on the SAP Help Portal.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Requirements

To integrate SAP Customer Data Cloud with Spartacus, you must have SAP Commerce Cloud 2105 or newer, along with the latest version of Commerce Cloud Extension Pack

## Enabling SAP Customer Data Cloud Integration in Spartacus

To enable SAP Customer Data Cloud Integration in Spartacus, you need to configure both the Commerce Cloud back end, and the Spartacus front end.

### Configuring the Back End for SAP Customer Data Cloud Integration

The following steps describe how to configure the Commerce Cloud back end for integration with SAP Customer Data Cloud.

1. Follow the steps for [{% assign linkedpage = site.pages | where: "name", "installing-sap-commerce-cloud.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/backend/installing-sap-commerce-cloud.md %}).

2. Enable the SAP Customer Data Cloud extensions for B2C.

    For more information, see [SAP Customer Data Cloud Integration Implementation](https://help.sap.com/viewer/b6a1e8b75222421a8faf0269e8fbd0dc/latest/en-US/2f49dd87b27740529dd8ccc3cd45ffa7.html) on the SAP Help Portal.

3. Build and update the system so that the new functionality provided by the SAP Customer Data Cloud integration extension is available.

    This step also creates sample CMS data for the `electronics-spaContentCatalog` content catalog.

    **Note:** You can view the SAP Customer Data Cloud login page through the `<spartacus-site-url>/cdc/login` URL. This allows you to access the Customer Data Cloud pages and the default login page together.

4. Update the `mobile_android` OAuth client (created in step 1) to support the `custom` authorization grant type, and remove the `refresh_token` grant type. The following ImpEx can be used to update the grant types:

   ```plaintext
   INSERT_UPDATE OAuthClientDetails ; clientId[unique = true] ; resourceIds ; scope ; authorizedGrantTypes                                  ; authorities ; clientSecret ; registeredRedirectUri
                                    ; mobile_android          ; hybris      ; basic ; authorization_code,password,client_credentials,custom ; ROLE_CLIENT ; secret       ; http://localhost:9001/authorizationserver/oauth2_callback ;
   ```

   **Note:** Refresh tokens are not supported. This ensures that the token from Commerce Cloud and the SAP Customer Data Cloud login session are maintained for the same duration of time.

5. Define the SAP Customer Data Cloud Site configuration and link it to the `electronics-spa` site.

    You can also define other configurations for the integration, such as Field Mapping and Consent Templates. For more information, see [SAP Customer Data Cloud Integration Implementation](https://help.sap.com/viewer/b6a1e8b75222421a8faf0269e8fbd0dc/latest/en-US/2f49dd87b27740529dd8ccc3cd45ffa7.html) on the SAP Help Portal.

### Configuring Spartacus for SAP Customer Data Cloud Integration

Perform the following steps after you have set up your Spartacus Storefront. For more information, see [{% assign linkedpage = site.pages | where: "name", "building-the-spartacus-storefront-from-libraries.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/frontend/building-the-spartacus-storefront-from-libraries.md %}).

1. Install the SAP Customer Data Cloud integration library by running the following command from within the root directory of your storefront application:

   ```bash
   ng add @spartacus/cdc
   ```

   When you run this command, the schematics create a module for the CDC integration that includes all of the required imports and configuration.

   **Note**: To install the CDC integration library using schematics, your app structure needs to match the Spartacus reference app structure. For more information, see [{% assign linkedpage = site.pages | where: "name", "reference-app-structure.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/reference-app-structure.md %}).

   Alternatively, you can create the module manually and import it into your application, as shown in the following example:

   ```ts
   import { NgModule } from '@angular/core';
   import { CdcConfig, CdcRootModule, CDC_FEATURE } from '@spartacus/cdc/root';
   import { provideConfig } from '@spartacus/core';

   @NgModule({
     declarations: [],
     imports: [CdcRootModule],
     providers: [
       provideConfig({
         featureModules: {
           [CDC_FEATURE]: {
             module: () => import('@spartacus/cdc').then((m) => m.CdcModule),
           },
         },
       }),
       provideConfig(<CdcConfig>{
         cdc: [
           {
             baseSite: 'electronics-spa',
             javascriptUrl: '<paste-link-to-cdc-script>',
             sessionExpiration: 3600,
           },
         ],
       }),
     ],
   })
   export class CdcFeatureModule {}
   ```

2. Adjust the CDC configuration in the newly created module, as shown in the following example:

   ```ts
   provideConfig(<CdcConfig>{
         [CDC_FEATURE]: [
           {
             baseSite: 'electronics-spa',
             javascriptUrl: 'https://cdns.<data-center>.gigya.com/JS/gigya.js?apikey=<Site-API-Key>',
             sessionExpiration: 3600,
           },
         ],
       }),
   ```

   The following is a summary of the options that are available in the CDC configuration:

   - **baseSite** refers to the CMS Site that the Customer Data Cloud Site configuration should be applied to. The same should be configured in SAP Commerce Cloud Backoffice as well.

   - **javascriptUrl** specifies the URL of the Web SDK that you wish to load. This is constructed using the value of the Site API Key, and the data center where the Customer Data Cloud site is created. For example, `https://cdns.<data-center>.gigya.com/JS/gigya.js?apikey=<Site-API-Key>`

   - **sessionExpiration** is the time (in seconds) that defines the session expiry of the SAP Customer Data Cloud session. This should match with the session expiration time of the OAuth Client to ensure that both the Customer Data Cloud session and the SAP Commerce Cloud token live for the same time.

3. Build and start the storefront app to verify your changes.

---
title: Building the TUA Spartacus Storefront Using 3.x Libraries
---

The following instructions describe how to build a TUA storefront application using published TUA Spartacus 3.x libraries.

**Note:** If you are building TUA Spartacus from source, see [Contributor Setup]({{ site.baseurl }}{% link _pages/contributing/contributor-setup.md %}).

## Prerequisites

Before carrying out the procedures below, ensure that you meet the following front-end and back-end requirements.

## Front-End Development Requirements

- [Angular CLI](https://angular.io/): 10.1.0 or later, < 11.0.0
- node.js: The most recent 12.x version is recommended, < 13.0
- yarn: 1.15 or later

### Installing or Updating the Prerequisite Development Tools

There are a few ways you can install Angular and other prerequisite software. The following example installs yarn, node.js, and Angular CLI using [Homebrew](https://brew.sh), which was created for MacOS, but also works on Linux and Windows 10 (through the Linux subsystem feature).

To install the prerequisite development tools, install [Homebrew](https://brew.sh), and then run the following commands:

```text
brew install yarn
brew install node@12
brew install angular-cli
```

To update existing installations, use `brew upgrade` instead of `brew install`.

**Note:**

- If you have a later version of node.js installed in addition to v12, you can set v12 to be used with the following command:
`brew link --force --overwrite node@12`.
- Installing Homebrew and the prerequisites is beyond the scope of this document. You can also install the prerequisites using their individual installers.

## Back End Server Requirements

TUA Spartacus uses SAP Commerce Cloud and Telco & Utilities Accelerator for its back end, and makes use of the sample data from the Telco & Utilities Accelerator storefront in particular.

- SAP Commerce Cloud version: Release 2011 (latest patch is recommended).
- Telco & Utilities Accelerator version: Release 2102 (latest patch) is required.

For more information, see [Installing SAP Commerce Cloud for use with TUA Spartacus]({{ site.baseurl }}{% link _pages/telco/installing-sap-commerce-for-tua-spartacus.md %}).

## Creating a New Angular App

To create a new Angular application with the name `mystore`, follow the procedure:

1. Open a terminal or command prompt window at the location of your choice.

2. Using the Angular CLI, generate a new Angular application with the following command:

   ```bash
   ng new mystore --style=scss
   ```

   When prompted if you would like to add Angular routing, enter `n` for 'no'.

   The `mystore` folder and the new app are created.

3.  Access the newly created `mystore` folder with the following command:

     ```bash
     cd mystore
     ```

## Project Setup

The easiest way to start a new project and to quickly set up your application:

Run `yarn start`.

For a full list of available parameters, visit Spartacus schematics [documentation](https://github.com/SAP/cloud-commerce-spartacus-storefront/tree/develop/projects/schematics).

## Setting up a Storefront Manually

Although we recommend using Schematics, there might be situations when you want to build your application from scratch.

The dependencies in this procedure are required by the TUA Spartacus storefront.

1. Inspect the `mystore/src/app/app.module.ts` file for any changes you want to make for your setup. For example, you might want to change the `baseUrl` to point to your server and the `basesite` to correspond with the WCMS site. You likely also want to specify the compatibility version by changing `features.level`, as the default might not be the latest version.

    To make use of the modules shipped with `tua-spa` library, the `app.module.ts` must have the following structure:

    ```typescript
    import { BrowserModule } from '@angular/platform-browser';
    import { NgModule } from '@angular/core';
    import { AppComponent } from './app.component';
    import { translationChunksConfig, translations } from '@spartacus/assets';
    import { ConfigModule } from '@spartacus/core';
    import { TmaB2cStorefrontModule, tmaTranslations } from '@spartacus/tua-spa';

    @NgModule({
    declarations: [AppComponent],
    imports: [
        BrowserModule,
        TmaB2cStorefrontModule.withConfig({
        backend: {
            tmf: {
            baseUrl: 'https://localhost:9002',
            prefix: '/b2ctelcotmfwebservices',
            version: '/v2',
            endpoints: {
                getProduct: {
                baseUrl: 'https://localhost:9002',
                prefix: '/b2ctelcotmfwebservices',
                version: '/v3',
                endpoint: '/product/${id}'
                },
                getProductOffering: {
                baseUrl: 'https://localhost:9002',
                prefix: '/b2ctelcotmfwebservices',
                version: '/v3',
                endpoint: '/productOffering/${id}'
                }
            }
            },
            occ: {
            baseUrl: 'https://localhost:9002',
            prefix: '/occ/v2/',
            },
            tmf_appointment: {
            baseUrl: 'http://localhost:8080',
            prefix: '/tmf-api',
            },
            tmf_resource_pool_management: {
            baseUrl: 'http://localhost:8080',
            prefix: '/tmf-api',
            },
            premiseLookup: {
            baseUrl: 'http://localhost:9003',
            prefix: '/premise/v1/',
            },
            tmf_query_service_qualification: {
            baseUrl: 'http://localhost:8080',
            prefix: '/tmf-api'
            }
        },
        context: {
            urlParameters: ['baseSite', 'language', 'currency'],
            baseSite: ['telcospa', 'utilitiesspa'],
        },
        i18n: {
            resources: translations,
            chunks: translationChunksConfig,
            fallbackLang: 'en',
        },
        features: { level: '3.0' },
        journeyChecklist: {
            journeyChecklistSteps: ['APPOINTMENT', 'MSISDN', 'INSTALLATION_ADDRESS'],
            msisdn_reservation: {
            msisdn_qty: 1,
            msisdn_capacity_amount_demand: 1,
            msisdn_applied_capacity_amount: 5,
            applied_capacity_amount_for_msisdn_reservation: 1,
            },
            appointment: {
            requested_number_of_timeslots: 5,
            end_date_of_timeslots: 3,
            }
        },
        deliveryMode: {
            default_delivery_mode: 'not-applicable'
        }
        }),
        ConfigModule.withConfig({ i18n: { resources: tmaTranslations } }),
    ],
    providers: [],
    bootstrap: [AppComponent],
    })
    export class AppModule {}
    ```

2. Replace the entire contents of `mystore/src/app/app.component.html with <cx-storefront>Loading...</cx-storefront>` with:

   ```html
   <cx-storefront>Loading...</cx-storefront>
   ```
  
3. Open `mystore/package.json` using a text editor.

4. Add the following dependencies to the end of the `dependencies` section of `package.json`.

    ```json
    "@angular/localize": "^10.1.0",
    "@angular/platform-server": "~10.1.0",
    "@angular/service-worker": "~10.1.0",
    "@ng-bootstrap/ng-bootstrap": "^7.0.0",
    "@ng-select/ng-select": "^4.0.0",
    "@ngrx/effects": "~10.0.0",
    "@ngrx/router-store": "~10.0.0",
    "@ngrx/store": "~10.0.0",
    "@spartacus/assets": "3.0.0",
    "@spartacus/core": "3.0.0",
    "@spartacus/storefront": "3.0.0",
    "@spartacus/styles": "3.0.0",
    "@spartacus/tua-spa": "3.0.0",
    "angular-oauth2-oidc": "^10.0.1",
    "bootstrap": "^4.2.1",
    "chart.js": "^2.9.3",
    "express": "^4.15.2",
    "i18next": "^19.3.4",
    "i18next-xhr-backend": "^3.2.2",
    "material-design-icons": "^3.0.1",
    "ng2-charts": "^2.3.2",
    "ngx-infinite-scroll": "^8.0.0",
    "ngx-spinner": "^9.0.1"
   ```

    **Note:** Make sure to add a comma to the end of the last dependency statement listed in this section. For example, the last statement in your new app might be `"zone.js": "~0.10.2"` so you need to add a comma after `0.10.2"`.

5. Make sure that the following import is found in the  `mystore/src/styles.scss`:

    ```bash
   @import '~@spartacus/styles/index';
   @import '~@spartacus/tua-spa/storefrontstyles/index';
   @import '~material-design-icons/iconfont/material-icons.css';
    ```

6. Add the following import in the `/mystore/src/polyfills.ts` file:

   ```bash
   import '@angular/localize/init';
   import 'zone.js/dist/zone';
   ```

7. From the terminal window, within `mystore`, install the dependencies by running the following command:

   ```bash
   yarn install
   ```
  
8. Start the angular client app. From the terminal window, within `mystore` start the application by running the following command:

   ```bash
   yarn start
   ```
  
9. Make sure your backend server is up and running (SAP Commerce with TUA). When the backend server is properly started, point your browser to http://localhost:4200/telcospa/en/USD/.

10. Your client application is accessible at the following locations in your local environment:

    - Telco application: http://localhost:4200/telcospa/en/USD
    - Utilities application: http://localhost:4200/utilitiesspa/en/USD

**Note:**

(1) Using `~` instructs yarn to use the latest patch version (x.y.**z**); whereas, using `^` instructs yarn to use the latest minor version (x.**y**.0).

(2) If you are updating an existing app, and changing dependencies, it is recommended to delete the `node_modules` folder before running the install command.

### Adding Import Declarations and Storefront Configuration Settings

**Note:** Some statements in the preceding example were generated by Angular when you first created the app.

#### About the Import Statements

The import statements import either modules or default data needed by TUA Spartacus.

## Building and Starting

This section describes how to validate your back-end installation and start the application with the storefront enabled.

## Validating the SAP Commerce Back End

**Note:** The Chrome browser is recommended and used in the following example, but other browsers can be used as long as they recognize and allow you to continue even though a site is using a self-signed certificate.

1. Use a web browser to access the OCC endpoint of your backend.

   The default is available at: `{server-base-url}/occ/v2/telcospa/cms/pages` or `{server-base-url}/occ/v2/utilitiesspa/cms/pages`.

   For example, with a backend instance running from `https://localhost:9002`, you can access `https://localhost:9002/occ/v2/telcospa/cms/pages` or `https://localhost:9002/occ/v2/utilitiesspa/cms/pages`.

2. Accept the security exception in your browser if you are running a development instance with a self-signed HTTPS certificate.

    When the request works, you will see an XML response in your browser.

### Starting the Storefront Application

To start your TUA Spartacus storefront, enter the following command from `mystore` in your terminal window:

   ```bash
yarn start
   ```
  
When the app server is properly started, point your browser to http://localhost:4200.

Or, to start your TUA Spartacus storefront securely, enter the following command:

   ```bash
yarn start --ssl
   ```
  
Then point your browser to `https://localhost:4200`.

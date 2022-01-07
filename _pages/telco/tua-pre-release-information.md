---
title: Pre-Release Information
---
This document describes what is included in the latest pre-release of TUA Spartacus libraries, such as `next` and `rc` libraries.

_Last updated March 17, 2021 by Deborah Cholmeley-Jones, Solution Owner, TUA Spartacus_

For an overview of what is included in a specific release, see [Release Information]({{ site.baseurl }}{% link _pages/telco/telco-release-information.md %}).

For detailed release notes, see the [TUA Spartacus repository
](https://github.com/SAP/spartacus-tua/releases).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Release 3.0.0-next.2 - March 17, 2021

The `3.0.0-next.2` library has been published. We are happy to announce our 3.0 Spartacus for TUA pre-release.

In the `3.0.0-next.2` pre-release version, support is provided for the 2102 release of the Telco and Utilities Accelerator with SAP Commerce Cloud 2011.

### Complex Industry Cart (first introduced in 3.0.0-next.1)

The hierarchal representation of the cart and order is now available to support complex bundled product offerings and pricing. The cart and order now functions in a hierarchal structure, making it easy to support purchasing of complex and nested (multi-layered) bundled product offerings. With the hierarchal representation of the cart and order, the exact structure of a bundled product offering is retained. The components selected for the bundle are grouped accordingly, so that bundle in which the offerings belong to are known. For more information, see [Complex Industry Cart](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/latest/en-US/33005fa795d2425282ffe769737e27e7.html) on the SAP Help portal.

### Contract Renewals (first introduced in 3.0.0-next.1)

A contract renewal is the stage in the contract lifecycle where the contract is scheduled to expire. At this point, Operators or Service Providers may want to offer customers the ability to renew their contract as a retention scenario. Eligible customers are typically incentivized to renew with special promotional offering and price. In this scenario, based on the customer product inventory, customers can renew eligible subscriptions, resulting from a simple product offering.

### Serviceability Check of Simple Product Offerings (SPOs)

In order to determine if a service is available to a residential or commercial address, a serviceability check is needed. Serviceability check can be run for a specific product offering a customer is interested in, or it can be run at a catalog level to see all of the available service offerings based on a given address. Checks and validations are performed to ensure that a customer makes a valid purchase that can be installed and provisioned by the provider. For more information, see [Serviceability Check](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/latest/en-US/f17d331d62164ae686f2d4fdb437e9c4.html) on the SAP Help portal.

To set up Spartacus 3.0.0-next.2 and build the TUA Spartacus Storefront using 3.0.0-next.2 libraries, refer the following sections.

## Installing SAP Commerce Cloud for use with TUA Spartacus

Installation instructions are very similar to [Installing SAP Commerce Cloud for use with TUA Spartacus]({{ site.baseurl }}{% link _pages/telco/installing-sap-commerce-for-tua-spartacus.md %}), except the following instructions that describe how to install and configure SAP Commerce Cloud (release 2011) with Telco and Utilities Accelerator (supports release 2102, latest patch) for use with a Spartacus storefront. In these instructions, SAP Commerce Cloud with TUA is installed on your local computer, so `localhost` is used in the browser URLs.

The installation procedure includes steps for creating and using a `b2c_telco_spa` recipe that makes use of the TUA Spartacus Sample Data (`b2ctelcospastore`), but you can use your own sample data or recipe as long as it includes the `cmsocc`, `commercewebservices`, `acceleratorocc` extensions and TUA module.

Some of the steps in this procedure are derived from the documentation for installing SAP Commerce using recipes. For more information, see [Installing SAP Commerce Using Installer Recipes](https://help.sap.com/viewer/a74589c3a81a4a95bf51d87258c0ab15/latest/en-US/8c46c266866910149666a0fe4caeee4e.html) in the SAP Help Portal.

1. Unzip the SAP Commerce and Telco & Utilities Accelerator zip archives.

   **Note:** Use the latest patches for SAP Commerce Cloud version 2011 and Telco & Utilities Accelerator version 2102.

1. [Download](https://github.com/SAP/spartacus-tua/releases) the TUA Spartacus Sample Data Store Extension.

    The TUA Spartacus Sample Data Store Extension is the extension provided in the following zip files:

    - Sample data for Telco is stored in the following file: `b2ctelcospastore.zip`.
    - Sample data for Utilities is stored in the following file: `utilitiesspastore.zip`.

1. Unzip the TUA Spartacus sample data store from the preceding ZIP files.

    **Note:** You can use both the store extensions, or only one of them, depending on your needs (specific to telco or to utilities).

1. Move the `b2ctelcospastore` folder from extracted `b2ctelcospastore` folder to `<sap-commerce-folder>/hybris/bin/modules/b2c-telco-accelerator`.

1. Move the `utilitiesspastore` folder from extracted `utilitiesspastore` folder to `<sap-commerce-folder>/hybris/bin/modules/b2c-telco-accelerator`.

    **Note:** The `b2ctelcospastore` and `utilitiesspastore` folder can be stored anywhere in the modules folder. The `b2c-telco-accelerator` folder is chosen as it contains other TUA sample data.

1. Unzip TUA cms extension for utilities:

    - If you want to use utilities sample data then also unzip the `b2ctelcocms.zip`.
    - Move the `b2ctelcocms` folder in the same location with `utilitiesspastore` folder.

1. In the `sap-commerce-folder>/installer/recipes` folder, create a copy of the `b2c_telco` folder.

1. Rename the copy of the `b2c_telco` folder to `b2c_telco_spa`.

1. In `b2c_telco_spa`, the `build.gradle` file should have the following content:

    If you want to use the two sample data extensions, for Telco and Utilities, the `build.gradle` file must have the following structure:

   ```java
    apply plugin: 'installer-platform-plugin'
    apply plugin: 'installer-addon2-plugin'


    def pl = platform {
    localProperties {
        property 'kernel.events.cluster.jgroups.channel', 'disable'
        property 'datahub.publication.saveImpex', ''
        property 'commerceservices.default.desktop.ui.experience', 'responsive'
        property 'kernel.autoInitMode', 'update'
        property 'installed.tenants', 'junit'
    }
    afterSetup {
        ensureAdminPasswordSet()
    }

    extensions {
        extName 'acceleratorcms'
        extName 'adaptivesearchbackoffice'
        extName 'adaptivesearchsolr'
        extName 'addonsupport'
        extName 'b2ctelcobackoffice'
        extName 'b2ctelcofulfillmentprocess'
        extName 'b2ctelcocms'
        extName 'b2ctelcospastore'
        extName 'utilitiesspastore'
        extName 'b2ctelcotmfwebservices'
        extName 'b2ctelcowebservices'

        extName 'b2ctelcocommercewebservicescommons'
        extName 'b2ctelcoocc'
        extName 'b2ctelcoserviceabilityclient'	
        extName 'commerceservicesbackoffice'
        extName 'solrfacetsearchbackoffice'
        extName 'solrserver'
        extName 'subscriptionbackoffice'
        extName 'yacceleratorcore'
        extName 'commercewebservices'

        extName 'cmsbackoffice'
        extName 'cmswebservices'
        extName 'previewwebservices'
        extName 'smarteditwebservices'
        extName 'cmssmarteditwebservices'
        extName 'permissionswebservices'
        extName 'cmssmartedit'
        extName 'cmsocc'
        extName 'acceleratorocc'
        extName 'customersupportbackoffice'

        extName 'personalizationwebservices'
        extName 'previewpersonalizationweb'
        extName 'personalizationcmsweb'
        extName 'personalizationsmartedit'
        extName 'personalizationservicesbackoffice'
        extName 'personalizationcmsbackoffice'
        extName 'personalizationservices'
        extName 'personalizationfacades'

        extName 'acceleratorservices'
        extName 'assistedservicefacades'

        extName 'rulebuilderbackoffice'
        extName 'couponbackoffice'
        extName 'droolsruleengineservices'
        extName 'couponfacades'
        extName 'couponservices'
    }
    }

    task setup () {
    doLast {


        pl.setup()


        copy {
        from "${installerHome}/recipes/b2c_telco_spa/logback.xml"
        into "${suiteHome}/hybris/bin/platform/tomcat/lib"
        }
        copy {
        from "${installerHome}/recipes/b2c_telco_spa/sbg_properties"
        into "${suiteHome}/hybris/bin/platform/tomcat/lib"
        exclude "**/*.txt"
        }
    }
    }

    task buildSystem(dependsOn: setup) {
    doLast {
        pl.build()
    }
    }


    task initialize (dependsOn: buildSystem) {
    doLast {
        pl.initialize()
    }
    }


    task start () {
    doLast {
        pl.start()
    }
    }


    task startInBackground () {
    doLast {
        pl.startInBackground()
    }
    }

    task stopInBackground {
    doLast {
        pl.stopInBackground()
    }
    }
    ```
    **Note:** If you want to use both sample data extensions, for telco and utilities, the `build.gradle` file should have the following structure:

    - `extName 'utilitiesspastore'`
    - `extName 'b2ctelcocms'`

1. Open a terminal or command prompt window inside the `sap-commerce-folder>/installer` folder.

1. Set up the recipe using the following commands: 
    
    For Windows:

    ```bash
    install.bat -r b2c_telco_spa -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd
    ```
    For Unix:

    ```bash
    ./install.sh -r b2c_telco_spa -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd
   ```

    **Note:** Starting with release 2005, SAP  Cloud releases do not ship with a default admin password. You must specify a password when running the preceding recipe commands, or you can specify a password in the `custom.properties` file that is stored in `sap-commerce-folder>\installer\customconfig`. See the following [Alternate Method for Setting the SAP Commerce Admin Password](#alternate-method-for-setting-the-sap-commerce-admin-password) procedure for information on setting a password in the `custom.properties` file.

1. Initialize the system using the following command. From the `sap-commerce-folder>/installer` folder run the following commands:

   For Windows:

   ```bash
   install.bat -r b2c_telco_spa -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd initialize
   ```
   For Unix:

   ```bash
   ./install.sh -r b2c_telco_spa -A local_property:initialpassword.admin=Y0urFav0r!tePassw0rd initialize
   ```
1. Start SAP Commerce Cloud with the following command. From the `sap-commerce-folder>/installer` folder, run the following commands 

   For Windows:

   ```bash
   install.bat -r b2c_telco_spa start
   ```
   For Unix:

   ```bash
   ./install.sh -r b2c_telco_spa start
   ```
1. Verify that the system is working.

   - Access Admin Console: https://localhost:9002
   - Access Backoffice: https://localhost:9002/backoffice
   

   **Note:** When setting up your Spartacus storefront, set the base site in `app.module.ts` to telcospa and/or utilitiesspa depending on which sample data you want to use. Following are the samples:

    Telco:

    ```ts
    context: {
    baseSite: ['telcospa']
    },
    ```

    Utilities:

    ```ts
    context: {
    baseSite: ['utilitiesspa']
    },
    ```

    Both:

    ```ts
    context: {
    baseSite: ['telcospa', ‘utilitiesspa’]
    },
    ```

## Building the TUA Spartacus Storefront Using 3.x Libraries

The following instructions describe how to build a telco and utilities storefront application using published Spartacus 3.X libraries.

**Note:** Ensure that you meet the following front-end and back-end requirements:

- [Angular CLI](https://angular.io/): 10.1.0 or later, < 11.0.0
- node.js: The most recent 12.x version is recommended, < 13.0
- yarn: 1.15 or later

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

### Project Setup

The easiest way to start a new project and to quickly set up your application:

Run `yarn start`.

For a full list of available parameters, visit Spartacus schematics [documentation](https://github.com/SAP/cloud-commerce-spartacus-storefront/tree/develop/projects/schematics).

### Setting up a Storefront Manually

Although we recommend using Schematics, there might be situations when you want to build your application from scratch.

The dependencies in this procedure are required by the TUA Spartacus storefront.

1. Inspect the `mystore/src/app/app.module.ts` file for any changes you want to make for your setup. For example, you might want to change the `baseUrl` to point to your server and the `basesite` to corresond with the WCMS site. You likely also want to specify the compatibility version by changing `features.level`, as the default might not be the latest version.

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
    "@spartacus/tua-spa": "3.0.0-next.2",
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

For more information on setting up TUA Spartacus 2.0.0-next.2, see [Building the TUA Spartacus Storefront Using Libraries]({{ site.baseurl }}{% link _pages/telco/building-the-tua-storefront-from-libraries-2.md %}).

As always, feedback appreciated! Contact us through Slack or submit an [issue](https://github.com/SAP/spartacus/issues/new/choose).

## Pre-release Libraries for 3.0.0 and Earlier

Pre-release libraries are no longer published for versions 3.0.0 and earlier, as the final releases of these libraries were published. Pre-release libraries are still available, but the final versions should be used. New pre-release libraries will be published as needed for 3.1, 3.2, and so on.

## Release 3.0.0-next.1 - February 17, 2021

The `3.0.0-next.1` library has been published. We are happy to announce our 3.0 Spartacus for TUA pre-release.

In the `3.0.0-next.1` pre-release version, support is provided for the 2102 release of the Telco and Utilities Accelerator with SAP Commerce Cloud 2011.

### **Complex Industry Cart**

The hierarchical representation of the cart and order is now available to support complex bundled product offerings and pricing. The cart and order now functions in a hierarchical manner making it easy to support the purchasing of complex and nested (multi-layered) bundled product offerings. With the hierarchical representation of the cart and order, the exact structure of a bundled product offering is retained and the selected components are together by the parent bundle in which they belong. For more information, see [Complex Industry Cart](https://help.sap.com/viewer/d28406c672ff4cbca70dfb4b5748f8d8/2102/en-US/33005fa795d2425282ffe769737e27e7.html.html) in the TUA Help portal.

### **Contract Renewals**

A contract renewal is the stage in the contract lifecycle where the contract is scheduled to expire.  At this point, Operators or Service Providers may want to offer customers the ability to renew their contract as a retention scenario. Eligible customers are typically incentivized to renew with special promotional offering and price. In this scenario, based on the customer product inventory, a customer can renew eligible subscriptions resulting from a simple product offering.

## Release 2.0.0-next.2 - November 25, 2020

The `2.0.0-next.2` library has been published! We are happy to announce our second Spartacus for TUA pre-release. 

In the `2.0.0-next.2` pre-release version, support for both - TUA 2007 and TUA 2011 is provided. In addition to supporting composite pricing and price alteration discounts, priority pricing is now available, as well as support for 1.x spartacus features that were delivered in previous releases, with the exception of 1.3 features.

## Release 2.0.0-next.1 - October 28, 2020

The `2.0.0-next.1` library has been published! For more information, see [Release Information]({{ site.baseurl }}{% link _pages/telco/telco-release-information.md %}).

We are happy to announce support for the TUA 2007 release.

You can set up TUA Spartacus 2.0.0-next.1 by following the instructions from [Building the TUA Spartacus Storefront Using Libraries]({{ site.baseurl }}{% link _pages/telco/building-the-tua-storefront-from-libraries-2.md %}).

The following features are included as part of this pre-release:

### Composite Pricing

Composite Pricing brings forth a new way for handling operational processes for service providers that is clearer and more efficient. The underlying TUA data model has been enhanced to support the hierarchical structure of composite prices in a TM Forum compliant manner.  Product Offering Prices are now hierarchical; that is, they can be grouped together and they are also re-usable. For more information, see [Composite Pricing](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/2e0fa8602fff440ba756e1a0a8390ea3.html) in the TUA Help portal.

### Price Alteration Discounts

The Price Alteration Discounts works on top of the Composite Pricing data model and enables the ability to offer fixed-price and percentage discounts at any level in the composite price structure, and for any type of charge including one-time charges, recurring charges and usage-based charges. With price alteration discounts, customers can see discounts upfront before placing their order. For more information, see [Price Alteration Discounts](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/61b21155624e4a498632964bc566e1eb.html) in the TUA Help portal.

## Pre-Release Libraries for 2.0 and Earlier

Pre-release libraries are no longer actively updated for versions 1.0 and earlier, as the final release of these libraries was already published. Pre-release libraries are still available but the final versions should be used.

## Questions

If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ). Feedback welcome!

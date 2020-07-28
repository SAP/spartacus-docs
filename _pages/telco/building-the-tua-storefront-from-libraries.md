---
title: Building the Spartacus TUA Storefront from Libraries
---

The following instructions describe how to build a Telco & Utilities storefront application using published Spartacus 1.x libraries.

**Note:** If you are building Spartacus from source, see [Contributor Setup]({{ site.baseurl }}{% link _pages/contributing/contributor-setup.md %}).

## Prerequisites

Before carrying out the procedures below, ensure that you meet the following front-end and back-end requirements.

## Front-End Development Requirements

{% include docs/frontend_requirements.html %}

### Installing or Updating the Prerequisite Development Tools

There are a few ways you can install Angular and other prerequisite software. The following example installs yarn, node.js, and Angular CLI using [Homebrew](https://brew.sh), which was created for MacOS, but also works on Linux and Windows 10 (through the Linux subsystem feature). 

To install the prerequisite development tools, install [Homebrew](https://brew.sh), and then run the following commands:

```
brew install yarn
brew install node@10
brew install angular-cli
```

To update existing installations, use `brew upgrade` instead of `brew install`.

**Note:** 

- If you have a later version of node.js installed in addition to v10, you can set v10 to be used with the following command:
`brew link --force --overwrite node@10`.
- Installing Homebrew and the prerequisites is beyond the scope of this document. You can also install the prerequisites using their individual installers.

## Back-End Server Requirements

Spartacus for TUA uses SAP Commerce Cloud and Telco & Utilities Accelerator for its back-end, and makes use of the sample data from the Telco & Utilities Accelerator storefront in particular.

- SAP Commerce version: Release 1905 (latest patch is recommended).
- TUA version: Release 2003 (latest patch) is required.

For more information, see [Installing SAP Commerce Cloud for use with Spartacus]({{ site.baseurl }}{% link _pages/install/installing-sap-commerce-cloud.md %}). 

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

The dependencies in this procedure are required by the Spartacus storefront.

1. Inspect the `mystore/src/app/app.module.ts` file for any changes you want to make for your setup. For example, you might want to change the `baseUrl` to point to your server and the `basesite` to corresond with the WCMS site. You likely also want to specify the compatibility version by changing `features.level`, as the default might not be the latest version.

To make use of the modules shipped with `tua-spa` library, the `app.module.ts` must have the following structure:

```typescript
import {BrowserModule} from '@angular/platform-browser';
import {NgModule} from '@angular/core';
import {ConfigModule} from '@spartacus/core';
import {AppComponent} from './app.component';
import {translationChunksConfig, translations} from '@spartacus/assets';
import {TmaAuthModule, TmaB2cStorefrontModule, TmaProductSummaryModule, tmaTranslations, TmfModule} from '@spartacus/tua-spa';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    TmaAuthModule,
    TmfModule.forRoot(),
    TmaB2cStorefrontModule.withConfig({
      backend: {
        tmf: {
          baseUrl: 'https://localhost:9002',
          prefix: '/b2ctelcotmfwebservices/v2/',
        },
        occ: {
          baseUrl: 'https://localhost:9002',
          prefix: '/rest/v2/',
          endpoints: {
            product_scopes: {
              details:
                'products/${productCode}?fields=averageRating,stock(DEFAULT),description,availableForPickup,code,url,price(DEFAULT),numberOfReviews,manufacturer,categories(FULL),priceRange,multidimensional,configuratorType,configurable,tags,images(FULL),productOfferingPrice(FULL),productSpecification,validFor',
            },
            productSearch:
              'products/search?fields=products(code,name,summary,price(FULL),images(DEFAULT),stock(FULL),averageRating,variantOptions,productSpecification),facets,breadcrumbs,pagination(DEFAULT),sorts(DEFAULT),freeTextSearch',
          },
        }
      },
      routing: {
        routes: {
          product: {
            paths: ['product/:productCode/:name', 'product/:productCode'],
          }
        }
      },
      context: {
        urlParameters: ['baseSite', 'language', 'currency'],
        baseSite: ['telcospa']
      },
      i18n: {
        resources: translations,
        chunks: translationChunksConfig,
        fallbackLang: 'en'
      },
      features: {
        level: '1.4'
      }
    }),
    ConfigModule.withConfig({
      i18n: {
        resources: tmaTranslations
      }
    }),
    TmaProductSummaryModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule {
}
```
2. Replace the entire contents of `mystore/src/app/app.component.html with <cx-storefront>Loading...</cx-storefront>` with:

   ```html
   <cx-storefront>Loading...</cx-storefront>
   ```
3. Open `mystore/package.json` using a text editor.

4. Add the following dependencies to the end of the `dependencies` section of `package.json`. 

    ```json
    "@angular/pwa": "^0.803.2",
    "@angular/service-worker": "~8.2.5",
    "@ng-bootstrap/ng-bootstrap": "5.1.0",
    "@ng-select/ng-select": "^3.0.7",
    "@ngrx/effects": "~8.3.0",
    "@ngrx/router-store": "~8.3.0",
    "@ngrx/store": "~8.3.0",
    "ngx-infinite-scroll": "^8.0.0",
    "bootstrap": "^4.2.1",
    "i18next": "^15.0.6",
    "i18next-xhr-backend": "^2.0.1",
    "material-design-icons": "^3.0.1",
    
    "@spartacus/core": "~1.5.0",
    "@spartacus/styles": "~1.5.0",
    "@spartacus/storefront": "~1.5.0",
    "@spartacus/assets": "~1.5.0",
    "@spartacus/styles": "~1.5.0",
    "@spartacus/tua-spa": "~0.1.0-next.2",
   ```

    **Note:** Make sure to add a comma to the end of the last dependency statement listed in this section. For example, the last statement in your new app might be `"zone.js": "~0.9.1"` so you need to add a comma after `0.9.1"`.

5. Make sure that the following import is found in the  `mystore/src/styles.scss`:

    ```bash
   @import '~@spartacus/styles/index';
   @import '~@spartacus/tua-spa/storefrontstyles/index';
    ```
6. From the terminal window, within `mystore`, install the dependencies by running the following command:

   ```bash
   yarn install
   ```
7. Start the angular client app. From the terminal window, within `mystore` start the application by running the following command:

   ```bash
   yarn start
   ```
8. Make sure your backend server is up and running (SAP Commerce with TUA). When the backend server is properly started, point your browser to http://localhost:4200/telcospa/en/usd.

**Note:** 

(1) Using `~` instructs yarn to use the latest patch version (x.y.**z**); whereas, using `^` instructs yarn to use the latest minor version (x.**y**.0).

(2) If you are updating an existing app, and changing dependencies, it is recommended to delete the `node_modules` folder before running the install command.

### Adding Import Declarations and Storefront Configuration Settings

**Note:** Some statements in the prceeding example were generated by Angular when you first created the app.

#### About the Import Statements

The import statements import either modules or default data needed by Spartacus.

## Building and Starting

This section describes how to validate your back-end installation and start the application with the storefront enabled.

## Validating the SAP Commerce Cloud Back-end

**Note:** The Chrome browser is recommended and used in the following example, but other browsers can be used as long as they recognize and allow you to continue even though a site is using a self-signed certificate.

1. Use a web browser to access the OCC endpoint of your backend.

   The default is available at: `{server-base-url}/rest/v2/electronics/cms/pages`

   For example, you can access:
   https://localhost:9002/rest/v2/telcospa/cms/pages with a back-end instance running from `https://localhost:9002`.

2. Accept the security exception in your browser if you are running a development instance with a self-signed HTTPS certificate.

    When the request works, you will see an XML response in your browser.

### Starting the Storefront Application

To start your Spartacus storefront, enter the following command from `mystore` in your terminal window:

   ```bash
yarn start
   ```
   When the app server is properly started, point your browser to http://localhost:4200.

Or, to start your Spartacus storefront securely, enter the following command:

   ```bash
yarn start --ssl
   ```
Then point your browser to  https://localhost:4200.
---
title: Building the Spartacus Storefront from Libraries
---

The following instructions describe how to build a storefront application using published Spartacus libraries.

To build the Spartacus project from source, see [[Contributor Setup]].

## Prerequisites

Before carrying out the procedures below, ensure the following front end and back end requirements are in place.

## Front End Requirements

Your Angular development environment should include the following:

- [Angular CLI](https://angular.io/): v7.3.7 or later, < v8.0.0
- node.js: v10 or later, < v12
- yarn: v1.15 or later

## Back End Requirements

Spartacus uses SAP Commerce Cloud for its back end, and makes use of the sample data from the B2C Accelerator Electronics storefront in particular.

Release 1905 is recommended, but it will work with 1811 and 1808, with reduced functionality.

For more information, see [[Installing SAP Commerce Cloud]]. If you are not using the latest version of SAP Commerce Cloud, see [Working with Older Versions of SAP Commerce Cloud](https://github.com/SAP/cloud-commerce-spartacus-storefront/tree/develop/docs/archived_installation_docs) for installation instructions appropriate to your version.

## Creating a New Angular App

The following procedure describes how to create a new Angular application with the name `mystore`.

1. Open a terminal or command prompt window at the location of your choice.

2. Using the Angular CLI, generate a new Angular application with the following command:

   ```bash
   ng new mystore --style=scss
   ```

3. When prompted if you would like to add Angular routing, enter `n` for 'no'.

    The `mystore` folder and the new app are created.

4.  Access the newly created `mystore` folder with the following command:

     ```bash
     cd mystore
     ```

## Adding Peer Dependencies to the Storefront

The dependencies in this procedure are required by the Spartacus storefront.

1. Open `mystore/package.json` using a text editor.

2. Add the following dependencies to the end of the `dependencies` section of `package.json`. 

   ```json
   "@angular/pwa": "^0.13.7",
   "@angular/service-worker": "~7.2.11",
   "@ng-bootstrap/ng-bootstrap": "^4.0.1",
   "@ng-select/ng-select": "^2.13.2",
   "@ngrx/effects": "~7.4.0",
   "@ngrx/router-store": "~7.4.0",
   "@ngrx/store": "~7.4.0",
   "bootstrap": "^4.2.1",
   "i18next": "^15.0.6",
   "i18next-xhr-backend": "^2.0.1",
   "ngrx-store-localstorage": "^7.0.0",
   "rxjs": "^6.4.0",
   
   "@spartacus/core": "~0.1.0-alpha.1",
   "@spartacus/styles": "~0.1.0-alpha.1",
   "@spartacus/assets": "~0.1.0-alpha.1",
   "@spartacus/storefront": "~0.1.0-alpha.1",
   ```

   Note: Make sure to add a comma to the end of the last dependency statement listed in this section. For example, the last statement in your new app might be `"zone.js": "~0.8.26"` so you would need to add a comma after `.26"`.


3. From the terminal window, within `mystore`, install the dependencies by running the following command:

   ```bash
   yarn install
   ```

**Note:** 

(1) If Spartacus libraries are in beta, change `alpha` to `beta`. The `~` instructs yarn to use the latest minor version (x.y), whereas the `^` instructs yarn to use the latest patch version (x.y.z). However, because Spartacus libraries have `-alpha.1`, yarn will only install the latest alpha releases (it won't automatically use beta versions).

(2) If you are updating an existing app, and changing dependencies, it's recommended that you delete the `node_modules` folder before running the install command.

## Adding Import Declarations and Storefront Configuration Settings

To use Spartacus, your new Angular app needs to import Spartacus libraries.

1. Open `mystore/src/app/app.module.ts` using a text editor.

2. Add the following lines to the top of the file, below existing import statements.

   ```typescript
   import { ConfigModule } from '@spartacus/core';
   import { translations } from '@spartacus/assets';
   import { StorefrontModule, defaultCmsContentConfig } from '@spartacus/storefront';
   ```

3. Add the following lines to the `NgModule/imports` section, below existing `BrowserModule` and `AppRoutingModule` statements, but before the last `],` (closing square bracket):
  
   ```typescript
   StorefrontModule.withConfig({
       backend: {
         occ: {
           baseUrl: 'https://localhost:9002',
           prefix: '/rest/v2/'
         }
       },
       authentication: {
         client_id: 'mobile_android',
         client_secret: 'secret'
       },
       site: {
         baseSite: 'electronics'
       },
       i18n: {
         resources: translations
       }
     }),
     ConfigModule.withConfigFactory(defaultCmsContentConfig)
   ```
  
   Don't forget to add a comma to the module entry before `StorefrontModule`.

4. Save the file. 

    The final version of  `mystore/src/app/app.module.ts` should look like this:

   ```typescript
   import { BrowserModule } from '@angular/platform-browser';
   import { NgModule } from '@angular/core';
   
   import { AppComponent } from './app.component';
   
   import { ConfigModule } from '@spartacus/core';
   import { translations } from '@spartacus/assets';
   import { StorefrontModule, defaultCmsContentConfig } from '@spartacus/storefront';
   
   @NgModule({
     declarations: [
       AppComponent
     ],
     imports: [
       BrowserModule,
       StorefrontModule.withConfig({
           backend: {
             occ: {
               baseUrl: 'https://localhost:9002',
               prefix: '/rest/v2/'
             }
           },
           authentication: {
             client_id: 'mobile_android',
             client_secret: 'secret'
           },
           site: {
             baseSite: 'electronics'
           },
           i18n: {
             resources: translations
           }
         }),
         ConfigModule.withConfigFactory(defaultCmsContentConfig)
       ],
     providers: [],
     bootstrap: [AppComponent],
   })
   export class AppModule { }
   ```

**Note:** Some of the statements in the example above were generated by Angular when you first created the app.

### Import Statements

The import statements import either modules or default data needed by Spartacus.

### StorefrontModule Settings

These settings are described in more detail in the Spartacus documentation. The following is a brief summary:

- `backend.occ` (`baseUrl`, `prefix`): When combined, the `baseUrl` and `prefix` parameters form the basis for all OCC REST API calls to your SAP Commerce Cloud server. The value of `https://localhost:9002` is valid if you have installed SAP Commerce Cloud on a local machine. The value of `rest/v2` is the default OCC REST API path. Change these values depending on the URL of your SAP Commerce Cloud server, and your prefix configuration.

  **Note:** Your server is properly configured if you can display the Open API documentation (for example, `https://localhost:9002/rest/v2/swagger-ui.html`)

- `authentication` (`client_id`, `client_secret`): The `client_id` and `client_secret` parameters define the ID and password to use when communicating with SAP Commerce Cloud using OCC REST API calls. The values `mobile_android` and `secret` correspond to examples in this [help document](https://help.sap.com/viewer/d0224eca81e249cb821f2cdf45a82ace/1811/en-US/627c92db29ce4fce8b01ffbe478a8b3b.html?q=Configuring%20OAuth%20Clients). Change the ID and secret to the settings for your server.

- `site` (`baseSite`): The value for `baseSite` is the CMS name of the back end storefront, as it appears in **Backoffice > WCMS > Website**. This example uses the `electronics` sample storefront included with SAP Commerce Cloud. Change this value based on the CMS sites installed on your server.

- `i18n` (`resources`): This parameter configures Spartacus to use default translation data provided with Spartacus.

### ConfigModule Statement

The `ConfigModule.withConfigFactory(defaultCmsContentConfig)` paramater configures Spartacus to use default CMS (content) data provided with Spartacus.

## Adding the Storefront to `app.component.html`

This procedure adds the storefront component `cx-storefront` to `app.component.html`. Doing so will display your storefront app in your browser.

1. Open `mystore/src/app/app.component.html` with a text editor.

2. Replace the entire contents of the file with the following line:

   ```html
   <cx-storefront>Loading...</cx-storefront>
   ```



## Adding Default Styling

This procedure adds the default Spartacus styling to your storefront. Without it, your storefront app will not display properly.

1. Open `mystore/src/styles.scss` with a text editor.

2. Add the following line:

   ```scss
   @import "~@spartacus/styles/index";
   ```

## Building and Starting

This section describes how to validate your back end installation, and then start the application with the storefront enabled.

### Validating the SAP Commerce Cloud Backend

**Note:** The Chrome browser is highly recommended for the following steps. Other browsers may not work properly.

1. Use a web browser to access the OCC endpoint of your backend.

   The default is available at: `{server-base-url}/rest/v2/electronics/cms/pages`.

   For example, with a back end instance running from `https://localhost:9002`, you would access:
   https://localhost:9002/rest/v2/electronics/cms/pages


2. Accept the security exception in your browser, if you are running a development instance with a self-signed HTTPS certificate.

    When the request works, you see an XML response in your browser.

### Starting the Storefront Application

To start your Spartacus storefront, enter the following command from `mystore` in your terminal window:

   ```bash
   yarn start
   ```

   When the app server is properly started, point your browser to http://localhost:4200.

To start your Spartacus storefront securely, enter the following command:

   ```bash
   yarn start --ssl
   ```

Then point your browser to  https://localhost:4200.

## Changing the Logo

If you are using the `electronics` sample store that is included with SAP Commerce Cloud, you may notice that the logo is small and difficult to see. This is because the logo was designed for Accelerator templates. The logo comes from the server and can be updated.

1. Log in to SAP Commerce Backoffice.

2. Select **WCMS** in the left-hand navigation pane, then select the **Component** child node that appears below.

3. Search for the term `SiteLogoComponent` in the **Search** box in the top-center panel.

      You can modify the component directly in the **Online Catalog**, or you can modify it in the **Staged Catalog** and then perform a sync.

4. Open the **Administration** tab of the `SiteLogoComponent`, and remove the **Media** value.

5. Click the button labelled **...** next to the **Media** field.

6. In the pop-up search box that appears, search for the desired media file in your system and select it.

7. Save your changes.

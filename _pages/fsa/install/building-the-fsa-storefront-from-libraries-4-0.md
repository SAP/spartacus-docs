---
title: Building the FSA Spartacus Storefront using 4.0 Libraries
---

The following instructions describe how to build an FSA storefront application using published FSA Spartacus 4.x libraries. 
If you are building Spartacus from the source, see [Contributor Setup]({{ site.baseurl }}{% link _pages/contributing/contributor-setup.md %}).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Prerequisites

Before carrying out the procedures below, ensure the following front-end and back-end requirements are in place.

### Front-End Development Requirements

Your Angular development environment should include the following:

- **Angular CLI**: Version 12.0.5 or later.
- **node.js**: Version 14.x is recommended.
- **yarn**: Version 1.22.x or later.

### Back-End Server Requirements

FSA Spartacus uses SAP Commerce and Financial Services Accelerator back end and makes use of the sample data.

- **SAP Commerce Cloud**: Release **2105** is required. Patch version **2105.5** is recommended
- **Financial Services Accelerator**: Version **2202** is required.

For more information, see [Installing SAP Commerce Cloud FSA for use with FSA Spartacus]({{ site.baseurl }}{% link _pages/fsa/install/installing-sap-commerce-with-fsa-spartacus.md %}).

### Windows Setup

To successfully install the project in the Windows environment, first make sure that you have installed GitBash.

Next, create the .npmrc file at the root of your Angular project.
The .npmrc file should contain the following:

```shell
shell = "{instalation directory}\\Git\\bin\\bash.exe" 
script-shell = "{instalation directory}\\Git\\bin\\bash.exe" 


Example:
shell = "C:\\Program Files\\Git\\bin\\bash.exe"
script-shell = "C:\\Program Files\\Git\\bin\\bash.exe"
```

Once you have configured this, you should execute all the commands in the procedures that follow from the GitBash console.

## Creating a New Angular App

The following procedure describes how to create a new Angular application with the name `mystore`.

1. Open a terminal or command prompt window at the location of your choice.
2. Using the Angular CLI, generate a new Angular application with the following command:

   ```bash
   ng new mystore --style=scss
   ```

   When prompted for Angular routing, enter `n` for 'no'.

   The `mystore` folder and the new app are created.

3. Access the newly created `mystore` folder with the following command:

     ```bash
     cd mystore
     ```

## FSA Spartacus Project Setup

1. Go to the `package.json` file at the root of your project and replace existing dependencies with the following:

    ```shell
    "dependencies": {
    "@angular/animations": "~12.0.5",
    "@angular/common": "~12.0.5",
    "@angular/compiler": "~12.0.5",
    "@angular/core": "~12.0.5",
    "@angular/forms": "~12.0.5",
    "@angular/platform-browser": "~12.0.5",
    "@angular/platform-browser-dynamic": "~12.0.5",
    "@angular/platform-server": "~12.0.5",
    "@angular/pwa": "~12.0.5",
    "@angular/router": "~12.0.5",
    "@angular/service-worker": "~12.0.5",
    "@compodoc/compodoc": "^1.1.10",
    "@ng-bootstrap/ng-bootstrap": "~10.0.0",
    "@ng-select/ng-select": "~7.0.1",
    "@ngrx/effects": "~12.1.0",
    "@ngrx/router-store": "~12.1.0",
    "@ngrx/store": "~12.1.0",
    "@nguniversal/express-engine": "~12.0.2",
    "@spartacus/dynamicforms": "4.0.0",
    "@spartacus/fsa-storefront": "4.0.0",
    "@spartacus/fsa-styles": "3.0.0",
    "@spartacus/asm": "4.2.1",
    "@spartacus/assets": "4.2.0",
    "@spartacus/cart": "4.2.1",
    "@spartacus/cds": "4.2.1",
    "@spartacus/checkout": "4.2.1",
    "@spartacus/core": "4.3.0",
    "@spartacus/digital-payments": "4.2.1",
    "@spartacus/organization": "4.2.1",
    "@spartacus/product": "4.2.1",
    "@spartacus/product-configurator": "4.2.1",
    "@spartacus/smartedit": "4.2.1",
    "@spartacus/storefinder": "4.2.1",
    "@spartacus/storefront": "4.2.0",
    "@spartacus/styles": "4.2.1",
    "@spartacus/tracking": "4.2.1",
    "@spartacus/user": "4.2.1",
    "@syncpilot/bpool-guest-lib": "^0.2.6",
    "@types/googlemaps": "^3.37.5",
    "angular-oauth2-oidc": "~10.0.1",
    "blob-util": "^2.0.2",
    "bootstrap": "^4.3.1",
    "comment-json": "^4.1.0",
    "echarts": "^5.0.2",
    "express": "^4.15.2",
    "file-saver": "^2.0.2",
    "hamburgers": "^1.1.3",
    "i18next": "^20.2.2",
    "i18next-http-backend": "^1.2.2",
    "i18next-xhr-backend": "^3.2.2",
    "ngx-echarts": "^6.0.1",
    "ngx-infinite-scroll": "^8.0.0",
    "parse5": "^6.0.1",
    "resize-observer-polyfill": "^1.5.1",
    "rxjs": "^6.6.0",
    "ts-loader": "^6.0.4",
    "tslib": "^2.3.0",
    "zone.js": "~0.11.4"
    ```

In order for the installation to proceed without any errors, you need to have the latest Spartacus app directory structure in place. 
Simply changing the version in `package.json` file is not enough.
FSA Spartacus 4.0 requires Spartacus version 4.x. 
For instructions on how to set up Spartacus project, see [Spartacus documentation](https://sap.github.io/spartacus-docs/building-the-spartacus-storefront-from-libraries-4-x/)

### Installing Dependencies

**NOTE**: If you installed dependencies during upgrade to version 4.0, you can skip this step.

Install dependencies needed by your FSA Spartacus app with the following command:

```bash
yarn install
```

### Starting your Spartacus App

**NOTE**: If you started the app during upgrade to version 4.0, you can skip this step.

Start your app with the following command:

```bash
yarn start
```

Your app will be compiled and then started.

To display your storefront, assuming you installed everything locally, browse to `http://localhost:4200`. 
If you installed the Financial SPA Sample Data with the *financialprocess* extension, the FSA Spartacus storefront for financial services should appear.

**Note:** If your storefront doesn't appear, you probably have to accept a privacy certificate. 
To do so, browse to `https://localhost:9002/occ/v2/financial/cms/pages`, and then accept the privacy certificate. 
This step is necessary because your browser will block calls to the app which makes calls to `localhost:9002`, due to security settings. 
To see the browser message, right-click in your browser, select **Inspect**, then click **Console**.


Congratulations! You've built your first FSA Spartacus storefront.

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

- **SAP Commerce Cloud**: Release **2105** is required. Patch version **2105.5** is recommended.
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

1. Open a command line and navigate to the location of your choice.
2. Using Angular CLI, generate a new Angular application with the following command:

   ```shell
   ng new mystore --style=scss
   ```

   When prompted for Angular routing, enter `n` for 'no'.

   The `mystore` folder and the new app are created.

3. Access the newly created `mystore` folder with the following command:

     ```shell
     cd mystore
     ```

## FSA Spartacus Project Setup

1. Go to the `package.json` file at the root of your project and add the following dependencies:

    ```json
    "@angular/service-worker": "^12.0.5",
    "@ng-bootstrap/ng-bootstrap": "^10.0.0",
    "@ng-select/ng-select": "^7.0.1",
    "@ngrx/effects": "^12.1.0",
    "@ngrx/router-store": "^12.1.0",
    "@ngrx/store": "^12.1.0",
    "@spartacus/asm": "4.2.1",
    "@spartacus/assets": "4.2.0",
    "@spartacus/cart": "4.2.1",
    "@spartacus/cds": "4.2.1",
    "@spartacus/checkout": "4.2.1",
    "@spartacus/core": "4.3.0",
    "@spartacus/digital-payments": "4.2.1",
    "@spartacus/dynamicforms": "^4.0.0",
    "@spartacus/fsa-storefront": "^4.0.0",
    "@spartacus/fsa-styles": "^4.0.0",
    "@spartacus/organization": "4.2.1",
    "@spartacus/product": "4.2.1",
    "@spartacus/product-configurator": "4.2.1",
    "@spartacus/smartedit": "4.2.1",
    "@spartacus/storefinder": "4.2.1",
    "@spartacus/storefront": "4.2.0",
    "@spartacus/styles": "4.2.1",
    "@spartacus/tracking": "4.2.1",
    "@spartacus/user": "4.2.1",
    "@syncpilot/bpool-guest-lib": "^0.3.2",
    "angular-oauth2-oidc": "^10.0.1",
    "blob-util": "^2.0.2",
    "bootstrap": "^4.3.1",
    "echarts": "^5.0.2",
    "file-saver": "^2.0.2",
    "i18next": "^20.2.2",
    "i18next-http-backend": "^1.2.2",
    "ngx-echarts": "6.0.1",
    "ngx-infinite-scroll": "^8.0.0",
    "resize-observer-polyfill": "^1.5.1",
    ```

2. Install the dependencies:

    ```shell
    yarn install
    ```

3. After the installation is completed, the app structure needs to be updated to meet Spartacus requirements. 
To do that, you need to replace the existing `app` folder with the one that contains the required structure.
You can download a ready-made `app` folder with the new structure on link provided below.
Perform the following steps:
    - [Download new app.zip](https://github.com/SAP/spartacus-financial-services-accelerator/releases/download/fsa-storefront-4.0.0/app.zip).
    - Navigate to `mystore/src/`.
    - Delete the existing `app` folder.
    - Unpack the downloaded `app.zip` folder to that same location (`mystore/src/`).

4. Now that you have the new app structure, you need to set the `baseUrl`:
  - Navigate to `app/spartacus`.
  - Find and open `fs-configuration.module.ts`, which holds the configuration necessary for the FSA to function properly.
  - Edit `baseUrl` property so that it points to your back-end server.

5. Return to `src` folder, open `style.scss` file and add the following line:

    ```typescript
    @import "~@spartacus/fsa-styles/index";
    ```

6. Copy the `fonts` directory from `node_modules/@spartacus/fsa-styles` to `src/assets` directory.

7. Start the server:

    ```shell
    ng serve
    ```

Your app will be compiled and then started.

To display your storefront, assuming everything is installed locally, browse to `http://localhost:4200`. 
If you installed Financial SPA sample data with the *financialprocess* extension, the FSA Spartacus storefront for Financial services should appear.

**Note**: If your storefront doesn’t appear, you probably need to accept a privacy certificate. 
To do so, browse to `https://localhost:9002/occ/v2/financial/cms/pages`, and then accept the privacy certificate. 
This step is necessary because your browser will block calls to the app which makes calls to `localhost:9002`, due to security settings. 
To see the browser message, right-click in your browser, select **Inspect**, and then click **Console**.

**Congratulations! You've built your first FSA Spartacus storefront.**

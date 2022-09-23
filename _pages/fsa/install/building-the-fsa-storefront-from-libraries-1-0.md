---
title: Building the FSA Spartacus Storefront using 1.0 Libraries
---

The following instructions describe how to build an FSA storefront application using published FSA Spartacus 1.x libraries. If you are building Spartacus from the source, see [Contributor Setup]({{ site.baseurl }}{% link _pages/contributing/contributor-setup.md %}).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Prerequisites

Before carrying out the procedures below, ensure the following front-end and back-end requirements are in place.

### Front-End Development Requirements

Your Angular development environment should include the following:

- Angular CLI: Version 9.1 or later, < 10.0.
- node.js: 10.14.1 or later, < 13.0. The most recent 12.x version is recommended.
- yarn: v1.15 or later.

### Back-End Server Requirements

FSA Spartacus uses SAP Commerce and Financial Services Accelerator back end, and makes use of the sample data.

- SAP Commerce version: Release 2005 (the latest patch is recommended - 2005.5).
- Financial Services Accelerator version: Release 2008 (the latest patch - 2008.2) is required.

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
1. Using the Angular CLI, generate a new Angular application with the following command:

   ```bash
   ng new mystore --style=scss
   ```

   When prompted for Angular routing, enter `n` for 'no'.

   The `mystore` folder and the new app are created.

1. Access the newly created `mystore` folder with the following command:

     ```bash
     cd mystore
     ```

## FSA Spartacus Project Setup

The easiest way to start a new project is to use Angular Schematics to quickly set up your application.  

You can add FSA Spartacus libraries to your Spartacus Angular project by running the following command from your project root:

```shell
ng add @spartacus/fsa-schematics --base-site=sample-financial-site --currency=usd,eur --language=en,de,fr
```

For a detailed explanation, visit [FSA Schematics]({{ site.baseurl }}{% link _pages/fsa/install/fsa-schematics.md %}).

For a full list of available parameters, please visit Spartacus Schematics [documentation](https://github.com/SAP/spartacus/tree/develop/projects/schematics).

### Installing Dependencies

Install dependencies needed by your FSA Spartacus app with the following command:

```shell
yarn install
```

### Checking app.module.ts for base URL and Other Settings

Open the `src\app\app.module.ts` file, and check for any changes you want to make for your setup.

You should add the following ngrx store module with specified runtime checks option in the imports section:

```ts
    StoreModule.forRoot({}, {
      runtimeChecks: {
        strictStateImmutability: false,
        strictActionImmutability: false,
      },
    }),
```

It also requires an `ngrx` import:

```ts
import { StoreModule } from '@ngrx/store';
```

After FSA is installed your app.module.ts should look like following:

```ts
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { StoreModule } from '@ngrx/store';
import { AppComponent } from './app.component';
import { FSStorefrontModule } from '@spartacus/fsa-storefront';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    StoreModule.forRoot({}, {
      runtimeChecks: {
        strictStateImmutability: false,
        strictActionImmutability: false,
      },
    }),
    FSStorefrontModule.withConfig({
      backend: {
        occ: {
          baseUrl: '/--path to the server---/',
          prefix: '/occ/v2/'
        }
      },
      context: {
        currency: ['EUR'],
        language: ['en', 'de'],
        urlParameters: ['baseSite', 'language', 'currency'],
        baseSite: ['financial']
      },
      authentication: {
        client_id: 'financial_customer',
        client_secret: 'secret'
      },
      features: {
        consignmentTracking: true,
      }
    })
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
```

For example, check:

- `baseUrl`: Points to your SAP Commerce server
- `prefix`: Defines the prefix to OCC calls; change `/rest/v2/` to `/occ/v2/` if using release 2005
- `context`: Defines the site context such as base site, language, and currency.
- `authentication`: Defines authorization of financial customer

**Note:** If your setup failed and for some reason your app.module.ts is not configured like described please check one more time requirements for fsa schematics usage, Angular CLI version should be <= 10.0!

### Starting Your Spartacus App

Start your app with the following command:

```shell
yarn start
```

Your app will be compiled and then started.

To display your storefront, assuming everything is installed locally, browse to `http://localhost:4200`. If you installed Financial sample data with the financialstorefront extension, the FSA Spartacus storefront for Financial services should appear.

**Note:** If your storefront doesn't appear, you probably have to accept a privacy certificate. To do so, browse to `https://localhost:9002/occ/v2/financial/cms/pages`, and then accept the privacy certificate. This step is necessary because your browser will block calls to app which makes calls to localhost:9002, due to security settings. To see the browser message, right-click in your browser, select *Inspect*, then click *Console*.

Congratulations! You've built your first FSA Spartacus storefront.

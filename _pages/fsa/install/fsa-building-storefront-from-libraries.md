---
title: Building the FSA Spartacus Storefront using 1.0 Libraries
---

The following instructions describe how to build a FSA storefront application using published FSA Spartacus 1.x libraries. If you are building Spartacus from source, see [Contributor Setup]({{ site.baseurl }}{% link _pages/contributing/contributor-setup.md %}).

## Prerequisites

Before carrying out the procedures below, ensure the following front end and back end requirements are in place.

## Front-End Development Requirements

{% include docs/frontend_requirements.html %}

## Back End Server Requirements

FSA Spartacus uses SAP Commerce and Financial Services Accelerator back end, and makes use of the sample data.

- SAP Commerce version: Release 2005 (latest patch is recommended - 2005.5).
- Financial Services Accelerator version: Release 2008 (latest patch - 2008.2) is required.

For more information, see [Installing SAP Commerce Cloud for use with Spartacus]({{ site.baseurl }} link _pages/fsa/install/installing-sap-commerce-for-use-with-fsa-spartacus-1.0.md ). 

## Creating a New Angular App

The following procedure describes how to create a new Angular application with the name `mystore`.

1. Open a terminal or command prompt window at the location of your choice.

2. Using the Angular CLI, generate a new Angular application with the following command:

   ```bash
   ng new mystore --style=scss
   ```

   When prompted for Angular routing, enter `n` for 'no'.

   The `mystore` folder and the new app are created.

4.  Access the newly created `mystore` folder with the following command:

     ```bash
     cd mystore
     ```

## FSA Spartacus Project Setup

The easiest way to start a new project is to use Angular Schematics to quickly set up your application. 
First install plane Spartacus application over schematics:
```shell
ng add @spartacus/schematics
```

After that you can add FSA Spartacus libraries to your Spartacus Angular project by running the following command from your project root:

```shell
ng add @fsa/schematics
```
After this make sure that you have only FSStorefrontModule.withConfig({..}) in you app.module. Remove any other storefront module configuration you have.

For the detailed explanation visit [FSA Schematics]({{ site.baseurl }}{% link _pages/fsa/install/fsa-schematics.md %}).

For a full list of available parameters please visit Spartacus schematics [documentation](https://github.com/SAP/spartacus/tree/develop/projects/schematics).


### Install dependencies ###  

Install dependencies needed by your FSA Spartacus app with the following command:

```
yarn install
```

### Check app.module.ts for base URL and other settings ###

Open the `src\app\app.module.ts` file, and check for any changes you want to make for your setup. 

For example, check:
- `baseUrl`: Points to your SAP Commerce server
- `prefix`: Defines the prefix to OCC calls; change `/rest/v2/` to `/occ/v2/` if using release 2005
- `features.level`: Defines the compatibility level
- `context`: Defines the site context such as base site, language, and currency. For example, to see the base site in the URL and add Financial store support, change `context` to the following:
   ```
   context: {
     urlParameters: ['baseSite', 'language', 'currency'],
     baseSite: ['financial'],
     language: ['en', 'de'],
     currency: ['EUR']
   },
   ```
  
### Copy styles to your application ###

Copy the folder @fsa/fsastorefrontstyles/fonts from node_modules to src/assets folder of your new application.

### Starting your Spartacus app ###  

Start your app with the following command:

```
yarn start
```

Your app will be compiled and then started.

To display your storefront, assuming everything is installed locally, browse to `http://localhost:4200`. If you installed Financial sample data with the Financialstorefront extension, the FSA Spartacus storefront for Financial services should appear.

Note: If your storefront doesn't appear, likely you have to accept a privacy certificate. To do so, browse to `https://localhost:9002/occ/v2/electronics/cms/pages`, and then accept the privacy certificate. This step is necessary because your browser will block calls to app will make calls to localhost:9002 due to security settings. To see the browser message, right-click in your browser, select Inspect, then click Console.


Congratulations! You've built your first FSA Spartacus storefront.


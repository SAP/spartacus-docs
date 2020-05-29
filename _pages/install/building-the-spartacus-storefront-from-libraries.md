---
title: Building the Spartacus Storefront using 2.x Libraries
---

The following instructions describe how to build a storefront application using published Spartacus 1.x libraries.

If you are building Spartacus from source, see [Contributor Setup]({{ site.baseurl }}{% link _pages/contributing/contributor-setup.md %}).

## Prerequisites

Before carrying out the procedures below, ensure the following front end and back end requirements are in place.

## Front-End Development Requirements

{% include docs/frontend_requirements.html %}

## Back End Server Requirements

Spartacus uses SAP Commerce Cloud for its back end, and makes use of the sample data from the B2C Accelerator Electronics storefront in particular. Release 2005 is recommended although Spartacus works with 1905 as well; the difference is in the APIs available (such as cancel/returns and B2B My Company). No matter the version, the latest patch is required, as important fixes as often added that affect Spartacus.

For more information, see [Installing SAP Commerce Cloud for use with Spartacus]({{ site.baseurl }}{% link _pages/install/backend/installing-sap-commerce-cloud.md %}). 

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

## Spartacus Project Setup

The easiest way to start a new project is to use Angular Schematics to quickly set up your application. 

For a full list of available parameters please visit Spartacus schematics [documentation](https://github.com/SAP/spartacus/tree/develop/projects/schematics).

### Setting up the project using schematics ###

Until 2.0 is released and is designated the "latest" Spartacus library, use this command:

```bash
ng add @spartacus/schematics@rc
```

After 2.0 is released, you can omit the `@rc` at the end of the command. By default the latest libraries will be installed.

To verify what versions of Spartacus libraries were installed, inspect the file package.json and look for `@spartacus`

### After the project is set up using schematics ###

Inspect the `src\app\app.module.ts` file for any changes you want to make for your setup. 

For example, check:
- `baseUrl` to point to your server
- `features.level` to specify the compatibility version 
- `prefix` to specify `/rest/` (default for release 1905) or `/occ/` (default for release 2005)

You may also want to specify base site configuration information to correspond with your WCMS sites:
```json
context: {
urlParameters: ['baseSite', 'language', 'currency'],
baseSite: ['electronics-spa','apparel-uk-spa'],
currency: ['USD', 'GBP',]
},
```

### Starting your Spartacus app ###  

Run `yarn start`.

To display your storefront, assuming everything is installed locally:

1. Browse to `https://localhost:9002/rest/v2/electronics/cms/pages` and accept the privacy certificate.

   (This step is necessary because your app will make calls to localhost:9002, but your browser will block the calls due to privacy settings.)
   
2. Browse to `http://localhost:4200`.


Congratulations! You've built your first Spartacus storefront.


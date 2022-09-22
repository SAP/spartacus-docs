---
layout: building-from-3x-libs-redirect
title: Building the Spartacus Storefront Using 3.1 Libraries
---

The following instructions describe how to build a storefront application, for both B2C (Electronics, Apparel) and B2B (Powertools) sample stores. If you are building Spartacus from source, see [{% assign linkedpage = site.pages | where: "name", "contributor-setup.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/contributing/contributor-setup.md %}).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Prerequisites

Before carrying out the procedures below, ensure the following front end and back end requirements are in place.

## Front End Development Requirements

{% include docs/frontend_requirements.html %}

## Back End Server Requirements

Spartacus uses SAP Commerce Cloud for its back end and makes use of the sample data. Spartacus should only be used with SAP Commerce Cloud 1905 or newer; the latest release is recommended. The difference between releases is in the APIs and features available. Newer releases of SAP Commerce Cloud contain new OCC APIs. For example, the B2B Commerce Organization API was added in release 2005. For more information on which back end releases contain which APIs, see [{% assign linkedpage = site.pages | where: "name", "feature-release-versions.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/home/feature-release-versions.md %}).

No matter the version, the latest patch is required, as important fixes are often added that affect Spartacus.

For more information, see [{% assign linkedpage = site.pages | where: "name", "installing-sap-commerce-cloud.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/backend/installing-sap-commerce-cloud.md %}).

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

   ```shell
   cd mystore
   ```

## Spartacus Project Setup

The easiest way to start a new project is to use Angular Schematics to quickly set up your application.

For a full list of available parameters please visit Spartacus schematics [documentation](https://github.com/SAP/spartacus/tree/develop/projects/schematics).

### Setting up the Core B2C Project Using Schematics

To install version 3.1 of Spartacus using schematics:

```bash
ng add @spartacus/schematics@3.1
```

**Notes:**

- The `/schematics` command adds the core Spartacus (or B2C) configuration, to work with SAP Commerce Cloud Electronics or Apparel sample stores.
- To install the latest 'Next' or Release Candidate, you can add `@next` or `@rc` at the end of the command.
- To verify what versions of Spartacus libraries were installed, open the file `package.json` and look for `@spartacus`.
- The store locator feature is no longer included with the core Spartacus libraries. You can enable it by installing the `@spartacus/storefinder` feature library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

### Adding B2B Commerce Organization (Optional)

**Note:** Spartacus does not support B2C and B2B storefronts running together in a single storefront application. When you enable B2B Commerce Organization, the B2C storefront will load but not work properly.

**Note:** You need to first install the Spartacus core libraries before you can add B2B Commerce Organization. If you have not already done so, run the following command to install the Spartacus core libraries:

```bash
ng add @spartacus/schematics
```

To get Spartacus to work with the SAP Commerce Cloud Powertools sample store, you must add the B2B Commerce Organization configuration to Spartacus using schematics, as follows:

```bash
ng add @spartacus/organization
```

The installer asks what to include (`Administration` and `Order-approval`); both are required for B2B Commerce Organization to work. The default is both, so you can just press **Enter** when prompted.

### Installing Dependencies

Install dependencies needed by your Spartacus app with the following command:

```shell
yarn install
```
  
### Checking app.module.ts for Base URL and Other Settings

Open the `src\app\app.module.ts` file, and check for any changes you want to make for your setup.

For example, check:

- `baseUrl`: Points to your SAP Commerce Cloud server.
- `prefix`: Defines the prefix for OCC calls.
  - The default for Spartacus libraries 3.0 and later is `/occ/v2/`; this entry is not added by schematics.
  - If using 2005 or later, the default backend prefix is `/occ/v2/`.
  - If using 1905, or 2005 with the OCC AddOn, add the line `prefix: '/rest/v2/'`.
- `features.level`: Defines the compatibility level
- `context`: Defines the site context such as base site, language, and currency.
  - To see the base site in the URL and add Apparel store support, change `context` to the following:

     ```ts
     context: {
     urlParameters: ['baseSite', 'language', 'currency'],
     baseSite: ['electronics-spa','apparel-uk-spa'],
     currency: ['USD', 'GBP',]
     },
     ```

  - If using Powertools, add `powertools-spa` to the list in `baseSite`.
  
### Starting Your Spartacus App

Start your app with the following command:

```shell
yarn start
```

Your app will be compiled and then started.

To display your storefront, assuming everything is installed locally, browse to `http://localhost:4200`. If you installed Electronics sample data and the Spartacus Sample Data extension, the Spartacus storefront for Electronics should appear.

**Note:** If your storefront doesn't appear, likely you have to accept a privacy certificate. To do so, browse to `https://localhost:9002/occ/v2/electronics/cms/pages` (or `../rest/..` if using 1905), and then accept the privacy certificate. This step is necessary because your browser will block calls the app will make to `localhost:9002` due to security settings. To see the browser message, right-click in your browser, select **Inspect**, then click **Console**.

- You can display the Apparel storefront through this URL: `http://localhost:4200/apparel-uk-spa/en/GBP`
- You can display the Powertools storefront through this URL: `http://localhost:4200/powertools-spa/en/USD`

Congratulations! You've built your first Spartacus storefront.

---
title: Building the Spartacus Storefront Using 3.x Libraries
---

The following instructions describe how to build a storefront application, for both B2C (Electronics, Apparel) and B2B (Powertools) sample stores. If you are building Spartacus from source, see [Contributor Setup]({{ site.baseurl }}{% link _pages/contributing/contributor-setup.md %}).

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

Spartacus uses SAP Commerce Cloud for its back end and makes use of the sample data. Spartacus should only be used with SAP Commerce Cloud 1905 or newer; the latest release is recommended. The difference between releases is in the APIs and features available. Newer releases of SAP Commerce Cloud contain new OCC APIs. For example, the B2B Commerce Organization API was added in release 2005. For more information on which back end releases contain which APIs, see [Feature Compatibility]({{ site.baseurl }}{% link _pages/home/feature-release-versions.md %}).

No matter the version, the latest patch is required, as important fixes are often added that affect Spartacus.

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

3. Access the newly created `mystore` folder with the following command:

     ```shell
     cd mystore
     ```

## Spartacus Project Setup

The easiest way to start a new project is to use Angular Schematics to quickly set up your application.

For a full list of available parameters please visit Spartacus schematics [documentation]({{ site.baseurl }}{% link _pages/install/schematics.md %}).

### Setting up the Project Using Schematics

To install the latest official release of Spartacus using schematics:

```bash
ng add @spartacus/schematics@latest
```

Schematics will ask you first to choose Spartacus configuration (b2c or b2b). B2B configuration differs from B2C only with few occ endpoints and checkout configuration (additional `defaultB2bOccConfig` and `defaultB2bCheckoutConfig` from `@spartacus/setup`).

**Note:** Spartacus does not support B2C and B2B storefronts running together in a single storefront application. When you enable B2B Commerce Organization, the B2C storefront will load but not work properly.

Next prompt from schematics will ask you which additional features would you like to install in your storefront. This list doesn't show all spartacus features, but all the libraries. Some libraries have a single feature (eg. `@spartacus/smartedit`, `@spartacus/cdc`), where other contain smaller features (eg. `@spartacus/organization` with "Organization administration" and "Order approval" features).

When you select libraries with multiple features you will see more prompts for each library to select features they contain.

List of all the features libraries is [available here]({{ site.baseurl }}{% link _pages/install/schematics.md %}).

**Notes:**

- When you select feature for b2b storefronts the schematics will automatically add required b2b configs if they are missing.
- The command adds the core Spartacus files and configuration, to work with SAP Commerce Cloud sample stores.
- To install the latest 'Next' or Release Candidate, you can add `@next` or `@rc` at the end of the command.
- To verify what versions of Spartacus libraries were installed, open the file `package.json` and look for `@spartacus`.
- More and more features are moved from the core libraries to dedicated feature libraries, so expect with each major release that scope of core libraries will shrink with features being extracted to separated packages.

### Installing Dependencies

Install dependencies needed by your Spartacus app with the following command:

```shell
yarn install
```

### Checking spartacus-configuration.module.ts for Base URL and Other Settings

Open the `src\app\spartacus\spartacus-configuration.module.ts` file, and check for any changes you want to make for your setup.

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

Note: If your storefront doesn't appear, likely you have to accept a privacy certificate. To do so, browse to `https://localhost:9002/occ/v2/electronics/cms/pages` (or `../rest/..` if using 1905), and then accept the privacy certificate. This step is necessary because your browser will block calls the app will make to `localhost:9002` due to security settings. To see the browser message, right-click in your browser, select **Inspect**, then click **Console**.

- You can display the Apparel storefront through this URL: `http://localhost:4200/apparel-uk-spa/en/GBP`
- You can display the Powertools storefront through this URL: `http://localhost:4200/powertools-spa/en/USD`

Congratulations! You've built your first Spartacus storefront.

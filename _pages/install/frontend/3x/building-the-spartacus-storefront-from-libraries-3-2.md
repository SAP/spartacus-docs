---
layout: building-from-3x-libs-redirect
title: Building the Spartacus Storefront Using 3.2 Libraries
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

The easiest way to start a new project is to use Spartacus schematics to quickly set up your application.

For a full list of available parameters, see [{% assign linkedpage = site.pages | where: "name", "schematics.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/schematics.md %}).

### Setting Up Your Project Using Schematics

Run the following command to install the latest patch version of Spartacus 3.2 using schematics:

```bash
ng add @spartacus/schematics@3.2
```

When you run this command, you are first asked to choose either a B2C or B2B configuration. The only difference between the two options is that the B2B configuration has a few additional OCC endpoints and a different checkout configuration. Specifically, the B2B configuration adds the `defaultB2bOccConfig` and `defaultB2bCheckoutConfig` from `@spartacus/setup`.

**Note:** Spartacus does not support B2C and B2B storefronts running together in a single storefront application. When you enable B2B Commerce Organization, the B2C storefront will load but not work properly.

After choosing `b2c` or `b2b`, the next prompt asks you which Spartacus features you want to set up in your storefront, and you are presented with a list of integration libraries and feature libraries to choose from.

To set up a Spartacus feature, you first install the relevant [integration library or feature library]({{ site.baseurl }}/schematics/#integration-libraries-and-feature-libraries) by choosing it from the list. After the step for selecting which libraries you want to install, if you selected a library that contains multiple features, you are then prompted to select which features you want to install from that library. If you selected an integration library that requires additional information to complete the setup, you are also prompted to provide this information.

The `@spartacus/user` library is not included in the list of libraries to install because it is included by default. After the step for selecting which libraries you want to install, the next prompt asks if you want to install the Account and Profile features from the `@spartacus/user` library. It is highly recommended to install both.

For more information, see [Integration Libraries and Feature Libraries]({{ site.baseurl }}/schematics/#integration-libraries-and-feature-libraries).

**Notes:**

- If you select a feature that is for B2B storefronts, the schematics automatically add any required B2B configurations if they are missing.
- The schematics add the core Spartacus files and configuration that are needed to work with the SAP Commerce Cloud sample stores.
- To install the latest "next" release, you can add `@next` at the end of the command.
- To install the latest release candidate, you can add `@rc` at the end of the command.
- To verify what versions of Spartacus libraries were installed, open `package.json` and look for `@spartacus`.
- With each release of Spartacus, existing features are moved out of the core libraries and into their own dedicated feature libraries. With time, the core libraries will shrink as features are extracted to their own, separate packages.

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

**Note:** If your storefront doesn't appear, likely you have to accept a privacy certificate. To do so, browse to `https://localhost:9002/occ/v2/electronics/cms/pages` (or `../rest/..` if using 1905), and then accept the privacy certificate. This step is necessary because your browser will block calls the app will make to `localhost:9002` due to security settings. To see the browser message, right-click in your browser, select **Inspect**, then click **Console**.

- You can display the Apparel storefront through this URL: `http://localhost:4200/apparel-uk-spa/en/GBP`
- You can display the Powertools storefront through this URL: `http://localhost:4200/powertools-spa/en/USD`

Congratulations! You've built your first Spartacus storefront.

---
title: Building the Spartacus Storefront using 2.x Libraries
---

The following instructions describe how to build a storefront application using published Spartacus 2.x libraries. If you are building Spartacus from source, see [Contributor Setup]({{ site.baseurl }}{% link _pages/contributing/contributor-setup.md %}).

## Prerequisites

Before carrying out the procedures below, ensure the following front end and back end requirements are in place.

## Front-End Development Requirements

{% include docs/frontend_requirements.html %}

## Back End Server Requirements

Spartacus uses SAP Commerce Cloud for its back end, and makes use of the sample data. Release 2005 is recommended, although Spartacus works with 1905 as well; the difference is in the APIs available (such as cancellations and returns and the Commerce Organization feature). No matter the version, the latest patch is required, as important fixes as often added that affect Spartacus.

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

To install the latest release of Spartacus 2.0 using schematics:

```bash
ng add @spartacus/schematics
```

To install the latest 'Next' or Release Candidate, you can add `@next` or `@rc` at the end of the command. 

To verify what versions of Spartacus libraries were installed, open the file `package.json` and look for `@spartacus`.

### Install dependencies ###  

Install dependencies needed by your Spartacus app with the following command:

```
yarn install
```


### Check app.module.ts for base URL and other settings ###

Open the `src\app\app.module.ts` file, and check for any changes you want to make for your setup. 

For example, check:
- `baseUrl`: Points to your SAP Commerce Cloud server
- `prefix`: Defines the prefix to OCC calls; change `/rest/v2/` to `/occ/v2/` if using release 2005
- `features.level`: Defines the compatibility level
- `context`: Defines the site context such as base site, language, and currency. For example, to see the base site in the URL and add Apparel store support, change `context` to the following:
   ```
   context: {
     urlParameters: ['baseSite', 'language', 'currency'],
     baseSite: ['electronics-spa','apparel-uk-spa'],
     currency: ['USD', 'GBP',]
   },
   ```

### Starting your Spartacus app ###  

Start your app with the following command:

```
yarn start
```

Your app will be compiled and then started.

To display your storefront, assuming everything is installed locally, browse to `http://localhost:4200`. If you installed Electronics sample data and the Spartacus Sample Data extension, the Spartacus storefront for Electronics should appear.

Note: If your storefront doesn't appear, likely you have to accept a privacy certificate. To do so, browse to `https://localhost:9002/rest/v2/electronics/cms/pages`, and then accept the privacy certificate. This step is necessary because your browser will block calls to app will make calls to localhost:9002 due to security settings. To see the browser message, right-click in your browser, select Inspect, then click Console.

You can display the Apparel storefront through this URL: `http://localhost:4200/apparel-uk-spa/en-GBP`

Congratulations! You've built your first Spartacus storefront.


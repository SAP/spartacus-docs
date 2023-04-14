---
title: Contributor Setup
---

To contribute to Spartacus, you need to build and run Spartacus in development mode in the early phases of development, and then as your project gets closer to completion, you also need to build and run Spartacus in production mode. This guide shows how to get up and running with Spartacus, in both development mode and production mode, so that you can start contributing.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Prerequisites

Before carrying out the procedures below, please ensure the following front end and back end requirements are in place.

## Front End Requirements

{% include docs/frontend_requirements.html %}

## Back End Requirements

The Spartacus  Storefront uses SAP Commerce Cloud for its back end, and makes use of the sample data from the B2C Accelerator electronics storefront in particular.

For more information, see [{% assign linkedpage = site.pages | where: "name", "installing-sap-commerce-cloud.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/backend/installing-sap-commerce-cloud.md %}).

**Note:** The latest release of SAP Commerce Cloud is recommended.

## Getting the Source Code

To get started with contributing to Spartacus, clone the Spartacus GitHub repository on your local system using the following command:

```bash
git clone https://github.com/SAP/spartacus
```

## Installing the Dependencies

Install the npm dependencies. We recommend using [npm](https://npmjs.org/). The following command installs the dependencies using npm:

```bash
npm install
```

## Building and Running Spartacus in Development Mode

The simplest way to start contributing is to build Spartacus and run it in development mode.

### Configuring Your Back End URL and Base Site in Development Mode

Carry out the following steps before you build and launch.

1. Configure your back end URL in the `projects/storefrontapp/src/environments/environment.ts` file.

   The `environment.ts` file contains properties that are applied when the app is run in development mode.

2. Add your back end base URL to the `occBaseUrl` property, as follows:

   ```typescript
   export const environment = {
     occBaseUrl: "https://custom-backend-url",
   };
   ```

3. There are separate configuration files for B2C and B2B storefronts in Spartacus. B2C storefronts use the `spartacus-b2c-configuration-module.ts` configuration file, while B2B storefronts use the `spartacus-b2b-configuration-module.ts` configuration file. Depending on whether you are working with a B2C or a B2B setup, in the relevant configuration file, update the `baseSite` parameter to point to the base site(s) that you have configured in your back end.

   The following is an example:

   ```typescript
   context: {
     urlParameters: ['baseSite', 'language', 'currency'],
     baseSite: ['electronics-spa', 'apparel-de', 'apparel-uk'],
   },
   ```

### Running the Spartacus Storefront

Run the Spartacus storefront with the following command:

```bash
npm start
```

This is the most convenient way for a developer to run the storefront. It allows for hot-reloading of the library code as the code changes.

## Building and Running Spartacus in Production Mode

Building in production mode has more restrictive rules about what kind of code is allowed, but it also allows you to generate a build that is optimized for production. Use this mode as your development cycle nears completion.

### Building the Spartacus Libraries

In production mode, Spartacus is distributed as a set of libraries. To build the libraries, use the following command:

```bash
npm run build:libs
```

This will build all of the Spartacus libraries and place them under the `/dist` folder.

### Building the Spartacus Storefront Library

Contrary to development mode, in production mode you need to package and build a standalone storefront library. This is done with the following command:

```bash
npm run build
```

### Configuring Your Back End URL and Base Site in Production Mode

1. Configure your back end URL in the `projects/storefrontapp/environments/environment.prod.ts` file by adding your back end base URL to the `occBaseUrl` property. The following is an example:

   ```typescript
   export const environment = {
     occBaseUrl: "https://custom-backend-url"
   };
   ```

2. There are separate configuration files for B2C and B2B storefronts in Spartacus. B2C storefronts use the `spartacus-b2c-configuration-module.ts` configuration file, while B2B storefronts use the `spartacus-b2b-configuration-module.ts` configuration file. Depending on whether you are working with a B2C or a B2B setup, in the relevant configuration file, update `baseSite` parameter to point to the base site(s) that you have configured in your back end.

   The following is an example:

   ```typescript
   context: {
     urlParameters: ['baseSite', 'language', 'currency'],
     baseSite: ['electronics-spa', 'apparel-de', 'apparel-uk'],
   },
   ```

   **Note**: The base site and its context can also be detected automatically, based on URL patterns defined in the CMS. For more information, see [Automatic Multi-Site Configuration]({{ site.baseurl }}{% link _pages/dev/context/automatic-context-configuration.md %}).

### Launching the Spartacus Storefront

Launch the Spartacus storefront with the following command:

```bash
npm run start:prod
```

### Launching the Storefront with SSR (and PWA) Enabled

1. Build the server-side rendering (SSR) version of the app (that is, the production build wrapped in the `express.js` server), as follows:

   ```bash
   npm run build:ssr
   ```

2. Launch the SSR server as follows:

   ```bash
   npm run serve:ssr
   ```

The app will be served with the production build, without using the webpack dev server. As a result, PWA and the features related to service workers will be fully functional.

## Additional Storefront Configuration

In both development mode and production mode, the Spartacus storefront has default values for all of its configurations. However, you may need to override these values.

To configure the storefront, use the `provideConfig` method from `@spartacus/core`. The following is an example:

```typescript
@NgModule({
  imports: [
    BrowserModule,
    ...
  ],
  providers: [
    provideConfig(<OccConfig>{
      backend: {
        occ: {
          baseUrl: environment.occBaseUrl,
          prefix: environment.occApiPrefix,
        },
      },
    }),
    provideConfig(<RoutingConfig>{
      // custom routing configuration for e2e testing
      routing: {
        routes: {
          product: {
            paths: ['product/:productCode/:name', 'product/:productCode'],
            paramsMapping: { name: 'slug' },
          },
        },
      },
    }),
    provideConfig(<I18nConfig>{
      // we bring in static translations to be up and running soon right away
      i18n: {
        resources: translations,
        chunks: translationChunksConfig,
        fallbackLang: 'en',
      },
    provideConfig(<FeaturesConfig>{
      features: {
        level: '4.0',
      },
    }),
  ],
  bootstrap: [StorefrontComponent]
})
export class AppModule {}
```

The OCC back end `baseUrl` is pulled from the `environment.*.ts` file, but the rest of the properties in this example use the default values for the configurations. You do not have to specify a configuration if you do not need to override the default value.

For example, if you only need to override the `baseUrl` and the `client_secret`, and you want to use the default values for other properties, you can provide the following configuration:

```typescript
    provideConfig(<OccConfig>{
     backend: {
        occ: {
          baseUrl: environment.occBaseUrl,
        },
      },
      authentication: {
        client_secret: "secret",
      },
    }),
```

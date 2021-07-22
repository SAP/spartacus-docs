---
title: Contributor Setup
---

This guide shows how to get up and running on Spartacus by building it and running it both in development mode and in production mode so that you can start contributing.

---

## Table of Contents

- This will become a table of contents (this text will be scrapped).
  {:toc}

---

## Prerequisites

Before carrying out the procedures below, please ensure the following front end and back end requirements are in place.

## Front End Requirements

{% include docs/frontend_requirements.html %}

## Back End Requirements

The Spartacus Storefront uses SAP Commerce Cloud for its back end, and makes use of the sample data from the B2C Accelerator electronics storefront in particular.

For more information, see [{% assign linkedpage = site.pages | where: "name", "installing-sap-commerce-cloud.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/backend/installing-sap-commerce-cloud.md %}).

**Note:** The latest release of SAP Commerce Cloud is recommended.

## Getting the source code

The first step is to clone the Spartacus GitHub repository on your local system.

```bash
git clone https://github.com/SAP/spartacus
```

## Installing the Dependencies

Install the npm dependencies. (We recommend using [yarn](https://yarnpkg.com/) but you can also use `npm`):

```bash
yarn install
```

## Building and Running Spartacus in Development Mode

The simplest way to start contributing is to build Spartacus and run it is to work in development mode.

### Configuring Your Back End URL and Base Site

Carry out the following steps before you build and launch.

1. Configure your back end URL in the `projects/storefrontapp/src/environments/environment.ts` file.

   The `environment.ts` file contains properties that are applied when the app is run in development mode.

2. Add your back end base URL to the `occBaseUrl` property, as follows:

   ```typescript
   export const environment = {
     occBaseUrl: "https://custom-backend-url",
   };
   ```

3. There are separate config files for _B2C_ (`spartacus-b2c-configuration-module.ts`) and _B2B_ (`spartacus-b2b-configuration-module.ts`) modes in Spartacus. On the one that you will use, update `baseSite` parameter to point to the base site(s) that you have configured in your back end.

   The following is an example:

   ```typescript
   context: {
     urlParameters: ['baseSite', 'language', 'currency'],
     baseSite: ['electronics-spa', 'apparel-de', 'apparel-uk'],
   },
   ```

### Running Spartacus storefront

Run the Spartacus storefront with the following command:

```bash
yarn start
```

This is the most convenient way for a developer to run the storefront. It allows for hot-reloading of the library code as the code changes.

## Building and Running in Production Mode

Building in production mode has more restrictive rules about what kind of code is allowed, but it also allows you to generate a build that is optimized for production. Use this mode as your development cycle nears completion.

### Building the @spartacus/\* libraries

In production mode, Spartacus is distributed as a set of Libraries. To build the libraries, use the following command:

```bash
yarn build:libs
```

This will build all of the Spartacus libraries and place them under the `/dist` folder

### Building the @spartacus/storefront Library

Contrary to development mode, in production mode you need to package and build a standalone storefront library. This is done with the following command:

```bash
yarn build
```

### Configuring Your Backend URL and BaseSite

1. Configure your back end URL in the `projects/storefrontapp/environments/environment.prod.ts` file. Add your back end base URL to the `occBaseUrl` property, as follows:

   ```typescript
   export const environment = {
     occBaseUrl: "https://custom-backend-url",
   };
   ```

2. There are separate config files for _B2C_ (`spartacus-b2c-configuration-module.ts`) and _B2B_ (`spartacus-b2b-configuration-module.ts`) modes in Spartacus. On the one that you will use, update `baseSite` parameter to point to the base site(s) that you have configured in your back end.

   The following is an example:

   ```typescript
   context: {
     urlParameters: ['baseSite', 'language', 'currency'],
     baseSite: ['electronics-spa', 'apparel-de', 'apparel-uk'],
   },
   ```

   **Note**: The base site and its context can also be detected automatically, based on URL patterns defined in the CMS. For more information, see [Context Configuration]({{ site.baseurl }}/context-configuration/#automatic-context-configuration).

### Launching the Spartacus Storefront

Launch the Spartacus storefront with the following command:

```bash
yarn start:prod
```

### Launching the Storefront with SSR (and PWA) Enabled

1. Build the server-side rendering (SSR) version of the app (that is, the production build wrapped in the `express.js` server), as follows:

   ```bash
   yarn build:ssr
   ```

2. Launch the SSR server as follows:

   ```bash
   yarn serve:ssr
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

The occ back end `baseUrl` is pulled from the `environment.*.ts` file, but the rest of the properties in this example use the default values for the configs. You do not have to specify a config if you do not need to override the default value.

For example, if you only need to override the `baseUrl` and the `client_secret`, and want to use the default values for other properties, you can provide the following config:

```typescript
    provideConfig(<OccConfig>{
     backend: {
        occ: {
          baseUrl: environment.occBaseUrl,
          legacy: true,
        },
      },
      authentication: {
        client_secret: "secret",
      },
    }),
```

Note: The `legacy` has a default value of false if it is not included. This means that the cms components is using a `GET` request for anyone using `19.05 and above`. Overriding `legacy` to true will make sure you will be using the `POST` request instead. This is recommended for anyone using `18.11 and below`.

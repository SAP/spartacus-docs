---
title: Contributor Setup
---

To contribute to the Spartacus project, the first steps are to clone the Spartacus library sources, build, and then run the storefront from the library development workspace.

This guide shows how to build and run both in development mode and in production mode.

## Prerequisites

Before carrying out the procedures below, please ensure the following front end and back end requirements are in place.

## Front End Requirements

{% include docs/frontend_requirements.html %}

## Back End Requirements

The Spartacus JavaScript Storefront uses SAP Commerce Cloud for its back end, and makes use of the sample data from the B2C Accelerator electronics storefront in particular.

For more information, see [Installing SAP Commerce Cloud for use with Spartacus]({{ site.baseurl }}{% link _pages/install/backend/installing-sap-commerce-cloud.md %}).

**Note:** The latest release of SAP Commerce Cloud is recommended.

# Cloning the Sources

The first step is to clone the Spartacus GitHub repository on your local system.

# Installing the Dependencies.

Install the dependencies by running the following yarn command:

```bash
yarn install
```

# Building and Running in Development Mode

The simplest way to build and run from the source code is to work in development mode.

## Configuring Your Back End URL and Base Site

Carry out the following steps before you build and launch.

1. Configure your back end URL in the `projects/storefrontapp/src/environments/environment.ts` file.

   The `environment.ts` file contains properties that are applied when the app is run in development mode.

2. Add your back end base URL to the `occBaseUrl` property, as follows:

   ```typescript
   export const environment = {
     occBaseUrl: "https://custom-backend-url"
   };
   ```

3. In your `app.module.ts` file, update `baseSite` parameter to point to the base site(s) that you have configured in your back end.

   The following is an example:

   ```typescript
   context: {
     urlParameters: ['baseSite', 'language', 'currency'],
     baseSite: ['electronics-spa', 'apparel-de', 'apparel-uk'],
   },
   ```

## Launching the Storefront

Launch the storefront with the following command:

```bash
yarn start
```

This is the most convenient way for a developer to run the storefront. It allows for hot-reloading of the library code as the code changes.

# Building and Running in Production Mode

Building in production mode has more restrictive rules about what kind of code is allowed, but it also allows you to generate a build that is optimized for production. Use this mode as your development cycle nears completion.

## Building the @spartacus/storefront Library

Contrary to development mode, in production mode you need to package and build a standalone storefront library. This is done with the following command:

```bash
yarn build:core:lib
```

## Configuring Your Back End URL and Base Site

1. Configure your back end URL in the `projects/storefrontapp/environments/environment.prod.ts` file.

2. Add your back end base URL to the `occBaseUrl` property, as follows:

   ```typescript
   export const environment = {
     occBaseUrl: "https://custom-backend-url"
   };
   ```

3. In your `app.module.ts` file, update `baseSite` parameter to point to the base site(s) that you have configured in your back end.

   The following is an example:

   ```typescript
   context: {
     urlParameters: ['baseSite', 'language', 'currency'],
     baseSite: ['electronics-spa', 'apparel-de', 'apparel-uk'],
   },
   ```

   **Note**: The base site and its context can also be detected automatically, based on URL patterns defined in the CMS. For more information, see [Context Configuration]({{ site.baseurl }}/context-configuration/#automatic-context-configuration).

## Launching the Storefront

Launch the server with ng serve, as follows:

```bash
yarn start:prod
```

## Launching the Storefront with SSR (and PWA) Enabled

1. Build the server-side rendering (SSR) version of the app (that is, the production build wrapped in the `express.js` server), as follows:

   ```bash
   yarn build:ssr
   ```

2. Launch the SSR server as follows:

   ```bash
   yarn start:ssr
   ```

The app will be served with the production build, without using the webpack dev server. As a result, PWA and the features related to service workers will be fully functional.

# Additional Storefront Configuration

In both development mode and production mode, the Spartacus storefront has default values for all of its configurations. However, you may need to override these values.

To configure the storefront, use the `withConfig` method on the B2cStorefrontModule. The following is an example:

```typescript
@NgModule({
  imports: [
    BrowserModule,
    B2cStorefrontModule.withConfig({
      backend: {
        occ: {
          baseUrl: environment.occBaseUrl,
          prefix: '/rest/v2/',
          legacy: false
        }
      }
      authentication: {
        client_id: 'mobile_android',
        client_secret: 'secret'
      }
    }),
    ...devImports
  ],
  bootstrap: [StorefrontComponent]
})
export class AppModule {}
```

The occ back end `baseUrl` is pulled from the `environment.*.ts` file, but the rest of the properties in this example use the default values for the configs. You do not have to specify a config if you do not need to override the default value.

For example, if you only need to override the `baseUrl` and the `client_secret`, and want to use the default values for other properties, you can use the following config:

```typescript
@NgModule({
  imports: [
    BrowserModule,
    B2cStorefrontModule.withConfig({
      backend: {
        occ: {
          baseUrl: environment.occBaseUrl,
          legacy: true
        }
      },
      authentication: {
        client_secret: "secret"
      }
    }),
    ...devImports
  ],
  bootstrap: [StorefrontComponent]
})
export class AppModule {}
```

Note: The `legacy` has a default value of false if it is not included. This means that the cms components is using a `GET` request for anyone using `19.05 and above`. Overriding `legacy` to true will make sure you will be using the `POST` request instead. This is recommended for anyone using `18.11 and below`. 

---
title: Setup and Installation
permalink: /Setup-and-Installation/
---

If you're just getting started, see the document [Building the Spartacus Storefront from Libraries]({{ site.baseurl }}{% link pages/install/Building-the-Spartacus-Storefront-from-Libraries.md %}), which demonstrates step-by-step how to build a Spartacus-based storefront using the Spartacus libraries.

Spartacus requires a SAP Commerce Cloud backend. See [Installing SAP Commerce Cloud for use with Spartacus]({{ site.baseurl }}{% link pages/install/Installing-SAP-Commerce-Cloud.md %}) for information on setting up a sample backend.

Before carrying out the procedures below, please ensure the following front end and back end requirements are in place.

## Front End Requirements

Your Angular development environment should include the following:

- [Angular CLI](https://angular.io/): v7.3.7 or later, < v8.0.0
- node.js: v10 or later, < v12
- yarn: v1.15 or later

## Back End Requirements

The Spartacus JavaScript Storefront uses SAP Commerce Cloud for its back end, and makes use of the sample data from the B2C Accelerator electronics storefront in particular.

For more information, see [Installing SAP Commerce Cloud for use with Spartacus]({{ site.baseurl }}{% link pages/install/Installing-SAP-Commerce-Cloud.md %}). If you are not using the latest version of SAP Commerce Cloud, see [Working with Older Versions of SAP Commerce Cloud](https://github.com/SAP/cloud-commerce-spartacus-storefront/tree/develop/docs/archived_installation_docs) for installation instructions appropriate to your version.

Note: The latest release of SAP Commerce Cloud is recommended.

# Creating a New Angular Application

In the following procedure, we create a new Angular application with the name `mystore`.

1. Generate a new Angular application using the Angular CLI, as follows:

   ```bash
   ng new mystore --style=scss
   ```

2. When prompted if you would like add Angular routing, enter `y` for yes.

3. Access the newly created directory:
   ```bash
   cd mystore
   ```

# Adding Peer Dependencies to the Storefront

The dependencies in this procedure are required by the Spartacus storefront.

1. Add the following dependencies to the `dependencies` section of `mystore/package.json`:

   ```json
   "@angular/pwa": "^0.12.0",
   "@angular/service-worker": "~7.2.0",
   "@ng-bootstrap/ng-bootstrap": "^4.0.1",
   "@ng-select/ng-select": "^2.13.2",
   "@ngrx/effects": "~7.0.0",
   "@ngrx/router-store": "~7.0.0",
   "@ngrx/store": "~7.0.0",
   "bootstrap": "^4.1.3",
   "ngrx-store-localstorage": "^5.1.0",
   "i18next": "^15.0.6",
   "i18next-xhr-backend": "^2.0.1",
   ```

2. Install the dependencies. The following is an example using yarn:

   ```bash
   yarn install
   ```

# Adding the Storefront Dependencies

Add the Spartacus libraries to your storefront application. You can do so with yarn, as follows:

```bash
yarn add @spartacus/core
yarn add @spartacus/storefront
yarn add @spartacus/styles
yarn add @spartacus/assets
```

# Importing the Storefront Module into Your Application

1. Open `mystore/src/app/app.module.ts` and add the following line:

   ```typescript
   import { B2cStorefrontModule } from "@spartacus/storefront";
   ```

2. Add the `B2cStorefrontModule` to the import section of the `NgModule` decorator:

   ```typescript
   imports: [BrowserModule, AppRoutingModule, B2cStorefrontModule],
   ```

Your file should look like this:

```typescript
import { BrowserModule } from "@angular/platform-browser";
import { NgModule } from "@angular/core";

import { AppRoutingModule } from "./app-routing.module";
import { AppComponent } from "./app.component";
import { B2cStorefrontModule } from "@spartacus/storefront";

@NgModule({
  declarations: [AppComponent],
  imports: [BrowserModule, AppRoutingModule, B2cStorefrontModule],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule {}
```

# Configuring the Storefront

The Spartacus storefront has default values for all of its configurations. However, you may need to override these values. An example use case would be so that your storefront can communicate with your SAP Commerce back end.

To configure the storefront, use the `withConfig` method on the B2cStorefrontModule. The following is an example that uses the default values for the configs with the Electronics storefront served locally:

```typescript
  imports: [
    BrowserModule, B2cStorefrontModule.withConfig({
      backend: {
        occ: {
          baseUrl: 'https://localhost:9002',
          prefix: '/rest/v2/'
        }
      },
      authentication: {
        client_id: 'mobile_android',
        client_secret: 'secret'
      },
      site: {
        baseSite: 'electronics'
      }
    })
  ],
```

You do not have to specify a config if you do not need to override its value. For example, if you only need to override the back end base URL, you can use the following config:

```typescript
imports: [
  BrowserModule,
  B2cStorefrontModule.withConfig({
    backend: {
      occ: {
        baseUrl: "https://my-custom-backend-url:8080"
      }
    }
  })
];
```

## Configuring Translations

Spartacus includes predefined English translations of the texts that are used in components. Pass them into the configuration of the `B2cStorefrontModule`, as shown in the following example:

```typescript
import { translations } from '@spartacus/assets';
/* ... */

    B2cStorefrontModule.withConfig({
      /* ... */    ,
      i18n: {
        resources: translations
      }
    }
```

# Adding the Storefront Component

This procedure adds the storefront component in the UI.

1. Open `mystore/src/app/app.component.html` and replace the entire contents of the file with the following line:

   ```html
   <cx-storefront>Loading...</cx-storefront>
   ```

2. Import the styles from the `@spartacus/styles` library by opening `mystore/src/styles.scss` and adding the following line:

   ```scss
   @import "~@spartacus/styles/index";
   ```

# Building and Starting

This section describes how to validate your back end installation, and then start the application with the storefront enabled.

## Validating the Back end

1. Use a web browser (Chrome is highly recommended) to access the CMS OCC endpoint of your back end.

   The default is available at: `{server-base-url}/rest/v2/electronics/cms/pages`.

   For example, with a back end instance running from `https://localhost:9002`, you would access: https://localhost:9002/rest/v2/electronics/cms/pages.

2. Accept the security exception in your browser if you are running a development instance with a self-signed HTTPS certificate.

   When the request works, you see an XML response in your browser.

## Starting the Storefront Application

1. Start the application with the storefront enabled, as follows:

   ```bash
   ng serve
   ```

2. When the app server is properly started, point your browser to http://localhost:4200, as instructed from the terminal output of `ng serve`.

# Known Issues

The following are known issues with the current release of Spartacus JavaScript Storefront:

- Certain AddOns may cause the Spartacus storefront to not work properly.

- Spartacus relies on the `cmsoccaddon` for CMS information. However, this extension is currently not fully compatible with SmartEdit. As a result, the categories may not appear in Spartacus. To avoid this problem, remove the SmartEdit CMS web services and personalization extensions.

- You may notice that the logo is very small. This can be fixed as follows:

  1.  Log in to SAP Commerce Backoffice.

  2.  Select `WCMS` in the left-hand navigation pane, then select the `Component` child node that appears below.

  3.  Search for the term `SiteLogoComponent` in the Search box in the top-center panel.

      You can modify the component directly in the Online Catalog, or you can modify it in the Staged Catalog and then perform a sync.

  4.  Open the `Administration` tab of the SiteLogoComponent, and remove the `Media` value.

  5.  Click the button labelled `...` next to the `Media` field.

  6.  In the pop-up search box that appears, search for the desired media file in your system and select it.

  7.  Save your changes

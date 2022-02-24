---
title: Updating to Version 4.0
---

**NOTE:**  We strongly recommend you upgrade your FSA Spartacus libraries to version 3.0.1 first, and then upgrade to version 4.0.0.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***


## Upgrading FSA Spartacus Libraries from Version 3.0.0 to 3.0.1


## Overview

Patch version 3.0.1 of FSA Spartacus Libraries contains a fix related to missing dependencies detected in version 3.0.0.


### Prerequisites

Before upgrading your FSA Spartacus libraries to version 3.0.1, you must address the following prerequisites:

- Make sure all of your `@spartacus` libraries are upgraded to **Spartacus 3.4.0**. 
- Note that this version of Spartacus requires **Angular version 10.2.4**. 
If your Angular version is <10.2.4, you must update it before updating Spartacus. 
For more information, see the official [Angular Update Guide](https://update.angular.io/).
  

### Updating FSA Spartacus

1. Depending on whether you use yarn or npm for installations, delete `yarn.lock` file or `package-lock.json` file from your project.

2. Go to the `package.json` file at the root of your project and make sure you have the following versions of Spartacus libraries:

    ```shell
    "@spartacus/assets": "^3.4.0",
    "@spartacus/core": "^3.4.0",
    "@spartacus/organization": "3.4.0",
    "@spartacus/storefinder": "^3.4.0",
    "@spartacus/storefront": "3.4.0",
    "@spartacus/user": "3.4.0",
    "@spartacus/styles": "^3.4.0",
    ```
   
3. Upgrade FSA Spartacus libraries:  
   
     ```shell
     "@spartacus/dynamicforms": "^3.0.1",
     "@spartacus/fsa-storefront": "^3.0.1",
     "@spartacus/fsa-styles": "^3.0.1",
     ```

5. To complete the update, run the following commands:

    ```shell
    yarn install
    yarn start
    ```

***
   
**NOTE**: If you get errors related to font-icons, perform the following steps:

1. Run the following command:

    `ng add @spartacus/fsa-schematics --baseSite=sample-financial-site --currency=usd,eur --language=en,de,fr`

2. When prompted, enter your base site URL (that is, your back-end server URL).

3. After that, you should be able to run `ng serve` or `yarn start` without any errors.

***

   
## Upgrading FSA Spartacus Libraries from Version 3.0.1 to 4.0.0


### Prerequisites

Before upgrading your FSA Spartacus libraries to version 4.0.0, you must address the following prerequisites:

- **Angular CLI**: Version [12.0.5](https://update.angular.io/) or later
- **node.js**: Version 14.18.1 or later
- **Spartacus**: Minimum version [4.0](https://sap.github.io/spartacus-docs/updating-to-version-4/), the latest minor/patch version is recommended.

**NOTE**: In order for this upgrade to proceed without any errors, you need to have the new Spartacus app directory structure in place. 
Simply changing the version in `package.json` file is not enough. 
For instructions on how to create new app directory structure, see [Spartacus documentation](https://sap.github.io/spartacus-docs/updating-to-version-4/).

### Specifying configuration options for FSA Spartacus

Once you have created new App directory structure as described in the previous step, you need to specify configuration options necessary for FSA. This configuration should be declared after all other Spartacus modules and should contain the following:

```ts
provideConfig(<OccConfig | SiteContextConfig>{
    backend: {
    occ: {
        prefix: '/occ/v2/',
        baseUrl: '/--path to the server--/',
    },
    },
    context: {
    baseSite: ['financial'],
    language: ['en', 'de'],
    currency: ['EUR'],
    urlParameters: ['baseSite', 'language', 'currency'],
    },
    authentication: {
    client_id: 'financial_customer',
    client_secret: 'secret',
    },
    features: {
    consignmentTracking: true,
    },
}),
```

### Updating FSA Spartacus

1. Depending on whether you use yarn or npm for installations, delete `yarn.lock` file or `package-lock.json` file from your project.

2. Go to the `package.json` file at the root of your project and replace existing dependencies with the following:

    ```shell
    "dependencies": {
    "@angular/animations": "~12.0.5",
    "@angular/common": "~12.0.5",
    "@angular/compiler": "~12.0.5",
    "@angular/core": "~12.0.5",
    "@angular/forms": "~12.0.5",
    "@angular/platform-browser": "~12.0.5",
    "@angular/platform-browser-dynamic": "~12.0.5",
    "@angular/platform-server": "~12.0.5",
    "@angular/pwa": "~12.0.5",
    "@angular/router": "~12.0.5",
    "@angular/service-worker": "~12.0.5",
    "@compodoc/compodoc": "^1.1.10",
    "@ng-bootstrap/ng-bootstrap": "~10.0.0",
    "@ng-select/ng-select": "~7.0.1",
    "@ngrx/effects": "~12.1.0",
    "@ngrx/router-store": "~12.1.0",
    "@ngrx/store": "~12.1.0",
    "@nguniversal/express-engine": "~12.0.2",
    "@spartacus/dynamicforms": "4.0.0",
    "@spartacus/fsa-storefront": "4.0.0",
    "@spartacus/fsa-styles": "3.0.0",
    "@spartacus/asm": "4.2.1",
    "@spartacus/assets": "4.2.0",
    "@spartacus/cart": "4.2.1",
    "@spartacus/cds": "4.2.1",
    "@spartacus/checkout": "4.2.1",
    "@spartacus/core": "4.3.0",
    "@spartacus/digital-payments": "4.2.1",
    "@spartacus/organization": "4.2.1",
    "@spartacus/product": "4.2.1",
    "@spartacus/product-configurator": "4.2.1",
    "@spartacus/smartedit": "4.2.1",
    "@spartacus/storefinder": "4.2.1",
    "@spartacus/storefront": "4.2.0",
    "@spartacus/styles": "4.2.1",
    "@spartacus/tracking": "4.2.1",
    "@spartacus/user": "4.2.1",
    "@syncpilot/bpool-guest-lib": "^0.2.6",
    "@types/googlemaps": "^3.37.5",
    "angular-oauth2-oidc": "~10.0.1",
    "blob-util": "^2.0.2",
    "bootstrap": "^4.3.1",
    "comment-json": "^4.1.0",
    "echarts": "^5.0.2",
    "express": "^4.15.2",
    "file-saver": "^2.0.2",
    "hamburgers": "^1.1.3",
    "i18next": "^20.2.2",
    "i18next-http-backend": "^1.2.2",
    "i18next-xhr-backend": "^3.2.2",
    "ngx-echarts": "^6.0.1",
    "ngx-infinite-scroll": "^8.0.0",
    "parse5": "^6.0.1",
    "resize-observer-polyfill": "^1.5.1",
    "rxjs": "^6.6.0",
    "ts-loader": "^6.0.4",
    "tslib": "^2.3.0",
    "zone.js": "~0.11.4"
    ```

3. To complete the update, run the following commands:

    ```shell
    yarn install
    yarn start
    ```

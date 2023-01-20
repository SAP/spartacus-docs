---
title: Updating TUA Spartacus to Version 2.0
---

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Prerequisites

Before updating your TUA Spartacus libraries to version 2.0, you must address the following prerequisites:

- You must first upgrade all of your `@spartacus` libraries to the latest 1.5.x release before you begin upgrading to Spartacus 2.0. For more information, see [Upgrading TUA Spartacus Libraries to a New Minor Version](#upgrading-tua-spartacus-libraries-to-a-new-minor-version).
- You also must first upgrade all of your `@spartacus/tua-spa` to the latest 1.5.x release before you begin upgrading to Spartacus 2.0
- Your `@spartacus` libraries must include the `@spartacus/schematics` library. If you do not have the `@spartacus/schematics` library, add it to your `package.json` file in the `devDependencies` section, and set it to the same version as your other `@spartacus` libraries. Then run `yarn install`.
- Spartacus 2.0 requires Angular version 9. You must update Angular before updating Spartacus. For more information, see [Updating to Angular version 9](https://update.angular.io/).

## Updating TUA Spartacus

TUA Spartacus 2.0 includes new features and fixes. Since this update is a major release, some of the updates may also be breaking changes for your application. In this case, additional work on your side may be required to fix issues that result from upgrading from 1.x to 2.0.

To update to version 2.0 of TUA Spartacus, run the following command in the workspace of your Angular application:

```shell
ng update @spartacus/schematics
```

## Upgrading TUA Spartacus Libraries to a New Minor Version

You can upgrade your TUA Spartacus libraries to a new minor version, as follows:

1. In `package.json`, set your `@spartacus` libraries to `“~2.#.0"`, where `#` is replaced with the release version number you wish to upgrade to.

   **Note:** If you are upgrading from 1.x to the latest 1.5 release, then upgrade to 2.x, in `package.json`, set your `@spartacus` libraries to `“~1.5.5"`.

1. Make sure other entries in `package.json` match with the following configuration (Add the entries if not available).

    ```bash
   "@angular/localize":"^9.1.0",    
    "@angular/service-worker": "~9.1.0",
    "@ng-bootstrap/ng-bootstrap": "6.0.0",
    "@ng-select/ng-select": "^4.0.0",
    "@ngrx/effects": "~9.0.0",
    "@ngrx/router-store": "~9.0.0",
    "@ngrx/store": "~9.0.0",
    "bootstrap": "^4.2.1",
    "chart.js": "^2.9.3",
    "express": "^4.15.2",
    "i18next": "^19.3.4",
    "i18next-xhr-backend": "^3.2.2",
    "material-design-icons": "^3.0.1",
    "ng2-charts": "^2.3.2",
    "ngx-infinite-scroll": "^8.0.0",
    "ngx-spinner": "^9.0.1",
    "jquery": "^3.5.1"
    ```

1. Inspect the `mystore/src/app/app.module.ts` file for any changes you want to make for your setup.
    - Remove the `premiseLookup` entry from the backend section if present.
    - Remove `saveForLater: false` from features section if present.
    - Remove the `utilitiesspa` entry from the `baseSite` list under the section context.
    - Update level under the features section to 2.0.0.
  
1. Add the following import `/mystore/src/polyfills.ts` in the file:

    ```bash
    import '@angular/localize/init';    
    import 'zone.js/dist/zone';    
    ```

1. Add the following entry `/mystore/tsconfig.json` in the `mystore/src/app/app.module.ts` file if not already available:

    ```bash
    “enableIvy”: false        
    ```

1. Delete your `node_modules` folder.
1. Run `yarn install`.

For more information, see [Technical Changes in TUA Spartacus 2.0]({{ site.baseurl }}{% link _pages/telco/technical-changes-tua-version-2.md %}).

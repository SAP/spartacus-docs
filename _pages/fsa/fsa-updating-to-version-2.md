---
title: Updating FSA Spartacus to Version 2.0
---

## Prerequisites

Before upgrading your FSA Spartacus libraries to version 2.0, you must address the following prerequisites:

- Spartacus 3.0 requires Angular version 10. You must update Angular before updating Spartacus. For more information, see [Updating to Angular version 10](https://update.angular.io/).

- You must first upgrade all of your `@spartacus` libraries to Spartacus 3.0.  

## Updating FSA Spartacus

1. Go to the `package.json` at the root of your project and upgrade FSA SPA versions:  

    ```shell
    "@spartacus/fsa-schematics": "^2.0.0",
    "@spartacus/dynamicforms": "^2.0.0",
    "@spartacus/fsa-storefront": "^2.0.0",
    "@spartacus/fsa-styles": "^2.0.0",
    ```

2. Upgrade the Spartacus versions:

    ```shell
    "@spartacus/assets": "^3.0.0",
    "@spartacus/core": "^3.0.0",
    "@spartacus/styles": "^3.0.0",
    ```

3. Add new dependencies from Spartacus 3.0:

    ```shell
    "@spartacus/storefinder": "^3.0.0",
    "angular-oauth2-oidc": "^10.0.0",
    ```

4. Open the `src\app\app.module.ts` file and remove the following:

    ```shell
    StoreModule.forRoot({}, {
          runtimeChecks: {
            strictStateImmutability: false,
            strictActionImmutability: false,
          },
        }),
    ```

5. To complete the update, run the following commands:

    ```shell
    yarn install
    yarn start
    ```

You have now successfully updated your FSA Spartacus app.

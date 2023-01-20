---
title: Updating FSA Spartacus to Version 3.0
---

## Prerequisites

Before upgrading your FSA Spartacus libraries to version 3.0, you must address the following prerequisites:

- Upgrade all of your `@spartacus` libraries to Spartacus 3.4. 
Note that Spartacus 3.4 requires Angular version 10. If your Angular version is <10, you must update it before updating Spartacus. For more information, see [Updating to Angular version 10](https://update.angular.io/).
  

## Updating FSA Spartacus

1. Go to the `package.json` at the root of your project and upgrade Spartacus libraries:

    ```shell
    "@spartacus/assets": "^3.4.0",
    "@spartacus/core": "^3.4.0",
    "@spartacus/storefinder": "^3.4.0",
    "@spartacus/styles": "^3.4.0",
    ```
   
2. Add new dependencies from Spartacus:

    ```shell
    "@spartacus/storefront": "3.4.0",
    "@spartacus/organization": "3.4.0",
    "@spartacus/user": "3.4.0",
    ```
   
3. Upgrade FSA Spartacus libraries:  
   
     ```shell
     "@spartacus/fsa-schematics": "^3.0.0",
     "@spartacus/dynamicforms": "^3.0.0",
     "@spartacus/fsa-storefront": "^3.0.0",
     "@spartacus/fsa-styles": "^3.0.0",
     ```
4. Add new FSA dependencies: 

   ```shell
   "echarts": "^5.0.2",
   "ngx-echarts": "^6.0.1",
   ```

5. To complete the update, run the following commands:

    ```shell
    yarn install
    yarn start
    ```

You have now successfully updated your FSA Spartacus app.

---
title: Workaround for Issue with Server-Side Rendering in Spartacus 2.0 or later and SAP Commerce Cloud for Public Cloud
---

This document describes a temporary workaround for a problem with running Spartacus 2.0 or later with Server-Side Rendering (SSR) on SAP Commerce Cloud in the Public Cloud. 

## Overview

As of this writing (December 2020), Spartacus 2.0 or later, with SSR, does not work out of the box with SAP Commerce Cloud in the Public Cloud. This is because the hosting service expects a predefined structure for building Angular applications based on Angular 8 and ng-universal 8, which is used by Spartacus 1.x. However, Spartacus 2.0/3.0 use Angular 9/10, which has a slightly different file structure.

This problem will be fixed in a release of SAP Commerce Cloud in the Public Cloud, expected early 2021. For the moment, use the following workaround for Spartacus 2.0 or later with SSR when hosting with SAP Commerce Cloud in the Public Cloud.

## Workaround

With the following changes, the Angular build process is modified to match the structure expected by SAP Commerce Cloud in the Public Cloud.

**Note:**  In the following steps, substitute "APPNAME" with the name of your app.

1. In `angular.json`, make the following changes:
    - Change  `"outputPath": "dist/APPNAME/browser"` to `"outputPath": "dist/APPNAME"`
    - Change  `"outputPath": "dist/APPNAME/server"` to `"outputPath": "dist/APPNAME-server"`
  
2. In `server.ts`, the following appears:

   ```plaintext
   const distFolder = join(process.cwd(), 'dist/APPNAME/browser');
   ```

   Change this to the following:
   ```plaintext
   const distFolder = join(process.cwd(), 'dist/APPNAME');
   ```

3. In `package.json`, add the following  command to the end of the `build:ssr` script.

   ```plaintext
   && mv dist/APPNAME-server/main.js dist/server.js || move dist\\APPNAME-server\\main.js dist\\server.js"
   ```

   The final `build:ssr` might appear as follows:
  
   ```plaintext
   "build:ssr": "ng build --prod && ng run mystore:server:production && mv dist/APPNAME-server/main.js dist/server.js || move dist\\APPNAME-server\\main.js dist\\server.js"
   ```

A bit of explanation for this last step:

- The hosting automation service expects a `server.ts` file in the `dist` folder, instead of `main.ts` in the ssr app folder. To fulfill this requirement, after the build is complete, the `dist/APPNAME-server/main.ts` file is moved to the `dist` folder and renamed to `server.ts`.
- To ensure the move command works on Windows computers, both `mv` and `move` are used, separated by `||`, in case `mv` fails.

## Further Reading

For more information on deploying SAP Commerce Cloud in the Public Cloud, see [SAP Commerce Cloud in the Public Cloud](https://help.sap.com/viewer/product/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/SHIP/en-US) on the SAP Help Portal.

For information specific to deploying JavaScript storefronts in SAP Commerce Cloud in the Public Cloud, see [JavaScript Storefronts](https://help.sap.com/viewer/b2f400d4c0414461a4bb7e115dccd779/SHIP/en-US/d1a3de28d67c4a418eabbba532238f9b.html) on the SAP Help Portal.

To follow the upcoming updates that will make SSR work without modification, see [Spartacus GitHub Issue 7993](https://github.com/SAP/spartacus/issues/7993).

## Support

If you need help with this specific issue (Spartacus 2.0 or later with SSR on hosted SAP Commerce Cloud in the Public Cloud), contact Bill Marcotte through the [Spartacus Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ).

For general support, search for Spartacus answers on [Stack Overflow](https://stackoverflow.com/search?q=spartacus-storefront), or add a new question using the *spartacus-storefront* tag.

---
title: Solution for Issue with Server-Side Rendering in Spartacus 2.0 or later and SAP Commerce Cloud for Public Cloud
---

This document describes how to resolve a problem with running Spartacus 2.0 or later with Server-Side Rendering (SSR) on SAP Commerce Cloud in the Public Cloud.

The problem has been resolved with a new `manifest.json` format that is described below. It is strongly recommended that you update your `manifest.json` so that you no longer need to use the workaround.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Resolving the Issue

The workaround is no longer required if your `manifest.json` is structured as follows:

```json
  "applications": [
      {
          "name": "<your storefrontapp name>",
          "path": "<your storefrontapp path>",
          "ssr": {
               "enabled": true,
               "path": "dist/<your storefrontapp name>/server/main.js"
          },
          "csr": {
               "webroot": "dist/<your storefrontapp name>/browser/"
          }
      }
  ]
```

By adding the `csr` section with the `webroot` path, the hosting service is able to resolve your front end file. The path presented here is based on the Angular default configuration, but you can customize it in the `angular.json` file.

**Note:** If you are updating your `manifest.json` from an older version and you applied a workaround, make sure to remove the workaround before deploying again.

## Previous Workarounds

**Note:** These workarounds are no longer needed because the issue can be resolved with a new `manifest.json` format, as described above. The following information is for reference purposes only.

Prior to the current solution (see above), you would choose a workaround depending on whether the `manifest.json` of your js-app used the new manifest format or the old manifest format.

### Workaround for the New Manifest Format

Use this workaround if the `manifest.json` of your js-app looks like the following example:

```json
  "applications": [
      {
          "name": "<your storefrontapp name>",
          "path": "<your storefrontapp path>",
          "ssr": {
                "enabled": true,
                "path": "dist/<your storefrontapp name>/server/main.js"
          }
      }
  ]
```

For more information on how to structure your manifest, see [Enabling Server-Side Rendering](https://help.sap.com/viewer/b2f400d4c0414461a4bb7e115dccd779/LATEST/en-US/cd5b94c25a68456ba5840f942f33f68b.html) on the SAP Help Portal.

With the following changes, the Angular build process is modified to match the browser structure that is expected by SAP Commerce Cloud in the Public Cloud.

**Note:** In the following steps, substitute `APPNAME` with the name of your app.

### Applying the Workaround for the New Manifest Format

1. In `angular.json`, the following appears:

   ```json
   "outputPath": "dist/APPNAME/browser"
   ```

   Change this to the following:

   ```json
   "outputPath": "dist/APPNAME"
   ```

   **Note:** The `outputPath` must match the path in your `manifest.json`.

2. In `server.ts`, the following appears:

   ```ts
   const distFolder = join(process.cwd(), 'dist/APPNAME/browser');
   ```

   Change this to the following:

   ```ts
   const distFolder = join(process.cwd(), 'dist/APPNAME');
   ```

### Workaround for the Old Manifest Format

Use this workaround if the `manifest.json` of your js-app looks like the following example:

```json
  "applications": [
      {
          "name": "<your storefrontapp name>",
          "path": "<your storefrontapp path>",
          "enableSSR": true
      }
  ]
```

**Note** This manifest format is still supported, but you may want to consider moving to the new format to be more future-proof.

With the following changes, the Angular build process is modified to match the structure that is expected by SAP Commerce Cloud in the Public Cloud.

**Note:** In the following steps, substitute "APPNAME" with the name of your app.

### Applying the Workaround for the Old Manifest Format

1. In `angular.json`, the following appears:

   ```json
   "outputPath": "dist/APPNAME/browser"
   ```

   Change this to the following:

   ```json
   "outputPath": "dist/APPNAME"
   ```

2. In `angular.json`, the following appears:

   ```json
   "outputPath": "dist/APPNAME/server"
   ```

   Change this to the following:

   ```json
   "outputPath": "dist/APPNAME-server"
   ```

3. In `server.ts`, the following appears:

   ```ts
   const distFolder = join(process.cwd(), 'dist/APPNAME/browser');
   ```

   Change this to the following:

   ```ts
   const distFolder = join(process.cwd(), 'dist/APPNAME');
   ```

4. In `package.json`, add the following command to the end of the `build:ssr` script:

   ```text
   && mv dist/APPNAME-server/main.js dist/server.js || move dist\\APPNAME-server\\main.js dist\\server.js"
   ```

   The final `build:ssr` might appear as follows:

   ```text
   "build:ssr": "ng build --prod && ng run mystore:server:production && mv dist/APPNAME-server/main.js dist/server.js || move dist\\APPNAME-server\\main.js dist\\server.js"
   ```

   The hosting automation service expects a `server.js` file in the `dist` folder, instead of `main.js` in the ssr app folder. To fulfill this requirement, after the build is complete, the `dist/APPNAME-server/main.js` file is moved to the `dist` folder and renamed to `server.js`.

   Also, to ensure the move command works on Windows computers, both `mv` and `move` are used, separated by `||`, in case `mv` fails.

## Further Reading

For more information on deploying SAP Commerce Cloud in the Public Cloud, see [SAP Commerce Cloud in the Public Cloud](https://help.sap.com/viewer/product/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/LATEST/en-US) on the SAP Help Portal.

For information specific to deploying JavaScript storefronts in SAP Commerce Cloud in the Public Cloud, see [JavaScript Storefronts](https://help.sap.com/viewer/b2f400d4c0414461a4bb7e115dccd779/LATEST/en-US/d1a3de28d67c4a418eabbba532238f9b.html) on the SAP Help Portal.

To follow the upcoming updates that will make SSR work without modification, see [Spartacus GitHub Issue 7993](https://github.com/SAP/spartacus/issues/7993).

## Support

If you need help with this specific issue (Spartacus 2.0 or later with SSR on hosted SAP Commerce Cloud in the Public Cloud), contact Bill Marcotte through the [Spartacus Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ).

For general support, search for Spartacus answers on [Stack Overflow](https://stackoverflow.com/search?q=spartacus-storefront), or add a new question using the *spartacus-storefront* tag.

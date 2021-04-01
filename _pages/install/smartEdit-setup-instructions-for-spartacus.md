---
title: SmartEdit Setup Instructions for Spartacus
feature:
- name: SmartEdit for Spartacus
  spa_version: 1.0
  cx_version: 1905
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

## Prerequisites

For Spartacus to work with SmartEdit, you need SAP Commerce Cloud 1905 (or newer) with the `spartacussampledata` installed.

## Configuring SmartEdit to Work With a Spartacus Storefront

The SmartEdit feature library is introduced with version 3.2 of the Spartacus libraries, and as a result, the steps for configuring SmartEdit to work with Spartacus are different, depending on whether or not you are using the SmartEdit feature library.

### Configuring SmartEdit to work with Spartacus 3.2 or Newer

The following steps are for configuring SmartEdit to work using the SmartEdit feature library.

1. Build your Angular app, adding Spartacus libraries as normal.

   Make sure the app is working before continuing. For more information, see [Building the Spartacus Storefront from Libraries]({{ site.baseurl }}{% link _pages/install/building-the-spartacus-storefront-from-libraries.md %}).

1. Install the SmartEdit feature library by running the following schematics command:

   ```bash
   ng add @spartacus/smartedit
   ```

   If you install the SmartEdit library manually (that is, without schematics), then you also need to either copy the `webApplicationInjector.js` file from `node_modules/@spartacus/smartedit/assets` to your application's asset folder, or else add `node_modules/@spartacus/smartedit/assets` into the `assets` array in `angular.json`, as shown in the following example:

   ```ts
      {
         "glob": "**/*",
         "input": "node_modules/@spartacus/smartedit/assets",
         "output": "assets/"
      }
   ```

1. Add the following SmartEdit configuration to your application:

   ```ts
      smartEdit: {
         storefrontPreviewRoute: 'cx-preview',
         allowOrigin: 'localhost:9002',
      }
   ```

   The default values for `storefrontPreviewRoute` and `allowOrigin` can be modified as required.

1. Ensure that the **WCMS Cockpit Preview URL** is set correctly by carrying out the following steps:

   - In Backoffice, in **WCMS > Website > *your site***, click the **WCMS Properties** tab.
   - Set the **WCMS Cockpit Preview URL** to match your Spartacus web site. For example, if you go to `https://localhost:4200`, you will see the default URL path (or context), such as `https://localhost:4200/en/USD`. The Preview URL must match what the default context uses, or errors will occur when using SmartEdit. The default context installed by Spartacus schematics is `https://localhost:4200/en/USD`.

1. Ensure that the Spartacus site is allowlisted in SmartEdit. The following is one example of how you can do this:

   - Sign in to SmartEdit as the admin user.
  
   - Click the Settings icon in the top right.
  
   - In the Configuration Editor, scroll down to `whiteListedStorefronts` and add the exact URL of your Spartacus storefront. For this example, it is `["https://localhost:4200"]`.

   For more information, see [Adding Storefronts to the Allowlist of Permitted Domains in the Configuration Editor](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/e954737efc4d4d72b090d7e27b005191.html) on the SAP Help Portal.
  
1. Start your Angular app in SSL mode, as follows:

   ```plaintext
   yarn start --ssl
   ```

   By starting your app in SSL mode, you avoid an `unsafe scripting` message from the browser.

   **Note:** If you start your application without using SSL mode, the two references to `https://localhost:4200` must be changed to `http://localhost:4200`.

### Configuring SmartEdit to work with Spartacus 3.1 or Older

The following steps are for configuring SmartEdit to work without the SmartEdit feature library.

1. Build your Angular app, adding Spartacus libraries as normal.

   Make sure the app is working before continuing. For more information, see [Building the Spartacus Storefront from Libraries]({{ site.baseurl }}{% link _pages/install/building-the-spartacus-storefront-from-libraries.md %}).

1. Copy the `webApplicationInjector.js` SmartEdit file to the `src` folder of your Angular app.

   This file can be found in your SAP Commerce Cloud installation in the following folder:

   ```plaintext
   hybris/bin/modules/smartedit/smarteditaddon/acceleratoraddon/web/webroot/_ui/shared/common/js/webApplicationInjector.js
   ```

1. In the root folder of your Angular app, edit the `angular.json` file by adding `src/webApplicationInjector.js` to `architect > build > option > assets`. The following is an example:

   ```json
   "architect": {
   "build": {
   "builder": "@angular-devk  build-angular:browser",
   "options": {
      "outputPath": "dist/mystore",
      "index": "src/index.html",
      "main": "src/main.ts",
       "polyfills": "src/polyfills.ts",
       "tsConfig": "src/tsconfig.app.json",
      "assets": [
         "src/favicon.ico",
         "src/assets",
         "src/webApplicationInjector.js"
         ],
      ...
   ```

1. In the `HEAD` section of `src/index.html`, add the following line:

      ```html
      <script id="smartedit-injector" src="webApplicationInjector.js" data-smartedit-allow-origin="localhost:9002"></script>
      ```

      Replace `localhost:9002` with the domain of your server.

      This line tells SmartEdit that Spartacus is allowed to be edited by SmartEdit.

1. Ensure that the **WCMS Cockpit Preview URL** is set correctly by carrying out the following steps:

   - In Backoffice, in **WCMS > Website > *your site***, click the **WCMS Properties** tab.
   - Set the **WCMS Cockpit Preview URL** to match your Spartacus web site. For example, if you go to `https://localhost:4200`, you will see the default URL path (or context), such as `https://localhost:4200/en/USD`. The Preview URL must match what the default context uses, or errors will occur when using SmartEdit. The default context installed by Spartacus schematics is `https://localhost:4200/en/USD`.

1. Ensure that the Spartacus site is allowlisted in SmartEdit. The following is one example of how you can do this:

   - Sign in to SmartEdit as the admin user.
  
   - Click the Settings icon in the top right.
  
   - In the Configuration Editor, scroll down to `whiteListedStorefronts` and add the exact URL of your Spartacus storefront. For this example, it is `["https://localhost:4200"]`.

   For more information, see [Adding Storefronts to the Allowlist of Permitted Domains in the Configuration Editor](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/e954737efc4d4d72b090d7e27b005191.html) on the SAP Help Portal.
  
1. Start your Angular app in SSL mode, as follows:

   ```plaintext
   yarn start --ssl
   ```

   By starting your app in SSL mode, you avoid an `unsafe scripting` message from the browser.

   **Note:** If you start your application without using SSL mode, the two references to `https://localhost:4200` must be changed to `http://localhost:4200`.

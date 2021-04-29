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

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Prerequisites

For Spartacus to work with SmartEdit, you need SAP Commerce Cloud 1905 (or newer) with the `spartacussampledata` installed.

## Configuring SmartEdit to Work With a Spartacus Storefront

The SmartEdit feature library is introduced with version 3.2 of the Spartacus libraries, and as a result, there are steps for [Configuring SmartEdit to work with Spartacus 3.2 or Newer](#configuring-smartedit-to-work-with-spartacus-32-or-newer), and steps for [Configuring SmartEdit to work with Spartacus 3.1 or Older](#configuring-smartedit-to-work-with-spartacus-31-or-older).

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

1. Update the SmartEdit configuration in your application if you want to replace the default values, which are shown in the following example:

   ```ts
   export const defaultSmartEditConfig: SmartEditConfig = {
      smartEdit: {
         storefrontPreviewRoute: 'cx-preview',
         allowOrigin: 'localhost:9002',
      },
   };
   ```

   If you want to change the value of `storefrontPreviewRoute` or `allowOrigin`, you can replace the default configuration by adding the following to your application:

   ```ts
   provideConfig(<SmartEditConfig>{
      smartEdit: {
        storefrontPreviewRoute: 'your-preview-route-value',
        allowOrigin: 'your-origin',
      },
    })
   ```

1. Ensure that the **WCMS Cockpit Preview URL** is set correctly by carrying out the following steps:

   - In Backoffice, in **WCMS > Website > *your site***, click the **WCMS Properties** tab.
   - Set the **WCMS Cockpit Preview URL** to match your Spartacus web site. (SmartEdit opens the preview URL in its iframe.)

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
         
      ```

1. In the `HEAD` section of `src/index.html`, add the following line:

      ```html
      <script id="smartedit-injector" src="webApplicationInjector.js" data-smartedit-allow-origin="localhost:9002"></script>
      ```

      Replace `localhost:9002` with the domain of your server.

      This line tells SmartEdit that Spartacus is allowed to be edited by SmartEdit.

1. Ensure that the **WCMS Cockpit Preview URL** is set correctly by carrying out the following steps:

   - In Backoffice, in **WCMS > Website > *your site***, click the **WCMS Properties** tab.
   - Set the **WCMS Cockpit Preview URL** to match your Spartacus web site. (SmartEdit opens the preview URL in its iframe.)

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

## Troubleshooting

When you are in SmartEdit, if you have not opened any actual Spartacus pages (such as the Homepage), then any issues you might encounter are not caused by Spartacus. For example, on the **Your Site** page, Spartacus is not actually opened on this page. If you see an issues (such as the site list not containing any base sites), please contact the SmartEdit team for help.

### The Perspective Toolbar is Missing

The perspective toolbar will be missing if `webApplicationInjector.js` is not loaded. Please see the procedures above for information on how to copy and set `webApplicationInjector.js`.

The following example shows the perspective toolbar not appearing when `webApplicationInjector.js` is not loaded.

![webApplicationInjector.js]({{ site.baseurl }}/assets/images/webApplicationInjector.png)

### The Preview URL Does Not Match Your Website URL

SmartEdit opens the `previewUrl` in its iframe. You can open the `previewUrl` in a browser to see whether it works. Although it is recommended to start the app in SSL mode, you are not required to do so. You only need to make sure that the preview URL matches your site URL.

### The Page is Not Refreshed When You Add, Edit, or Remove Components

When you add, edit, or remove components, the CMS page data is reloaded. If the page does not refresh, it may be caused by the caching in OCC.

You can verify this by opening the **Network** tab in your browser (right-click > **Inspect**), and then editing a component. When you do this, you should see a new request to load CMS page data. Check the response of this request to see whether the edited component data is updated.

If only some operations do not make the page refresh (for example, editing a component causes the page to refresh, but updating an image does not cause the page to refresh), then please contact the SmartEdit team for help.

### Error Message: Not Allowed to Override This Storefront

If you see an error message that says `... is not allowed to override this storefront.`, it means the `allowOrigin` is not set correctly. Please see the procedures above for information on how to set this value.

### Your Website is Not in the SmartEdit Allowlist

If you see an error message that says `disallowed storefront is trying to communicate with smarteditcontainer`, it means your storefront is not in the SmartEdit allowlist. Please see the procedures above for information on how to add you site to the SmartEdit allowlist.

### The SmartEdit Slot Contextual Menu is Missing

For information on how to resolve this issue, see [Spartacus GitHub issue #845](https://github.com/SAP/spartacus/issues/845).

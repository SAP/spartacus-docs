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

## Prerequisites

For Spartacus to work with SmartEdit, you need SAP Commerce Cloud 1905 (or newer) with `spartacussampledataaddon` installed.

## Configuring SmartEdit to work with a Spartacus storefront

1. Build your Angular app, adding Spartacus libraries as normal. Make sure it's working before continuing. For more information, see [Building the Spartacus Storefront from Libraries]({{ site.baseurl }}{% link _pages/install/building-the-spartacus-storefront-from-libraries.md %}).

2. Copy the SmartEdit file `webApplicationInjector.js` to the folder `src` of your Angular app.

   This file to copy can be found in your SAP Commerce Cloud installation, in the following folder:

   ```javascript
   hybris/bin/modules/smartedit/smarteditaddon/acceleratoraddon/web/webroot/_ui/shared/common/js/webApplicationInjector.js
   ```

3. In the root folder of your Angular app, edit the file `angular.json`.

   In the section` architect > build > option > assets`, add `src/webApplicationInjector.js`.

   Example:

   ```
   "architect": {
   "build": {
     "builder": "@angular-devkit/build-angular:browser",
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

4. In  `src/index.html` file, in the `HEAD` section, add the following line:

   ```html
   <script id="smartedit-injector" src="webApplicationInjector.js" data-smartedit-allow-origin="localhost:9002"></script>
   ```

   Replace `localhost:9002` with the domain of your server.

   This line tells SmartEdit that Spartacus is allowed to be edited by SmartEdit.

5. Ensure that the `WCMS Cockpit Preview URL` is set correctly by carrying out the following steps:

   - In Backoffice, in WCMS > Website > *your site*, click the `WCMS Properties` tab.
   - Set the `WCMS Cockpit Preview URL` to match your Spartacus web site. For example, if you go to `https://localhost:4200`, you will see the default URL path (or context), such as `https://localhost:4200/en/USD`. The Preview URL must match the default context uses, or errors will occur using SmartEdit. The default context installed by Spartacus schematics is `https://localhost:4200/en/USD`.

6. Ensure that the Spartacus site is allowlisted in SmartEdit. There are many ways to do this; see the SmartEdit documentation for more information.

   - Log onto SmartEdit as an administrator.
  
   - Click the Settings icon at top right.
  
   - Scroll down to `whiteListedStorefronts`, and add the exact URL of the Spartacus storefront.
      For this example, it is:
  
      ```plaintext
      [
         "https://localhost:4200"
      ]
      ```
  
7. Start the Angular app in SSL mode. Doing so will avoid an "unsafe scripting" message from the browser.

   ```plaintext
   yarn start --ssl
   ```

   **Note:** If you start the app without SSL mode, the two references to `https://localhost:4200` must be changed to `http://localhost:4200`.

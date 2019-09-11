---
title: SmartEdit Setup Instructions for Spartacus
---

Pre-requisites:

- SAP Commerce Cloud 1905 (released May 29, 2019)
  - with spartacussampledataaddon installed
- Spartacus libraries, releases **0.1.0 alpha.4** or later, latest recommended



### Configuring SmartEdit to work with a Spartacus storefront

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

5. Ensure that the WCMS Cockpit Preview URL is set correctly.

   - In Backoffice, in WCMS > Website > *your site*, click the WCMS Properties tab.
   - Set the WCMS Cockpit Preview URL to your Spartacus web site. For this example, it should point to `https://localhost:4200`.
   
6. Ensure that the Spartacus site is whitelisted in Smartedit. There are many ways to do this; see the SmartEdit documentation for more information.

   - Log onto SmartEdit as an administrator.
   
   - Click the Settings icon at top right.
   
   - Scroll down to whiteListedStorefronts, and add the exact URL of the Spartacus storefront.
      For this example, it is:
      
      ``` 
      [
         "https://localhost:4200"
      ]
      ```
   
7. Start the Angular app in SSL mode. Doing so will avoid an "unsafe scripting" message from the browser.

   ```
   yarn start --ssl
   ```

Note: If you start the app without SSL mode, the two references to `https://localhost:4200` must be changed to `http://localhost:4200`.

---
title: Yotpo Integration (DRAFT)
---
You can integrate Spartacus with [Yotpo](https://www.yotpo.com) to import customer reviews from Yotpo for use in the storefront as well as submitting new reviews to the Yotpo service. The following instructions explain how you can import the Yotpo module and add the Yotpo widget to your storefront.

The steps described in this document are:

1. Install the Storefront
2. Add the Peer Dependencies
3. Add the Import Declarations
4. Add the Yotpo Widget
5. Add the JS Code to Load the Widget

## Installing Spartacus Storefront

1. Install the Spartacus storefront as described in [Building the Spartacus Storefront from Libraries]({{ site.baseurl }}{% link _pages/install/building-the-spartacus-storefront-from-libraries.md %}).

## Adding Peer Dependencies to the Storefront

1. Open *mystore/package.json* using a text editor.
2. Add the following dependency to the end of the dependencies section of package.json.

    ``` json
    "@spartacus/yotpo": "~0.1.0-prealpha.0"
    ```

3. Use the terminal to navigate to the **mystore** directory and install the dependencies by running the following command:

    ``` bash
    yarn install
    ```

## Adding Import Declarations and Storefront Configuration Settings

1. Edit *mystore/src/app/app.module.ts*.
2. Add the following import below the existing import statements.

    ``` javascript
    import { YotpoModule } from '@spartacus/yotpo';
    ```

3. Add **YotpoModule** into the *NgModule/imports* section.

## Adding the Yotpo Widgets to the app.component.html and app.component.ts Files

1. In the **app.component.html** file, add the following code:

    ``` html
    <ng-template cxOutletRef="ProductReviewsTabComponent">
      <cx-yotporeview></cx-yotporeview>
    </ng-template>
  
    <ng-template cxOutletRef="ProductIntroComponent">
      <cx-yotpostarrating></cx-yotpostarrating>
    </ng-template>
    ```

2. In the **app.component.ts** file, add the following code:

    ``` javascript
    import { Component } from '@angular/core';
    import { ProductDetailOutlets } from '@spartacus/storefront';

    @Component({
      selector: 'app-root',
     templateUrl: './app.component.html',
      styleUrls: <'./app.component.scss'>
    })

    export class AppComponent {
      outlets = ProductDetailOutlets;
      title = 'mystore';
    }

    ```

## Adding JS Code to Load the Yotpo Widget

1. Under *mystore/src*, create a file called **yotpoinit.js**  and insert the following content:

    ``` javascript
    (function e() {
      var e = document.createElement('script');
      (e.type = 'text/javascript'),
        (e.async = true),
        (e.src =
          'https://staticw2.yotpo.com/<<YOTPO API APP KEY>>/widget.js');
      var t = document.getElementsByTagName('script')<0>;
      t.parentNode.insertBefore(e, t);
    })();
    ```

2. Open *mystore/angular.json* and in the *projects.mystore.architect.build.options.scripts* section, add `"src/yotpoinit.js"`.

    The file should look as follows:

    ``` json
    {
      "$schema": "./node_modules/@angular/cli/lib/config/schema.json",
      "version": 1,
      "newProjectRoot": "projects",
      "projects": {
        "mystore": {
          "projectType": "application",
          "schematics": {
            "@schematics/angular:component": {
              "style": "scss"
            }
          },
          "root": "",
          "sourceRoot": "src",
          "prefix": "app",
          "architect": {
            "build": {
              "builder": "@angular-devkit/build-angular:browser",
              "options": {
                "outputPath": "dist/mystore",
                "index": "src/index.html",
                "main": "src/main.ts",
                "polyfills": "src/polyfills.ts",
                "tsConfig": "tsconfig.app.json",
                "aot": false,
                "assets": [
                  "src/favicon.ico",
                  "src/assets"
                ],
                "styles": [
                  "src/styles.scss"
                ],
                "scripts": [
                  "src/yotpoinit.js"
                ]
              }

    }
    ```

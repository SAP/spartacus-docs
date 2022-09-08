---
title: Updating to Version 4.0
---

## Prerequisites

Before updating your TUA Spartacus libraries to version 4.0, you must address the following prerequisites:

- You must first upgrade all of your `@spartacus` libraries to the latest 4.0.0 or higher release before you begin upgrading to Spartacus 4.0.0. For more information, see [Upgrading TUA Spartacus Libraries to a New Minor Version](#upgrading-tua-spartacus-libraries-to-a-new-minor-version).
- Your `@spartacus` libraries must include the `@spartacus/schematics` library. If you do not have the `@spartacus/schematics` library, add it to your `package.json` file in the `devDependencies` section, and set it to the same version as your other `@spartacus` libraries. Then run `yarn install`.
- You also must first upgrade all of your `@spartacus/tua-spa` to the latest 4.0.0 or higher release before you begin upgrading to Spartacus 4.0.
- Spartacus 4.0 requires Angular version 12.0.0. You must update Angular before updating Spartacus. For more information, see [Updating to Angular version 10](https://update.angular.io/).

## Updating Spartacus

TUA Spartacus 4.0 includes new features and fixes. Since this update is a major release, some of the updates may also be breaking changes for your application. In this case, additional work on your side may be required to fix issues that result from upgrading from 3.x to 4.0.

To update to version 4.0 of TUA Spartacus, run the following command in the workspace of your Angular application:

```shell
ng update @spartacus/schematics
```

## Upgrading TUA Spartacus Libraries to a New Minor Version

You can upgrade your TUA Spartacus libraries to a new minor version, as follows:

1. In `package.json`, set your `@spartacus` libraries to `“~4.0.0"`or higher.

   **Note:** If you are upgrading from a lower version (1.5 or 2.0), then upgrade to one version higher (1.5 to 2.x, 2.x to 3.x and 3.x to 4.0).
   For example. if you are upgrading from 1.5 to the latest 2.0 release, then upgrade to 2.x, in `package.json`, set your `@spartacus` libraries to `“~2.0.0"`.

1. Make sure other entries in `package.json` match with the following configuration (add the entries if not available).

    ```bash
    {
  "name": "tua-spa",
  "version": "4.0.0",
  "engines": {
    "node": ">=12 <17"
  },
  "scripts": {
    "ng": "ng",
    "start": "ng serve",
    "build": "ng build",
    "test": "ng test",
    "lint": "ng lint",
    "e2e": "ng e2e"
  },
  "private": false,
  "dependencies": {
    "@angular/animations": "^12.0.5",
    "@angular/common": "^12.0.5",
    "@angular/compiler": "^12.0.5",
    "@angular/core": "^12.0.5",
    "@angular/forms": "^12.0.5",
    "@angular/localize": "^12.0.5",
    "@angular/platform-browser": "^12.0.5",
    "@angular/platform-browser-dynamic": "^12.0.5",
    "@angular/platform-server": "^12.0.5",
    "@angular/router": "^12.0.5",
    "@angular/service-worker": "^12.0.5",
    "@ng-bootstrap/ng-bootstrap": "^10.0.0",
    "@ng-select/ng-select": "^7.0.1",
    "@ngrx/effects": "^12.1.0",
    "@ngrx/router-store": "^12.1.0",
    "@ngrx/store": "^12.1.0",
    "@spartacus/asm": "4.0.0",
    "@spartacus/assets": "4.0.0",
    "@spartacus/cart": "4.0.0",
    "@spartacus/checkout": "4.0.0",
    "@spartacus/core": "4.0.0",
    "@spartacus/organization": "4.0.0",
    "@spartacus/qualtrics": "4.0.0",
    "@spartacus/setup": "4.0.0",
    "@spartacus/storefront": "4.0.0",
    "@spartacus/styles": "4.0.0",
    "@spartacus/tracking": "4.0.0",
    "@spartacus/user": "4.0.0",
    "angular-oauth2-oidc": "^10.0.1",
    "bootstrap": "^4.3.1",
    "chart.js": "^2.9.3",
    "express": "^4.15.2",
    "i18next": "^20.2.2",
    "i18next-http-backend": "^1.2.2",
    "i18next-xhr-backend": "^1.2.2",
    "material-design-icons": "^3.0.1",
    "ng2-charts": "^2.3.2",
    "ngx-infinite-scroll": "^8.0.0",
    "ngx-spinner": "^9.0.1",
    "rxjs": "~6.6.3",
    "tslib": "^2.3.0",
    "zone.js": "~0.11.4"
  },
  "devDependencies": {
    "@angular-devkit/build-angular": "^12.0.5",
    "@angular-devkit/build-ng-packagr": "~0.1001.0",
    "@angular/cli": "^12.0.5",
    "@angular/compiler-cli": "^12.0.5",
    "@angular/language-service": "^12.0.5",
    "@spartacus/schematics": "4.0.0",
    "@types/jasmine": "~3.6.0",
    "@types/jasminewd2": "~2.0.3",
    "@types/node": "^12.11.1",
    "codelyzer": "^5.1.2",
    "jasmine-core": "~3.6.0",
    "jquery": "^3.5.1",
    "karma": "~6.3.4",
    "karma-chrome-launcher": "~3.1.0",
    "karma-coverage-istanbul-reporter": "~3.0.2",
    "karma-jasmine": "~4.0.0",
    "karma-jasmine-html-reporter": "^1.5.0",
    "ng-packagr": "^9.0.0",
    "postcss": "^8.2.10",
    "postcss-scss": "^3.0.4",
    "protractor": "~5.4.0",
    "ts-node": "~8.3.0",
    "tsickle": "^0.38.0",
    "tslint": "~6.1.0",
    "typescript": "~4.3.5"
  },
  "prettier": {
    "singleQuote": true
  }
}
    ```

1. Inspect the `mystore/src/app/app.module.ts` file for any changes you want to make for your setup.
    - Update level under features section to `12.0.0`.
    - Add query service `Qualification` in the `backend:` section.
    - Add `getProduct` and `getProductOffering` URLs in the `tmf:` section.
    - Add `deliveryMode` in the `TmaB2cStorefrontModule` section.

    ```bash
    import { HttpClientModule } from '@angular/common/http';
    import { NgModule } from '@angular/core';
    import { BrowserModule } from '@angular/platform-browser';
    import { EffectsModule } from '@ngrx/effects';
    import { StoreModule } from '@ngrx/store';
    import { translationChunksConfig, translations } from '@spartacus/assets';
    import { ConfigModule, FeaturesConfig, I18nConfig, provideConfig} from '@spartacus/core';
    import { tmaTranslations } from '../../../tua-spa/src/assets';
    import { TmaSpartacusModule } from '../../../tua-spa/src/storefrontlib';
    import { AppRoutingModule } from './app-routing.module';
    import { AppComponent } from './app.component';

    @NgModule({
    declarations: [AppComponent],
    imports: [
        AppRoutingModule,
        BrowserModule,
        HttpClientModule,
        StoreModule.forRoot({}),
        EffectsModule.forRoot([]),
        TmaSpartacusModule,
        ConfigModule.withConfig({
        i18n: {
            resources: tmaTranslations,
      },
    }), 
    ],
    providers: [
    provideConfig(<I18nConfig>{
      // we bring in static translations to be up and running soon right away
      i18n: {
        resources: translations,
        chunks: translationChunksConfig,
        fallbackLang: 'en',
      },
    }),
    provideConfig(<FeaturesConfig>{
      features: {
        level: '4.0',
      },
    }),
    ],
  bootstrap: [AppComponent],
  })
  export class AppModule {}
    ```

1. Add the following import `/mystore/src/polyfills.ts` in the file:

    ```bash
    import '@angular/localize/init';    
    import 'zone.js/dist/zone';    
    ```

1. Delete your `node_modules` folder.
1. Run `yarn install`.

For more information, see [Technical Changes in TUA Spartacus 4.0]({{ site.baseurl }}{% link _pages/telco/technical-changes-tua-version-4.md %}).

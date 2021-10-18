---
title: Updating to Version 3.1
---

## Prerequisites

Before updating your TUA Spartacus libraries to version 3.1, you must address the following prerequisites:

- You must first upgrade all of your `@spartacus` libraries to the latest 3.x release before you begin upgrading to Spartacus 3.3.0. For more information, see [Upgrading TUA Spartacus Libraries to a New Minor Version](#upgrading-tua-spartacus-libraries-to-a-new-minor-version).
- Your `@spartacus` libraries must include the `@spartacus/schematics` library. If you do not have the `@spartacus/schematics` library, add it to your `package.json` file in the `devDependencies` section, and set it to the same version as your other `@spartacus` libraries. Then run `yarn install`.
- You also must first upgrade all of your `@spartacus/tua-spa` to the latest 3.x release before you begin upgrading to Spartacus 3.3.0.
- Spartacus 3.3.0 requires Angular version 10. You must update Angular before updating Spartacus. For more information, see [Updating to Angular version 10](https://update.angular.io/).

## Updating Spartacus

TUA Spartacus 3.1 includes new features and fixes. Since this update is a major release, some of the updates may also be breaking changes for your application. In this case, additional work on your side may be required to fix issues that result from upgrading from 3.x to 3.3.0.

To update to version 3.1.0 of TUA Spartacus, run the following command in the workspace of your Angular application:

```shell
ng update @spartacus/schematics
```

## Upgrading TUA Spartacus Libraries to a New Minor Version

You can upgrade your TUA Spartacus libraries to a new minor version, as follows:

1. In `package.json`, set your `@spartacus` libraries to `“~3.#.0"`, where `#` is replaced with the release version number you wish to upgrade to.

1. Make sure other entries in `package.json` match with the following configuration (add the entries if not available).

    ```bash
    "@angular/localize": "^10.1.0",
    "@angular/platform-server": "~10.1.0",
    "@angular/service-worker": "~10.1.0",
    "@ng-bootstrap/ng-bootstrap": "^7.0.0",
    "@ng-select/ng-select": "^4.0.0",
    "@ngrx/effects": "~10.0.0",
    "@ngrx/router-store": "~10.0.0",
    "@ngrx/store": "~10.0.0",
    "angular-oauth2-oidc": "^10.0.1",
    "bootstrap": "^4.2.1",
    "chart.js": "^2.9.3",
    "express": "^4.15.2",
    "i18next": "^19.3.4",
    "i18next-xhr-backend": "^3.2.2",
    "material-design-icons": "^3.0.1",
    "ng2-charts": "^2.3.2",
    "ngx-infinite-scroll": "^8.0.0",
    "ngx-spinner": "^9.0.1"
    ```

1. Inspect the `mystore/src/app/app.module.ts` file for any changes you want to make for your setup.
    - Update level under features section to `3.1.0`.
    - Add query service `Qualification` in the `backend:` section.
    - Add `getProduct` and `getProductOffering` URLs in the `tmf:` section.
    - Add `deliveryMode` in the `TmaB2cStorefrontModule` section.

    ```bash
    import { BrowserModule } from '@angular/platform-browser';
    import { NgModule } from '@angular/core';
    import { AppComponent } from './app.component';
    import { translationChunksConfig, translations } from '@spartacus/assets';
    import { ConfigModule } from '@spartacus/core';
    import { TmaB2cStorefrontModule, tmaTranslations } from '@spartacus/tua-spa';

    @NgModule({
    declarations: [AppComponent],
    imports: [
        BrowserModule,
        TmaB2cStorefrontModule.withConfig({
        backend: {
            tmf: {
            baseUrl: 'https://localhost:9002',
            prefix: '/b2ctelcotmfwebservices',
            version: '/v2',
            endpoints: {
                getProduct: {
                baseUrl: 'https://localhost:9002',
                prefix: '/b2ctelcotmfwebservices',
                version: '/v3',
                endpoint: '/product/${id}'
                },
                getProductOffering: {
                baseUrl: 'https://localhost:9002',
                prefix: '/b2ctelcotmfwebservices',
                version: '/v3',
                endpoint: '/productOffering/${id}'
                }
            }
            },
            occ: {
            baseUrl: 'https://localhost:9002',
            prefix: '/occ/v2/',
            },
            tmf_appointment: {
            baseUrl: 'http://localhost:8080',
            prefix: '/tmf-api',
            },
            tmf_resource_pool_management: {
            baseUrl: 'http://localhost:8080',
            prefix: '/tmf-api',
            },
            premiseLookup: {
            baseUrl: 'http://localhost:9003',
            prefix: '/premise/v1/',
            },
            tmf_query_service_qualification: {
            baseUrl: 'http://localhost:8080',
            prefix: '/tmf-api'
            }
        },
        context: {
            urlParameters: ['baseSite', 'language', 'currency'],
            baseSite: ['telcospa', 'utilitiesspa'],
        },
        i18n: {
            resources: translations,
            chunks: translationChunksConfig,
            fallbackLang: 'en',
        },
        features: { level: '3.0' },
        journeyChecklist: {
            journeyChecklistSteps: ['APPOINTMENT', 'MSISDN', 'INSTALLATION_ADDRESS'],
            msisdn_reservation: {
            msisdn_qty: 1,
            msisdn_capacity_amount_demand: 1,
            msisdn_applied_capacity_amount: 5,
            applied_capacity_amount_for_msisdn_reservation: 1,
            },
            appointment: {
            requested_number_of_timeslots: 5,
            end_date_of_timeslots: 3,
            }
        },
        deliveryMode: {
            default_delivery_mode: 'not-applicable'
        }
        }),
        ConfigModule.withConfig({ i18n: { resources: tmaTranslations } }),
    ],
    providers: [],
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

For more information, see [Technical Changes in TUA Spartacus 3.0]({{ site.baseurl }}{% link _pages/telco/technical-changes-tua-version-3.md %}).
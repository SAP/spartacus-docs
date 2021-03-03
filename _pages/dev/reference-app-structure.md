---
title: Reference App Structure
---

# Recommended Spartacus Application structure

This document describes the recommended app structure introduced in Spartacus 3.1 onwards.

By using it, you can benefit the most from automatic migrations available with major Spartacus releases, while still keeping flexibility for customizations and for building new features on top of it.

Note: The structure described in this document is planned to be supported as a default one by schematics in one of Spartacus 3.x version. but not later than in 4.0. Until this happens, it's possible to migrate it (in any version starting from 3.1), but it has to be done manually.

You can refer to the working example repository:
https://github.com/dunqan/spartacus-reference-structure
\
# Introduction

Spartacus is an Angular library, which means, it can be used solely in the Angular application, or can also be integrated into existing Angular project, or, the other way around, you can add any other Angular solution or library to the Spartacus project.

Spartacus itself comes with several layers and concepts, and dozen of smaller feature libraries that can be lazy-loaded out of the box. Customization and third-party code only add complexity to it, so it's quite hard to keep the balance and not end up with some god modules that mix everything.

Defining and sticking to some standardized reference structure aims to solve the above, but also helps in on-boarding new devs to the project, any external support cases, and audits.

# Structure overview

- `AppModule` (placed in main app folder)
  - _(application modules)_
  - `SpartacusModule` (placed in `app/spartacus` folder)
    - `BaseStorefrontModule` (from `@spartacus/storefront`)
    - `SpartacusFeaturesModule` (placed in `app/spartacus` folder)
      - _(feature related modules)_ (placed in `app/spartacus/features` folder)
    - `SpartacusConfigurationModule`(placed in `app/spartacus` folder)
    

## Spartacus Module

Every Angular application has to have its root app module, usually named `AppModule`. It should include application-wide imports, that's we don't want to keep complex Spartacus-related things in it, but we want to narrow it to only one `SpartacusModule`.

Note:
Angular Router and Ngrx are used by Spartacus, but it's affecting global Application, so we keep them outside of `SpaartacusModule` and import them directly in the `AppModule`.

`SpartacusModule` is composed of:
- `BaseStorefrontModule` - encapsulated core Spartacus imports (usually required by most of the Spartacus applications), imported directly from `@spartacus/storefront`
- `SpartacusFeaturesModule` - encapsulates Spartacus features
- `SpartacusConfigurationModule` - encapsulated general Spartacus configuration

and in most of the cases won't event change, as changes are usually encapsulated in configuration or feature modules. 

Module example: 
```typescript
import { NgModule } from '@angular/core';
import { BaseStorefrontModule } from '@spartacus/storefront';
import { SpartacusConfigurationModule } from './spartacus-configuration.module';
import { SpartacusFeaturesModule } from './spartacus-features.module';

@NgModule({
  imports: [
    BaseStorefrontModule,
    SpartacusFeaturesModule,
    SpartacusConfigurationModule,
  ],
  exports: [BaseStorefrontModule],
})
export class SpartacusModule {}
```

## SpartacusConfiguration Module

The `SpartacusConfigurationModule` contains all global Spartacus configuration entries.


It can look like this:
```typescript
import { NgModule } from '@angular/core';
import { provideConfig } from '@spartacus/core';
import {
  layoutConfig,
  mediaConfig,
} from '@spartacus/storefront';

@NgModule({
  providers: [
    provideConfig(layoutConfig),
    provideConfig(mediaConfig),
    provideConfig({
      backend: {
        occ: {
          baseUrl: 'https://my.custom.occ.url.com',
        },
      },
      context: {
        urlParameters: ['baseSite', 'language', 'currency'],
        baseSite: ['electronics-spa',],
      },
      pwa: {
        enabled: true,
        addToHomeScreen: true,
      },
    }),
  ],
})
export class SpartacusConfigurationModule {}
```

Feature-specific configuration can be either kept in feature modules or in `SpartacusConfigurationModule`. Keeping them in feature modules helps to maintain a good separation of concerns, so it's generally recommended, but there is nothing against keeping it if it helps to solve specific issues (using some env flag to change configuration).

## Spartacus Feature Module

Spartacus Feature Module is intended to easily manage all non-core Spartacus features, both statically and lazy-loaded. It serves as an entry point to all the features, which are ideally wrapped into separate feature modules on itself.

Example:
```typescript
@NgModule({
    imports: [
        AuthModule.forRoot(),

        // Basic Cms Components
        HamburgerMenuModule,
        SiteContextSelectorModule,
        LinkModule,
        BannerModule,
        CmsParagraphModule,
        TabParagraphContainerModule,
        BannerCarouselModule,
        CategoryNavigationModule,
        NavigationModule,
        FooterNavigationModule,
        BreadcrumbModule,

        /************************* Opt-in features *************************/
        ExternalRoutesModule.forRoot(),
        JsonLdBuilderModule,

        /************************* External features *************************/
        TrackingFeatureModule,
        StorefinderFeatureModule,
        QualtricsFeatureModule,
        SmartEditFeatureModule,
    ],
})
export class SpartacusFeaturesModule {}
```

### Specific Feature Modules

Ideally, one complete feature can be encapsulated into a specific feature module.
It can contain both feature-related configurations, customizations, etc.

Example of feature module with lazy loaded configuration:
```typescript
import { NgModule } from '@angular/core';
import { StoreFinderRootModule } from '@spartacus/storefinder/root';
import { provideConfig } from '@spartacus/core';
import {
  storeFinderTranslationChunksConfig,
  storeFinderTranslations,
} from '@spartacus/storefinder/assets';

@NgModule({
  imports: [StoreFinderRootModule],
  providers: [
    provideConfig({
      featureModules: {
        storeFinder: {
          module: () =>
            import('@spartacus/storefinder').then((m) => m.StoreFinderModule),
        },
      },
      i18n: {
        resources: storeFinderTranslations,
        chunks: storeFinderTranslationChunksConfig,
      },
    }),
  ],
})
export class StorefinderFeatureModule {}
```

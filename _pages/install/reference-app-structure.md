---
title: Reference App Structure
---

**Note:** The reference app structure is introduced with version 3.1 of the Spartacus libraries.

## Overview

This recommended Spartacus app structure is intended to act as a reference for when you are setting up your own Spartacus application.

Spartacus is an Angular library, which means it can be used on its own in an Angular application, or it can be integrated into an existing Angular project. Conversely, you can add any other Angular solution or library to your Spartacus project.

Spartacus itself comes with several layers and concepts, as well as a number of smaller feature libraries that can be lazy loaded out of the box. Customizations and third-party code add further complexity, and you can end up with modules that are difficult to maintain because they mix too many of these elements together.

This can be solved by defining and adhering to a standardized structure, such as the Spartacus reference app structure. Having a standardized structure also makes it easier to onboard new developers to your project, to handle external support cases, and to take care of audits.

By using the Spartacus reference app structure, you can get the most benefit from automatic migrations that are available with major Spartacus releases, while still having the flexibility to add customizations and to build new features on top of those customizations. Using the Spartacus reference app structure also makes it possible to take advantage of code splitting for features that are moved into separate libraries after the 3.0 release.  

**Note:** In one of the 3.x releases that is after 3.1, the reference structure described in the following sections will be supported by schematics as the default structure. Until this update is made to schematics, if you are using release 3.1 or newer, you can migrate to the reference structure, but it must be done manually.

To see a working example repository, see [https://github.com/dunqan/spartacus-reference-structure](https://github.com/dunqan/spartacus-reference-structure).

## Structure Overview

The following is an example of the reference app structure:

- `AppModule` (placed in the main app folder)
  - _application modules_
  - `SpartacusModule` (placed in the `app/spartacus` folder)
    - `BaseStorefrontModule` (imported from `@spartacus/storefront`)
    - `SpartacusFeaturesModule` (placed in the `app/spartacus` folder)
      - _feature related modules_ (placed in the `app/spartacus/features` folder)
    - `SpartacusConfigurationModule`(placed in the `app/spartacus` folder)

## Spartacus Module

Every Angular application has a root app module, usually named `AppModule`. This module should include application-wide imports, and should avoid complex configurations related to Spartacus, which it does by handling only one `SpartacusModule`.

 that's we don't want to keep complex Spartacus-related things in it, but we want to narrow it to only one `SpartacusModule`.

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

With early 3.x minor releases, `SpartacusFeatureModule` may look bloated and busy, but with every consecutive release, it should become more and more concise, thanks to moving most of the features to separate libraries.

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

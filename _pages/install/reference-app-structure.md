---
title: Reference App Structure
---

**Note:** The reference app structure is introduced with version 3.1 of the Spartacus libraries.

This recommended Spartacus app structure is intended to act as a reference for when you are setting up your own Spartacus application.

Spartacus is an Angular library, which means it can be used on its own in an Angular application, or it can be integrated into an existing Angular project. Conversely, you can add any other Angular solution or library to your Spartacus project.

Spartacus itself comes with several layers and concepts, as well as a number of smaller feature libraries that can be lazy loaded out of the box. Customizations and third-party code add further complexity, and you can end up with modules that are difficult to maintain because they mix too many of these elements together.

This can be solved by defining and adhering to a standardized structure, such as the Spartacus reference app structure. Having a standardized structure also makes it easier to onboard new developers to your project, to handle external support cases, and to take care of audits.

By using the Spartacus reference app structure, you benefit the most from the automatic migrations that are available with each major Spartacus release, while also maintaining the flexibility to add customizations, and to build new features on top of those customizations. Using the reference app structure also makes it possible to take advantage of code splitting for features that are moved into separate libraries after the 3.0 release.  

To see a working example that makes use of the reference app structure, see [this repository](https://github.com/dunqan/spartacus-reference-structure).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

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

Every Angular application has a root app module, usually named `AppModule`. In the reference app strcuture, this module includes application-wide imports, and avoids complex module imports related to Spartacus by handling only one `SpartacusModule`.

**Note:** Both Angular Router and NgRx are used by Spartacus, but these affect the global application, so they are kept outside of the `SpartacusModule` and are imported directly in the `AppModule`.

The `SpartacusModule` is composed of the following:

- The `BaseStorefrontModule`, which encapsulates core Spartacus imports that are usually required by most Spartacus applications. The `BaseStorefrontModule` is imported directly from `@spartacus/storefront`.
- The `SpartacusFeaturesModule`, which encapsulates Spartacus features.
- The `SpartacusConfigurationModule`, which encapsulates the general Spartacus configuration.

In most cases, the `SpartacusModule` does not get modified because changes are more often encapsulated in configuration modules or feature modules.

The following is an example of the `SpartacusModule`:

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

## Spartacus Configuration Module

The `SpartacusConfigurationModule` contains all global Spartacus configuration entries.

The following is an example:

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

Feature-specific configurations can be kept either in feature modules, or in the `SpartacusConfigurationModule`. Keeping them in feature modules helps to maintain a good separation of concerns, so it is generally recommended, but there is nothing against keeping feature-specific configurations in the `SpartacusConfigurationModule` if it helps to solve specific issues (for example, by using an `env` flag to change the configuration).

## Spartacus Features Module

The `SpartacusFeaturesModule` is intended to easily manage all non-core Spartacus features, both statically and though lazy loading. It serves as an entry point for all features, which are ideally wrapped into their own, separate feature modules.

With early 3.x minor releases, the `SpartacusFeaturesModule` may look bloated and busy, but with every consecutive release, it should become more concise as a result of efforts to move most of the features to separate libraries.

The following is an example:

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

        // Opt-in features //
        ExternalRoutesModule.forRoot(),
        JsonLdBuilderModule,

        // External features //
        TrackingFeatureModule,
        StorefinderFeatureModule,
        QualtricsFeatureModule,
        SmartEditFeatureModule,
    ],
})
export class SpartacusFeaturesModule {}
```

### Specific Feature Modules

Ideally, one complete feature can be encapsulated into a specific feature module. The module can contain feature-related configurations as well as customizations.

The following is an example of a feature module with a lazy-loaded configuration:

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

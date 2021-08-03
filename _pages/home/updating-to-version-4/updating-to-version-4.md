---
title: Updating to Version 4.0
---

## Before migrating to Spartacus 4.0

Before you migrate to version 4.0 of libraries we highly recommend to switch to new app structure and new feature libraries. It's easier to do migration in multiple small steps (migrating to new app structure, switching to extracted feature libs and then migrating to 4.0), where you can make sure that everything still works as before after every step. Read the next chapter if you need more insights why we introduce this change.

### Reasons for migration to new app structure

Before the 3.0 release we started to separate libraries based on it's responsibility. With 3.0 we already released few libraries in separate packages (eg. @spartacus/organization, @spartacus/storefinder). We kept moving more libraries in the minor 3.x releases as well. We tried to do that in a no breaking-changes manner. However with each major release we want to pay off tech debt we accumulated during minor releases. Extracted libraries are huge contributor to tech debt, as we keep the same functionality in 2 places. With 4.0 release we will remove the functionality from core libraries (@spartacus/core, @spartacus/storefront, @spartacus/assets and @spartacus/styles) that was already extracted to separate libraries in minor releases.

Along the way we discovered that we had to change few of the bigger modules to accommodate these changes (eg. `B2cStoreFrontModule`, `StorefrontModule` or `CmsLibModule`).

So that's why we recommend to switch to new app structure that is not using these modules and to switch to new feature libraries if they exists for the features you are using. Below you can find generic guide on how to do it. After that migration to 4.0 should be easier.

### Migrating to new, reference app structure

Before you start to migrate to new app structure read the reasoning behind the change [here](https://sap.github.io/spartacus-docs/reference-app-structure/).

So let's migrate to the new structure step by step.

1. Create `SpartacusModule` under `app/spartacus/spartacus.module.ts` path and add it to `imports` in `AppModule`.
2. Add `BaseStorefrontModule` to imports and exports of `SpartacusModule`. This modules is exported from `@spartacus/storefront` library.
3. Create `SpartacusFeaturesModule` under `app/spartacus/spartacus-features.module.ts` path and add it to `imports` in `SpartacusModule`.
4. Create `SpartacusConfigurationModule` under `app/spartacus/spartacus-configuration.module.ts` path and add it to `imports` in `SpartacusModule`.
5. Move spartacus configuration to `SpartacusConfigurationModule`. That would be the configurations you pass with `provideConfig`, `provideConfigFactory` or with `withConfig` methods from some of the modules (eg. `B2cStorefrontModule`, `ConfigModule`). We recommend to use `provideConfig` or `provideConfigFactory` in module providers to configure spartacus.
6. Configure `AppRoutingModule`. If you don't have this module, first create it under `app/app-routing.module.ts`. Don't forget to import this module in `AppModule`. In `AppRoutingModule` imports configure `RouterModule` with these 3 options:

    ```ts
    RouterModule.forRoot([], {
      anchorScrolling: 'enabled',
      relativeLinkResolution: 'corrected',
      initialNavigation: 'enabled',
    }),
    ```

    Previously this module was configured in `StorefrontModule`, which is now deprecated and removed in version 4.0.

7. Configure ngrx modules in `AppModule`. They were part of the `StorefrontModule`, but similarly like `RouterModule` we require this configuration to be present in application. You need to add to `imports` 2 modules: `StoreModule.forRoot({})` and `EffectsModule.forRoot([])`. Import these modules from `@ngrx/store` and from `@ngrx/effects`.

    ```ts
    @NgModule({
      imports: [
        AppRoutingModule,
        StoreModule.forRoot({}),
        EffectsModule.forRoot([]),
        SpartacusModule,

        // then the rest of your custom modules...
      ],
      ...
    ```

8. Now let's focus on replacing deprecated Spartacus grouping modules

    1. Migrating `B2cStorefrontModule`.
        - config from `B2cStorefrontModule.withConfig` should be already moved to `SpartacusConfigurationModule` and provided with `provideConfig`
        - first add `HttpClientModule` to imports in `AppModule` if it's not present there
        - now add in `SpartacusFeaturesModule` module imports two modules from `@spartacus/storefront`: `StorefrontModule` and `CmsLibModule` (those modules are removed in 4.0, but we want to migrate the modules step by step. Migration of those modules will be covered in next steps).
        - this module provided few default configs, so add them to your `SpartacusConfigurationModule` if you rely on them

            ```ts
            provideConfig({
              pwa: {
                enabled: true,
                addToHomeScreen: true,
              },
            }),
            provideConfig(layoutConfig),
            provideConfig(mediaConfig),
            ...defaultCmsContentProviders,
            ```

        - remove usage of `B2cStorefrontModule` from your app

    2. Migrating `B2bStorefrontModule`.
        - config from `B2bStorefrontModule.withConfig` should be already moved to `SpartacusConfigurationModule` and provided with `provideConfig`
        - add `HttpClientModule` to imports in `AppModule` if it's not present there
        - add in `SpartacusFeaturesModule` imports few modules: `StorefrontModule`, `CmsLibModule` from `@spartacus/storefront` (those modules are removed in 4.0, but we want to migrate the modules step by step. Migration of those modules will be covered in next steps) and `CostCenterModule.forRoot()` from `@spartacus/core`
        - this module provided few default configs, so add them to your `SpartacusConfigurationModule` if you rely on them

            ```ts
            provideConfig(layoutConfig),
            provideConfig(mediaConfig),
            provideConfig(defaultB2bOccConfig),
            provideConfig(defaultB2bCheckoutConfig),
            ...defaultCmsContentProviders,
            ```

        - remove usage of `B2bStorefrontModule` from your app

    3. Migrating `StorefrontModule`
        - you should have configured `RouterModule` in `AppRoutingModule`
        - in `AppModule` you should already have `StoreModule.forRoot({})` and `EffectsModule.forRoot([])` present in `imports`
        - add `AsmModule` from `@spartacus/storefront` to imports in `SpartacusFeaturesModule`
        - add `StorefrontFoundationModule` to `SpartacusFeaturesModule` imports.
        - Add `MainModule` to `SpartacusFeaturesModule` imports
        - Add `SmartEditModule.forRoot()`, `PersonalizationModule.forRoot()` and `OccModule.forRoot()` from `@spartacus/core` to imports in `SpartacusFeaturesModule`
        - Add `ProductDetailsPageModule` and `ProductListingPageModule` from `@spartacus/storefront` to imports in `SpartacusFeaturesModule`
        - Add `ExternalRoutesModule.forRoot()` from `@spartacus/core` to imports in `SpartacusFeaturesModule`
        - remove usage of `StorefrontModule` from you app

    4. Migrating `CmsLibModule`
        - add imports listed below from `@spartacus/storefront` directly to imports in `SpartacusFeaturesModule`:

            ```ts
            AnonymousConsentManagementBannerModule,
            AsmModule, // remove if it's already present
            HamburgerMenuModule,
            CmsParagraphModule,
            LinkModule,
            BannerModule,
            CategoryNavigationModule,
            NavigationModule,
            FooterNavigationModule,
            BreadcrumbModule,
            SearchBoxModule,
            SiteContextSelectorModule,
            QualtricsModule,
            AddressBookModule,
            OrderHistoryModule,
            OrderCancellationModule,
            OrderReturnModule,
            ReturnRequestListModule,
            ReturnRequestDetailModule,
            ProductListModule,
            ProductFacetNavigationModule,
            ProductTabsModule,
            ProductCarouselModule,
            ProductReferencesModule,
            OrderDetailsModule,
            PaymentMethodsModule,
            ConsentManagementModule,
            CartComponentModule,
            TabParagraphContainerModule,
            OrderConfirmationModule,
            ProductImagesModule,
            ProductSummaryModule,
            ProductVariantsModule,
            ProductIntroModule,
            BannerCarouselModule,
            MyCouponsModule,
            WishListModule,
            NotificationPreferenceModule,
            MyInterestsModule,
            StockNotificationModule,
            ReplenishmentOrderHistoryModule,
            ReplenishmentOrderConfirmationModule,
            ReplenishmentOrderDetailsModule,
            UserComponentModule,
            CloseAccountModule,
            UpdateEmailModule,
            UpdatePasswordModule,
            UpdateProfileModule,
            ForgotPasswordModule,
            ResetPasswordModule,
            ```

        - remove usage of `CmsLibModule` from your app

    5. Migrating `MainModule`
        - add `AnonymousConsentsDialogModule` from `@spartacus/storefront` into imports in `SpartacusFeaturesModule`
        - remove usage of `MainModule` from you app

    6. Migrating `StorefrontFoundationModule`
        - add `AuthModule.forRoot()`, `AnonymousConsentsModule.forRoot()`, `CartModule.forRoot()`, `CheckoutModule.forRoot()`, `UserModule.forRoot()` and `ProductModule.forRoot()` from `@spartacus/core` into imports in `SpartacusFeaturesModule`
        - add `CartPageEventModule`, `PageEventModule` and `ProductPageEventModule` from `@spartacus/storefront` into imports in `SpartacusFeaturesModule`
        - remove usage of `StorefrontFoundationModule` from your app

    7. Migrating `OccModule`
        - add `AsmOccModule`, `CartOccModule`, `CheckoutOccModule`, `ProductOccModule`, `UserOccModule`, `CostCenterOccModule` from `@spartacus/core` to imports in `SpartacusFeaturesModule`
        - remove usage of `OccModule` from your app

    8. Migrating `EventsModule`
        - add `CartPageEventModule`, `PageEventModule` and `ProductPageEventModule` from `@spartacus/storefront` to imports in `SpartacusFeaturesModule`
        - remove usage of `EventsModule` from your app

    9. That's it. You migrated to new app structure. However there is one more thing that we recommend to do. All these huge modules that we just migrated were created to make it easy to create complete spartacus application. What we mean by "complete" is the spartacus with a lot of features enabled out of the box. You might've not even used those features and yet they landed in your application files making your app bigger and by that increasing your application initial load time. As we just replaced these bootstrap modules with granular modules it gives you a great opportunity to remove feature modules that you don't need.

        Here is a list of common features that you might not use:
          - if you don't use ASM feature you can remove from `SpartacusFeaturesModule` imports of `AsmModule` and `AsmOccModule`
          - if you don't use Smartedit you can remove from `SpartacusFeaturesModule` import of `SmartEditModule`
          - if you don't use Qualtrics you can remove from `SpartacusFeaturesModule` import of `QualtricsModule`
          - if you don't use product variants you can remove from `SpartacusFeaturesModule` imports of `ProductVariantsModule`
          - if you don't support replenishments order you can remove from `SpartacusFeaturesModule` imports of `ReplenishmentOrderHistoryModule`, `ReplenishmentOrderConfirmationModule` and `ReplenishmentOrderDetailsModule`

        There are many more modules that you might not need, so we recommend just going through all the imports in `SpartacusFeaturesModule` and verifying if you use it or not. If not just remove it and make your application smaller.

### Upgrade Angular libraries first
Before upgrading Spartacus to 4.0, you need first to upgrade Angular to the version 12 and upgrade Angular 3rd party dependencies like `@ng-bootstrap/ng-bootstrap` or `@ng-select/ng-select` to the versions compatible with Angular 12.

```bash
ng update @ng-bootstrap/ng-bootstrap@10 @ng-select/ng-select@7 @angular/core@12 @angular/cli@12
```

For more, see [the official Angular upgrade guide](https://update.angular.io/).

### Upgrade Spartacus to 3.4.x first

You must first upgrade all of your `@spartacus` libraries to the latest 3.4.x release before you begin upgrading to Spartacus 4.0. For more information, see [Upgrading Spartacus Libraries to a New Minor Version](https://sap.github.io/spartacus-docs/release-information/#upgrading-spartacus-libraries-to-a-new-minor-version).

### Finally, upgrade Spartacus to 4.0

Spartacus 4.0 includes many new features and fixes. Since this update is a major release, some of the updates may also be breaking changes for your application. In this case, additional work on your side may be required to fix issues that result from upgrading from 3.4.x to 4.0.

To update to version 4.0 of Spartacus, run the following command in the workspace of your Angular application:

```bash
ng update @spartacus/schematics@4
```

When the update has finished running, inspect your code for comments that begin with `// TODO:Spartacus`. For detailed information about each added comment, see [Detailed List of Changes](#detailed-list-of-changes) below.
---
title: Updating to Version 4.0
---

Before you migrate to version 4.0 of the Spartacus libraries, it is highly recommend that you update your app structure to match the Spartacus reference app structure, and that you also make the move to using feature libraries. It is easier to perform the migration in multiple, small steps (migrating to the new app structure, switching to the extracted feature libraries, and then migrating to 4.0), where you can make sure that everything still works as before after each step.

**Note:** The procedures below are listed in the order they should be performed, which is to say, migrate to the reference app structure first, then upgrade your Angular libraries, then upgrade to Spartacus 3.4.x, and finally, upgrade to Spartacus 4.0.

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

## Overview

Before the 3.0 release, Spartacus started to have separate libraries based on their responsibility. With 3.0, Spartacus was released with a few libraries already in separate packages (such as `@spartacus/organization` and `@spartacus/storefinder`). More libraries continued to be moved in the minor 3.x releases. This was done while trying to avoid breaking changes. However, each major release provides an opportunity to pay off technical debt that has accumulated during the minor releases. The extracted libraries are a big contributor to technical debt, because the same functionality has been kept in two places. With the 4.0 release, the functionality that was extracted to separate libraries in the minor releases is now removed from the core libraries (that is, from `@spartacus/core`, `@spartacus/storefront`, `@spartacus/assets` and `@spartacus/styles`).

To accommodate these changes, it was necessary to also modify a few of the bigger modules, namely `B2cStoreFrontModule`, `StorefrontModule` and `CmsLibModule`.

For these reasons, it is strongly recommended to switch to the new app structure, which does not use these modules, and to switch to the new feature libraries if they exist for the features you are using.

For more information on the Spartacus reference app structure, see [{% assign linkedpage = site.pages | where: "name", "reference-app-structure.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/reference-app-structure.md %}).

## Migrating to the Reference App Structure

The following steps describe how to migrate to the new reference app structure.

1. Create the `SpartacusModule` with the following filename and path: `app/spartacus/spartacus.module.ts`
1. Add the `SpartacusModule` to the `imports` in `AppModule`.
1. Add `BaseStorefrontModule` to the imports and exports of `SpartacusModule`. This module is exported from the `@spartacus/storefront` library.
1. Create the `SpartacusFeaturesModule` with the following filename and path: `app/spartacus/spartacus-features.module.ts`
1. Add the `SpartacusFeaturesModule` to the `imports` in `SpartacusModule`.
1. Create the `SpartacusConfigurationModule` with the following filename and path: `app/spartacus/spartacus-configuration.module.ts`.
1. Add the `SpartacusConfigurationModule` to the `imports` in `SpartacusModule`.
1. Move Spartacus configurations to the `SpartacusConfigurationModule`.

    These are the configurations you pass with `provideConfig`, `provideConfigFactory`, or with the `withConfig` methods from some of the modules (such as `B2cStorefrontModule` and `ConfigModule`). It is recommended that you use `provideConfig` or `provideConfigFactory` in module providers to configure Spartacus.
1. Configure the `AppRoutingModule`.

    If you do not have this module, first create it under `app/app-routing.module.ts`. Make sure you import this module in you `AppModule`. In the imports of `AppRoutingModule`, configure the `RouterModule` with the following options:

    ```ts
    RouterModule.forRoot([], {
      anchorScrolling: 'enabled',
      relativeLinkResolution: 'corrected',
      initialNavigation: 'enabled',
    }),
    ```

    Previously, this module was configured in `StorefrontModule`, which is now deprecated and removed in version 4.0.

1. Configure the NgRx modules in your `AppModule`.

    The NgRx modules were part of the `StorefrontModule`, but similarly to the `RouterModule`, Spartacus requires this configuration to be present in the application. You need to add the following modules to the `imports` of your `AppModule`: `StoreModule.forRoot({})` and `EffectsModule.forRoot([])`. Import these modules from `@ngrx/store` and from `@ngrx/effects`, respectively. The following is an example:

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

1. Continue with the following procedures, which focus on replacing deprecated Spartacus grouping modules.

### Migrating the B2cStorefrontModule

1. From the steps above, the config from `B2cStorefrontModule.withConfig` should already be moved to `SpartacusConfigurationModule` and provided with `provideConfig`, but if not, then please do so now.
1. Add `HttpClientModule` to the imports in your `AppModule` if it is not there.
1. In the `SpartacusFeaturesModule` module imports, add the following modules from the `@spartacus/storefront` library: `StorefrontModule` and `CmsLibModule`.

    These modules are removed in 4.0, but it is better to migrate the modules step by step. The migration of these modules is covered in the next steps.
1. The `B2cStorefrontModule` module provided a few default configs. If you rely on them, add them to your `SpartacusConfigurationModule`. The following is an example:

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

1. Remove any use of `B2cStorefrontModule` from your app.

### Migrating the B2bStorefrontModule

1. config from `B2bStorefrontModule.withConfig` should be already moved to `SpartacusConfigurationModule` and provided with `provideConfig`
1. add `HttpClientModule` to imports in `AppModule` if it's not present there
1. add in `SpartacusFeaturesModule` imports few modules: `StorefrontModule`, `CmsLibModule` from `@spartacus/storefront` (those modules are removed in 4.0, but we want to migrate the modules step by step. Migration of those modules will be covered in next steps) and `CostCenterModule.forRoot()` from `@spartacus/core`
1. this module provided few default configs, so add them to your `SpartacusConfigurationModule` if you rely on them

    ```ts
    provideConfig(layoutConfig),
    provideConfig(mediaConfig),
    provideConfig(defaultB2bOccConfig),
    provideConfig(defaultB2bCheckoutConfig),
    ...defaultCmsContentProviders,
    ```

1. remove usage of `B2bStorefrontModule` from your app

### Migrating the StorefrontModule

1. you should have configured `RouterModule` in `AppRoutingModule`
1. in `AppModule` you should already have `StoreModule.forRoot({})` and `EffectsModule.forRoot([])` present in `imports`
1. add `AsmModule` from `@spartacus/storefront` to imports in `SpartacusFeaturesModule`
1. add `StorefrontFoundationModule` to `SpartacusFeaturesModule` imports.
1. Add `MainModule` to `SpartacusFeaturesModule` imports
1. Add `SmartEditModule.forRoot()`, `PersonalizationModule.forRoot()` and `OccModule.forRoot()` from `@spartacus/core` to imports in `SpartacusFeaturesModule`
1. Add `ProductDetailsPageModule` and `ProductListingPageModule` from `@spartacus/storefront` to imports in `SpartacusFeaturesModule`
1. Add `ExternalRoutesModule.forRoot()` from `@spartacus/core` to imports in `SpartacusFeaturesModule`
1. remove usage of `StorefrontModule` from you app

### Migrating the CmsLibModule

1. add imports listed below from `@spartacus/storefront` directly to imports in `SpartacusFeaturesModule`:

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

1. remove usage of `CmsLibModule` from your app

### Migrating the MainModule

1. add `AnonymousConsentsDialogModule` from `@spartacus/storefront` into imports in `SpartacusFeaturesModule`
1. remove usage of `MainModule` from you app

### Migrating the StorefrontFoundationModule

1. add `AuthModule.forRoot()`, `AnonymousConsentsModule.forRoot()`, `CartModule.forRoot()`, `CheckoutModule.forRoot()`, `UserModule.forRoot()` and `ProductModule.forRoot()` from `@spartacus/core` into imports in `SpartacusFeaturesModule`
1. add `CartPageEventModule`, `PageEventModule` and `ProductPageEventModule` from `@spartacus/storefront` into imports in `SpartacusFeaturesModule`
1. remove usage of `StorefrontFoundationModule` from your app

### Migrating the OccModule

1. add `AsmOccModule`, `CartOccModule`, `CheckoutOccModule`, `ProductOccModule`, `UserOccModule`, `CostCenterOccModule` from `@spartacus/core` to imports in `SpartacusFeaturesModule`
1. remove usage of `OccModule` from your app

### Migrating the EventsModule

1. add `CartPageEventModule`, `PageEventModule` and `ProductPageEventModule` from `@spartacus/storefront` to imports in `SpartacusFeaturesModule`
1. remove usage of `EventsModule` from your app

### Cleaning Up

That's it. You migrated to new app structure. However there is one more thing that we recommend to do. All these huge modules that we just migrated were created to make it easy to create complete spartacus application. What we mean by "complete" is the spartacus with a lot of features enabled out of the box. You might've not even used those features and yet they landed in your application files making your app bigger and by that increasing your application initial load time. As we just replaced these bootstrap modules with granular modules it gives you a great opportunity to remove feature modules that you don't need.

        Here is a list of common features that you might not use:
          - if you don't use ASM feature you can remove from `SpartacusFeaturesModule` imports of `AsmModule` and `AsmOccModule`
          - if you don't use Smartedit you can remove from `SpartacusFeaturesModule` import of `SmartEditModule`
          - if you don't use Qualtrics you can remove from `SpartacusFeaturesModule` import of `QualtricsModule`
          - if you don't use product variants you can remove from `SpartacusFeaturesModule` imports of `ProductVariantsModule`
          - if you don't support replenishments order you can remove from `SpartacusFeaturesModule` imports of `ReplenishmentOrderHistoryModule`, `ReplenishmentOrderConfirmationModule` and `ReplenishmentOrderDetailsModule`

        There are many more modules that you might not need, so we recommend just going through all the imports in `SpartacusFeaturesModule` and verifying if you use it or not. If not just remove it and make your application smaller.

## Upgrading Your Angular Libraries

Before upgrading Spartacus to 4.0, you need first to upgrade Angular to the version 12 and upgrade Angular 3rd party dependencies like `@ng-bootstrap/ng-bootstrap` or `@ng-select/ng-select` to the versions compatible with Angular 12.

```bash
ng update @ng-bootstrap/ng-bootstrap@10 @ng-select/ng-select@7 @angular/core@12 @angular/cli@12
```

For more, see [the official Angular upgrade guide](https://update.angular.io/).

## Upgrading Spartacus to 3.4.x

You must first upgrade all of your `@spartacus` libraries to the latest 3.4.x release before you begin upgrading to Spartacus 4.0. For more information, see [Upgrading Spartacus Libraries to a New Minor Version](https://sap.github.io/spartacus-docs/release-information/#upgrading-spartacus-libraries-to-a-new-minor-version).

## Upgrading Spartacus to 4.0

Spartacus 4.0 includes many new features and fixes. Since this update is a major release, some of the updates may also be breaking changes for your application. In this case, additional work on your side may be required to fix issues that result from upgrading from 3.4.x to 4.0.

To update to version 4.0 of Spartacus, run the following command in the workspace of your Angular application:

```bash
ng update @spartacus/schematics@4
```

When the update has finished running, inspect your code for comments that begin with `// TODO:Spartacus`. For detailed information about each added comment, see [Detailed List of Changes](#detailed-list-of-changes) below.

---
title: Updating Spartacus to Version 4.0
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

1. Create a module called `SpartacusModule` with the following path: `app/spartacus/spartacus.module.ts`.
1. Add the `SpartacusModule` to the `imports` in `AppModule`.
1. Add `BaseStorefrontModule` to the imports and exports of the `SpartacusModule`. This module is exported from the `@spartacus/storefront` library.
1. Create a module called `SpartacusFeaturesModule` with the following path: `app/spartacus/spartacus-features.module.ts`
1. Add the `SpartacusFeaturesModule` to the `imports` in `SpartacusModule`.
1. Create a module called `SpartacusConfigurationModule` with the following path: `app/spartacus/spartacus-configuration.module.ts`.
1. Add the `SpartacusConfigurationModule` to the `imports` in the `SpartacusModule`.
1. Move Spartacus configurations to the `SpartacusConfigurationModule`.

    These are the configurations you pass with `provideConfig`, `provideConfigFactory`, or with the `withConfig` methods from some of the modules (such as the `B2cStorefrontModule` and `ConfigModule`). It is recommended that you use `provideConfig` or `provideConfigFactory` in module providers to configure Spartacus.
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

1. From the steps in the previous section, the configuration from `B2cStorefrontModule.withConfig` should already be moved to the `SpartacusConfigurationModule` and provided with `provideConfig`, but if not, then you can do so now.
1. Add the `HttpClientModule` to the imports in your `AppModule` if it is not there.
1. In the `SpartacusFeaturesModule` module imports, add the `StorefrontModule` and `CmsLibModule` from the `@spartacus/storefront` library.

    These modules are removed in 4.0, but it is better to migrate the modules step by step. The migration of these modules is covered in the next steps.
1. The `B2cStorefrontModule` provided a few default configurations. If you rely on them, add them to your `SpartacusConfigurationModule`. The following is an example:

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

1. Remove any use of the `B2cStorefrontModule` from your app.

### Migrating the B2bStorefrontModule

1. From the steps in the first section, the configuration from `B2bStorefrontModule.withConfig` should already be moved to the `SpartacusConfigurationModule` and provided with `provideConfig`, but if not, then you can do so now.
1. Add the `HttpClientModule` to the imports in your `AppModule` if it is not there.
1. In the `SpartacusFeaturesModule` module imports, add the `StorefrontModule` and `CmsLibModule` from the `@spartacus/storefront` library.

    These modules are removed in 4.0, but it is better to migrate the modules step by step. The migration of these modules is covered in the next steps.
1. In the `SpartacusFeaturesModule` module imports, add `CostCenterModule.forRoot()` from the `@spartacus/core` library.
1. The `B2bStorefrontModule` provided a few default configurations. If you rely on them, add them to your `SpartacusConfigurationModule`. The following is an example:

    ```ts
    provideConfig(layoutConfig),
    provideConfig(mediaConfig),
    provideConfig(defaultB2bOccConfig),
    provideConfig(defaultB2bCheckoutConfig),
    ...defaultCmsContentProviders,
    ```

1. Remove any use of the `B2bStorefrontModule` from your app.

### Migrating the StorefrontModule

1. From the steps in the first section, you should have already configured `RouterModule` in `AppRoutingModule`, but if not, then you can do so now.
1. The `imports` of your `AppModule` should already include `StoreModule.forRoot({})` and `EffectsModule.forRoot([])`, but if not, you can add them now.
1. In the `SpartacusFeaturesModule`, import the `AsmModule` from `@spartacus/storefront`.
1. Add the `StorefrontFoundationModule` to the imports of the `SpartacusFeaturesModule`.
1. Add the `MainModule` to the imports of the `SpartacusFeaturesModule`.
1. In the `SpartacusFeaturesModule`, import `SmartEditModule.forRoot()`, `PersonalizationModule.forRoot()` and `OccModule.forRoot()` from `@spartacus/core`.
1. In the `SpartacusFeaturesModule`, import the `ProductDetailsPageModule` and `ProductListingPageModule` from `@spartacus/storefront`.
1. In the `SpartacusFeaturesModule`, import `ExternalRoutesModule.forRoot()` from `@spartacus/core`.
1. Remove any use of the `StorefrontModule` from you app.

### Migrating the CmsLibModule

1. In the `SpartacusFeaturesModule`, import the following modules from `@spartacus/storefront`:

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

1. Remove any use of the `CmsLibModule` from your app.

### Migrating the MainModule

1. In the `SpartacusFeaturesModule`, import the `AnonymousConsentsDialogModule` from `@spartacus/storefront`.
1. Remove any use of the `MainModule` from you app.

### Migrating the StorefrontFoundationModule

1. In the `SpartacusFeaturesModule`, import the following from `@spartacus/core`:
   - `AuthModule.forRoot()`
   - `AnonymousConsentsModule.forRoot()`
   - `CartModule.forRoot()`
   - `CheckoutModule.forRoot()`
   - `UserModule.forRoot()`
   - `ProductModule.forRoot()`
1. In the `SpartacusFeaturesModule`, import the `CartPageEventModule`, `PageEventModule` and `ProductPageEventModule` from `@spartacus/storefront`.
1. Remove any use of the `StorefrontFoundationModule` from your app.

### Migrating the OccModule

1. In the `SpartacusFeaturesModule`, import the following modules from `@spartacus/core`:
   - `AsmOccModule`
   - `CartOccModule`
   - `CheckoutOccModule`
   - `ProductOccModule`
   - `UserOccModule`
   - `CostCenterOccModule`
1. Remove any use of the `OccModule` from your app.

### Migrating the EventsModule

1. In the `SpartacusFeaturesModule`, import the `CartPageEventModule`, `PageEventModule` and `ProductPageEventModule` from `@spartacus/storefront`.
1. Remove any use of the `EventsModule` from your app.

### Cleaning Up

Now that you have migrated your application to the new app structure, you have the opportunity to remove feature modules that were originally included in the core Spartacus libraries, but which you may not have been using. By removing unused feature modules, you can make your application's initial load time faster.

The following is a list of common Spartacus features that you may not be using, and which you can remove from your application:

- If you do not use ASM, you can remove the `AsmModule` and `AsmOccModule` imports from the `SpartacusFeaturesModule`.
- If you do not use Smartedit, you can remove the `SmartEditModule` import from the `SpartacusFeaturesModule`.
- If you do not use Qualtrics, you can remove the `QualtricsModule` import from the `SpartacusFeaturesModule`.
- If you do not use product variants, you can remove the `ProductVariantsModule` import from the `SpartacusFeaturesModule`
- If you do not support order replenishment, you can remove the  `ReplenishmentOrderHistoryModule`, `ReplenishmentOrderConfirmationModule` and `ReplenishmentOrderDetailsModule` imports from the `SpartacusFeaturesModule`.

There are many more modules that you may not need, and it is recommended to go through all of the imports in the `SpartacusFeaturesModule` and verify if you are using them or not. If not, simply remove the import to make your application smaller.

## Upgrading Your Angular Libraries

Before upgrading Spartacus to 4.0, you first need to upgrade Angular to version 12, and upgrade Angular third party dependencies, such as `@ng-bootstrap/ng-bootstrap` and `@ng-select/ng-select`, to the version that is compatible with Angular 12.

The following is an example command that upgrades Angular to version 12, and also upgrades the related dependencies:

```bash
ng update @ng-bootstrap/ng-bootstrap@10 @ng-select/ng-select@7 @angular/core@12 @angular/cli@12
```

For more information, see the official[Angular Update Guide](https://update.angular.io/).

## Upgrading Spartacus to 3.4.x

You must first upgrade all of your `@spartacus` libraries to the latest 3.4.x release before you begin upgrading to Spartacus 4.0. For more information, see [Upgrading Spartacus Libraries to a New Minor Version]({{ site.baseurl }}/release-information/#upgrading-spartacus-libraries-to-a-new-minor-version).

## Upgrading Spartacus to 4.0

Spartacus 4.0 includes many new features and fixes. Since this update is a major release, some of the updates may also be breaking changes for your application. In this case, additional work on your side may be required to fix issues that result from upgrading from 3.4.x to 4.0.

To update to version 4.0 of Spartacus, run the following command in the workspace of your Angular application:

```bash
ng update @spartacus/schematics@4
```

When the update has finished running, inspect your code for comments that begin with `// TODO:Spartacus`. For detailed information about each added comment, see the [Detailed List of Changes]({{ site.baseurl }}/technical-changes-version-4/#detailed-list-of-changes).

### Importing the App Routing Module from the Storefront Library

After upgrading to 4.0, you can delete your local `app-routing.module` file, if it exists. Instead of importing the local `AppRoutingModule` into your `AppModule`, you should import the `AppRoutingModule` from `@spartacus/storefront`.

## Migrating from Accelerator to Spartacus

If you are considering migrating a project from Accelerator to Spartacus, see [Migrate Your Accelerator-based Storefront to Project Spartacus](https://www.sap.com/cxworks/article/2589632310/migrate_your_accelerator_based_storefront_to_project_spartacus) on the SAP CX Works website.

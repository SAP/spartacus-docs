---
title: Cart Library Release Notes
---

In Spartacus 5.0, the code for the base cart and wish list features has been extracted from the `@spartacus/core` and `@spartacus/storefrontlib` libraries and moved into the cart library. The cart library already existed before the release of Spartacus 5.0, and was already split into separate features.

## Base Cart Functionality

The base cart functionality is now placed within the `base` feature of the cart library, and the entry points that contain the base cart functionality all start with `@spartacus/cart/base/*`. The following is a list of the new base cart entry points:

- `@spartacus/cart/base/assets`: the base cart i18n keys are moved here.
- `@spartacus/cart/base/components`: the base cart-related UI code is moved here. This includes components, guards and UI services.
- `@spartacus/cart/base/core`: the base cart facade API implementations are moved here, as well as the connectors, event builder, event listener, models, other services, and state management.
- `@spartacus/cart/base/occ`: the base cart-related OCC code is moved here. This includes adapters and converters.
- `@spartacus/cart/base/root`: by convention, the root entry point is meant to always be eager loaded.  It contains the config, events, facades, HTTP interceptors, and models.
- `@spartacus/cart/base/styles`: the base cart-related SCSS styles are moved here.

### Lazy Loading the Base Cart Feature

The base cart feature is now lazy loadable. As a result of this update, the base cart feature needs to be imported in your storefront application using a feature module that properly applies standard imports and dynamic imports for the correct entry points. Your application then needs to import that feature module.

If you use the Spartacus schematics to install the base cart feature, the feature module is automatically generated. If you upgrade an existing application to Spartacus 5.0, you need to add the feature module manually. To get the source code for the `CartBaseFeatureModule`, you can create a simple Spartacus application and retrieve the `CartBaseFeatureModule` source from there. Otherwise, the following is a template of the source code for `CartBaseFeatureModule` that you can use, and which should closely resemble the code that is generated from the Spartacus schematics installer:

```ts
import { NgModule } from '@angular/core';
import { cartBaseTranslationChunksConfig, cartBaseTranslations } from "@spartacus/cart/base/assets";
import { ADD_TO_CART_FEATURE, CartBaseRootModule, CART_BASE_FEATURE, MINI_CART_FEATURE } from "@spartacus/cart/base/root";
import { CmsConfig, I18nConfig, provideConfig } from "@spartacus/core";

@NgModule({
  declarations: [],
  imports: [
    CartBaseRootModule
  ],
  providers: [provideConfig(<CmsConfig>{
    featureModules: {
      [CART_BASE_FEATURE]: {
        module: () =>
          import('@spartacus/cart/base').then((m) => m.CartBaseModule),
      },
    }
  }),
  provideConfig(<CmsConfig>{
    featureModules: {
      [MINI_CART_FEATURE]: {
        module: () =>
          import('@spartacus/cart/base/components/mini-cart').then((m) => m.MiniCartModule),
      },
    }
  }),
  provideConfig(<CmsConfig>{
    featureModules: {
      [ADD_TO_CART_FEATURE]: {
        module: () =>
          import('@spartacus/cart/base/components/add-to-cart').then((m) => m.AddToCartModule),
      },
    }
  }),
  provideConfig(<I18nConfig>{
    i18n: {
      resources: cartBaseTranslations,
      chunks: cartBaseTranslationChunksConfig,
    },
  })
  ]
})
export class CartBaseFeatureModule { }
```

## Wish List Functionality

The wish list functionality is now placed within the `wish-list` feature of the cart library, and the entry points that contain the wish list functionality all start with `@spartacus/cart/wish-list/*`. The following is a list of the new wish list entry points:

- `@spartacus/cart/wish-list/assets`: the wish list i18n keys are moved here.
- `@spartacus/cart/wish-list/components`: the wish list-related UI code is moved here. This includes components, guards and UI services.
- `@spartacus/cart/wish-list/core`: the wish list facade API implementations are moved here, as well as the connectors, event builder, event listener, models, other services, and state management.
- `@spartacus/cart/wish-list/occ`: the wish list-related OCC code is moved here. This includes the checkout-related adapters and converters.
- `@spartacus/cart/wish-list/root`: by convention, the root entry point is meant to always be eager loaded. It contains the config, events, facades, HTTP interceptors, and models.
- `@spartacus/cart/wish-list/styles`: the wish list-related SCSS styles are moved here.

## Lazy Loading the Wish List Feature

The wish list feature is now lazy loadable. As a result of this update, the wish list feature needs to be imported in your storefront application using a feature module that properly applies standard imports and dynamic imports for the correct entry points. Your application then needs to import that feature module.

If you use the Spartacus schematics to install the wish list feature, the feature module is automatically generated. If you upgrade an existing application to Spartacus 5.0, you need to add the feature module manually. To get the source code for the `WishListFeatureModule`, you can create a simple Spartacus application and retrieve the `WishListFeatureModule` source from there. Otherwise, the following is a template of the source code for `WishListFeatureModule` that you can use, and which should closely resemble the code that is generated from the Spartacus schematics installer:

```ts
import { NgModule } from '@angular/core';
import { wishListTranslationChunksConfig, wishListTranslations } from "@spartacus/cart/wish-list/assets";
import { ADD_TO_WISHLIST_FEATURE, CART_WISH_LIST_FEATURE, WishListRootModule } from "@spartacus/cart/wish-list/root";
import { CmsConfig, I18nConfig, provideConfig } from "@spartacus/core";

@NgModule({
  declarations: [],
  imports: [
    WishListRootModule
  ],
  providers: [provideConfig(<CmsConfig>{
    featureModules: {
      [CART_WISH_LIST_FEATURE]: {
        module: () =>
          import('@spartacus/cart/wish-list').then((m) => m.WishListModule),
      },
    }
  }),
  provideConfig(<CmsConfig>{
    featureModules: {
      [ADD_TO_WISHLIST_FEATURE]: {
        module: () =>
          import('@spartacus/cart/wish-list/components/add-to-wishlist').then((m) => m.AddToWishListModule),
      },
    }
  }),
  provideConfig(<I18nConfig>{
    i18n: {
      resources: wishListTranslations,
      chunks: wishListTranslationChunksConfig,
    },
  })
  ]
})
export class WishListFeatureModule { }
```

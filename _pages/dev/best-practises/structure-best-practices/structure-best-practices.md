---
title: Structure Best Practices
---

Spartacus schematics installation gives us the basic structure of folder structure. It is adding `spartacus` folder with required modules and `feature` folder with feature libs and their modules. We are recommending to not modify `spartacus` folder with any own folder/files because of schematics installation and possible conflicts in the future. The only once modification we can recommend is about `configuration` folder describe in `layout-best-practices.md` and `i18n-best-practices.md`.

## Our structure recommandations:

### Shared folder

Under `app`, create `shared` folder. This folder will contain all elements used globally in the project like cms-components, components, adapters, connectors, guards, configs, directives, pipes, etc.

We will suggest creating a separate folder for each of the above examples. We will recommend also dividing the folder for components into: `components` and `cms-components`, the first one is to keep shared components, but the second one is to keep all shared components with cms mapping.

### Features folder

Next folder we will recommand to create is `features` folder next to the `shared`. This folder will containt all page main features/modules. For each page funcionality/module we should create seperate folder, including following folders:
- components
- services
- adapters
- configs
- assets
- ...

Below there is an example of the structure:

<img src="{{ site.baseurl }}/assets/images/structure-best-practises-1.png" alt="Shopping Cart" width="700" border="1px" />

### Features module

For each feature module, we are recommending to provide all configs in main feature module:

```
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CartTotalModule } from './components/cart-total/cart-total.module';
import {
  cartCmsConfig,
  cartOccConfig,
  cartRoutingConfig,
  cartTranslationsConfig,
} from './configs/cart.config';
import { provideConfig } from '@spartacus/core';

@NgModule({
  imports: [CommonModule, CartTotalModule],
  providers: [
    provideConfig(cartCmsConfig),
    provideConfig(cartOccConfig),
    provideConfig(cartRoutingConfig),
    provideConfig(cartTranslationsConfig),
  ],
})
export class CustomCartModule {}
```

with config file `cart.config.ts` in `src/app/features/cart/configs/cart.config.ts`:

```
import {
  CmsConfig,
  I18nConfig,
  OccConfig,
  RoutingConfig,
} from '@spartacus/core';

export const cartRoutingConfig: RoutingConfig = {
  routing: {
    routes: {
      customRoute: {
        paths: ['cart/custom'],
      },
    },
  },
};

export const cartOccConfig: OccConfig = {
  backend: {
    occ: {
      endpoints: {
        cart: 'users/${userId}/carts/${cartId}?fields=Full',
      },
    },
  },
};

export const cartCmsConfig: CmsConfig = {
  cmsComponents: {
    CartTotalsComponent: {
      component: CustomCartTotalsComponent,
    },
  },
};

const cartTranslationsOverwrites = {
  en: {
    cart: {
      custom: 'Custom',
    },
  },
};

export const cartTranslationsConfig: I18nConfig = {
  i18n: {
    resources: cartTranslationsOverwrites,
  },
};
```

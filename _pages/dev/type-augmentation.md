---
title: Type augmentation
feature:
  - name: Type augmentation
    spa_version: 3.0
    cx_version: Any version
---

Typescript gives us developers a lot of confidence, safety and speeds development and library discovery. With each Spartacus release we want to provide you better developer experience leveraging possibilities offered by Typescript. With `3.0` release we added one more mechanism to make your life easier - type augmentation.

We already had typed most of the common objects used across the whole codebase such as `Cart`, `Product` and many more. However the shape of these models was defined only by us. You were not able to add additional properties to defined models and had not that good experience working with those extra fields added by your customizations.

From now on we will be adding more and more top level exports which allows you to [augment them](https://www.typescriptlang.org/docs/handbook/declaration-merging.html#module-augmentation).

## Exporting type for augmentation

The most often customized models are currently placed in `@spartacus/core`, so I'll show example module augmentation on an newly added `CostCenter` model used in B2B Checkout.

```ts
export interface CostCenter {
  active?: boolean;
  code?: string;
  name?: string;
  unit?: B2BUnit;
}
```

In core library in our file defining public API `public_api.ts` we export models directly (no reexport).

```ts
export { CostCenter } from './src/model/org-unit.model';
```

That's the only thing we have to do expose model for augmentation. Feel free to submit issues and pull requests with models you find worth exposing for augmentation.

## Augmenting module

As the `CostCenter` can now be augmented we can alter the shape a bit for our needs. Let's say we also need the field `originalCode` to display it to users. You already adjusted endpoint configuration and entity normalizers, but TS still doesn't automatically suggests that this key is also present on that model. To add it to the TS type you have to declare new property on a `CostCenter` module.

```ts
declare module '@spartacus/core' {
  interface CostCenter {
    originalCode?: string;
  }
}
```

The declaration is pretty straightforward. Module name `@spartacus/core` must be set according to the same value as you reference the type. You import the type `import { CostCenter } from "@spartacus/core"`, so the module is `@spartacus/core`.

Warning! Don't add required properties to the module, when you augment it. In library code we might construct new objects of this type and then you will get errors from TS compiler that there are some missing properties in objects of augmented type.

From now on, when you work on an object of type `CostCenter` Typescript compiler will hint this property in autocomplete and will allow you to normally define them on this type without hacking the TS with `as CostCenter` declarations.

## Augmentation in feature libraries

With the new `@spartacus/my-account` library and the new `OrganizationModule` we also work on a `CostCenter` objects. However we needed more properties than what was defined in `@spartacus/core` library. Module augmentation can help in this case as well.

We created new file `cost-center.model.ts` and there used the module augmentation. In feature libraries all properties should be optional as well as it was mentioned above.

```ts
import { Currency } from '@spartacus/core';

declare module '@spartacus/core' {
  interface CostCenter {
    activeFlag?: boolean;
    currency?: Currency;
  }
}
```

Now to make it work we need to reference the file somewhere. So in the file exposing all organization models in public API we added import of this augmented model.

```ts
import './cost-center.model';
```

Now you can safely use new properties in `@spartacus/my-account` library and in the app build based on this library. You can still augment module in the app with your own properties. All those declarations will be combined together and you will be able to use in your application all properties declared in `@spartacus/core`, `@spartacus/my-account` and your module augmentation.

In each module augmentation declaration you use the module name of the library exposing the base type.

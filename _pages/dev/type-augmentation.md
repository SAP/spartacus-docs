---
title: Extending Built-In Models
feature:
  - name: Extending Built-In Models
    spa_version: 2.1
    cx_version: 1905
---

{% capture version_note %}
{{ site.version_note_part1 }} 2.1 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

TypeScript gives developers a lot of confidence and safety, and speeds up development and library discovery. Where possible, Spartacus leverages the possibilities offered by TypeScript to provide a better developer experience. With Spartacus 2.1, you can take advantage of type augmentation.

Spartacus has already typed most of the common objects that are used across the whole codebase, such as `Cart` and `Product` (and many more). However, the shape of these models was defined by Spartacus, which prevented you from adding properties to defined models. This could lead to difficulties working with the extra fields you may have needed in your customizations.

In future releases of Spartacus, more top-level exports will be added, which will allow you to augment them. For more information, see [Module Augmentation](https://www.typescriptlang.org/docs/handbook/declaration-merging.html#module-augmentation) in the TypeScript documentation.

## Exporting Type for Augmentation

The models that are most frequently customized are currently placed in `@spartacus/core`. The following is an example of module augmentation on a newly-added `CostCenter` model that is used in B2B Checkout:

```ts
export interface CostCenter {
  active?: boolean;
  code?: string;
  name?: string;
  unit?: B2BUnit;
}
```

In the core library, in the file that defines the public API (that is, `public_api.ts`), Spartacus exports models directly, meaning there is no re-export. The following is an example:

```ts
export { CostCenter } from './src/model/org-unit.model';
```

**Note:** This approach is required because of the current limitations of Typescript. See TypeScipt issues [#9532](https://github.com/microsoft/TypeScript/issues/9532) and [#18877](https://github.com/microsoft/TypeScript/issues/18877) for more information.

That is all that is required to expose the model for augmentation. Feel free to submit issues and pull requests indicating models that you would like to expose for augmentation.

## Augmenting Modules

Now that the `CostCenter` can be augmented, you can alter the shape a bit to fit your requirements. Let's say you also need to display the `originalCode` field to users. You have already adjusted the endpoint configuration and entity normalizers, but TypeScript still does not automatically suggests that this key is also present on that model. To add it to the TypeScript type, you have to declare a new property on a `CostCenter` module. The following is an example:

```ts
declare module '@spartacus/core' {
  interface CostCenter {
    originalCode?: string;
  }
}
```

In the above example, the `@spartacus/core` module name must be set according to the same value that you use to reference the type. You import the type with the following line:

```ts
import { CostCenter } from "@spartacus/core"
```

Accordingly, the module is `@spartacus/core`.

**Note:** Do not add required properties to the module when you augment it. New objects of this type may be constructed in the library code,and then you will get errors from the TypeScript compiler that there are missing properties in objects of augmented type.

From now on, when you work on an object of type `CostCenter`, the TypeScript compiler will suggest this property in autocomplete, and will allow you to normally define objects on this type without hacking the TypeScript with `as CostCenter` declarations.

## Augmentation in Feature Libraries

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

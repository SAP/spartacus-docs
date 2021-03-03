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

TypeScript gives developers a lot of confidence and safety, and speeds up development and library discovery. Where possible, Spartacus leverages the possibilities offered by TypeScript to provide a better developer experience. With Spartacus 2.1, you can take advantage of TypeScript's type augmentation capabilities.

Spartacus has already typed most of the common objects that are used across the whole codebase, such as `Cart` and `Product` (and many more). However, the shape of these models was defined by Spartacus, which prevented you from adding properties to already-defined models. This could lead to difficulties working with the extra fields you may have needed in your customizations.

In future releases of Spartacus, more top-level exports will be added, which will allow you to augment them.

For more information about type augmentation in general, see [Module Augmentation](https://www.typescriptlang.org/docs/handbook/declaration-merging.html#module-augmentation) in the TypeScript documentation.

## Exporting Type for Augmentation

The models that are most frequently customized are currently placed in `@spartacus/core`. The following is an example of module augmentation on the `CostCenter` model that is used in B2B Checkout:

```ts
export interface CostCenter {
  active?: boolean;
  code?: string;
  name?: string;
  unit?: B2BUnit;
}
```

In the core library, in the `projects/core/public_api.ts` file that defines the public API, Spartacus exports models directly, meaning there is no re-export. The following is an example:

```ts
export { CostCenter } from './src/model/org-unit.model';
```

That is all that is required to expose the model for augmentation.

**Note:** This approach is required because of the current limitations of Typescript. See TypeScript issues [#9532](https://github.com/microsoft/TypeScript/issues/9532) and [#18877](https://github.com/microsoft/TypeScript/issues/18877) for more information.

**Note:** If there are models that you would like to expose for augmentation, you can submit issues and pull requests to the Spartacus project indicating which models you would like to expose.

## Augmenting Modules

Now that the `CostCenter` can be augmented, you can alter its shape to fit your requirements. Let's say you need to display the `originalCode` field to users. Even if you have already adjusted the endpoint configuration and entity normalizers, TypeScript still does not automatically suggest that the `originalCode` key is also present on that model. To add it to the TypeScript type, you have to declare a new property on a `CostCenter` interface. The following is an example:

```ts
declare module '@spartacus/core' {
  interface CostCenter {
    originalCode?: string;
  }
}
```

The module name `@spartacus/core` must be set according to the same value that you use to reference the type. In this case, the module is `@spartacus/core`, and you import the type as follows:

```ts
import { CostCenter } from '@spartacus/core';
```

From now on, when you work on an object of type `CostCenter`, the TypeScript compiler suggests the `originalCode` property in autocomplete, and allows you to define objects on this type normally, without having to hack the TypeScript with `as CostCenter` declarations.

**Note:** When you augment a module, the properties that you add should be optional, rather than required. You should not add required properties because new objects of this type may be constructed in the library code, and then you will get errors from the TypeScript compiler that there are missing properties in objects of augmented type.

**Note:** In any file where a module is augmented, there must be at least one import from the module. It can even be an unused import.

## Augmentation in Feature Libraries

You can also apply module augmentation techniques to feature libraries. To take an example from the Spartacus development team, we needed a `CostCenter` object for the `@spartacus/organization` library and the `AdministrationCoreModule`. However, we needed more properties than were defined in the `@spartacus/core` library.

Accordingly, we created a new `cost-center.model.ts` file where we could apply module augmentation. As with regular module augmentation, when augmenting a feature library, all properties should be optional. The following is an example:

```ts
import { Currency } from '@spartacus/core';

declare module '@spartacus/core' {
  interface CostCenter {
    activeFlag?: boolean;
    currency?: Currency;
  }
}
```

Next, we needed to reference this file. In the file that exposes all the organization models that are in the public API (`feature-libs/organization/administration/core/model/index.ts`), we added an import of this augmented model. The following is an example:

```ts
import './cost-center.model';
```

After that, anyone can safely use the new properties in the `@spartacus/organization` library, as well as in the app build that is based on this library. You can also augment the module in the app with your own properties. All these declarations are combined together, and in your application, you can use all the properties that are declared in `@spartacus/core`, `@spartacus/organization`, and in your module augmentation.

**Note:** In each module augmentation declaration, you use the module name of the library that exposes the base type.

## Enum augmentation

All the examples above showed augmentation of interfaces, but `enum` can be augmented as well.
To augment enum values use `const enum` in most cases.

```ts
declare module '@spartacus/core' {
  const enum ProductScope {
    BULK_PRICING = 'bulkPricing',
  }
}
```

There is one case when you don't want to use `const enum` and that is when you dynamically assign the enum value. Eg. mapping property from backend response to enum value. Augmenting normal `enum` is a bit different, because you also need to provide value for the underlying object (not only the type). This is not needed in case of `const enum` as the values during Typescript compilation are inlined.

```ts
declare module '@spartacus/core' {
  enum ProductScope {
    BULK_PRICING = 'bulkPricing',
  }
}

(ProductScope as any)['BULK_PRICING'] = 'bulkPricing';
```

---
title: Maintaining Public APIs
---

The Spartacus public APIs are developed and maintained according to a set of best practices and procedures that are described in the following sections.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Keeping Public APIs Minimal

It is a challenge to maintain stability in large APIs. If you are making changes to the API library, consider the broad consequences of your changes, and try to anticipate any issues that might arise. It is also a good idea to check the generated public API report with previous `develop` reports, and to make sure that only the things you explicitly want to export are publicly visible.

## Avoiding Breaking Changes

Spartacus releases follow semantic versioning, which means breaking changes are only included in major releases. Breaking changes will not be included in minor or patch releases. A breaking change may be introduced by any of the following actions:

- Changing the selector of a `component`, `directive`, or `pipe`.
- Removing or changing the name of exported classes, functions, constants, interfaces or types in `public_api.ts`. Note that `index.ts` barrels can also bubble up exports to `public_api.ts`.
- Changing or removing interface properties.
- Adding new, required properties to interfaces and types. However, you can add optional properties with `?`.
- Changing or removing `public` or `protected` class members.
- Changing or removing existing `public` or `protected` function parameters. Note that changing the order also introduces a breaking change.
- Adding new, required parameters to `public` functions. However, you can add optional parameters to `public` functions.
- Changing access levels on classes, functions or interfaces to a more restrictive access level. In other words, changing `public` to `protected` or `private`, or changing `protected` to `private` introduces a breaking change.
- Changing function's return type form `T` to `T | S`
- Changing function behavior where the function returns different results. In other words, when changing function behavior, the function should return the same results for the same provided input as it did before the change.
- Changing assertions in unit tests or end-to-end tests.
- Removing anything from Angular modules, such as imports, providers, declarations, entryComponents, or exports.
- Removing or updating existing values, or changing the order for exported enums. However, you can add new values.
- Changing the default value for function parameters. The default value should match the function behavior from before the change.
- Making any changes to the class constructor signature. Note that `super` calls need to be updated in classes extending ours.
- Changing the initial values of an exported class's `public` or `protected` fields, or changing them to read-only.
- Changing or removing translation keys or values.

  **Note:** Adding new translation keys and values is not considered a breaking change.
- Changing default configurations.
- Changing any CSS or SCSS attributes, classes or selectors.
- Changing anything that affects the rendering of the existing DOM. 

  **Note:** Additions, changes, or deletions of `aria` attributes (for screen readers) are not considered breaking changes.

## Adding New Constructor Dependencies in Minor Versions

The following describes what to do, and what not do do, when adding a new constructor dependency in a minor version.

The following is an example of some code before a new constructor dependency is added:

```ts
  constructor(
    protected promotionService: PromotionService,
  ) {}
```

A new `cartItemContextSource` constructor dependency is then added, as follows:

```ts
  constructor(
    protected promotionService: PromotionService,
    protected cartItemContextSource: CartItemContextSource
  ) {}

  /* ... */

  method() {
    console.log(this.cartItemContextSource.item$);
  }
```

This would cause a breaking change (specifically, a compilation error) for any customer who upgrades to the new minor version and who has previously extended our service in their codebase by calling the `super()` constructor with less parameters, such as in the following example:

```ts
   export class CustomService extends SpartacusService {
     constructor(promotionService: PromotionService){
       super(promotionService); // <--------- wrong constructor signature
       /* customer's constructor logic here */
     }
   }
   ```

Instead, the new constructor dependency should be added as follows:

```ts
  // TODO(#10946): make CartItemContextSource a required dependency
  constructor(
    promotionService: PromotionService,
    // eslint-disable-next-line @typescript-eslint/unified-signatures
    cartItemContextSource: CartItemContextSource
  );
  /**
   * @deprecated since 3.1
   */
  constructor(promotionService: PromotionService);
  constructor(
    protected promotionService: PromotionService,
    @Optional() protected cartItemContextSource?: CartItemContextSource
  ) {}

  /* ... */

  method() {
    console.log(this.cartItemContextSource?.item$);
  }
```

When adding a new constructor dependency, you **must** do the following:

- Add `?` to make the new constructor parameter optional. Otherwise, customers who pass less arguments will get a compilation error.
- In the logic of your class, allow for the new constructor parameter to be null or undefined. You can do this by accessing any properties of the new dependency with optional chaining (`?.`), such as `this.cartItemContextSource?.item$`. If this is not done, a customer who extends our class and passes less parameters to the `super()` constructor will get a runtime error in our logic because the `this.cartItemContextSource` object would be undefined.
- If your new constructor dependency might not be provided for your class (for example, the dependency service is not `providedIn: 'root'`, or is provided conditionally in the DOM), then precede the constructor dependency with `@Optional()`. Otherwise, when the dependency is not conditionally provided, customers will get an Angular runtime error that the dependency cannot be resolved. Preceding the constructor dependency with `@Optional()` tells Angular to fall back gracefully to `null` when the value cannot be injected.

Aside from the above requirements, we also encourage you to do the following:

- Add an inline comment, such as `// TODO(#ticket-number): make X a required dependency`, to reference planned work for the next major version.
- Add two alternative declarations of the constructor above the implementation. **The top declaration must be the newest one**. This is because, in a production build using SSR, only the first declaration is used to resolve dependencies. It is also helpful to add `@deprecated since X.Y` to your JSDoc comment. When this is included, customers can be warned by their IDE that the old constructor signature they are using (with less parameters) is deprecated, and this can motivate them to migrate early to the new signature.

### Using the Inject Decorator for Dependencies

You should not include any constructor declarations when using `@Inject` for dependencies. Instead, you should only include the constructor definition.

When you build libraries (for example, when you run `ng build --prod core`), the `ng-packagr` tool only uses the first constructor declaration to resolve injected dependencies, and the construction definition is ignored. However, the `Inject` decorator is not supported in constructor declarations, so it cannot be used to resolve dependencies there. If you include a constructor declaration with a dependency, the `ng-packagr` tool will fail to resolve the dependency and you will get an error, as follows:

```shell
> ERROR: Internal error: unknown identifier []
```

The following is an example that will give you this error:

```typescript
import { PLATFORM_ID } from '@angular/core';
/*...*/

  // Do not add any constructor declarations when using @Inject to resolve a dependency
  constructor(
    platformId: any, // this dependency will not be resolved, nor can it be fixed with @Inject, because the Inject decorator is not supported here!
    newService?: NewService
  ) {}
   constructor(
    protected platformId: any,
  ) {}

  constructor(
    @Inject(PLATFORM_ID) protected platformId: any,
    protected newService?: NewService
  ) {}
```

The following is a modification of the previous example that illustrates how you can use the `Inject` decorator to handle a dependency:

```typescript
import { PLATFORM_ID } from '@angular/core';
/*...*/

  constructor(
    @Inject(PLATFORM_ID) protected platformId: any,
    protected newService?: NewService
  ) {}
```

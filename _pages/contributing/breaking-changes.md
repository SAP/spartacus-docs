---
title: Maintaining Public APIs
---

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
- Changing default configurations.
- Changing any CSS or SCSS attributes, classes or selectors.
- Changing anything that affects the rendering of the existing DOM.

## How to add new constructor dependencies in minor versions
Let's say we want to add a new constructor dependency `cartItemContextSource` in a minor version. For example:

Before:
```ts
  constructor(
    protected promotionService: PromotionService,
  ) {}
```

After:
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

That would cause a breaking change (compilation error) when upgrading to that minor version by a customer who already extended our service in his codebase, calling `super()` constructor with less parameters.

```ts
   export class CustomService extends SpartacusService {
     constructor(promotionService: PromotionService){
       super(promotionService);
       /* customer's constructor logic here */
     }
   }
   ```

### Ideal solution
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

#### MUST HAVEs:

- Add `?` to make the new constructor parameter optional. Otherwise customer passing less arguments will get a compilation error.
-  In the latter code of your class, be prepared that the new constructor parameter might be undefined. Please simply access any properties of the new dependency with `?.` (optional chaining), for example `this.cartItemContextSource?.item$`. Otherwise a customer extending our class and passing less params to the `super()` constructor, will get a runtime error because there is no property `item$` of undefined.
- If your new constructor dependency **might** be not provided for your class (i.e. the dependency service is not `providedIn: 'root'` or is provided conditionally in the DOM, etc.), then precede it with `@Optional()`. Otherwise when the dependency is conditionally NOT provided customers, customer will get an Angular runtime error (that it can't resolve the dependency). Preceding with `@Optional()` tells Angular to fallback gracefully to `null` value when cannot inject.

#### NICE TO HAVEs:
- add inline comment `// TODO(#ticket-number): make X a required dependency`
- add 2 alternative **declarations** of the constructor above the implementation. **The top one** has to be **the newest one**. (It's because in prod SSR build only the first declaration is used to resolve dependencies). Moreover you can `@deprecated since X.Y` the old constructor in the JSDoc comment. Thanks to that, customers can get warned by their IDE that the old constructor signature they are using (with less params) is deprecated and motivate them to migrate to the new signature early before the next major release.
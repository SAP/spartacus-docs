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

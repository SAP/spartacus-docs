---
title: Maintaining Public APIs (DRAFT)
---

## Keeping Public APIs Minimal

It is a challenge to maintain stability in large APIs. If you are making changes to the API library, consider the broad consequences of your changes, and try to anticipate any issues that might arise. It is also a good idea to check the generated public API report with previous `develop` reports, and to make sure that only the things you explicitly want to export are publicly visible.

## Avoiding Breaking Changes

We try to following semantic versioning, which means keeping breaking changes for major releases. When working on new features or bug fixes, the following list of guidelines can help you to avoid introducing breaking changes:

- Do not change the selector of the `component` or `directive` or `pipe`.
- Do not change or remove exported classes, functions, constants, interfaces or types in `public_api.ts`. Note that `index.ts` barrels can also bubble up exports to `public_api.ts`.
- Do not change or remove interface properties.
- Do not add new, required properties to interfaces and types (only optional with '?')
- Do not change or remove `public` or `protected` class members
- Do not change or remove existing `public` or `protected` function parameters (also do not change the order)
- Do not add new, required parameters to public functions (only optional)
- Do not change function behavior. After a change, the function should return the same output for the same provided input, and should dispatch the same side effects. Bug fixes might require different function behavior for edge cases.
- Do not change or remove unit tests. You can change internal implementation details, but assertions should not be changed.
- Do not remove anything from Angular modules, such as imports, providers, declarations, exports, and so on.
- Do not remove or update existing values, or change the order for exported enums. Only add new values.
- Do not change the default value for new functions parameters. The default value should match the function behavior from before the change.
- Do not make any changes to the class constructor. Any change to the class constructor is considered a breaking change (`super` calls needs to be updated in classes extending ours).
- Do not change the initial values of an exported class's fields, or change them to readonly.
- Do not change or remove translations.
- Do not remove or change default configs.

If you have any other general rule regarding breaking changes, feel free to add it.

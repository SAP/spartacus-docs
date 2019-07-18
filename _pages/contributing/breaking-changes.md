---
title: Maintaining Public APIs (DRAFT)
---

## Keeping Public APIs Minimal

It is a challenge to maintain stability in large APIs. If you are making changes to the API library, consider the broad consequences of your changes, and try to anticipate any issues that might arise. It is also a good idea to check the generated public API report with previous `develop` reports, and to make sure that only the things you explicitly want to export are visible publicly.

## Avoiding Breaking Changes

We try to following semantic versioning, which means keeping breaking changes for major releases. When working on new features or bug fixes, the following list of guidelines can help you to avoid introducing breaking changes:

- Do not change the selector of the `component` or `directive` or `pipe`.
- Do not change or remove exported classes, functions, constants, interfaces or types in `public_api.ts`. Also note that `index.ts` barrels can also bubble up exports to `public_api.ts`.
- don't change or remove interface properties
- don't add new required properties to interfaces and types (only optional with '?')
- don't change or remove public/protected class members
- don't change or remove existing public/protected functions parameters (also don't change order)
- don't add new required parameters to public functions (only optional)
- don't change function behavior (after change it should return the same output for provided input and dispatch same side effects). Bug fixes might require different function behavior for edge cases.
- don't change, remove unit tests (you can only change internal implementation details, assertions shouldn't be changed)
- don't remove anything from Angular modules (imports, providers, declarations, exports)
- don't remove, update existing values or change order for exported enums (only add new values)
- default value for new functions parameters should match function behavior before change
- any change to class constructor is breaking (`super` calls needs to be updated in classes extending ours)
- don't change initial values of exported class' fields or change them to readonly
- don't change or remove translations
- don't remove or change default configs

If you have any other general rule regarding breaking changes feel free to add it.

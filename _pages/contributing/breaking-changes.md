---
title: Breaking changes (DRAFT)
---

## Avoiding breaking changes

Below is a list of things should avoid doing while working on new features and bug fixes. We try to following semantic versioning and doing that means keeping breaking changes for major releases. This list should make you aware of different ways to introduce breaking changes.

- don't change selector of component/directive/pipe
- don't change or remove exported classes, functions, constants, interfaces and types in `public_api.ts` file
- don't change or remove interface properties
- don't change or remove public/protected class members
- don't change or remove existing public functions parameters (also don't change order)
- don't add new required properties to interfaces and types (only optional with '?')
- don't add new required parameters to public functions (only optional)
- don't change function behavior (after change it should return the same output for provided input and dispatch same side effects). Bug fixes might require different function behavior for edge cases.
- don't change, remove unit tests (you can only change internal implementation details, assertions shouldn't be changed)
- don't remove anything from Angular modules (imports, providers, declarations, exports)
- check generated public API report with previous `develop` report. Make sure only things that you explicitly wanted exported are visible publicly.
- don't remove or update existing values for public enums (only add new values)
- default value for new functions parameters should match function behavior before change
- any change to class constructor is breaking (`super` calls needs to be updated in classes extending ours)
- don't change exported class fields to readonly
- don't change or remove translations

If you have any other general rule regarding breaking changes feel free to add it.

Keeping enormous API we have stable is very challenging. Always think about bigger consequences of your changes and try to anticipate new problems, when changing library API.

---
title: Updating Schematics
---

When upgrading Spartacus to a new major version (for example, from 3.x to 4.0), the Spartacus migration mechanism automatically implements fixes for code that is modified or removed in the new version.

When you are working on a feature or a bug, or making any other change to the Spartacus source code, you need to update the schematics as part of the [Definition Of Done]({{ site.baseurl }}{% link _pages/contributing/definition-of-done.md %}). By making these updates iteratively as part of the DoD for each change to the source code, it saves you from having to spend a lot of time upgrading the migration mechanism at the end of the development cycle, and as a result, it makes it easier to prepare the Spartacus libraries for a new major version.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Migration Mechanism

After upgrading to a new major version, the migration mechanism should be updated at the very beginning of the new development cycle. For example, if Spartacus has been updated from version 2.x to 3.0, the updated mechanism should be merged to the `develop` branch as soon as possible. This allows contributors to include migrations with their features and bug fixes from the very start of the development cycle.

## Structure for Updating Schematics

The `projects/schematics/src/migrations/migrations.json` file contains a list of all the migration scripts for every Spartacus version. The following is an example of a migration script:

```json
"migration-v3-constructor-deprecations-03": {
      "version": "3.0.0",
      "factory": "./3_0/constructor-deprecations/constructor-deprecations#migrate",
      "description": "Add or remove constructor parameters"
    },
```

Each script has a set of properties, which are described as follows:

- `name` allows developers to quickly understand what the migration script is doing. The migration `name` has the following pattern: `migration-v<version>-<migration-feature-name>-<sequence-number>`. The elements of `name` are as follows:
  - `version` indicates which version of Spartacus the migration is intended for.
  - `migration-feature-name` is a short name that describes what the migration is doing.
  - `sequence-number` indicates the order of execution for the migration scripts. For example, if a script has a `sequence-number` of `03`, it will be the third script to execute when the migration scripts are run.
- `version` is very important for the Angular update mechanism. It is used to automatically run the required migration scripts for a specific version. For more information, see the [Releasing Update Schematics](https://github.com/SAP/spartacus/tree/develop/projects/schematics#releasing-update-schematics) section of the schematics README.
- `factory` points to the relevant migration script.
- `description` is a short, free-form description field to describe what the migration script does.

## Validations

If any validations need to be run before actually upgrading Spartacus, you can use the "migration script" located in `projects/schematics/src/migrations/2_0/validate.ts`.

## Constructor Deprecation

The `projects/schematics/src/migrations/2_0/constructor-deprecations.ts` performs the constructor migration tasks. Usually, a developer does not need to touch this file, and instead should describe constructor deprecations in `projects/schematics/src/migrations/2_0/constructor-deprecation-data.ts`. The `CONSTRUCTOR_DEPRECATION_DATA` constant describes the deprecated constructor, and includes the `addParams` and `removeParams` properties that allow you to specify which parameters should be added or removed, respectively.

## Commenting Code

When it is not possible to automatically migrate code, we often place a comment in the customer's code base that describes what the customer should do to upgrade their project to the new version of Spartacus. We should do this only in cases where upgrading manually is easy, and writing a migration script would be too complex.

The `projects/schematics/src/shared/utils/file-utils.ts#insertCommentAboveIdentifier` method adds comments above the specified `identifier` TypeScript node.

The following are examples of how you might add a comment:

- If you removed an API method, you could add a comment above the removed method that suggests which method can be used instead.
- If you changed the parameters of an NgRx action, you could add a comment above the action where the parameters were changed.

## Component Deprecation

Similar to constructor deprecation, `projects/schematics/src/migrations/2_0/component-deprecations.ts` performs component migration tasks, for both component `*.ts` and `HTML` templates. Usually, a developer does not need to touch this file, and instead should describe component deprecations in `projects/schematics/src/migrations/2_0/component-deprecations-data.ts`. The `COMPONENT_DEPRECATION_DATA` constant describes the deprecated components.

## CSS

To handle CSS changes, we print a link to the CSS migration documentation, where customers can look up which CSS selectors have changed in the new version of Spartacus. If you are making a change to a CSS selector, simply update the relevant documentation (such as, [Changes to Styles in 3.0]({{ site.baseurl }}{% link _pages/home/updating-to-version-3/css-changes-in-version-3.md %})).

## Adding a Migration

The following is an example flow for adding a migration:

- Check whether any of the changed files are exported in the public API. If no, then no further action is required.
- Check whether any of the changes you have made are breaking changes. If not, no further action is required. For more information, see [Maintaining Public APIs]({{ site.baseurl }}{% link _pages/contributing/breaking-changes.md %}).
- For every breaking change, you must do the following:
  - Document the breaking change by updating the corresponding migration doc file (such as `docs/migration/3_0.md`), and if necessary, ensure that code comments have been added.
  - Build automation tasks, as described in the [Validations](#validations), [Constructor Deprecation](#constructor-deprecation), and [Component Deprecation](#component-deprecation)) sections, above.
  - Test the added migrations by running tests, trying to migrate an example app, and so on.

You can see an example of adding a migration in [this pull request](https://github.com/SAP/spartacus/pull/9946/files).

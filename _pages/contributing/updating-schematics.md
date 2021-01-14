---
title: Updating Schematics
---
## Introduction

The Spartacus' migrations mechanism has been developed in order to perform automatic changes of the code which has been either change or removed in a newer major version. As a part of the [Definition Of Done]({{ site.baseurl }}{% link _pages/contributing/definition-of-done.md %}), while working on a bug, feature or other change in the Spartacus' source code requirements described in this document has to be fulfilled. It makes upgrading Spartacus to a new major version (eg. 3 -> 4) much easier for developers who:
- contribute to Spartacus: no need to spent tons of time on upgrading the migrations mechanism just before the actual release
- integrate Spartacus: automatic migrations will take an action (either updating the code to it's new form or, at least, auto-comment parts of the used code which can't be updated programatically)

That being said, more changes covered with migration mechanism mean less manual work during the Spartacus major upgrade.
## Migrations mechanism

The migrations mechanism should be updated at the very beginning of a new development path after upgrading to new major version. For example, if Spartacus has been updated from version 2 to 3, updated mechanism should be merged to develop branch as soon as possible (to allow contributors provide migrations along with features and bug fixes).

## Structure for Updating Schematics

The `projects/schematics/src/migrations/migrations.json` file contains all migration scripts for all Spartacus versions:

- _name_ property is important for developers to quickly understand what the migration script is doing. By convention, the migration _name_ should follow `migration-v<version>-<migration-feature-name>-<sequence-number>` pattern, where:
  - _version_ should indicate for which Spartacus version the migration is intended.
  - _migration-feature-name_ is a short name that describes what the migration is doing.
  - _sequence-number_ is the sequence number in which the migrations should be executed
  - An example is _migration-v2-update-cms-component-state-02_.
- _version_ is _really_ important for the Angular's update mechanism, as it is used to automatically execute the required migration scripts for the current project's version. For more information about this, please check [releasing update schematics](#releasing-update-schematics) section.
- _factory_ - points to the specific migration script.
- _description_ - a short free-form description field for developers.

## Validations

If some validations are required to be ran before actually upgrading the Spartacus version, the "migration script" located in `projects/schematics/src/migrations/2_0/validate.ts` can be used.

## Constructor Deprecation

The `projects/schematics/src/migrations/2_0/constructor-deprecations.ts` performs the constructor migration tasks. Usually, a developer does not need to touch this file, but they should rather describe the constructor deprecation in `projects/schematics/src/migrations/2_0/constructor-deprecation-data.ts`. The constant `CONSTRUCTOR_DEPRECATION_DATA` describes the deprecated constructor and has `addParams` and `removeParams` properties in which you can specify which parameters should be added or removed, respectively.

## Commenting Code

Another common case is to place a comment in customer's code base, describing what should they do in order to upgrade to a new Spartacus version. We should do this only in cases where upgrading manually is easy, but writing a migration script would be too complex.
The `projects/schematics/src/shared/utils/file-utils.ts#insertCommentAboveIdentifier` method will add comment above the specified _identifier_ TypeScript node.

Some examples:

- adding a comment above the removed API method, guiding customers which method they can use instead.
- adding a comment above the Ngrx action in which we changed parameters

## Component Deprecation

Similar to [constructor deprecation](#Constructor-deprecation), `projects/schematics/src/migrations/2_0/component-deprecations.ts` performs the component migration tasks, for both component _*.ts_ and _HTML_ templates. Usually, a developer does not need to touch this file, and they should rather describe the component deprecation in `projects/schematics/src/migrations/2_0/component-deprecations-data.ts`. The constant `COMPONENT_DEPRECATION_DATA` describes the deprecated components.

## CSS

To handle CSS changes, we are printing a link to the CSS docs, where customers can look up which CSS selectors have changed between Spartacus versions. For this reason, if making a change to a CSS selector, please update this docs. (link to follow).

## Example flow of adding a migration

As a Spartacus' contributor, after finish work on bug/feature/other change, to properly take care of a migration please follow the below checklist:
- check wether any of changed files is exported in the public API (if no, you're done)
- check wether changes made are [the breaking ones]({{ site.baseurl }}{% link _pages/contributing/breaking-changes.md %}) - if no, you're done.
- for all the breaking changes please ensure that you have:
  - docummented them, ie updated the corresponding migration docs file (for migration from 2 to 3 it's `docs/migration/3_0.md`) and/or code comments has been added
  - builded automation tasks (check for described above: [validations](#validations), [constructor deprecations](#constructor-deprecation), [component deprecations](#component-deprecation))
  - tested added migrations (run tests, try to migrate an example app)
- nice and short example of migration being made is [this one](https://github.com/SAP/spartacus/pull/9946/files)

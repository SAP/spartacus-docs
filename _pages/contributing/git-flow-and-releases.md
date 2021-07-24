---
title: Git Flow and Release Process
---

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Library Version Compatibility

The Spartacus project is made up of a set of libraries. To make it easier to know which version of a library is compatible with another version, the library versions are synchronized across all packages. This means that when we want to release version `1.5.0`, we release all libraries under this version, even if some libraries do not have any changes since the previous release. In so doing, we can use a single version number to refer to the entire set of Spartacus libraries for any given release.

This also means that you can be confident that if you install all packages with the same version, everything will work together correctly. Different versions of libraries may work well together, but we do not test those configurations and cannot promise correct behavior.

## Version Support

For versioning, we follow semantic versioning, also known as [SemVer](https://semver.org). Aside from `stable` versions, Spartacus also produces `next` and `rc` releases.

Our assumptions about versions are as follows:

- A `stable` version is a well-tested Spartacus release (including testing by the community), and will only be patched with bug fixes. These versions are available under the `latest` tag on [npm](https://www.npmjs.com).
- An `rc` version is released when the Spartacus team has finished development of all new features for that version, which means there won't be any major changes in the features nor in the public API. The community can safely start testing the features in an `rc` release. An `rc` release might contain a few bugs that will be fixed before the `stable` version is released. When there aren't any more bugs and the community stops reporting issues for that version, we proceed with producing the `stable` release.
- A `next` version is released when the Spartacus team finishes a particular feature. This allows the community to start testing the feature right away. These `next` versions may contain a lot of bugs, and the features and public API may be still be subject to change. If you want to test new features as soon as possible, this is the version for you. The `next` versions are available under the `next` tag on [npm](https://www.npmjs.com).

    **Note:** It is strongly recommended that you **do not** use a `next` version in a production setup. This is because upgrading from a `next` release may be much more difficult that upgrading from one `stable` version to another.

### Support Policy

There is always at least one `stable` or `rc` version supported.

Once version `x.y` is released, it will be actively maintained until a new `stable` or `rc` for version `x.z` is released. At that point, version `x.z` will become the actively maintained version, and work on the next version wil begin.

For example, let's say we just released version `1.5.0-rc.0`. From that moment, version `1.5.x` will be actively maintained, until we release `1.6.0-rc.0`. Once version `1.6.0-rc.0` is released, then we would switch active support to version `1.6.x`.

**Note:** For important security issues or critical bug fixes, there may be additional patches for versions that are no longer actively maintained.

## Git Flow

The flow in the Spartacus project is structured around the version support described in the previous sections.

The `develop` branch is the default branch, and is intended for new version development, for both minor and major versions. All features and bug fixes are merged to this branch.

There is also a maintenance branch, which changes with new `stable` or `rc` releases, and this is used for patch versions. Only bug fixes are merged to the maintenance branch.

Once we release version `1.4.0-rc.0`, the `release/1.4.x` branch is treated as a maintenance branch. When we release version `1.5.0-rc.0`, then the `release/1.5.x` branch becomes the maintenance branch, and so on.

Other branch conventions:

- `feature/GH-xxxx` branches are used for simple features and bug fixes
- `epic/epic-name` branches are used for big features (called epics)
- `release/1.4.0-rc.0` branches are used for specific releases (you can distinguish them from maintenance branches because the full version number is included)

### Flow for Epic Development

The following are the steps for working with epics:

1. Create a new `epic/epic-name` branch from the `develop` branch.
1. Create branches for epic subtasks from `epic/epic-name`, and merge them back to the `epic/epic-name` branch.
1. From time to time, update your `epic/epic-name` branch with changes from the `develop` branch (it will help you with managing conflicts).
1. When the epic is complete, create a PR and merge the `epic/epic-name` branch to the `develop` branch.

### Flow for Smaller Features

The following are the steps for working with smaller features:

1. Create a new `feature/GH-xxxx` branch from the `develop` branch.
1. Develop your feature.
1. When you have finished, create a PR and merge the `feature/GH-xxxx` branch to the `develop` branch.

### Flow for Bug Fixes

The following are the steps for working with bug fixes:

1. Create a new `feature/GH-xxxx` branch from the `develop` branch.
1. Fix the bug.
1. Create a PR and merge the `feature/GH-xxxx` branch to the `develop` branch.
1. If this fix applies to the actively-supported version, create a new `feature/GH-xxxx-maintenance` branch from the maintenance branch.
1. Cherry pick the commit with the fix from the `develop` branch.
1. Create a PR and merge `feature/GH-xxxx-maintenance` into the maintenance branch.

## Release Schedule

Currently, we do not have scheduled releases. The product owner or the team decides when to release a new version.

## Terminology

The following are terms we currently use that can be misleading:

- "feature freeze" describes a moment when we have completed all features for a new minor or major release (which means we want to release an `rc` very soon, but still need to fix some bugs).
- "code freeze" describes the moment when we stop committing code (although this is not needed with our flow, because we can always cut a release or maintenance branch and keep committing).

The following concepts can be used to replace these terms:

- Instead of having a feature freeze, we can create a new maintenance branch and release a new `rc`. The first RC can be buggy, because it is accepted that `rc` releases may contain bugs.
- Instead of having a code freeze, we can create a new release branch. We never need to block the main development or maintenance branch (and we don't need to bother developers with these details, because our flow supports concurrent work on these branches and releasing another version).

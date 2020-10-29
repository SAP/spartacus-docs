---
title: Git Flow and Release Process
---

## Library Versions Compatibility

In this document we always refer to version as a single instance. However spartacus project is not a single library, but a set of libraries.

To make it easier to know which version of one library is compatible with another library we keep version synchronized across all packages.
That means when we want to release version `1.5.0` we release all libraries under this version (even if some libraries doesn't have any changes since the last release).

Thanks to that you can be confident that if you install all packages with the same version everything will work correctly together. Different versions of libraries might work well together, but we don't test those configurations and can't promise correct behavior.

## Version support

For versioning we follow semver. (TODO put link here). Apart from `stable` versions we make use of `next` and `rc` releases.

Our assumptions about versions:

- `stable` version is well tested (also by community) spartacus release that will only be patched with bug fixes (versions available under `latest` tag on `npmjs.rg`).
- `rc` version means that we finished development of all new features for that version (there won't be any major changes in this features and public API) and community can start testing those. These release might contain few bugs that will be fixed before stable release. When there won't be any more bugs and community stops reporting issues for that version we proceed with `stable` release.
- `next` versions are released when we finish some particular feature so community can test them instantly. This versions can have a lot of bugs. Features and public API might be still a subject for big changes. If you want to test new features as soon as possible this is the versions for you (versions available under `next` tag on `npmjs.org`).

### Support policy

There is always at least one `stable` or `rc` version supported.

Once version `x.y` is released it will be actively maintained until new `stable` or `rc` for `x.z` version will be released.
On that moment `x.z` version will be the actively maintained version and work on next version begins.

Eg. We just released `1.5.0-rc.0` version. From that moment `1.5.x` version will be actively maintained until we release `1.6.0-rc.0` which would switch active support to `1.6.x` version.

For important security issues or critical bug fixes there might be additional patch for versions no longer actively maintained.

## Git flow

Flow in spartacus project was structured around version support described above.

`develop` is the default branch intended for new version development (is used for minor/major versions). All features and bug fixes are merged to this branch.

There is also so called maintenance branch which changes on new `stable`/`rc` release and is used for patch versions. Only bug fixes are merged to this branch.
Once we release version `1.4.0-rc.0` the `release/1.4.x` branch is treated as a maintenance branch. When we release `1.5.0-rc.0` version then the `release/1.5.x` branch becomes the maintenance branch and so on.

Other branches convention:

- `feature/GH-xxxx` branches are used for simple features and bug fixes
- `epic/epic-name` branches are used for big features (called epics)
- `release/1.4.0-rc.0` branches are used for specific release (you can distinguish them from maintenance branches, because the full version number is included)

### Flow for epic development

- create from `develop` branch new `epic/epic-name` branch
- create branches for epic subtasks from `epic/epic-name` and merge them to `epic/epic-name` branch
- from time to time update your `epic/epic-name` branch with changes from `develop` branch (it will help you with managing conflicts)
- once the epic is complete create PR and merge `epic/epic-name` branch to `develop` branch

### Flow for new simple feature

- create from `develop` branch new `feature/GH-xxxx` branch
- develop your feature
- when you finish create PR and merge `feature/GH-xxxx` branch to `develop` branch

### Flow for bug fix

- create from `develop` branch new `feature/GH-xxxx` branch
- fix the bug
- create PR and merge `feature/GH-xxxx` branch to `develop` branch
- if this fix applies to actively supported version create new branch `feature/GH-xxxx-maintenance` from maintenance branch
- cherry pick commit with the fix from `develop` branch
- create PR and merge `feature/GH-xxxx-maintenance` into maintenance branch

## Release schedule

Currently we don't have scheduled releases. Product owner or team decides when is a good time to release a new version.

Terms we currently use that are misleading:

- feature freeze - describes moment when we completed all features for new minor/major release (means that we want to release `rc` very soon, but still needs to fix some bugs)
- code freeze - describes moment when you should stop committing code (that is not needed with our flow, because we can always cut release/maintenance branch and keep committing)

Replacements for those terms:

- feature freeze -> new maintenance branch and release new `rc` - first RC can be buggy, that's the point of RC
- code freeze -> create new release branch - don't block main development/maintenance branch ever (don't need to bother developers with these details, because our flow supports concurrent work on these branches and releasing another version).

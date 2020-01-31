---
title: Git flow and release process
---

## Version support

For versioning we follow semver. (TODO put link here). Apart from `stable` versions we make use of `next` and `rc` releases.

Our assumptions about versions:

- `stable` version is well tested (also by community) spartacus release that will only be patched with bug fixes (versions available under `latest` tag on `npmjs.rg`).
- `rc` version means that we finished development of all new features for that version (there won't be any major changes in this features and public API) and community can start testing those. These release might contain few bugs that will be fixed before stable release. When there won't be any more bugs and community stops reporting issues for that version we proceed with `stable` release.
- `next` versions are released when we finish some particular feature so community can test them instantly. This versions can have a lot of bugs. Features and public API might be still a subject for big changes. If you want to test new features as soon as possible this is the versions for you (versions available under `next` tag on `npmjs.org`).

There is always at least one `stable` or `rc` version supported.

Once version `x.y` is released it will be actively maintained until new `stable` or `rc` for `x.z` version will be released.
On that moment `x.z` version will be the actively maintained version and work on next version begins.

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

## Release process

TODO - document when we can release (what needs to be finished), steps to do before release, how to ensure quality of the release

## Release steps

You can use following checklist for your release github issue to avoid mistakes during release

- [ ] validate that every merged ticket was tested (nothing should be left in QA column, exceptions - ticket marked as `not-blocking-release`)
- [ ] for new minors/RC create maintenance branch e.g. `release/1.5.x`
- [ ] announce new maintenance branch on tribe channel (only when new maintenance branch is created)
- [ ] create release branch eg. `release/1.5.0` (from develop for `next` release, from maintenance branch for any other release)
- [ ] build app on this branch using this script: [https://github.tools.sap/cx-commerce/spartacus-installation](https://github.tools.sap/cx-commerce/spartacus-installation)
- [ ] run all e2e tests on release branch (tip: run mobile, regression, smoke scripts in parallel to get all the results faster, after that retry failed tests in open mode)
- [ ] make sure that release branch is working correctly, everything is passing and it builds (click few pages manually and look into build errors)

---

For Mac:

- [ ] cleanup repo, build and generate compodocs and publish on github pages, generate spartacussampleaddon archives (`./scripts/pre-release.sh`)

For Windows:

- [ ] cleanup repo, build and generate compodocs and publish on github pages (`./scripts/pre-release.sh` - without sampleaddon zip)
- [ ] download and rename in root directory `https://github.tools.sap/cx-commerce/spartacussampledataaddon/archive/develop.zip` -> `spartacussampleaddon.zip`
- [ ] download and rename in root directory `https://github.tools.sap/cx-commerce/spartacussampledataaddon/archive/develop.tar.gz` -> `spartacussampleaddon.tar.gz`

---

- [ ] release libraries with `release-it` scripts (eg. for core `npm run release:core:with-changelog`)
  - make sure to run it as an npm script (`yarn` has issues with npm login)
  - add GITHUB_TOKEN env variable (`export GITHUB_TOKEN=token`)
  - be logged in to npm
  - libs to release (core, assets, styles, storefrontlib, schematics)
- [ ] check if release notes are populated on github (polish them or ask someone to review and improve them)
- [ ] check tags on npm (`next` should always point to the highest version, `latest` to highest stable version)
- [ ] check if everything builds from npm packages (spartacus installation script)
- [ ] merge release branch into develop branch (for next releases) or into maintenance branch (for any other release)
- [ ] announce on tribe channel
- [ ] create tickets to non-blocking release problems found during the release process

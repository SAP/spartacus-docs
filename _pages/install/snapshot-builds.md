---
title: Snapshot Builds
---

Snapshot builds are a way for Spartacus users to have access to library fixes or features that have not yet been officially released in our npm libraries.

Snapshot builds are published in the following GitHub repositories:

* [Core](https://github.com/SAP/spartacus-core-builds)
* [Styles](https://github.com/SAP/spartacus-styles-builds)
* [Assets](https://github.com/SAP/spartacus-assets-builds)
* [Storefront](https://github.com/SAP/spartacus-storefront-builds)

Each commit represents a snapshot. We create a snapshot every time a change is merged to the `develop` branch. A GitHub release with the source code is created for every snapshot.

To import a snapshot build in your shell app, update the library dependency in your `package.json`, as follows:

```json
{
  "dependencies" : {
    "@spartacus/core": "SAP/spartacus-core-builds",
    "@spartacus/styles": "SAP/spartacus-styles-builds",
    "@spartacus/assets": "SAP/spartacus-assets-builds",
    "@spartacus/storefront": "SAP/spartacus-storefront-builds"
    }
}
 ```

This allows you to import the latest (most recent) snapshot from GitHub.

If you want to import a specific snapshot, append the suffix of the GitHub repository and the git tag of the release in your dependency version, as follows:

```json
{
  "dependencies" : {
    "@spartacus/core": "SAP/spartacus-core-builds#core-0.1.0+abcde23f",
    "@spartacus/styles": "SAP/spartacus-styles-builds#styles-0.1.0+abcde23f",
    "@spartacus/assets": "SAP/spartacus-assets-builds#styles-0.1.0+abcde23f",
    "@spartacus/storefront": "SAP/spartacus-storefront-builds#storefront-0.1.0+abcde23f"
  }
}
 ```

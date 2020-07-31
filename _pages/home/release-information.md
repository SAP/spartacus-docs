---
title: Release Information for Versions 2.0 of Spartacus Libraries
---

**Final 2.0 released June 3, 2020!**

*Last updated June 3, 2020 by Bill Marcotte, Senior Product Manager, Spartacus*

Contents:

- [Introduction](#introduction)
- [Release 2.0](#release-20)
- [About Spartacus Releases](#about-spartacus-releases)
- [How Spartacus is Versioned](#how-spartacus-is-versioned)
- [Upgrading Spartacus Libraries to a New Minor Version](#upgrading-spartacus-libraries-to-a-new-minor-version)
- [Future Releases](#future-releases)
  
## Introduction

This document describes what is included in all Spartacus 2.x libraries since 2.0.

For release information about Spartacus 1.x, see [Release Information for Versions 1.0-1.5 of Spartacus Libraries](https://sap.github.io/spartacus-docs-v1/release-information/) in our version 1.x documentation archive.

**Note: Spartacus 2.x requires Angular 9. For more information, see [Updating to Version 2.0]({{ site.baseurl }}{% link _pages/home/updating-to-version-2/updating-to-version-2.md %}).**

- For information on specific code changes for a particular release, see the [Development Release Notes](https://github.com/SAP/spartacus/releases).
- For information about features published in pre-release libraries, see [Pre-Release Information]({{ site.baseurl }}{% link _pages/home/pre-release-information.md %}).
- For information about upgrading, see [Upgrading Spartacus Libraries to a New Minor Version](#upgrading-spartacus-libraries-to-a-new-minor-version).
- If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU). Feedback welcome!
  
**Disclaimer - Forward-Looking Statements**

*This document contains or may contain forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality.  This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence.*

*The various documentation links provided point to SAP Commerce Cloud platform or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented in Spartacus.*
  
## Release 2.0

*Release 2.0.0 libraries published June 3, 2020*

As Release 2.0 is a new major version, it contains breaking changes. To migrate to 2.0 from 1.x, see the following documentation:

- [Updating to Version 2.0]({{ site.baseurl }}{% link _pages/home/updating-to-version-2/updating-to-version-2.md %}) (automated update using schematics)
- [Technical Changes in Spartacus 2.0]({{ site.baseurl }}{% link _pages/home/updating-to-version-2/technical-changes-version-2.md %})
- [Changes to Styles in 2.0]({{ site.baseurl }}{% link _pages/home/updating-to-version-2/css-changes-in-version-2.md %})

The following is a summary of the major changes introduced in 2.0:

- Framework updated to Angular 9, including related dependencies such as ngrx 9
- [Schematics updated]({{ site.baseurl }}{% link _pages/install/schematics.md %})
- [Accessibility Keyboarding features]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus.md %})
- [Lazy loading of CMS components](https://sap.github.io/spartacus-docs/customizing-cms-components/#lazy-loaded-cms-components-code-splitting)
- [Event Service]({{ site.baseurl }}{% link _pages/dev/event-service.md %}), with Add to Cart event
- [State Persistence]({{ site.baseurl }}{% link _pages/dev/state_management/state-persistence.md %})
- [Custom Angular URL Matching](https://sap.github.io/spartacus-docs/adding-and-customizing-routes/#avoiding-static-url-segments-in-the-product-page-url-advanced)
- Many components refactored
- New facet navigation makes extending facets easier
- Deprecated code removed

### Notes for deployment of Spartacus 2.0 storefronts via SAP Commerce cloud hosting service.

Spartacus 2.0 uses Angular 9, which changes certain file locations. As of this writing (July 2020), to use Spartacus 2.0 with SAP Commerce Cloud in the Public Cloud hosting services, you must make the following changes to your Angular application for it to build properly. (For more information, see https://github.com/SAP/spartacus/issues/7993.) This will be fixed in a future release of SAP Commerce Cloud in the Public Cloud.

Changes in `angular.json`:
- `"outputPath": "dist/app-name/browser"` to 
  `"outputPath": "dist/app-name"`
- `"outputPath": "dist/app-name/server"` to 
  `"outputPath": "dist/app-name-server"`

Change in `server.ts`:
- `const distFolder = join(process.cwd(), 'dist/app-name/browser');` to
  `const distFolder = join(process.cwd(), 'dist/app-name');`

### For more information on changes

For a detailed list of all changes for 2.0 and previous 'next' releases of the Spartacus libraries, see the [Spartacus project release page](https://github.com/SAP/spartacus/releases) on GitHub.

## About Spartacus Releases

- Libraries that are "released" are new, official, tested Spartacus libraries available to the public (hosted on npmjs.com)
- We usually publish new libraries every 2 weeks
- A change in minor means we added new features, but they are configured to be off by default, so as not to cause compatibility issues. A new minor also means inclusion of changes or bug fixes that may affect compatibility, but these are also controlled by feature flags. So all significant changes are “opt-in”. See feature flag documentation for more information.
- We will normally publish pre-release libraries labelled 'next' a few weeks before a new minor release. The goal is to provide early access to new features and get feedback from the community.
- If you choose not to use a new feature, you should have no problems upgrading to a new Major.# with features flag set to a previous Major.#. If you do see a problem, please report a bug and we’ll assess and fix it. We encourage you to upgrade to latest libraries frequently during development in order to take advantage of bug fixes and new features.
- To be able to use all functionality in Spartacus 2.\*, release 2005 of SAP Commerce Cloud is required. The latest patch release is required or at least strongly recommended, as it usually contains bug fixes that affect Spartacus (for example, ASM requires 1905.5 and Save for Later features requires 1905.11). However, Spartacus 2.\* also works and is tested with release 1905; Spartacus features that rely on new APIs introduced in 2005 (such as cancellations and returns) are not available.
  
## How Spartacus is Versioned

Spartacus is following semantic versioning (Major.Minor.Patch).

- A new patch release (1.2.**3** > 1.2.**4** for example) means we added fixes or improvements but no new features.
- A new minor release (1.**2**.4 > 1.**3**.0 for example)  means we added a new feature and possibly fixes and improvements.

For both patch and minor releases, upgrading to the new libraries should not cause any compatibility problems with your storefront app. (If it does, report a bug.) All new features and fixes are implemented in a compatible way. For example, all new features are disabled by default using feature flags. We hope you will upgrade frequently.

- A new major release (**1**.3.2 > **2**.0.0 for example) means that, besides adding new features and improvements, we made changes that will likely cause compatibility issues. Your app likely needs updating when moving to a new major release. These effects, reasons, and benefits will be documented.

We don't plan to introduce a new major release that frequently, unless an issue is found that makes it necessary to move to a major release . For example, a new major release of the Angular framework is one factor in our decision to move to a new major for Spartacus.
  
## Upgrading Spartacus Libraries to a New Minor Version

You can upgrade your Spartacus libraries to a new minor version, as follows:

1. In `package.json`, set your `@spartacus` libraries to `“~2.#.0"`, where `#` is replaced with the release version number you wish to upgrade to.

    If you are upgrading from 1.x to the latest 1.5 release in order to then upgrade to 2.x, in `package.json`, set your `@spartacus` libraries to `“~1.5.5"`.
1. Delete your `node_modules` folder.
1. Run `yarn install`.

## Future Releases

See the [separate roadmap document]({{ site.baseurl }}{% link _pages/home/spartacus-roadmap.md %}).

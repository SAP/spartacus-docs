---
title: Update Policy and Release Frequency for Spartacus Libraries
---

This document describes the update policy and release frequency for Spartacus.

## Summary

- SAP will release patches and feature updates to Spartacus on a continuous basis.
- A “roll-forward” approach is used, meaning only the latest release of the libraries will receive patches and new features.
- Customers are strongly encouraged to regularly upgrade to the latest release.

## Terms Used in this Document

- “Maintenance” refers to the release of patches for identified bugs and security vulnerabilities.
- “Functionality updates” refers to any change to how the product or services work or behave.
- “Backwards-compatible releases” are changes that include patches and new functionality, but are published in such a way that they do not require development work in the customer’s application, when upgrading, beyond testing.
- “Incompatible changes” are changes included in an update that may require development work in the customer’s application, when upgrading, to ensure no functional regressions occurred.
- “Semver” refers to Semantic Versioning, a convention for numbering JavaScript libraries. Semver is only used to indicate the inclusion of incompatible changes and is not indicative of the nature of a release itself. For more information, see [https://semver.org](https://semver.org).

## Background

Spartacus is a set of libraries that enable customers to develop their own web applications for creating a state-of-the art storefront for headless SAP Commerce Cloud. The customer is responsible for developing and maintaining the web application. Though highly recommended, use of Spartacus is optional.

Spartacus libraries are built using project “Spartacus” open-source software, which is based on the Angular development environment. The libraries are delivered through SAP’s [Repo-Based Shipment Channel](https://ui.repositories.cloud.sap/www/webapp/users). The composable storefront libraries are available to cloud customers only. Other customers may use [project “Spartacus” open-source software](https://github.com/SAP/spartacus).

## Update Policy for Spartacus

SAP will release patches and feature updates to Spartacus on a continuous basis. The expected frequency is described further in this document.

A “roll-forward” approach to updates is used. This means that only the latest major.minor release will receive patches and new features. Older releases do not receive maintenance patches. When releases include updates that are backwards-compatible, the minor or patch numbers on incremented, depending on if the release contains new features or patches. When necessary, some releases may include incompatible changes. These will be indicated using semver by incrementing the major version of the release.

SAP provides technical support to customers who have an SAP Commerce Cloud subscription, for the latest release of the software. This means that when requesting support, customers will be required to first upgrade to the latest release of the Spartacus software, if they have not already done so.

Customers are strongly encouraged to regularly schedule upgrades to the latest release. Creating a new build of your application using a version of Spartacus that is no longer receiving updates may result in build errors and therefore you will be unable to deploy new code. To be compliant with your agreement, you must be running a current, supported version of Spartacus. Not upgrading to a current version of Spartacus exposes you to the risk of software defects, as well as performance, availability, functionality, or security issues that otherwise would be mitigated by upgrading to a current version.

## Frequency of Spartacus Releases

A new release of the Spartacus libraries may include the following:

- Bug fixes
- New functionality that is backwards-compatible
- Changes that are not compatible with a previous release

| Type of Release | Details |
| --- | --- |
| New releases that contain bug fixes | - Published approximately every week, as needed<br>- Called “patch” in semver |
| New releases that contain backwards-compatible functionality | - Published approximately 8 times per year<br>- Called “minor” in semver |
| New releases that contain changes that are not compatible with a previous release | - Published approximately 2-3 times per year<br>- Called “major” in semver |

**Note:** Schedule subject to change. Releases containing new features will be published according to the SAP harmonized release schedule.

## Example

- The first release of Spartacus is 5.0 in November.
- A week later, the first patch release, 5.0.1, may be published. Patch releases may be published until the next backwards-compatible feature release.
- The first release that contains backwards-compatible features will be numbered 5.1.0.
- A week later, a patch release maybe be published for the latest major.minor, with numbering 5.1.1. The 5.0.x release will not receive patch updates.
- The cycle continues until incompatible changes are introduced. For example, upgrading to the newest Angular framework is usually considered an incompatible change. In that case, the new release is 6.0.0.
- A week later, the first 6.x patch release is published, numbered 6.0.1. The 5.x releases do not receive patch updates.
- A month after that, a new backwards-compatible feature may be released, and the numbering changes to 6.1.0.
- And so on.

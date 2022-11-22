---
title: Update Policy and Release Frequency for Composable Storefront Libraries
---

This document describes the update policy and release frequency for SAP Commerce Cloud, composable storefront.

## Summary

- SAP will release patches and feature updates to the composable storefront on a continuous basis.
- A “roll-forward” approach is used, meaning only the latest release of the libraries will receive patches and new features.
- Customers are strongly encouraged to regularly upgrade to the latest release.

## Terms Used in this Document

- “Maintenance” refers to the release of patches for identified bugs and security vulnerabilities.
- “Functionality updates” refers to any change to how the product or services work or behave.
- “Backwards-compatible releases” are changes that include patches and new functionality, but are published in such a way that they do not require development work in the customer’s application, when upgrading, beyond testing.
- “Incompatible changes” are changes included in an update that may require development work in the customer’s application, when upgrading, to ensure no functional regressions occurred.
- “Semver” refers to Semantic Versioning, a convention for numbering JavaScript libraries. Semver is only used to indicate the inclusion of incompatible changes and is not indicative of the nature of a release itself. For more information, see [https://semver.org](https://semver.org).

## Background

The composable storefront is a set of libraries that enable customers to develop their own web applications for creating a state-of-the art storefront for headless SAP Commerce Cloud. The customer is responsible for developing and maintaining the web application. Though highly recommended, use of the composable storefront is optional.

The composable storefront libraries are built using project “Spartacus” open-source software, which is based on the Angular development environment. The libraries are delivered through SAP’s [Repo-Based Shipment Channel](https://ui.repositories.cloud.sap/www/webapp/users). The composable storefront libraries are available to cloud customers only. Other customers may use [project “Spartacus” open-source software](https://github.com/SAP/spartacus).

## Frequency of Composable Storefront Releases

SAP will release patches and feature updates to the composable storefront on a continuous basis. This release strategy follows the principle of “one innovation code line” with subsequent versions that ensure continuous innovation with an evolving code line.

Updates are provided in either patch releases, minor releases, or major releases. A “roll-forward” approach to updates is used, which means that only the latest major.minor release will receive patches and new features. A new release of the composable storefront libraries may include the following:

| Type of Release | Details |
| --- | --- |
| **Patch:** new releases that contain bug fixes | - Published approximately **every week**, as needed<br>- Called “patch” in semver |
| **Minor:** new releases that contain backwards-compatible functionality | - Published approximately **eight times per year**<br>- Called “minor” in semver |
| **Major:** new releases that contain changes that are not compatible with a previous release | - Published approximately **two to three times per year**<br>- Called “major” in semver |

## Update Policy for Composable Storefront

A “roll-forward” approach to updates is used, which means that only the latest major.minor release will receive patches and new features. Older releases do not receive patch or release updates.

In practice, this works as follows:

- When a minor or patch release is provided (that is, an update that is backwards-compatible), the minor or patch number is incremented, depending on whether the release contains new features or patches.
- Major releases include incompatible changes. Using semver, these will be indicated by incrementing the major version of the release.

Customers are strongly encouraged to regularly schedule upgrades to the latest release to mitigate risks and potential issues, such as but not limited to the following:

- Not upgrading to a current version of composable storefront exposes you to the risk of software defects, as well as performance, availability, functionality, or security issues.
- Creating a new build of your application using a version of composable storefront that is no longer receiving updates may result in build errors and as a result, you will be unable to deploy new code.

SAP provides technical support to SAP Commerce Cloud customers for the latest release of the software. This means that when requesting support, customers will be required to first upgrade to the latest release of the composable storefront software, if they have not already done so.

**Note:** Schedule subject to change. Releases containing new features will be published according to the SAP harmonized release schedule.

## Example

- The first release of composable storefront is 5.0 in November.
- A week later, the first patch release, 5.0.1, may be published. Patch releases may be published until the next backwards-compatible feature release.
- The first release that contains backwards-compatible features will be numbered 5.1.0.
- A week later, a patch release may be published for the latest major.minor, with numbering 5.1.1. The 5.0.x release will not receive patch updates.
- The cycle continues until incompatible changes are introduced. For example, upgrading to the newest Angular framework is usually considered an incompatible change. In that case, the new release is 6.0.0.
- A week later, the first 6.x patch release is published, numbered 6.0.1. The 5.x releases do not receive patch updates.
- A month after that, a new backwards-compatible feature may be released, and the numbering changes to 6.1.0.
- And so on.

---
title: Update Release Policy and Publication Frequency for Spartacus Libraries
---

This document describes the update release policy and publication frequency for <pname conkeyref="loiof35dd21b5c7b47108bebca5a890244ac/SAP_CC_SF_LONG"/>.

## Summary

- SAP will publish update releases for the <pname conkeyref="loiof35dd21b5c7b47108bebca5a890244ac/SAP_CC_SF_SHORT_NO_CAPS"/> on a continuous basis. These updates may contain bug fixes, feature updates, or a combination of both.
- Update releases remain current for a minimum of three months (unless otherwise indicated).
- A “roll-forward” approach is used, meaning only the latest update release of the libraries will receive bug fixes and new features.
- Customers are strongly encouraged to regularly upgrade to the latest update release.
- The <pname conkeyref="loiof35dd21b5c7b47108bebca5a890244ac/SAP-CC"/> Portal will not allow builds against an update release that is no longer listed as a current update release, as shown in the following table.

| Current <pname conkeyref="loiof35dd21b5c7b47108bebca5a890244ac/SAP_CC_SF_SHORT_CAPS"/> Releases | Supported <pname conkeyref="loiof35dd21b5c7b47108bebca5a890244ac/SAP-CC"/> Releases |
| --- | --- |
| 5.0.0 | 2105, 2205, 2211 |

## Terms Used in this Document

- “Maintenance” refers to fixes for identified bugs and security vulnerabilities.
- “Functionality updates” refers to any change to how the product or services work or behave.
- “Backwards-compatible update releases” are changes that include bug fixes and new functionality, but are published in such a way that they do not require development work in the customer’s application, when upgrading, beyond testing.
- “Incompatible changes” are changes included in an update that may require development work in the customer’s application, when upgrading, to ensure no functional regressions occurred.
- “Semver” refers to Semantic Versioning, a convention for numbering JavaScript libraries. Semver is only used to indicate the inclusion of incompatible changes and is not indicative of the nature of an update release itself. For more information, see [https://semver.org](https://semver.org).

## Background

The <pname conkeyref="loiof35dd21b5c7b47108bebca5a890244ac/SAP_CC_SF_SHORT_NO_CAPS"/> is a set of libraries that enable customers to develop their own web applications for creating a state-of-the art storefront for headless <pname conkeyref="loiof35dd21b5c7b47108bebca5a890244ac/SAP-CC"/>. The customer is responsible for developing and maintaining the web application. Though highly recommended, use of the <pname conkeyref="loiof35dd21b5c7b47108bebca5a890244ac/SAP_CC_SF_SHORT_NO_CAPS"/> is optional.

The <pname conkeyref="loiof35dd21b5c7b47108bebca5a890244ac/SAP_CC_SF_SHORT_NO_CAPS"/> libraries are built using project “Spartacus” open-source software, which is based on the Angular development environment. The libraries are delivered through SAP’s [Repo-Based Shipment Channel](https://ui.repositories.cloud.sap/www/webapp/users). The <pname conkeyref="loiof35dd21b5c7b47108bebca5a890244ac/SAP_CC_SF_SHORT_NO_CAPS"/> libraries are available to cloud customers only. Other customers may use [project “Spartacus” open-source software](https://github.com/SAP/spartacus).

## Frequency of Spartacus Update Releases

SAP will publish bug fixes and new features to the <pname conkeyref="loiof35dd21b5c7b47108bebca5a890244ac/SAP_CC_SF_SHORT_NO_CAPS"/> on a continuous basis. This release strategy follows the principle of “one innovation code line” with subsequent update releases that ensure continuous innovation with an evolving code line.

A “roll-forward” approach to updates is used, which means that only the latest update release will receive bug fixes and new features. 

A new update release of the <pname conkeyref="loiof35dd21b5c7b47108bebca5a890244ac/SAP_CC_SF_SHORT_NO_CAPS"/> libraries may include the following:

| Type of Update Release | Details |
| --- | --- |
| **Bug Fix:** | - Contains backwards-compatible bug fixes<br>- Published approximately **every week**, as needed<br>- Called “patch” in semver |
| **Minor:** | - Contains new functionality that is backwards-compatible<br>- Published approximately **eight times per year**<br>- Called “minor” in semver |
| **Major:** | - Contain bug fixes and new functionality, some of which are not compatible with a previous update release<br>- Published approximately **two to three times per year**<br>- Called “major” in semver |

## Update Policy for Spartacus

A “roll-forward” approach to updates is used, which means that only the latest update release will receive bug fixes and new features. Older update releases do not receive bug fixes or features.

In practice, this works as follows:

- When backwards-compatible bug fixes or functionality are provided, the semver minor or patch number is incremented, depending on the nature of the changes.
- When changes are introduced that are not backwards-compatible, the semver major number is incremented.

Customers are strongly encouraged to regularly schedule upgrades to the latest update release to mitigate risks and potential issues, such as but not limited to the following:

- Not upgrading to a current update release of <pname conkeyref="loiof35dd21b5c7b47108bebca5a890244ac/SAP_CC_SF_SHORT_NO_CAPS"/> exposes you to the risk of software defects, as well as performance, availability, functionality, or security issues.
- Creating a new build of your application using an update release of <pname conkeyref="loiof35dd21b5c7b47108bebca5a890244ac/SAP_CC_SF_SHORT_NO_CAPS"/> that is not current, may result in build errors -- as a result, you will be unable to deploy new code.

SAP provides technical support to <pname conkeyref="loiof35dd21b5c7b47108bebca5a890244ac/SAP-CC"/> customers for the latest update release of the software. This means that when requesting support, customers will be required to first upgrade to the latest update release of the <pname conkeyref="loiof35dd21b5c7b47108bebca5a890244ac/SAP_CC_SF_SHORT_NO_CAPS"/> software, if they have not already done so.

**Note:** Schedule subject to change. Update releases containing new features will be published according to the SAP harmonized release schedule.

## Example

- The first update release of <pname conkeyref="loiof35dd21b5c7b47108bebca5a890244ac/SAP_CC_SF_SHORT_NO_CAPS"/> was 5.0 in November 2022.
- A week later, the first bug fix update release, 5.0.1, may be published. Bug fix update releases may be published until the next backwards-compatible feature update release.
- The first update release that contains backwards-compatible features will be numbered 5.1.0.
- A week later, a bug fix update release may be published, 5.1.1. The 5.0.x update release will not receive bug fixes.
- The cycle continues until incompatible changes are introduced. For example, upgrading to the newest Angular framework is usually considered an incompatible change. In that case, the new update release is 6.0.0.
- A week later, the first 6.x bug fix update release is published, numbered 6.0.1. The 5.x update releases do not receive bug fixes.
- A month after that, a new backwards-compatible feature may be published, and the numbering changes to 6.1.0.
- And so on.

## Cloud Portal and Current Update Releases

Customers using the <pname conkeyref="loiof35dd21b5c7b47108bebca5a890244ac/SAP_CC_SF_SHORT_NO_CAPS"/> must remain current by adopting a current update release as listed in the table at the top of this document.

The <pname conkeyref="loiof35dd21b5c7b47108bebca5a890244ac/SAP-CC"/> Portal will not allow builds against an update release no longer listed as a current update release. As soon as you adopt a current update release, the builds will start working again.

For information on which update releases of <pname conkeyref="loiof35dd21b5c7b47108bebca5a890244ac/SAP-CC"/> are current, see [Supported Releases](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/12be4ac419604b01aabb1adeb2c4c8a2/1c6c687ad0ed4964bb43d409818d23a2.html).

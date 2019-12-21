---
title: Pre-Release Information
---

This document describes what is included in the latest pre-release of Spartacus libraries, such as `next` and `rc` libraries.

If you have any questions, use the help channel of our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU). Feedback welcome!

## 1.4.0-RC.0

Hello everyone! We’re proud to announce publication of the first 1.4 Release Candidate for our Spartacus libraries.
See release notes here: [https://github.com/SAP/cloud-commerce-spartacus-storefront/releases](https://github.com/SAP/cloud-commerce-spartacus-storefront/releases).

To use the 1.4 RC libraries, specify ^1.4.0-RC.0 for all Spartacus libraries in your `package.json` file ,except Schematics (which is still 1.3.0 at this time). You must also set your feature level in `app.module.ts` to 1.4.

The 1.4 RC contains everything that was in the 1.4 “next” libraries, plus additional new features and improvements:

- [Wish List](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/wish-list/)
- [Stock Notification](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/stock-notification/)
- [Notification Preferences](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/notification-preferences/)
- [Customer Interests](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/customer-interests/)
- Changes to cart handling (under the hood)
- [Token Revocation](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/token-revocation/) (supports backend improvement added to 1905.6).
- Stackable outlets. For more information, see [GitHub Issue 3462](https://github.com/SAP/cloud-commerce-spartacus-storefront/issues/3462)
- Performance improvements for loading product information
- Deferred and Above-the-Fold Loading. For more information, see [GitHub Issue 5823](https://github.com/SAP/cloud-commerce-spartacus-storefront/issues/5823)
- CMS component data loading optimization. For more information, see [GitHub Issue 5845](https://github.com/SAP/cloud-commerce-spartacus-storefront/issues/5845)

**Note:** The Cancellations and Returns feature is also part of 1.4. However, this feature requires updates to OCC REST APIs that are not yet released. The updated APIs are scheduled to be part of the May 2020 release (Release 2005) of SAP Commerce Cloud. Please see official SAP Commerce Cloud release announcements for more information.

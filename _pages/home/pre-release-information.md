---
title: Pre-Release Information for "Next" and "RC" versions of the Spartacus Libraries
---

This document describes what is included in the latest pre-releases of Spartacus libraries, such as the `next` and `rc` libraries.

If you have any questions, use the help channel of our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU). Feedback welcome!

## 1.4.0-next.1

The Spartacus team has published a new pre-release library containing the Wish List feature.

This feature uses the existing Saved Carts APIs to allow customers to save a product to their Wish List from the Product Details page. Later,customers can view the wish list and add a wish-list product to the cart. You must be signed in to to use the Wish List feature.

Full documentation to come, but here are some brief setup instructions:

- The Wish List feature is enabled through CMS. The required components (such as `AddToWishListComponent`) are included when you install the latest `spartacussampledataaddon` with the `b2c_acc_plus` recipe, as explained in the [SAP Help Portal](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/installing-sap-commerce-cloud/).
- When the CMS is present, **Add to Wish List** or **Sign in to add to wish list** links appear under **Add to Cart** in the Product Details page, and you can display the Wish List page from the Account menu.

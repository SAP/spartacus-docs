---
title: Order Lib Release Notes
---

Spartacus 4.2 introduces the Order Library. This is the latest iteration of the code splitting initiative. The main goal of code splitting is to reduce the initial download size of a Spartacus enabled app by leveraging lazy loading of feature libraries.

# Backwards compatibility for existing apps by default

By default, if you upgrade to 4.2 from 4.x, the order library will not be used. Instead, your app will continue to use the old/current order related code. The non-lib order code is still present in Spartacus and will only be removed in 5.0. This allows Spartacus 4.2 to be backwards compatible with previous 4.x versions.

# Order lib used in new Spartcus Apps.

In Spartacus 4.2, if you generate a new Spartacuus app with the schematics, the app will use the new Order Library.

# Known Limitations

## Some changes to expect in 5.0

The vast majority of the Order related code was moved to the order-lib in 4.2. However, to maintain backwards compatibility with 4.x, some parts of the order lib code will be movedd in 5.0. One known upcoming change is to move the Order and Replenishment Order models to the order library in 5.0. Also, the old/now legacy order code is set to be removed from the codebase in 5.0.

## Order Approval

The order approval feature in the Organization Lib uses these components from storefrontlib:

- OrderDetailTotalsComponent
- OrderDetailShippingComponent
- OrderDetailItemsComponent

For 4.x, we have to tolerate that when using Order Lib, the Order Approval feature still uses the old order components from storefront lib. If you are using Order Approvals, make sure to test the approvals to make sure this limiitation does not have negative side effects on your project. In doubt, wait for Sparrtacus 5.0 to use the order lib.

This limitation will be removed in 5.0. In 5.0, the components will be removed from storefrontlib and we will be able to update the organization lib for it to depend on oorder lib and use compoonents from it.

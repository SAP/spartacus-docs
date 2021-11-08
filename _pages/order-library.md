---
title: Order Lib Release Notes
---

Spartacus 4.2 introduces the Order Library. This is the latest iteration of the code splitting initiative. The main goal of code splitting is to reduce the initial download size of a Spartacus enabled app by leveraging lazy loading of feature libraries.

## Order lib is compatible with new Spartcus App

The the new Order Library is not backwards compatible. The order library is intended to be used with new applications created with Spartacus 4.2. In Spartacus 4.2, if you generate a new Spartacus app with the schematics, the app will use the new Order Library by default.

## Existing Apps upgrading to 4.2: keep backwards compatibility

The new Order Library is not backwards compatible. Therefore, by default, if you upgrade to 4.2 from 4.x, the order library will NOT be used. Instead, your app will continue to use the old/current order related code to preserve the backwards compatibility of the upgrade. The non-lib order code is still present in Spartacus. This allows Spartacus 4.2 to be backwards compatible with previous 4.x versions.

## Known Limitations

### Order lib is not backwards compatible

In 4.2, the intended use case for the Order library is for new spartacus apps.

### Expect some changes in an upcoming major version

The majority of the Order related code was moved to the order-lib in 4.2. However, to maintain backwards compatibility with 4.x, some parts of the order feature code will wait for an upcoming Spartacus major version upgrade to move to the order library. One known upcoming change in an upcoming major version is to move the Order and Replenishment Order models to the order library. Also, the old/now legacy order code is set to be removed from the codebase in an upcoming major version.

### Order Approval

The order approval feature in the Organization Lib uses these components from storefrontlib:

- OrderDetailTotalsComponent
- OrderDetailShippingComponent
- OrderDetailItemsComponent

For 4.x, we have to tolerate that when using Order Lib, the Order Approval feature still uses the old order components from storefront lib. If you are using Order Approvals, make sure to test the approvals to make sure this limitation does not have negative side effects on your project. 

This limitation will be removed in an upcoming major version. At that point, the components will be removed from storefrontlib and we will be able to update the organization lib for it to depend on order lib and use components from it.

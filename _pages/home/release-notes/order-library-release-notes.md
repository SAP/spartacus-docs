---
title: Order Library Release Notes
---

Spartacus 4.2 introduces the `@spartacus/order` library. This is the latest iteration of the code splitting initiative. The main goal of code splitting is to reduce the initial download size of a Spartacus storefront app, which is achieved through lazy loading of the feature libraries.

The new order library is not backwards compatible. This library is intended to be used with new applications that are created with Spartacus 4.2 libraries. With the version 4.2 libraries, if you generate a new storefront app using schematics, the app will use the new order library by default. For more information, see [Integration Libraries and Feature Libraries]({{ site.baseurl }}/schematics/#integration-libraries-and-feature-libraries).

If you upgrade to 4.2 from an older 4.x version, the order library will *not* be used. Instead, your app will continue to use the previous order-related code to preserve backwards compatibility. The non-order library code is still present in Spartacus. This allows Spartacus 4.2 to be backwards compatible with previous 4.x versions.

## Known Limitations

The majority of the order-related code was moved to the order library in 4.2. However, to maintain backwards compatibility with 4.x, some parts of the order feature code will wait for a future major version upgrade of Spartacus before being moved to the order library. One known upcoming change in a future major version is to move the Order and Replenishment Order models to the order library. Also, the legacy order code is set to be removed from the codebase in an upcoming major version.

### Order Approval

The order approval feature in the organization library uses the following components from the storefront library:

- `OrderDetailTotalsComponent`
- `OrderDetailShippingComponent`
- `OrderDetailItemsComponent`

For 4.x, we have to tolerate that when using the order library, the Order Approval feature still uses the old order components from the storefront library. If you are using Order Approvals, make sure to test the approvals to be sure this limitation does not have negative side effects on your project.

This limitation will be removed in an upcoming major version. At that point, the components will be removed from the storefront library and we will be able to update the organization library so that it depends on the order library and uses the components from it.

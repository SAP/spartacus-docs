---
title: Checkout Libraries Release Notes
---

With the release of Spartacus 5.0, it introduces three different entrypoints for the `@spartacus/checkout` library:

- `@spartacus/checkout/base` - includes basic checkout functionalities, which is more catered to business to consumer (b2c).
- `@spartacus/checkout/b2b` - includes the basic checkout functionalities from base, and additional checkout flow that is catered to business to business (b2b).
- `@spartacus/checkout/scheduled-replenishment` - includes both the base and b2b checkout functionalities, but it allows the user to either place an order or schedule a replenishment order.

Originally, [Spartacus 4.0 released the new code splitted checkout library](https://sap.github.io/spartacus-docs/technical-changes-version-4/#new-checkout-library), which had only a single entrypoint that contained all checkout flows even if it would not be used, for example, [scheduling a replenishment](https://sap.github.io/spartacus-docs/scheduled-replenishment/#setting-up-a-replenishment-order). However, in Spartacus 5.0, we further decoupled the library into different business logic features in order to have a smaller bundle size.

In addition to creating different entrypoints in order to reduce the bundle size, we have mostly removed ngrx dependencies, with the exception of a few ngrx actions that are isolated within an event listener, by replacing it with [commands and queries](https://sap.github.io/spartacus-docs/commands-and-queries/#page-title). It is currently not possible to fully separate ngrx from checkout until other libraries from Spartacus get refactored, such as Cart or User libraries.

- Benefits of converting to `command and queries`:
  - as all functionality is in classes, it is easier to extend, as opposed to ngrx where you can not really extend a reducer or an effect (without dismantling Spartacus' ngrx modules)
  - commands are built in a more reactive way, and return the execution result as part of the same method call.
  - similarly to the commands, listening to loading, error, and data state changes are as simple as calling one method and getting all the results in one call.

Finally, the business logic for placing an order or scheduling a replenishment order was moved to the Order library. The reason for this decision is that the logic to place an order was coupled with a normalizer that existed in the Order library, which would break the lazy loading mechanism we have in place. Therefore, we concluded to move the place order business logic in the Order library as [one of the features of our lazy loading mechanism](https://sap.github.io/spartacus-docs/lazy-loading-guide/#exposing-smart-proxy-facades-from-lazy-loaded-features) is that we can programatically lazy load a feature when calling a method or property from the proxy facades.

### General changes

- Majority of old checkout imports (`@spartacus/checkout`) are now spread across the new entry points, and its secondary entry points.
- `normalizeHttpError()` is moved from the effects to the adapter layer
- order confirmation components listed below were moved to the Order library
  - OrderConfirmationThankYouMessageComponent
  - OrderConfirmationItemsComponent
  - OrderConfirmationTotalsComponent
  - GuestRegisterFormComponent
- Checkout flow has a better transition experience due to enhanced smoothing, less requests and less duplicated requests, and a uniform spinner for every step.
- Most checkout components from Spartacus 4.0 has been re-named to be prefixed with Checkout. For example, CheckoutPlaceOrderComponent.

### New functionality

- `backOff` pattern is now added to the OCC adapters, and configured to retry on OCC-specific JALO errors.
- validation and error handling - the commands now perform various precondition checks. At the same time, commands will throw errors if the execution fails. Previously, effects were dispatching Fail actions, which usually were't handled.

### Sample data changes

- CheckoutShippingAddress `ContentPage` has been renamed to CheckoutDeliveryAddress
  - title of the content page has also been changed from `Checkout Shipping Address` to `Checkout Delivery Address`
  - page route has been also been changed from `/checkout/shipping-address` to `/checkout/delivery-address`
- CheckoutShippingAddressComponent `CMSComponent` has been renamed to CheckoutDeliveryAddress
- BodyContentSlot-checkoutShippingAddress `ContentSlot` has been renamed to BodyContentSlot-checkoutDeliveryAddress
- SideContent-checkoutShippingAddress `ContentSlot` has been renamed to SideContent-checkoutDeliveryAddress

Note: The new checkout library is not backwards compatible. This library is intended to be used with new applications that are created with Spartacus 5.0 libraries. With the version 5.0 libraries, if you generate a new storefront app using schematics, the app will use the new order library by default. For more information, see [Integration Libraries and Feature Libraries]({{ site.baseurl }}/schematics/#integration-libraries-and-feature-libraries).

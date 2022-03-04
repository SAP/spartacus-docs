---
title: Checkout Libraries Release Notes
---

With the release of Spartacus 5.0, it introduces three different entrypoints for the `@spartacus/checkout` library:

- `@spartacus/checkout/base` - includes basic checkout functionalities, which is more catered to business to consumer (b2c).
- `@spartacus/checkout/b2b` - includes the basic checkout functionalities from base, and additional checkout flow that is catered to business to business (b2b).
- `@spartacus/checkout/scheduled-replenishment` - includes both the base and b2b checkout functionalities, but it allows the user to either place an order or schedule a replenishment order.

---

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
  {:toc}

---

Originally, [Spartacus 4.0 released the new code splitted checkout library](https://sap.github.io/spartacus-docs/technical-changes-version-4/#new-checkout-library), which had only a single entrypoint that contained all checkout flows even if it would not be used, for example, [scheduling a replenishment](https://sap.github.io/spartacus-docs/scheduled-replenishment/#setting-up-a-replenishment-order). However, in Spartacus 5.0, we further decoupled the library into different business logic features in order to have a smaller bundle size.

In addition to creating different entrypoints in order to reduce the bundle size, we have mostly removed ngrx dependencies, with the exception of a few ngrx actions that are isolated within an event listener, by replacing it with [commands and queries](https://sap.github.io/spartacus-docs/commands-and-queries/#page-title). It is currently not possible to fully separate ngrx from checkout until other libraries from Spartacus get refactored, such as Cart or User libraries.

- Benefits of converting to `command and queries`:
  - as all functionality is in classes, it is easier to extend, as opposed to ngrx where you can not really extend a reducer or an effect (without dismantling Spartacus' ngrx modules)
  - commands are built in a more reactive way, and return the execution result as part of the same method call.
  - similarly to the commands, listening to loading, error, and data state changes are as simple as calling one method and getting all the results in one call.

Finally, the business logic for placing an order or scheduling a replenishment order was moved to the Order library. The reason for this decision is that the logic to place an order was coupled with a normalizer that existed in the Order library, which would break the lazy loading mechanism we have in place. Therefore, we concluded to move the place order business logic in the Order library as [one of the features of our lazy loading mechanism](https://sap.github.io/spartacus-docs/lazy-loading-guide/#exposing-smart-proxy-facades-from-lazy-loaded-features) is that we can programatically lazy load a feature when calling a method or property from the proxy facades.

## General changes

- Majority of old checkout imports (`@spartacus/checkout`) are now spread across the new entry points, and its secondary entry points.
- `normalizeHttpError()` is moved from the effects to the adapter layer
- order confirmation components listed below were moved to the Order library
  - OrderConfirmationThankYouMessageComponent
  - OrderConfirmationItemsComponent
  - OrderConfirmationTotalsComponent
  - GuestRegisterFormComponent
- Checkout flow has a better transition experience due to enhanced smoothing, less requests and less duplicated requests, and a uniform spinner for every step.
- Most checkout components from Spartacus 4.0 has been re-named to be prefixed with Checkout. For example, CheckoutPlaceOrderComponent.

## New functionality

- `backOff` pattern is now added to the OCC adapters, and configured to retry on OCC-specific JALO errors.
- validation and error handling - the commands now perform various precondition checks. At the same time, commands will throw errors if the execution fails. Previously, effects were dispatching Fail actions, which usually were't handled.

## Sample data changes

- CheckoutShippingAddress `ContentPage` has been renamed to CheckoutDeliveryAddress
  - title of the content page has also been changed from `Checkout Shipping Address` to `Checkout Delivery Address`
  - page route has been also been changed from `/checkout/shipping-address` to `/checkout/delivery-address`
- CheckoutShippingAddressComponent `CMSComponent` has been renamed to CheckoutDeliveryAddress
- BodyContentSlot-checkoutShippingAddress `ContentSlot` has been renamed to BodyContentSlot-checkoutDeliveryAddress
- SideContent-checkoutShippingAddress `ContentSlot` has been renamed to SideContent-checkoutDeliveryAddress

Note: The new checkout library is not backwards compatible. This library is intended to be used with new applications that are created with Spartacus 5.0 libraries. With the version 5.0 libraries, if you generate a new storefront app using schematics, the app will use the new order library by default. For more information, see [Integration Libraries and Feature Libraries]({{ site.baseurl }}/schematics/#integration-libraries-and-feature-libraries).

## Events

These events in checkout plays a special role as these are used for additional actions through as side-effects. Events below are either caught by our event listeners or reset/reload of a query.

### CheckoutReloadQueryEvent

TBD

### CheckoutResetQueryEvent

TBD

### CheckoutDeliveryAddressEvent

TBD

### CheckoutDeliveryAddressSetEvent

TBD

### CheckoutDeliveryAddressCreatedEvent

TBD

### CheckoutClearDeliveryAddressEvent

TBD

### CheckoutDeliveryAddressClearedEvent

TBD

### CheckoutDeliveryModeEvent

TBD

### CheckoutReloadDeliveryModesEvent

TBD

### CheckoutDeliveryModeSetEvent

TBD

### CheckoutDeliveryModeClearedEvent

TBD

### CheckoutPaymentDetailsSetEvent

TBD

### CheckoutPaymentDetailsCreatedEvent

TBD

### CostCenterSetEvent

TBD

### PaymentTypeSetEvent

TBD

## Commands and Queries example in Checkout

As mentioned, the checkout libraries has mostly removed ngrx dependencies while adapting to our commands and queries pattern for data flow.

1. components injects facades (example: [CheckoutDeliveryAddressComponent](https://github.com/SAP/spartacus/blob/develop/feature-libs/checkout/base/components/checkout-delivery-address/checkout-delivery-address.component.ts))

The following describes the dependency injection to the [proxy facade](https://sap.github.io/spartacus-docs/proxy-facades/#defining-proxy-facades), where the actual implementation is provided using a dependency provider. In the case of checkout, the facade service contains the business logic executed by commands and queries.

```typescript
  constructor(
    ...
    protected checkoutDeliveryAddressFacade: CheckoutDeliveryAddressFacade,
    protected checkoutDeliveryModesFacade: CheckoutDeliveryModesFacade,
    ...
  ) {}
```

1. facades executes commands and queries (example: [CheckoutDeliveryAddressFacade](https://github.com/SAP/spartacus/blob/develop/feature-libs/checkout/base/core/facade/checkout-delivery-address.service.ts))

Usually, each service contains both the `CommandService` and `QueryService`, but in the case of checkout, we have created a 'super query' called `CheckoutQueryFacade` that contains the usage of the `QueryService` as it is a common query for all checkout facade services in order to avoid repetion.

```typescript
  constructor(
    protected activeCartFacade: ActiveCartFacade,
    protected userIdService: UserIdService,
    protected eventService: EventService,
    protected commandService: CommandService,
    protected checkoutDeliveryAddressConnector: CheckoutDeliveryAddressConnector,
    protected checkoutQueryFacade: CheckoutQueryFacade
  ) {}
```

A [command](https://sap.github.io/spartacus-docs/commands-and-queries/#commands-overview) is created in order to execute the action of creating a delivery address. As you can the command type is of Address for the input (payload) and unknown for the output (payload) `Command<Address, unknown>`. An Address object is required for the command to execute while the returned value is unknown. However, if the http request that is fired contains a payload, we can change the unknown type to the actual type model.

```typescript
  createAndSetAddress(address: Address): Observable<unknown> {
    return this.createDeliveryAddressCommand.execute(address);
  }

  protected createDeliveryAddressCommand: Command<Address, unknown> =
  this.commandService.create<Address>(
    (payload) =>
      this.checkoutPreconditions().pipe(
        switchMap(([userId, cartId]) => {
          return this.checkoutDeliveryAddressConnector
            .createAddress(userId, cartId, payload)
            .pipe(
              tap(() => {
                if (userId !== OCC_USER_ID_ANONYMOUS) {
                  this.eventService.dispatch(
                    { userId },
                    LoadUserAddressesEvent
                  );
                }
              }),
              map((address) => {
                address.titleCode = payload.titleCode;
                if (payload.region?.isocodeShort) {
                  address.region = {
                    ...address.region,
                    isocodeShort: payload.region.isocodeShort,
                  };
                }
                return address;
              }),
              tap((address) =>
                this.eventService.dispatch(
                  {
                    userId,
                    cartId,
                    address,
                  },
                  CheckoutDeliveryAddressCreatedEvent
                )
              )
            );
        })
      ),
    {
      strategy: CommandStrategy.CancelPrevious,
    }
  );
```

1. commands can dispatch events (for other side effects)

The following snippet is taken from the createDeliveryAddressCommand above. After successfully creating an address, we have dispatched two [events](https://sap.github.io/spartacus-docs/event-service/#dispatching-individual-events) under the tap operator in order to be caught by our event listeners to perform additional actions.

```typescript
return this.checkoutDeliveryAddressConnector
  .createAddress(userId, cartId, payload)
  .pipe(
    tap(() => {
      if (userId !== OCC_USER_ID_ANONYMOUS) {
        this.eventService.dispatch(
          { userId },
          LoadUserAddressesEvent
        );
      }
    }),
    map((address) => {
      address.titleCode = payload.titleCode;
      if (payload.region?.isocodeShort) {
        address.region = {
          ...address.region,
          isocodeShort: payload.region.isocodeShort,
        };
      }
      return address;
    }),
    tap((address) =>
      this.eventService.dispatch(
        {
          userId,
          cartId,
          address,
        },
        CheckoutDeliveryAddressCreatedEvent
      )
    )
```

1. events are captured by our event listeners (example: [CheckoutDeliveryAddressEventListener](https://github.com/SAP/spartacus/blob/develop/feature-libs/checkout/base/root/events/checkout-delivery-address-event.listener.ts))

After an event that was dispatched during a command or query, our event listener that listened for `CheckoutDeliveryAddressCreatedEvent` fires a global message to let the user know that they have successfully created the delivery address. Event listeners are flexible as we can inject any number of dependencies to perform certain actions. Moreover, it fires additional events, such as `CheckoutResetDeliveryModesEvent` and `CheckoutResetQueryEvent` to be caught by other event listeners.

```typescript
  protected onDeliveryAddressChange(): void {
    this.subscriptions.add(
      this.eventService
        .get(CheckoutDeliveryAddressCreatedEvent)
        .subscribe(({ userId, cartId }) => {
          this.globalMessageService.add(
            { key: 'addressForm.userAddressAddSuccess' },
            GlobalMessageType.MSG_TYPE_CONFIRMATION
          );

          this.eventService.dispatch(
            { userId, cartId },
            CheckoutResetDeliveryModesEvent
          );

          this.eventService.dispatch({}, CheckoutResetQueryEvent);
        })
    );
    ...
```

`CheckoutResetDeliveryModesEvent` is fired to load a cart, which ends up being caught by our `CheckoutLegacyStoreEventListener`. This event listener encapsulates the ngrx actions that we can not remove from checkout until other features changes to commands and queries.

The example for `CheckoutResetQueryEvent` being fired is to reset our super query from `CheckoutQueryFacade` due to the nature of our commands and queries, where we can [reload or reset a query](https://sap.github.io/spartacus-docs/commands-and-queries/#queries-overview).

### How to properly make use of queries in checkout

Example: [CheckoutQueryFacade](https://github.com/SAP/spartacus/blob/develop/feature-libs/checkout/base/core/facade/checkout-query.service.ts) and [CheckoutDeliveryAddressComponent](https://github.com/SAP/spartacus/blob/develop/feature-libs/checkout/base/components/checkout-delivery-address/checkout-delivery-address.component.ts)

The 'super query' that is injected in other checkout services is used to get the current checkout details, which contains information on `delivery address, delivery mode, and payment information` when using base checkout. When using b2b checkout, you can additional data like `purchase order number`, `cost centers`, and `payment type`.

```typescript
  protected checkoutQuery$: Query<CheckoutState | undefined> =
    this.queryService.create<CheckoutState | undefined>(
      () =>
        this.checkoutPreconditions().pipe(
          switchMap(([userId, cartId]) =>
            this.checkoutConnector.getCheckoutDetails(userId, cartId)
          )
        ),
      {
        reloadOn: this.getQueryReloadTriggers(),
        resetOn: this.getQueryResetTriggers(),
      }
    );

    getCheckoutDetailsState(): Observable<QueryState<CheckoutState | undefined>> {
      return this.checkoutQuery$.getState();
    }
```

The getCheckoutDetailsState returns the entire state, which is an object composed of loading, error, and data state, but you can always create additional methods in your extended service to include only getting the data. You would only need to use .get() instead of getState() when executing queries.

```typescript
    getCheckoutDetails(): Observable<CheckoutState | undefined> {
      return this.checkoutQuery$.get();
    }
```

## How to add additional logic to existing features

TBD (wrappers)

## Migrations

Most of these migrations are handled by our schematics, but below are geenral information on what to expect and change.

### from usage effects

### using old components

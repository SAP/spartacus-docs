---
title: Checkout Libraries Release Notes
---

The release of Spartacus 5.0 introduces three different entry points for the `@spartacus/checkout` library.

The new entry points for the `@spartacus/checkout` library are the following:

- `@spartacus/checkout/base`, which includes basic checkout functionalities that cater especially to business-to-consumer (B2C) checkout flows.
- `@spartacus/checkout/b2b`, which includes the basic checkout functionalities from the base library, as well as additional checkout flows that cater to business-to-business (B2B) scenarios.
- `@spartacus/checkout/scheduled-replenishment`, which includes the functionalities of both the base and B2B checkout libraries, and also allows the user to either place a regular order, or schedule a replenishment order.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

In Spartacus 4.0, a new [checkout library](https://sap.github.io/spartacus-docs/technical-changes-version-4/#new-checkout-library) was created by extracting the checkout functionality from the original Spartacus libraries. However, this new checkout library only had a single entry point that contained all checkout flows, even if they were not be used (such as the [scheduled replenishment flow](https://sap.github.io/spartacus-docs/scheduled-replenishment/#setting-up-a-replenishment-order), for example). However, in Spartacus 5.0, the library has been further decoupled into different business logic features, with the intention of having a smaller bundle size.

In addition to creating different entry points to reduce the bundle size, NgRx dependencies have been mostly removed (with the exception of a few NgRx actions that are isolated within an event listener), and this has been done by replacing them with [commands and queries](https://sap.github.io/spartacus-docs/commands-and-queries/). It is currently not possible to fully separate NgRx from checkout until other libraries from Spartacus are refactored, such as the Cart or user libraries.

THe benefits of converting to `command and queries` are the following:

- All functionality is in classes, so it is easier to extend, as opposed to NgRx, where you can not really extend a reducer or an effect (without dismantling deeply nested NgRx modules in Spartacus).
- Commands are built in a more reactive way, and return the execution result as part of the same method call.
- Similarly to the commands, listening to loading, error, and data state changes is as simple as calling one method and getting all the results in one call through queries.
- It is much simpler to compose streams with commands and queries because Spartacus is able to chain (or pipe) to the execution of the action.

For more information, see the [Commands Overview](https://sap.github.io/spartacus-docs/commands-and-queries/#commands-overview).

Finally, the business logic for placing an order or scheduling a replenishment order was moved to the order library. The reason for this decision is that the logic to place an order was coupled with a normalizer that existed in the order library, which would break the lazy loading mechanism that is in place. Therefore, the decision was made to move the place order business logic to the order library as it is now [programmatically lazy loaded](https://sap.github.io/spartacus-docs/lazy-loading-guide/#exposing-smart-proxy-facades-from-lazy-loaded-features) when reaching the last step in the checkout process.

## General Changes

The following is a list of general changes made to the checkout libraries:

- The majority of old checkout imports (`@spartacus/checkout`) are now spread across the new entry points (`@spartacus/checkout/base`, `@spartacus/checkout/b2b`, `@spartacus/checkout/scheduled-replenishment`), and their secondary entry points (such as, `@spartacus/checkout/base/core`, `@spartacus/checkout/base/occ`, `@spartacus/checkout/base/components`).
- Services now use commands and queries instead of making use of NgRx for state management.
- `normalizeHttpError()` is moved from the effects to the adapter layer.
- The following order confirmation components are moved to the order library.
  - `OrderConfirmationThankYouMessageComponent`
  - `OrderConfirmationItemsComponent`
  - `OrderConfirmationTotalsComponent`
  - `GuestRegisterFormComponent`
- The business logic for placing an order and scheduling a replenishment is moved to the order library.
- The checkout flow has a better transition experience as a result of enhanced smoothing, less requests and less duplicated requests, and a uniform spinner for every step.
- Most checkout components from Spartacus 4.0 have been re-named to be prefixed with Checkout (for example, `CheckoutPlaceOrderComponent`).
- The `defaultB2bCheckoutConfig` was moved to `@spartacus/checkout/b2b/root`, and renamed to `defaultB2BCheckoutConfig` (note the capital `B2B`).
- If you are using the out-of-the-box checkout feature, and lazily loading `CheckoutModule` from `@spartacus/checkout`, you need to change the dynamic import path to `@spartacus/checkout/base`. It should look like something like the following example:

```ts
provideConfig({
  featureModules: {
    [CHECKOUT_FEATURE]: {
      module: () =>
        import('@spartacus/checkout/base').then((m) => m.CheckoutModule),
    },
  },
});
```

## New Functionality

The following is a list of new functionality in the checkout libraries:

- THe `backOff` pattern is now added to the OCC adapters, and configured to retry on OCC-specific JALO errors.
- For validation and error handling, the commands now perform various precondition checks. At the same time, commands will throw errors if the execution fails. Previously, effects dispatched Fail actions, which usually were not handled.

## Sample Data Changes

The following is a list of sample data changes in the checkout libraries:

- The CheckoutShippingAddress `ContentPage` has been renamed to `CheckoutDeliveryAddress`
  - The title of the content page has been changed from `Checkout Shipping Address` to `Checkout Delivery Address`
  - The page route has been changed from `/checkout/shipping-address` to `/checkout/delivery-address`
- The CheckoutShippingAddressComponent `CMSComponent` has been renamed to `CheckoutDeliveryAddress`
- The BodyContentSlot-checkoutShippingAddress `ContentSlot` has been renamed to `BodyContentSlot-checkoutDeliveryAddress`
- The SideContent-checkoutShippingAddress `ContentSlot` has been renamed to `SideContent-checkoutDeliveryAddress`

**Note:** The new checkout library is not backwards compatible. This library is intended to be used with new applications that are created with other Spartacus 5.0 libraries. If you generate a new storefront app using schematics, the app will use the new checkout library by default. For more information, see [Integration Libraries and Feature Libraries]({{ site.baseurl }}/schematics/#integration-libraries-and-feature-libraries).

## Events

Checkout events are essential because they are used to perform side effects. These events help remove the side effects done from `effects` when using NgRx. Events are caught either by event listeners (classes ending with `-event.listener`) or [queries to reset/reload the data state](https://sap.github.io/spartacus-docs/commands-and-queries/#queries-overview).

**Note:** All events can be found in our [Spartacus events table](https://sap.github.io/spartacus-docs/event-service/#list-of-spartacus-events).

## Commands and Queries Example in Checkout

As mentioned, the new checkout libraries have mostly removed NgRx dependencies while adapting to the Spartacus commands and queries pattern. The following is an example:

1. Components inject facades (example: [CheckoutDeliveryAddressComponent](https://github.com/SAP/spartacus/blob/develop/feature-libs/checkout/base/components/checkout-delivery-address/checkout-delivery-address.component.ts)).

   In [Defining Proxy Facades](https://sap.github.io/spartacus-docs/proxy-facades/#defining-proxy-facades), you can read a description of the dependency injection to the proxy facade, where the actual implementation is provided using a dependency provider. In the case of checkout, the facade service contains the business logic executed by commands and queries, as shown in the following example:

   ```typescript
     constructor(
       ...
       protected checkoutDeliveryAddressFacade: CheckoutDeliveryAddressFacade,
       protected checkoutDeliveryModesFacade: CheckoutDeliveryModesFacade,
       ...
     ) {}
   ```

1. Facades execute commands and queries (example: [CheckoutDeliveryAddressFacade](https://github.com/SAP/spartacus/blob/develop/feature-libs/checkout/base/core/facade/checkout-delivery-address.service.ts)).

   Most of the time, each facade service injects both the `CommandService` and `QueryService`.

   In the `CheckoutQueryFacade`, Spartacus now has a checkout details query that serves as a single source of truth for the checkout state, and is updated after each change the user does during the checkout.

   A [command](https://sap.github.io/spartacus-docs/commands-and-queries/#commands-overview) is created in order to execute an action. In this case, it is for creating a delivery address. As seen in the snippet below, the command type is of `Command<Address, unknown>`. Address is for the input and unknown is for the output. The input for this case is required for the command to execute while the output 'may' be unknown.

1. Commands can dispatch events (for other side effects).

   The following snippet is taken from the `createDeliveryAddressCommand`, which can be found in the source code under the [checkout-delivery-address.service.ts](https://github.com/SAP/spartacus/blob/7bba93e0e6b75024371361b169348cfaebeb2c7b/feature-libs/checkout/base/core/facade/checkout-delivery-address.service.ts#L29). After successfully creating an address, we are [dispatching events](https://sap.github.io/spartacus-docs/event-service/#dispatching-individual-events) under the tap operator in order to be caught by our event listeners to perform additional actions.

   ```typescript
   return this.checkoutDeliveryAddressConnector
     .createAddress(userId, cartId, payload)
     .pipe(
       tap(() => {
         ...
       }),
       map((address) => {
         ...
       }),
       tap((address) =>
         this.eventService.dispatch( // <-- Event dispatching
           {
             userId,
             cartId,
             address,
           },
           CheckoutDeliveryAddressCreatedEvent
         )
       )
   ```

   Event listeners are flexible, so you can inject any number of dependencies to perform certain actions. For example, in this case it fires additional events, such as [`CheckoutResetDeliveryModesEvent`](https://sap.github.io/spartacus-docs/event-service/#list-of-spartacus-events) and [`CheckoutResetQueryEvent`](https://sap.github.io/spartacus-docs/event-service/#list-of-spartacus-events).

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

   The example for [`CheckoutResetQueryEvent`](https://sap.github.io/spartacus-docs/event-service/#list-of-spartacus-events) being fired is to reset the checkout details query from the `CheckoutQueryFacade`, due to the nature of Spartacus commands and queries, where it is possible to [reload or reset a query](https://sap.github.io/spartacus-docs/commands-and-queries/#queries-overview).

## How to Properly Make Use of Queries in Checkout

Example: [CheckoutQueryFacade](https://github.com/SAP/spartacus/blob/7bba93e0e6b75024371361b169348cfaebeb2c7b/feature-libs/checkout/base/core/facade/checkout-query.service.ts) and [CheckoutDeliveryAddressComponent](https://github.com/SAP/spartacus/blob/7bba93e0e6b75024371361b169348cfaebeb2c7b/feature-libs/checkout/base/components/checkout-delivery-address/checkout-delivery-address.component.ts)

The "checkout details query" that is injected into other checkout "facade" services is used to get the current checkout details, which contain information on the delivery address, the delivery mode, and payment information when using the base checkout. When using the B2B checkout, you have additional data, such as "purchase order number", "cost centers", and "payment type".

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

The `getCheckoutDetailsState` returns the entire state, which is an object composed of loading, error, and data properties, but you can always create additional methods in your extended service to include only getting the data. In this case, you would only need to use `.get()` instead of `.getState()` when executing queries, as shown in the following example:

```typescript
    getCheckoutDetails(): Observable<CheckoutState | undefined> {
      return this.checkoutQuery$.get();
    }
```

When queries are used to get the state, it is recommended to filter the loading state. You should also consider using the RxJS `distinctUntilChanged` operator in order to reduce the number of emissions. In the following example, we are making sure to get the selected delivery address only when the data state is not loading, and we are also making sure we get only the distinct emissions:

```typescript
 get selectedAddress$(): Observable<Address | undefined> {
    return this.checkoutDeliveryAddressFacade.getDeliveryAddressState().pipe(
      filter((state) => !state.loading),
      map((state) => state.data),
      distinctUntilChanged((prev, curr) => prev?.id === curr?.id)
    );
  }
```

## Customizing the Lazy Loaded Checkout Module

The principle for customizing the lazy loaded checkout module is the same as for any other module. For more information, see
[Customizing Lazy Loaded Modules](https://sap.github.io/spartacus-docs/lazy-loading-guide/#customizing-lazy-loaded-modules).

## Migrations

Spartacus schematics are designed to assist you in your migration and to help make the transition from your current version to 5.0 go more smoothly.

Take a look at the [5.0 TypeScript Changes](https://github.com/SAP/spartacus/blob/84e6b462db1f5dca5c3145c5bc535fc5e2b52fe2/docs/migration/5_0-generated-typescript-changes-doc.md) to get a high-level overview of what has changed.

### Manually Updating From Old Checkout Facades

Most components will need to be updated to use the new checkout facades.

To do so, make sure to change the type in the constructor, if applicable, and import from the new checkout library.

If you had a component such as the following:

```ts
  import { CheckoutPaymentFacade } from '@spartacus/checkout/root';

  class SomeOldCheckoutComponent {
    constructor(
      ...
      protected checkoutPaymentFacade: CheckoutPaymentFacade
    ) {}
  }
```

You can update is as follows:

```ts
  import { CheckoutPaymentFacade } from '@spartacus/checkout/base/root';

  class SomeOldCheckoutComponent {
    constructor(
      ...
      protected checkoutPaymentFacade: CheckoutPaymentFacade
    ) {}
  }
```

**Note:** The "new" checkout would be from either `@spartacus/checkout/base/root`, `@spartacus/checkout/b2b/root`, or `@spartacus/checkout/scheduled-replenishment/root`.

### Using the Newly Created Checkout Components

You can consider whether to use the new Spartacus checkout components, such as `CheckoutPaymentTypeComponent`, instead of the old `PaymentTypeComponent`.

If you do not want to use the newly created Spartacus components that consume the new facades with commands and queries under the hood, you can always import the new facade into your existing components and adapt the code accordingly.

### Example of Removing NgRx by Using Spartacus Commands and Queries

Let's imagine a use case where you customized the loading of payment types in the checkout payment type step.

With the old checkout implementation that uses NgRx prior to the refactor, you would need to dismantle the checkout module(s) and replace the default Spartacus store modules (usually the `effect`s and `reducer`s).
Additionally, if you wanted to add custom logic in the old implementation, you could also "tap" into the NgRx actions stream, and listen for relevant actions in order to perform additional logic.

For example, you might have a custom effect, such as the following:

```ts
import { Injectable } from '@angular/core';
import { Actions, Effect, ofType } from '@ngrx/effects';
import { CheckoutActions } from '@spartacus/checkout/core';
import { switchMap } from 'rxjs/operators';

@Injectable()
export class CustomPaymentTypesEffects {
  @Effect()
  loadPaymentTypes$ = this.actions$.pipe(
    ofType(CheckoutActions.LOAD_PAYMENT_TYPES_SUCCESS),
    switchMap((action) => {
      // ... custom logic ...
    })
  );

  ...

  constructor(private actions$: Actions) {}

  ...
}
```

With the newly refactored checkout that uses commands and queries, you can now simply extend the relevant facade (such as `CheckoutPaymentTypeFacade`) and override the relevant method (such as `getPaymentTypes()`), which enables the use of adding custom logic in a central place. Another benefit of this approach is the fact that the custom logic applies to all the callers.

Alternatively, if you have a use case where you need to apply the custom logic to only one place, without affecting other callers, you can simply do the following:

```ts
import { ChangeDetectionStrategy, Component } from '@angular/core';
import { PaymentType } from '@spartacus/cart/base/root';
import { CheckoutPaymentTypeFacade } from '@spartacus/checkout/b2b/root';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators';

@Component({
  selector: 'cx-payment-type',
  templateUrl: './custom-checkout-payment-type.component.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class CustomCheckoutPaymentTypeComponent {
  ...

  paymentTypes$: Observable<PaymentType[]> = this.checkoutPaymentTypeFacade
    .getPaymentTypes()
    .pipe(
      tap(
        // handle next / success case
        (paymentTypes) => {
          // custom logic
        },
        // handle error
        (error) => {}
      )
    );

  constructor(protected checkoutPaymentTypeFacade: CheckoutPaymentTypeFacade) {}

  ...
}
```

### Mixing NgRx with Commands and Queries

The following are some reasons why you would mix NgRx with command and queries:

- Synchronizing the other parts of the (custom) state after the checkout state changes
- Gradually moving your custom NgRx-based logic to commands and queries during a transitional period

You can achieve this by using the relevant checkout events and NgRx actions.

If you would like to dispatch a custom NgRx action after a checkout event happens, you can either override the existing event listener, and alter the default behavior, or you can create a new listener and do something such as the following:

```ts
import { Injectable, OnDestroy } from '@angular/core';
import { Store } from '@ngrx/store';
import {
  EventService,
  LoadUserAddressesEvent,
  UserActions,
} from '@spartacus/core';
import { Subscription } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class CustomCheckoutStoreEventListener implements OnDestroy {
  protected subscriptions = new Subscription();

  constructor(
    protected eventService: EventService,
    protected store: Store<unknown>
  ) {
    this.onUserAddressAction();
  }

  protected onUserAddressAction(): void {
    this.subscriptions.add(
      this.eventService.get(LoadUserAddressesEvent).subscribe(({ userId }) => {
        this.store.dispatch(new UserActions.LoadUserAddresses(userId));
      })
    );
  }

  ngOnDestroy(): void {
    this.subscriptions.unsubscribe();
  }
}
```

### Migrating Reducers

The reducers update the state based on the action's payload. To customize the state in the new checkout, you can extend the appropriate facade and override the relevant method that returns the result of the query.

Because all queries are plain observables, you can compose multiple streams if needed, and use the `map` operator of `rxjs`.

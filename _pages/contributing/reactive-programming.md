---
title: Reactive programming in Spartacus
---

## Observables as main mechanism for asynchronous code

There are many ways to write asynchronous code in JS: callbacks, promises, observables (rxjs). In spartacus we decided to go all in on observables.

Sometimes to interact with external dependencies you have to use what is used by those, but from methods that are working on different patterns always try to return `Observable`. Consistent usage of those across the whole codebase makes code easier to follow and reasoning about flow of data is simpler.

Example:
You have method to add entry to the cart and you want return from it information about success or failure.
You could do it with Promise, but for better integration with spartacus code you should return observable.

```typescript
addEntry(product: string, quantity: number): Observable<Status> {
  return this.cartService.getId().pipe(
      switchMap(cartId => {
        // External API client returns Promise for actions
        return from(this.cartApiService.addEntry(cartId, product, quantity))
      })
    );
}
```

**Note** You might still find some promises/callbacks in spartacus, but those are leftovers from the past and will be gradually replaced.

## Beware of early subscriptions

In some cases we have subscriptions on some observables that stars at the application initialization and live the whole time (eg. if you register to events).

In those cases make sure to subscribe to the things you need at the moment and nothing else. Often streams cause some side effects (eg. loading some data). Using them recklessly can cause redundant calls, extra computations which can result in worse application performance.

Example:
Using operator `withLatestFrom` causes subscriptions to passed stream when the root stream is subscribed to.

```typescript
this.getAction(mapping.action).pipe(
  withLatestFrom(this.activeCartService.getActive()),
  map(([action, activeCart]) =>
    createFrom(mapping.event, {
      ...action.payload,
      cartCode: activeCart.code,
    })
  )
);
```

In this example we wanted to enrich cart actions with the content of the cart.
However usage of `withLatestFrom` here caused that once we registered listener to cart events we caused subscription to active cart which then invoked cart load.

As we think about this case we only want cart data when the cart event happens.
We can adjust the stream accordingly.
Now we don't subscribe to the cart stream when someone subscribes to the output stream (i.e. on app start), but only when the source event occurs.

```typescript
this.getAction(mapping.action).pipe(
  switchMap((action) => {
    return of(action).pipe(
      withLatestFrom(
        this.activeCartService.getActive(),
        this.activeCartService.getActiveCartId()
      )
    );
  }),
  map(([action, activeCart]) =>
    createFrom(mapping.event, {
      ...action.payload,
      cartCode: activeCart.code,
    })
  )
);
```

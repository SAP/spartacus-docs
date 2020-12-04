---
title: Events
---

## Beware of early subscriptions

In case of events we have subscriptions on event streams that stars at the application initialization and live the whole time (when someone subscribes to those events).

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

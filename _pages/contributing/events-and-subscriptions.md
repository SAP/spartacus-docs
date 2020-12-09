---
title: Events and Subscriptions
---

In Spartacus, at the application start, you can subscribe to event streams that continue to be active for the whole application lifetime.

When working with these kinds of event streams, it is important to subscribe only to the ones you need at the time, and nothing else. This is because streams can often cause side effects, such as loading data. Subscribing needlessly to streams can cause redundant calls, and add extra computations that result in reduced application performance.

In the following example, use of the `withLatestFrom` operator results in subscriptions to the passed stream (that is, to the parameter you use to call the `withLatestFrom` function) when the root stream is subscribed to:

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

The intention in this example is to enrich cart actions with the contents of the cart. However, once a listener has been registered to the cart events, using the `withLatestFrom` operator results in a subscription to the active cart, which then invokes a cart load. But in fact, we only want cart data when a cart event happens.

We can adjust the event stream, as shown in the following example:

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

In this example, we no longer subscribe to the cart stream when someone subscribes to the output stream (that is, when the application starts). Instead, we only subscribe when the source event occurs.

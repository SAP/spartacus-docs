---
title: Event Service
feature:
- name: Event Service
  spa_version: 2.0
  cx_version: n/a
- name: Event Type Inheritance
  spa_version: 3.1
  cx_version: n/a
  anchor: event-type-inheritance
---

The Spartacus event service provides a stream of events that can be consumed by customer experience personalization solutions, such as SAP Commerce Cloud, Context-Driven Services.

The event service also allows you to decouple certain components. For example, you might have a component that dispatches an event, and another component that reacts to this event, without requiring any hard dependency between the components.

The event service leverages RxJs Observables to drive the streams of events.

## Event Types

Events are driven by TypeScript classes, which are signatures for a given event and can be instantiated. The following is an example:

```typescript
import { CxEvent } from "@spartacus/core";
export class CartAddEntryEvent extends CxEvent {
  cartId: string;
  userId: string;
  productCode: string;
  quantity: number;
}
```

## Observing Events

To observe events of a given type, you can get the stream for the event type, and then subscribe to it whenever you need. The following is an example for the `CartAddEntryEvent` call:

```typescript
constructor(events: EventService){}
/* ... */

const result$ = this.events.get(CartAddEntrySuccessEvent);
result$.subscribe((event) => console.log(event));
```

## Pulling Additional Data From Facades

If you need more data than what is contained in a particular event, you can combine this data with other streams. For example, you can collect additional data from facades.

The following is an example of reacting to an "added to cart event", followed by waiting for the cart to be stable (because the OCC cart needs to be reloaded from the back end), and then appending all of the cart data to the data from the event:

```typescript
constructor(
    events: EventService,
    cartService: ActiveCartService
    ){}
/* ... */

const result$ = this.events.get(CartAddEntrySuccessEvent).pipe(
    // When the above event is captured, wait for the cart to be stable
    // (because OCC reloads the cart after any cart operation)...
    switchMap((event) =>
        this.cartService.isStable().pipe(filter(Boolean), mapTo(event))
    ),
    // Merge the state snapshot of the cart with the data from the event:
    withLatestFrom(this.cartService.getActive()),
    map(([event, cart]) => ({ ...event, cart }))
);
```

### No Performance Cost for Unused Events

Since the event service leverages RxJs Observables, event streams are lazy. This means that no defined computations happen (such as pulling data from facades) until someone subscribes to the particular stream of events. The following is an example:

```typescript
result$.subscribe((event) => {
  // < log the event (for example, to a tag manager) >
});
```

## Registering Event Sources

In theory, any RxJs Observable can be a source of events as soon as it emits objects of the declared class type. In practice, there are some limitations, as described in [Avoiding Certain Candidates for an Event Stream](#avoiding-certain-candidates-for-an-event-stream), below.

The following is an example of how to register an RxJs `Subject` as a source of events of type `CustomEvent`:

```typescript
const subject$ = new Subject<CustomEvent>();
const unregister = eventService.register(CustomEvent, subject$);
```

**Note:** It is possible to register multiple sources to a single event type, even without knowing it, because multiple decoupled features can attach sources to the same event type. The following is an example:

```typescript
eventService.register(CustomEvent, subject1$);
eventService.register(CustomEvent, subject2$);
```

### Avoiding Certain Candidates for an Event Stream

Not all RxJs Observables are good candidates for an event stream. For example, the NgRx selectors are not good candidates for an event stream. The Observable of the NgRx selector replays the latest updated value at the moment of the subscription, regardless of when the value was updated. But a valid event stream should emit a value only when the actual event happens.

Examples of candidates to avoid for event sources are the following Observables and their derivatives, including Spartacus facades that use the following under the hood:

- NgRx state selectors
- `BehaviorSubject` and `ReplaySubject` from RxJs
- Observables with the piped operators `replay()` and `shareReplay()` from RxJs
- Observables created by the operators `of()` and `from()` from RxJs
- anything that emits a value simply because a subscription was made.

A pure RxJs `Subject` is a good candidate for the event source.

### Avoiding Memory Leaks and Unregistering Event Sources

To avoid memory leaks, every event source Observable should be unregistered from the `EventService` when it is no longer needed. To unregister an event source, you can call the "tear down" function that is returned by the `register()` method. The following is an example:

```typescript
const unregister = eventService.register(CustomEvent, subject$);
/* ... */
unregister(); // Calling the handler assigned from `eventService.register(...)` in the example above
```

**Note:** Completed Observables must be unregistered manually. They will not be unregistered automatically on stream completion.

## Dispatching Individual Events

The `register()` method is intended to register RxJs Observables. However, event instances can also be dispatched individually, using the `dispatch()` method. For example, in your component logic, you could call the following:

```typescript
constructor(events: EventService){}
/* ... */

onClick() {
  this.events.dispatch(new CustomUIEvent(...));
}
```

## Event Type Inheritance

In Spartacus 3.1, we've introduced a concept of parent (or "umbrella") events. The purpose of these parent events is to group similar events under one common event. The parent event can be an abstract or a regular class.
By subscribing to the parent event, you will get emissions from all the "child" events that inherit it.

For example, `@spartacus/core`'s `PageEvent` is a parent event. All the specific page events inherit from it (`HomePageEvent`, `CartPageEvent`, etc.).
In the previous Spartacus versions, you had to observe each of the page events individually (i.e. `eventService.get(HomePageEvent).subscribe(...)`, `eventService.get(CartPageEvent).subscribe(...)`, etc.).
Starting from Spartacus 3.1, you can subscribe to all the grouped events just by observing the parent event:

```typescript
eventService.get(PageEvent).subscribe(...) // receives all page events
```

Note that all events _should_ inherit from `@spartacus/core`'s `CxEvent`:

```typescript
import { CxEvent } from "@spartacus/core";
export class MyEvent extends CxEvent {...}
```

This is not required for the event to work properly, but it is desireable to have in cases you want to observe all events at once:

```typescript
eventService.get(CxEvent).subscribe(...) // receives all Spartacus' events.
```

**Note:** observing all Spartacus' events at once might have a significant performance hit, therefore use with care.

## Finding Spartacus Events

The following is a non-exhaustive list of locations where you can find Spartacus events:

- `projects/core/src/event/cx-event.ts`
- `projects/core/src/auth/user-auth/events/user-auth.events.ts`
- `projects/core/src/cart/event/cart.events.ts`
- `projects/core/src/checkout/events/checkout.events.ts`
- `projects/core/src/product/event/product.events.ts`
- `projects/core/src/lazy-loading/events/module-initialized-event.ts`
- `projects/core/src/site-context/events/site-context.events.ts`
- `projects/storefrontlib/src/events/navigation/navigation.event.ts`
- `projects/storefrontlib/src/events/page/page.events.ts`
- `projects/storefrontlib/src/events/home/home-page.events.ts`
- `projects/storefrontlib/src/events/cart/cart-page.events.ts`
- `projects/storefrontlib/src/events/product/product-page.events.ts`
- `projects/storefrontlib/src/cms-components/navigation/search-box/search-box.events.ts`

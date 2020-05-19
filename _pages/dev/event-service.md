---
title: Event Service
---

To increase conversion, we'd like to analyze user's journey in the storefront and improve the experience by tweaking CMS data, banners, styles etc. Tools helping to gather and analyze those data could be tag managers, i.e. Google Tag Manager, Adobe Launch or CDS. Those tools need to be fed with a stream of events. Spartacus meets this need by providing the Event Service.

Events can also help decoupling some components. Let's say Component A dispatches an event, then Component B reacts to it and there is no hard dependency between components A and B.

## Event types
Events are driven by Typescript classes, which are signatures for a given event and can be instantiated, for example:

```typescript
export class CartAddEntryEvent {
  cartId: string;
  userId: string;
  productCode: string;
  quantity: number;
}
```

## Event Service and Observable pattern

The Event Service leverages the RxJs Observables to drive the streams of events.

### Observing events

When you are interested in events of a given type, just get the stream of this event, so you can subscribe to when you need. For example, for `CartAddEntryEvent` call:
```typescript
constructor(events: EventService){}
/* ... */

const result$ = this.events.get(CartAddEntrySuccessEvent);
result$.subscribe((event) => console.log(event));
```

### Pulling additional data from facades

Sometimes it may be the case that the data contained in the original event doesn't suffice, so you may want to combine it with other streams, i.e. by collecting additional data from facades. Here is how to react on "added to cart event", then wait for cart to be stable (because OCC cart needs being reloaded from backend) and finally append whole cart data to the event's data:

```typescript
constructor(
	events: EventService,
	cartService: ActiveCartService
	){}
/* ... */

const result$ = this.events.get(CartAddEntrySuccessEvent).pipe(
	// when captured above event, wait for the cart to be stable 
	// (it's OCC specific to reload cart after any cart operation):
	switchMap((event) =>
		this.cartService.isStable().pipe(filter(Boolean), mapTo(event))
	),
	// merge the state snapshot of the cart with the event's data:
	withLatestFrom(this.cartService.getActive()),
	map(([event, cart]) => ({ ...event, cart }))
);
```

#### No performance cost for unused events

Thanks to the used RxJs Observables, event streams are lazy. It means that no defined computations (i.e. pulling data from facades) will happen until someone subscribes to the particular stream of events:

```typescript
result$.subscribe(event => {
	// < log the event (i.e. to a tag manager) >
})
```

### Registering event sources 

Theoretically any RxJs Observable can be a source of events as soon as it emits objects of the declared class type. Practically there are some limitations ([described later](#unsupported-observables-to-register)). Here is how to register a RxJs `Subject` as a source of events of type `CustomEvent`:

```typescript
const subject$ = new Subject<CustomEvent>();
const unregister = eventService.register(CustomEvent, subject$);
```

*Note: It is possible to register multiple sources to a single event type, even without knowing as multiple decoupled features can attach sources to the same event type.*
```typescript
eventService.register(CustomEvent, subject1$);
eventService.register(CustomEvent, subject2$);
```

#### Bad candidates for en event stream

**Not all RxJs Observables are good candidates for an event stream,** for instance the *ngrx selectors*. The Observable of the ngrx selector replays the latest updated value at the moment of the subscription - regardless when the value was updated! But **a valid event stream should emit a value only when the actual event happens**.

Examples of bad candidates for the event sources are the following Observables and their derivatives (including Spartacus facades that use the following under the hood):
- ngrx state selectors
- `BehaviorSubject` and `ReplaySubject` of RxJs
- Observables with piped operators `replay()` and `shareReplay()` of RxJs
- Observables created by the operators `of()` and `from()` of RxJs
- ... and anything that emits a value only because of the fact of the subscription.


#### AVOIDING MEMORY LEAKS - unregistering event sources
To avoid memory leaks, every event source Observable should be unregistered from the `EventService`, when it's are no longer needed. To unregister an event source, just call the _tear down function_ returned by the method `register()`. For example:

```typescript
const unregister = eventService.register(CustomEvent, subject$);
/* ... */
unregister(); // calling the handler assigned from `eventSource.register(...)` in the example above
```

*Note: **Also completed Observables have to be unregistered manually** (they won't be unregistered automatically on the stream completion!).*

### Dispatching individual events

The method `register()` is meant to register RxJs Observables. But event instances can be also dispatched individually using the method `dispatch()`. For example in your component's logic you can call:

```typescript
constructor(events: EventService){}
/* ... */

onClick() {
  this.events.dispatch(new CustomUIEvent(...));
}
```
---
title: Reactive Programming in Spartacus
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

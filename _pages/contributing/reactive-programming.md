---
title: Reactive Programming in Spartacus
---

There are many ways to write asynchronous code in JS, such as callbacks and promises, as well as observables in the case of RxJS. As much as possible, Spartacus uses observables as the main mechanism for asynchronous code.

When interacting with external dependencies, it is sometimes necessary to follow the same pattern that is used by those dependencies. However, if you are working with methods that use a different pattern, always try to return an `Observable` if you can. By consistently using the same patterns across the entire codebase, we make our code easier to follow, and simplify the analysis of data flow.

For example, let's say you have a method to add an entry to the cart, and you want to return a result of success or failure. You could do this with a `Promise`, but for better integration with Spartacus code, you should return an `Observable` instead. The following is an example:

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

**Note:** You may still find promises or callbacks in the Spartacus codebase, but these will gradually be replaced in future releases.

---
title: Loader Meta Reducer
feature:
- name: Loader Meta Reducer
  spa_version: 1.0
  cx_version: n/a
---

When a user interacts with a Spartacus storefront, the storefront application often provides feedback, such as "Cart is loading", or "Fetching the user address failed", and so on. Spartacus handles this kind of meta data for every separate application state, as well as for each relevant aspect of the application, such as cart, user information, product data, and so on. To handle this requirement efficiently across the codebase, Spartacus uses the `loaderReducer`. This reducer standardizes the handling of meta data across the whole state tree. You can use it at any depth of the tree, wherever you need it. In addition to the reducer, Spartacus also provides utilities for actions and selectors.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Applying the Meta Reducer

You can wrap a part of the state tree with the loader utility, as shown in the following example:

``` ts
import { loaderReducer } from '@spartacus/core';

export const CART_DATA = '[Cart] Cart Data';

export function getReducers(): ActionReducerMap<CartsState> {
  return {
    active: loaderReducer<CartState>(CART_DATA, cartReducer),
  };
}
```

You provide a unique identifier to the `loaderReducer`, which in this example is the `CART_DATA` variable. This identifier is also used in actions to connect each action to a specific state tree.

To maintain a simple state (that is, with one property), you do not have to provide a reducer. The loader success action sets the `value` with the passed payload.

## Defining the State Interface

To correctly set type definitions on your state, use the `LoaderState` interface, as shown in the following example:

``` ts
import { LoaderState } from '@spartacus/core';

export const CART_FEATURE = 'cart';

export interface StateWithCart {
  [CART_FEATURE]: CartsState;
}

export interface CartsState {
  active: LoaderState<CartState>;
}

export interface CartState {
  content: Cart;
  entries: { [code: string]: OrderEntry };
  // ...
}
```

## Creating Actions

To manipulate meta data for the `loading`, `success` or `error` loading states, the actions that you create should extend the loader actions. It is very important to extend those actions, or to ensure that you set proper meta on the actions, preferably using the provided meta helpers. Note that if all of your actions implement the standard `Action`, the loader flags will not work correctly.

The following is an example of how to create a set of actions for the cart:

``` ts
import { StateLoaderActions } from '@spartacus/core';

// ...

// action's result
// - `loading` flag => true
export class LoadCart extends StateLoaderActions.LoaderLoadAction {
  readonly type = LOAD_CART;
  constructor(public payload: { userId: string; cartId: string }) {
    super(CART_DATA);
  }
}

// action's result
// - `error` flag => (provided error) || true
// - `loading` flag => false
// - `success` flag => false
export class LoadCartFail extends StateLoaderActions.LoaderFailAction {
  readonly type = LOAD_CART_FAIL;
  constructor(public payload: any) {
    super(CART_DATA, payload);
  }
}

// action's result
// - `success` flag => true
// - `loading` flag => false
// - `error` flag => false
export class LoadCartSuccess extends StateLoaderActions.LoaderSuccessAction {
  readonly type = LOAD_CART_SUCCESS;
  constructor(public payload: any) {
    super(CART_DATA);
  }
}

// action's result
// - `loading` flag => false
// - `error` flag => false
// - `success` flag => false
export class ClearCart extends StateLoaderActions.LoaderResetAction {
  readonly type = CLEAR_CART;
  constructor() {
    super(CART_DATA);
  }
}
```

## Working With Selectors

When you apply the loader reducer, it changes the state shape with additional flags and a `value` that contains the wrapped state. As a result, the `ngrx` selectors need to be adjusted. Spartacus provides utility functions for extracting the `value` key or meta data (`loading`, `error`, `success`).

The following are the available functions:

- `loaderValueSelector`
- `loaderLoadingSelector`
- `loaderErrorSelector`
- `loaderSuccessSelector`

This following is an example of selectors from the cart feature that makes use of these utility functions:

``` ts
import { StateLoaderSelectors } from '@spartacus/core';

export const getCartsState: MemoizedSelector<
  StateWithCart,
  CartsState
> = createFeatureSelector<CartsState>(CART_FEATURE);

export const getActiveCartState: MemoizedSelector<
  StateWithCart,
  LoaderState<CartState>
> = createSelector(
  getCartsState,
  (cartsState: CartsState) => cartsState.active
);


export const getCartState: MemoizedSelector<
  StateWithCart,
  CartState
> = createSelector(
  getActiveCartState,
  state => StateLoaderSelectors.loaderValueSelector(state)
);

export const getCartLoaded: MemoizedSelector<
  StateWithCart,
  boolean
> = createSelector(
  getActiveCartState,
  state =>
    StateLoaderSelectors.loaderSuccessSelector(state) &&
    !StateLoaderSelectors.loaderLoadingSelector(state) &&
    !StateLoaderSelectors.loaderValueSelector(state).refresh
);
```

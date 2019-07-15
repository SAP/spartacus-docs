---
title: Loader Meta Reducer (DRAFT)
---

## Overview

To give better feedback to users, based on their actions, we often have to keep information such as "cart is loading", "fetching user address failed", and so on.
For every separate application state, we have to keep that meta data beside. Separate for cart, user information, product data and so on. Implementing this logic in all of these places manually would result in having different solutions to the same problem across the codebase.
That's why in spartacus `loaderReducer` was created. This reducer standardizes meta data handling in the whole state tree.
You are able to use it on any depth of the tree, wherever you need it. Apart from the reducer, we also provide utilities for actions and selectors.

## Applying the Meta Reducer

Wrapping part of state tree with loader utility is quite simple:

``` ts
import { loaderReducer } from '@spartacus/core';

export const CART_DATA = '[Cart] Cart Data';

export function getReducers(): ActionReducerMap<CartsState> {
  return {
    active: loaderReducer<CartState>(CART_DATA, cartReducer),
  };
}
```

To `loaderReducer` you have to provide unique identifier. In case above it is `CART_DATA` variable.
This identifier will also be used in actions to connect each action to specific state tree.

For keeping simple state (one property), you don't have to provide reducer. Loader success action will set `value` with passed payload.

## Defining the State Interface

To correctly set type definitions on your state use `LoaderState` interface.

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

To manipulate meta data for loading states `loading`, `success` or `error`, actions created should extend loaders actions. It is very important to extend those actions or make sure to set proper meta on action (preferably using provided meta helpers).
In case all of your actions implements standard `Action`, loader flags won't work correctly.

Example below will describe it the best:

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

Applying loader reducer changes state shape with additional flags and `value` which contains wrapped state.
Because of that `ngrx` selectors needs to be adjusted. Spartacus provides utility functions for extracting `value` key or meta data (`loading`, `error`, `success`).

Available functions:

- loaderValueSelector
- loaderLoadingSelector
- loaderErrorSelector
- loaderSuccessSelector

Example selectors from cart feature that makes use of those utility functions:

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

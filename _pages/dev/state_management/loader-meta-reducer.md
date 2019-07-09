# Loader meta reducer

## Purpose

To give better feedback to users, based on their actions we often have to keep information such as `cart is loading`, `fetching user address failed`.
For every separate application state we have to keep that meta data beside. To make handling those meta data easier in spartacus `loaderReducer` was created.
This meta reducer standardize meta data handling in whole state tree.
You are able to use it on any depth of the tree, wherever you need it. Apart from reducer, we also provide utilities for actions and selectors.

## Usage in reducer

Wrapping part of state tree with loader utility is quite simple: 
``` ts
export function getReducers(): ActionReducerMap<CartsState> {
  return {
    active: loaderReducer<CartState>(CART_DATA, cartReducer),
  };
}

export const reducerToken: InjectionToken<
  ActionReducerMap<CartsState>
> = new InjectionToken<ActionReducerMap<CartsState>>('CartReducers');

export const reducerProvider: Provider = {
  provide: reducerToken,
  useFactory: getReducers,
};
```

## Creating Actions

## Working with selectors

## Handling effects

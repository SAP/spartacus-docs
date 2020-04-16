---
title: State persistence
---

In version 2.0 we introduced new mechanism to persist state of the application. Previously we only had very simple and declarative mechanism called storageSync where you could provide store properties keys to persist and those persisted keys were used on application start to set initial state in the store.

## API

Heart of the new feature is the `StatePersistenceService` and specifically its `syncWithStorage` method. First let's go through all the options that you can pass to this function:

- `key` is used to distinguish one feature state persistence from another one. Example: to store active cart id I would use `cart` key and for user session data `session`.
- `state$` observable which should emit every time you want to save new value to persistent storage. Example: to persist active cart id every time active cart id changes this observable should emit with new value.
- `context$` observable describes valid context for particular state. Example: active cart id is valid only on the one base site. On different base sites we want to use different carts. So in that case for `context$` we would use observable emitting base site every time it changes.
- `storageType` specifies storage type that should be used. By default it is local storage, but you can change that for example to session storage.
- `onRead` callback is invoked every time context changes. In case of the cart every time we change base site this callback would be called with value read from storage for that particular context. It might dispatch `undefined` value when there wasn't anything saved in storage.

## Flow of the state synchronization

1. I setup my own state persistence service with:

- `key`: `"cart"`
- `state$` : pointing to active cart id selector
- `context$`: `this.siteContextParamsService.getValues([BASE_SITE_CONTEXT_ID])` - so cart is valid only on the same base site
- `onRead`: function dispatching `ClearCart` action and then `SetActiveCartId` when id was read from storage

1. I enter `electronics` base site for the first time
1. `onRead` was dispatched with `undefined`, because we didn't have anything under `spartacus⚿electronics⚿cart` key in local storage. Because of that we cleared cart state.
1. We add something to the cart.
1. In the background cart is created for us and active cart id selector emitted new value.
1. Now in local storage we have saved active cart id under `spartacus⚿electronics⚿cart` key.
1. I switched from `electronics` to `apparel` site where I previously added few things to the cart.
1. `onRead` action was dispatched with active cart id for that site read from `spartacus⚿apparel⚿cart` key in storage. We cleared state and set active cart id. `ActiveCartService` picked that id and loaded cart created in some previous session.
1. I go back to `electronics` site.
1. The same thing happens. `onRead` is invoked with cart from electronics and we cleared `apparel` ngrx state and loaded correct cart.

## How to implement complete state persistence for feature

Based on cart example I will go through whole implementation (it's just 2 steps) of state persistence for a feature.

Let's start with creating service for cart state persistence.

```ts
// Import dependencies.

@Injectable({
  providedIn: 'root',
})
export class MultiCartStatePersistenceService {
  constructor(
    protected statePersistenceService: StatePersistenceService,
    protected store: Store<StateWithMultiCart>,
    protected siteContextParamsService: SiteContextParamsService
  ) {}

  public sync() {
    this.statePersistenceService.syncWithStorage({
      // We used this key to distinguish from other features.
      key: 'cart',
      state$: this.getCartState(),
      // Cart is only valid on one base site, so we used base site as a context value.
      // For common cases (language/currency/base site) `SiteContextParamsService.getValues` might come handy.
      // To have behavior similar to storageSync you might use just `of('')`.
      // For more custom solutions you might use anything here.
      context$: this.siteContextParamsService.getValues([BASE_SITE_CONTEXT_ID]),
      // We point to our read callback.
      // It will be called on every context change.
      onRead: (state) => this.onRead(state),
    });
  }

  // Every time active cart changes we emit new value here to trigger save to storage.
  protected getCartState(): Observable<{ active: string }> {
    return this.store.pipe(
      select(MultiCartSelectors.getMultiCartState),
      filter((state) => !!state),
      // As an optimization we try to emit only when necessary.
      distinctUntilKeyChanged('active'),
      map((state) => {
        return {
          active: state.active,
        };
      })
    );
  }

  protected onRead(state: { active: string }) {
    // We always want to clear cart state when we enter the base site.
    this.store.dispatch(new CartActions.ClearCartState());
    // State might be undefined, when there wasn't any data in storage.
    // When state is defined its type will be the same as inner type of state$ observable.
    if (state) {
      // In case we get the state we want to point to read active cart id.
      this.store.dispatch(new CartActions.SetActiveCartId(state.active));
    }
  }
}
```

Second part of implementation is to provide created service on app initialization.

```ts
// Import dependencies.

// Create factory to invoke `sync` method.
export function cartStatePersistenceFactory(
  cartStatePersistenceService: MultiCartStatePersistenceService,
  configInit: ConfigInitializerService
) {
  const result = () =>
    // With async configuration we want to want for stable configuration.
    // We have dependency on base site which is part of context config.
    configInit.getStableConfig('context').then(() => {
      // Initialize state persistence mechanism.
      cartStatePersistenceService.sync();
    });
  return result;
}

// It is recommended to couple state persistence with its main feature module.
@NgModule({
  imports: [MultiCartStoreModule, CartEventModule],
})
export class CartModule {
  static forRoot(): ModuleWithProviders<CartModule> {
    return {
      ngModule: CartModule,
      providers: [
        // Other providers here.
        {
          // Run factory on APP_INITIALIZER
          provide: APP_INITIALIZER,
          useFactory: cartStatePersistenceFactory,
          deps: [MultiCartStatePersistenceService, ConfigInitializerService],
          multi: true,
        },
      ],
    };
  }
}
```

That's the whole implementation needed to enable state persistence for particular feature.
It's not that simple as storageSync, but gives a lot more control with context and dedicated onRead callback.

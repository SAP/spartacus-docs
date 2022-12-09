---
title: State Persistence
feature:
- name: State Persistence
  spa_version: 2.0
  cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 2.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Prior to Spartacus version 2.0, the only way to achieve state persistence was by using a simple, declarative mechanism called `storageSync`, which allowed you to provide properties keys to persist in the store. When you started your application, these persisted keys were used to set the initial state in the store. With Spartacus version 2.0 or newer, you can persist the state of your storefront application by using the `StatePersistenceService`, and specifically, its `syncWithStorage` method. It is not as simple as `storageSync`, but it provides a lot more control using context and dedicated `onRead` callback.

You can pass the following options to the `syncWithStorage` function: `key`, `state$`, `context$`, `storageType`, and `onRead`.

These options work as follows:

- `key` is used to distinguish one feature from another in storage. For example, to store the active cart id, you can use the `cart` key, and for the user session data, you can use the `session` key.
- `state$` is an observable that emits a value every time you want to save the new value to the persistent storage. For example, to persist the active cart id every time the active cart id changes, this observable emits a new value.
- `context$` is an observable that describes a valid context for a particular state. For example, the active cart id is valid only for one base site. On different base sites, you want to use different carts. In this case, with `context$`, you would use an observable that emits the base site every time it changes.
- `storageType` specifies the storage type that is used. By default, the storage type is local storage, but you can change this to session storage, for example.
- `onRead` is a callback that is invoked every time the context changes. To use the cart as an example, every time you change the base site, this callback is called with a value read from storage for that particular context. It will dispatch a value of `undefined` if there is nothing saved in storage.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Implementing Complete State Persistence for a Feature

The following steps describe how to implement state persistence for a feature, using the cart as an example:

1. Create a service for cart state persistence.

    The following is an example:

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
          // We use this key to distinguish from other features.
          key: 'cart',
          state$: this.getCartState(),
          // The cart is only valid on one base site, so we use the base site as a context value.
          // For common cases (language/currency/base site) `SiteContextParamsService.getValues` might be useful.
          // If the persisted value does not depend on any context, you can skip the `context$` parameter.
          // For more custom solutions, you might use anything here.
          context$: this.siteContextParamsService.getValues([BASE_SITE_CONTEXT_ID]),
          // We point to our read callback, that will be called with the value restored from persisted storage.
          // We will restore the value on every context change. If `context$` was not given, the `onRead` callback will be invoked only once, on application start.
          onRead: (state) => this.onRead(state),
        });
      }

      // Every time the active cart changes, we emit a new value here to trigger a save to storage.
      protected getCartState(): Observable<{ active: string }> {
        return this.store.pipe(
          select(MultiCartSelectors.getMultiCartState),
          filter((state) => !!state),
          // As an optimization, we try to emit only when necessary.
          distinctUntilKeyChanged('active'),
          map((state) => {
            return {
              active: state.active,
            };
          })
        );
      }

      protected onRead(state: { active: string }) {
        // We always want to clear the cart state when we enter the base site.
        this.store.dispatch(new CartActions.ClearCartState());
        // The state might be undefined, when there isn't any data in storage.
        // When the state is defined, its type will be the same as the inner type of the `state$` observable.
        if (state) {
          // If we get the state, we want to point to the read active cart id.
          this.store.dispatch(new CartActions.SetActiveCartId(state.active));
        }
      }
    }
    ```

2. Provide the created service when the application is initialized.

    The following is an example:

    ```ts
    // Import dependencies.

    // Create factory to invoke `sync` method.
    export function cartStatePersistenceFactory(
      cartStatePersistenceService: MultiCartStatePersistenceService,
      configInit: ConfigInitializerService
    ) {
      const result = () =>
        // With async configuration we want to wait for stable configuration.
        // We have a dependency on the base site that is part of the context config.
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

## State Synchronization in Action

The following is an example description of state synchronization with an electronics and an apparel storefront. In this example, the state persistence service is set up as follows:

- `key`: `"cart"`
- `state$` : points to the active cart id selector
- `context$`: `this.siteContextParamsService.getValues([BASE_SITE_CONTEXT_ID])` // The cart is valid only on the same base site
- `onRead`: function dispatches `ClearCart` action, and then `SetActiveCartId` when the id is read from storage

### State Synchronization Example

The following describes an example flow of the state synchronization:

1. Access the `electronics` base site for the first time.

    The `onRead` callback is invoked with `undefined`, because there was nothing under the `spartacus⚿electronics⚿cart` key in local storage. In this implementation of `onRead`, the cart state is cleared by dispatching the `ClearCart` action.

2. Add something to the cart.

    In the background, the cart is created, and the active cart id selector emits a new value. Now the active cart id is saved under the `spartacus⚿electronics⚿cart` key in local storage.

3. Switch from the `electronics` to the `apparel` site, where there are a few items already added to the cart.

    The `onRead` callback is invoked with the active cart id for this site, which is read from the `spartacus⚿apparel⚿cart` key in storage. In this example implementation, the `onRead` clears the state and sets the active cart id. Then, `ActiveCartService` selects this id and loads the cart that was created in a previous session.
  
4. Return to the `electronics` site.

    The same steps repeat. The `onRead` is invoked with the cart id from the `electronics` site, the `apparel` ngrx state is cleared, and the correct cart is loaded.

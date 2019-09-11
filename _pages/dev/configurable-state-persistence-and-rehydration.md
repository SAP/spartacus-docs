---
title: Configurable State Persistence and Rehydration (DRAFT)
---

## Storage Synchronization

Spartacus offers a mechanism to sync NGRX's store slices to the specified browser's storage - `localStorage` or `sessionStorage`.

### Configuring storage synchronization

To configure the synchonization, one needs to provide a config similar to this:

```ts
export function authStoreConfigFactory(): StateConfig {
  const config: StateConfig = {
    state: {
      storageSync: {
        keys: {
          "auth.userToken.token": StorageSyncType.LOCAL_STORAGE
        }
      }
    }
  };
  return config;
}
@NgModule({
  imports: [
    ...
    ConfigModule.withConfigFactory(authStoreConfigFactory),
  ],
  ...
})
export class AuthStoreModule {}
```

In the provided example, the state object with `auth.userToken.token` will be synced to the browser's `localStorage`.

In case there is a need to sync multiple slices of the state, just specify the required properties in `storageSync`'s `keys` config and specify the storage type.

### Rehydration

During the startup of the application, Spartacus checks for data stored in either `localStorage` or `sessionStorage`. If the data exists, Spartacus will use it to rehydrate the state. This is done automatically and there's no need to configure it.

### Specifying the storage key names

If one wants to change the default key name(s) for the `localStorage` and `sessionStorage` (which have the default of `spartacus-local-data` and `spartacus-session-data`, respectively), they could do it by specifing `localStorageKeyName` or `sessionStorageKeyName` properties in the config:

```ts
export function authStoreConfigFactory(): StateConfig {
  const config: StateConfig = {
    state: {
      ...
      localStorageKeyName: 'new-localstorage-name',
      sessionStorageKeyName: 'new-sessionstorage-name',
    }
  };
  return config;
}
@NgModule({
  imports: [
    ...
    ConfigModule.withConfigFactory(authStoreConfigFactory),
  ],
  ...
})
export class AuthStoreModule {}
```

## SSR Transfer State

The application runs XHR requests on the server, and then again on the client-side (when the application bootstraps). To prevent unnecessary back end calls for the state that was already populated on the server, we include part of the NgRX state with the server-side rendered HTML.

You can configure the transfer of state for CMS and products (from NgRx store), as shown in the following example:

```typescript
ConfigModule.withConfig({
  state: {
    ssrTransfer: {
      keys: {
        products: true,
        cms: true
      }
    }
  }
});
```

You can also narrow the configuration to specific state sub-parts, as shown in the following example:

```typescript
ConfigModule.withConfig({
  state: {
    ssrTransfer: {
      keys: {
        products: true,
        cms: {
          page: true,
          navigation: true
        }
      }
    }
  }
});
```

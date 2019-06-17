---
title: Configurable State Persistence and Rehydration (DRAFT)
---

## Storage Synchronization

You can configure state synchronization to persist with session storage or local storage. The following example shows how to configure the synchronization of the "user token" and "clientToken" parts of the state:

```typescript
ConfigModule.withConfig({
  state: {
    storageSync: {
      keys: [{ auth: ["userToken", "clientToken"] }]
    }
  }
});
```

**Note**: In this code sample, there is no information about session storage or local storage.

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

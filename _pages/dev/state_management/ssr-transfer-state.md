---
title: SSR Transfer State
---

Spartacus on the server runs HTTP requests to the backend when the application is server-side rendered, and then again the same HTTP requests to the backend on the client-side when the application bootstraps in the browser. To prevent unnecessary calls to the backend for the state that was already populated on the server, Spartacus includes part of the NgRx state with the server-side rendered HTML via the `TransferState` mechanism.

You can configure the transfer of state for CMS and products (from NgRx store), as shown in the following example:

```typescript
ConfigModule.withConfig({
  state: {
    ssrTransfer: {
      keys: {
        products: StateTransferType.TRANSFER_STATE,
        cms: StateTransferType.TRANSFER_STATE,
      },
    },
  },
});
```

If you want to disable the transfer for some key of the state, that was enabled by default in Spartacus, you can do so by setting value to `undefined` for that key. See the following example:

```typescript
ConfigModule.withConfig({
  state: {
    ssrTransfer: {
      keys: {
        products: undefined,
      },
    },
  },
});
```

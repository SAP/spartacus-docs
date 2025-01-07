---
title: SSR Transfer State
---

On the server, Spartacus runs HTTP requests to SAP Commerce Cloud while the storefront application is server-side rendered, and then again, the same HTTP requests to the back end are made on the client-side when the application bootstraps in the browser. To prevent unnecessary calls to the back end for the state that was already populated on the server, Spartacus includes part of the NgRx state with the server-side rendered HTML through the `TransferState` mechanism.

You can configure the transfer of state for CMS and products (from NgRx store), as shown in the following example:

```typescript
ConfigModule.withConfig({
  state: {
    ssrTransfer: {
      keys: {
        product: StateTransferType.TRANSFER_STATE,
        cms: StateTransferType.TRANSFER_STATE,
      },
    },
  },
});
```

If you want to disable the transfer for some key of the state, which was enabled by default in Spartacus, you can do so by setting the value to `undefined` for that key. The following is an example:

```typescript
ConfigModule.withConfig({
  state: {
    ssrTransfer: {
      keys: {
        product: undefined,
      },
    },
  },
});
```

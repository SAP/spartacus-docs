---
title: SSR Transfer State
---

Spartacus runs XHR requests on the server, and then again on the client-side when the application bootstraps. To prevent unnecessary calls to the back end for the state that was already populated on the server, Spartacus includes part of the NgRx state with the server-side rendered HTML.

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
        products: StateTransferType.TRANSFER_STATE,
        cms: StateTransferType.TRANSFER_STATE,
      },
    },
  }
});
```

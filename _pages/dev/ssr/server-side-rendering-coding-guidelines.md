---
title: Server-Side Rendering Coding Guidelines
---

The following guidelines are highly recommended when working with server-side rendering (SSR).

## Working with Global Objects

Do not access global objects that are available in the browser. For example, do not use the `window`, `document`, `navigator`, and other browser types, because they do not exist on the server. If you try to use them, or any library that uses them, it will not work. For most cases, it is better to inject `WindowRef` and then do additional checks. For example, you can check if `WindowRef.nativeWindow` is defined.

## Working with Timeouts

Limit or avoid using `setTimeout`. It slows down the server-side rendering process and should be removed from the `ngOnDestroy` method of your components.

For RxJs timeouts, cancel their stream on success, because they can slow down rendering as well.

## Manipulating the nativeElement

Do not manipulate the `nativeElement` directly. Instead, use the `Renderer2` and related methods. We do this to ensure that, in any environment, we are able to change our view. The following is an example:

```typescript
constructor(element: ElementRef, renderer: Renderer2) {
  renderer.setStyle(element.nativeElement, 'font-size', 'x-large');
}
```

## Using Transfer State Functionality

We recommend using transfer state functionality. The application runs XHR requests on the server, and then again on the client-side (when the application bootstraps).

Use a cache that is transferred from the server to the client.

For more information, see [Configurable State Persistence and Rehydration]({{ site.baseurl }}{% link _pages/dev/configurable-state-persistence-and-rehydration.md %}).

## Getting Request Url and Origin

In CCV2 (or other setup using proxy servers), the request origin may be modified on the fly to something else i.e. localhost or 127.0.0.1.
Moreover the `document.location` behaves differently in the browser vs. SSR (where Angular Universal creates DOM with not all functionalities).

To get the request url or origin, in SSR you should use Spartacus injection tokens `SERVER_REQUEST_URL` and `SERVER_REQUEST_ORIGIN`. For example:

```ts
constructor(
  /* ... */
  @Optional() @Inject(SERVER_REQUEST_URL) protected serverRequestUrl: string | null,
  @Optional() @Inject(SERVER_REQUEST_ORIGIN) protected serverRequestOrigin: string | null
)
```

Note: `@Optional()` decorator is necessary. Otherwise it will crash for CRS, because those tokens are not provided in CSR.

### Workaround for a known issue in versions <3.0.3

When using ccv2 (or other setup using proxy servers), those tokens returned the  request origin `localhost` instead of the real website domain. In Spartacus versions 3.0.3 this has been fixed.


If you're using Spartacus version lower than 3.0.3, preferably upgrade to the latest version. But if you can't do it now, please apply the following workaround:


1. Copy this code snippet, preferably to separate file alongside `app.module.ts`:
```ts
import { StaticProvider } from '@angular/core';
import { REQUEST } from '@nguniversal/express-engine/tokens';
import { Request } from 'express';
import { SERVER_REQUEST_ORIGIN, SERVER_REQUEST_URL } from '@spartacus/core';

export const fixServerRequestProviders: StaticProvider[] = [
  {
    provide: SERVER_REQUEST_URL,
    useFactory: getRequestUrl,
    deps: [REQUEST],
  },
  {
    provide: SERVER_REQUEST_ORIGIN,
    useFactory: getRequestOrigin,
    deps: [REQUEST],
  },
];

function getRequestUrl(req: Request): string {
  return getRequestOrigin(req) + req.originalUrl;
}

function getRequestOrigin(req: Request): string {
  return req.protocol + '://' + req.hostname;
}
```

2. Add `fixServerRequestProviders` to providers array in `app.module.ts `:
```ts
providers: [
  // ...
  ...fixServerRequestProviders
],
```

3. Enable `trust proxy` option in `server.ts` file:
```ts
  server.set('trust proxy', 'loopback');
```  
(below `const server = express();` line)
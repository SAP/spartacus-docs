# Configuring timeout of outgoing http requests in SSR

Spartacus 6.0 comes with a new feature that allows you to set a timeout for all outgoing http requests, including those to the OCC backend. This feature is particularly important for Server-Side Rendering (SSR), where long-lasting outgoing requests can destabilize the SSR process if they take too long to return a response or if they never do so due to network issues.

By default, since version 6.0, the outgoing request timeout in SSR is set to 20 seconds. However, keep in mind that in the browser environment, the default timeout is not set, as browsers implement their own timeout mechanism.

To configure the preferred timeout for both the browser and server runtime in Spartacus, follow the steps below. 

#### Configuring globally timeout for outgoing requests

```typescript
provideConfig({
  backend: {
    timeout: {
      // values in milliseconds:
      browser: 60_000, // 60 seconds
      backend: 10_000, // 10 seconds
    }
  }
})
```
 

#### Configuring timeout for outgoing requests per request
If a request to some particular endpoint should have a different timeout than the global one, you can set the timeout value in the Angular's `HttpContext` of the request. For example:

```typescript

import { HttpContext } from '@angular/common/http';
import { HTTP_TIMEOUT_CONFIG } from `@spartacus/core`;

/* ... */

const context = new HttpContext().set(
  HTTP_TIMEOUT_CONFIG,
  { server: 15_000 } 
)

return this.httpClient.get('/some/api', { context });
```
  

#### Timed out outgoing requests print a warning to the console

When a request times out, the following warning is logged to the console:

```error
Request to URL '${request.url}' exceeded expected time of ${timeoutValue}ms and was aborted.
```

#### How to timeout outgoing requests in Spartacus versions <6.0

If you're using an older version of Spartacus, you may not have access to the easily configurable HTTP timeouts that were introduced in version 6.0. However, you can add this feature to your codebase yourself. You can take inspiration from the [original implementation of the http interceptor that was released in Spartacus 6.0](https://github.com/SAP/spartacus/blob/907d7897dba6add3ce2b56aa194f71596b9afb77/projects/core/src/http/http-timeout/http-timeout.interceptor.ts). Note that you may need to adapt the timeout values to suit your specific needs.
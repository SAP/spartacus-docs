---
title: Configuring the Timeout of Outgoing HTTP Requests in SSR
---

You can set a timeout for all outgoing HTTP requests, including those sent to the OCC back end. Configuring this timeout is particularly important for Server-Side Rendering (SSR), where long-lasting outgoing requests can destabilize the SSR process if they take too long to return a response, or if they never return a response because of network issues.

When a request times out, the following warning is logged to the console:

```text
Request to URL '${request.url}' exceeded expected time of ${timeoutValue}ms and was aborted.
```

## Configuring Global Timeouts for Outgoing Requests

In Spartacus 6.0 and newer, the default outgoing request timeout in SSR is set to 20 seconds. Spartacus does not provide a default outgoing request timeout for the browser environment because browsers implement their own timeout mechanism. However, it is possible to configure specific timeouts for both the browser and the server runtime in Spartacus, as shown in the following example:

```typescript
provideConfig({
  backend: {
    timeout: {
      // values in milliseconds:
      browser: 60_000, // 60 seconds
      server: 10_000, // 10 seconds
    }
  }
})
```

Note that setting a longer timeout value may increase the risk of SSR hanging for longer if a third party service is unreachable for an extended period of time. Conversely, setting a shorter timeout value may result in a higher rate of aborted requests, which could impact the reliability of your SSR application.

It is recommended that you test and tune the timeout values to find the optimal balance between reliability and performance for your use case.

## Configuring Timeouts for Specific Outgoing Requests

If you want a request to a particular endpoint to have a different timeout than the global one, you can set the timeout value for requests to that endpoint by using Angular's `HttpContext` class. The following is an example:

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
  
## Setting Timeouts for Outgoing Requests in Older Versions of Spartacus

If you are using a version of Spartacus that is older than 6.0, and you wish to add configurable timeouts for outgoing HTTP requests to your application, the [original implementation of the HTTP interceptor that was released in Spartacus 6.0](https://github.com/SAP/spartacus/blob/907d7897dba6add3ce2b56aa194f71596b9afb77/projects/core/src/http/http-timeout/http-timeout.interceptor.ts) may provide you with some ideas and inspiration for adding this feature to your own codebase.

---
title: Fine Tuning SSR service in Spartacus
---

## Idea

SSR optimization was brought up because we noticed the following issues:

- out of memory – in certain (rare) cases, pages cannot be rendered soon enough, SSR takes too much memory and eventually fails.
- failover - when there's no response in time, a 500 error is returned.

These symptoms happen mainly when the system is under heavy load. This is often due to an unhealthy implementation (memory leaks) or when the SSR response is not cached.

## Decorator includes SSR optimization engine

To enable SSR performance optimization use the `NgExpressEngineDecorator` decorator in your `server.ts` file.

```ts
import { ngExpressEngine as engine } from '@nguniversal/express-engine';
import { NgExpressEngineDecorator } from '@spartacus/setup/ssr';

[...]

const ngExpressEngine = NgExpressEngineDecorator.get(engine);

[...]

// In the app() function

server.engine(
  'html',
  ngExpressEngine({
    bootstrap: AppServerModule,
  })
);
```

By default the SSR optimization will use the following configuration:

```json
{
  "concurrency": 20,
  "timeout": 3000
}
```

The optimization engine can be configured by providing a configuration object as second parameter.

```ts
const ngExpressEngine = NgExpressEngineDecorator.get(engine, { timeout: 1000 });
```

The full list of parameters is explained in the [How to configure](#how-to-configure) section.

## How to configure

### timeout (number)

_Default 3000 milliseconds_

This property represents the amount of time (in milliseconds) the SSR server will try to render a page before falling back to CSR. Once the delay is expired, the server returns the `index.html` of the CSR which is blank. The CSR app (`index.html`) served with a `Cache-Control:no-store` header. As such, it will not be stored by the cache layer. SSR pages do not contain such a header as they are preferable for caching purposes.

In the background, the SSR server continues to render the SSR version of the page. Once this rendering finishes, the page is placed in a local cache to be returned the next time it is requested. By default, the server will clear the page from its cache after returning it for the first time. We assume that you are using an additional layer to cache the page externally.

### cache (boolean)

Enables the built-in in-memory cache for pre-rendered URLs. Even when this value is `false` the cache will be used to temporarily store the pages that finish rendering after the CSR fallback to serve them with the next request only.

_Note_: the cache should be used carefully to avoid running out of memory. Using the next attribute (cacheSize) can help avoid this.

### cacheSize (number)

Limits the cache size to a specified number of entries. This property helps to keep memory usage under control.

The `cacheSize` property can also be used when the `cache` option is set to false. This will then limit the number of timed out renders that are kept in a temporary cache, waiting to be served with the next request.

### concurrency (number)

_Default 20_

This property represents the number of concurrent requests that will be treated before defaulting to CSR. Usually, when the concurrency increases (more renders being done at the same time) the slower response per request is. To fine-tune it and keep response time reasonable, you can limit the maximum number of concurrent requests. All requests that won't be able to render because of this will fallback to CSR.

### ttl (number)

Time in milliseconds after prerendered page is becoming stale and should be rendered again.

### renderKeyResolver (function)

Accepts `(req: Request) => string` function that maps current request to specific render key.

Allows overriding default key generator for custom differentiating between rendered pages. By default it uses `req.originalUrl`.

### renderingStrategyResolver (function)

Accepts `(req: Request) => RenderingStrategy` function that allows defining custom rendering strategy per request. The available `RenderingStrategy` are:

- `ALWAYS_CSR` Always returns CSR
- `DEFAULT` Default behavior
- `ALWAYS_SSR` ALways returns SSR

### forcedSsrTimeout (number)

_Default 60 seconds_

Time in milliseconds to wait for rendering when SSR_ALWAYS render strategy is set for the request. This prevents the SSR rendering from blocking resources for too long if the server is under heavy load or the page contains errors.

## Troubleshooting

In the event SSR is not rendering the pages, you can use the following methods to troubleshoot the issue.

### Testing locally

If you notice SSR is not functioning on CCv2

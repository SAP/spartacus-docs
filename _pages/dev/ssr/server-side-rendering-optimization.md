---
title: Server-Side Rendering Optimization
feature:
- name: Server-Side Rendering Optimization
  spa_version: 3.0
  cx_version: n/a
---

## Idea

SSR optimization was brought up because we noticed the following issues:

- out of memory – in certain (rare) cases, pages cannot be rendered soon enough, SSR takes too much memory and eventually fails.
- failover - when there's no response in time, a 500 error is returned.

These symptoms happen mainly when the system is under heavy load. This is often due to an unhealthy implementation (memory leaks) or when the SSR response is not cached.

For these reasons, in Spartacus version 3.0 and up an optimization engine has been put in place. The goals for this engine are as follows:

- SSR will queue incoming requests
- Only the a certain number of queued page will be rendered before the rest of the queue defaults to Client Side Rendering (CSR)
- Pages will be served in SSR if they can be rendered in a given time (timeout)
- If the engine fallback to CSR because the SSR render was too long, once the SSR page is rendered it will be stored in memory and served with the subsequent request
- The CSR app will be server with the `Cache-Control:no-store` header to make sure it is not cached by the caching layer. **Note** CSR renders should never be cached.
- The rendered SSR pages should be cached (e.g. CDN) to ensure subsequent requests don't hit the SSR server. This will reduce the server load and insure as few CSR fallbacks as possible.

The next section will detail how to use this new optimization engine and how to configure it.

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

A value of 0 will instantly return the CSR page.

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

### How to tell if your storefront is running in SSR mode

There are many ways to check if your storefront is rendering SSR pages correctly.

The first one is by using the `curl` command available on Linux and MacOS out of the box. Running the following command (replace `YOUR_SITE_URL` with the url of the site you want to test):

```sh
curl YOUR_SITE_URL
```

Should return an HTML markup containing rendered elements such as for example:

```html
  [...]
  <app-root _nghost-sc293="" ng-version="10.1.6"><cx-storefront _ngcontent-sc293="" tabindex="0" class="LandingPage2Template stop-navigating"><cx-skip-link><div tabindex="-1" class=""><button> Skip to Header </button><button> Skip to Main Content </button><button> Skip to Footer </button><!----></div><!----></cx-skip-link><header cxskiplink="cx-header" class="" tabindex="-1"><cx-page-layout section="header" class="header"><cx-page-slot position="PreHeader" class="PreHeader has-components"><cx-hamburger-menu><button type="button" aria-label="Menu" aria-controls="header-account-container, header-categories-container, header-locale-container" class="cx-hamburger" aria-expanded="false"><span class="hamburger-box"><span class="hamburger-inner"></span></span></button></cx-hamburger-menu>
  [...]
  </app-root>
```

If the `<app-root>` in your response is empty it means SSR is not working correctly.

Alternatively, you can check in your browser's network tool to see if your storefront is rendering pages in SSR mode. Here are the steps to check:

1. Open a new browser tab and navigate to you site's address
2. Open your browser's developer tools and open the Network tab
3. Refresh if no requests are present
4. Look for the very first request which will be a **GET request for the page HTML**
5. Check if the response contains markup such as described above

### Possible pitfalls

If you've followed the steps described in [How to tell if your storefront is running in SSR mode](#how-to-tell-if-your-storefront-is-running-in-SSR-mode) and came to the conclusion the SSR pages were not rendering these are your next steps.

First, check for logs from your SSR server.

This will be in your terminal if you are running SSR locally or in Kibana if you are storefront is in CCv2.

1. If you see some errors either locally or in Kibana, refer to [Testing locally](#testing-locally) for more instructions on how to debug in SSR.
2. If you see the following

```txt
SSR rendering exceeded timeout, fallbacking to CSR for ...
```

it means something is preventing the SSR render from completing.

You can first try to increase the timeout and concurrency value to see if this has an effect, see [How to configure](#How-to-configure) for more details.

If increasing these values does not change anything it means the server cannot render the page.

In this case, check the following:

- Make sure your server has a valid certificate (see [Test SSR with a self signed or untrusted SSL certificate](#Test-SSR-with-a-self-signed-or-untrusted-SSL-certificate))
- _If on CCv2_ check your API's IP restriction. It is possible the SSR server's IP is being blocked. Try changing the configuration on the API to "Allow All" and see if that makes a difference.
- If none of the two solutions above fixes the SSR render it means there is a problem with your code. Review the [Server-Side Rendering Coding Guidelines](https://sap.github.io/spartacus-docs/server-side-rendering-coding-guidelines) and review your custom code to make sure you don't use any browser functions which are not available on SSR.

### CCv2 build failing

If your CCv2 build is failing with an error such as

```txt
Execution failed for task ':buildJsApps'
[...]
```

Run `yarn build:ssr` locally to get a more detailed error log.

### Testing locally

If you notice SSR is not functioning on CCv2 you should first try to run your Spartacus application locally to pinpoint the issue. Here are the steps to do it:

1. Make sure your `baseUrl` configuration in the app module is pointing to an accessible backend with a valid certificate. (If you think the certificate validity might be an issue [Test SSR with a self signed or untrusted SSL certificate](#Test-SSR-with-a-self-signed-or-untrusted-SSL-certificate))

**Note**: before committing your code make sure to remove this change so that CCv2 can use the `occ-backend-base-url` from the `index.html`. (see [Configuring the Base URL](https://sap.github.io/spartacus-docs/configuring-base-url))

2. Run `yarn dev:ssr` this will allow you to run a "development" SSR server that will pick up the changes you make in your source code

3. You can use the [How to Debug a Server–Side Rendered Storefront](https://sap.github.io/spartacus-docs/how-to-debug-server-side-rendered-storefront) page to learn how to debug an SSR application

### Testing SSR with a self signed or untrusted SSL certificate

During development it is possible to use self signed certificates which are not supported by SSR by default. If you are using such a certificate you can do the following to make SSR function despite it:

1. Run `yarn add -D cross-env` to add `cross-env` to your `devDependencies`
2. Add the following script to your `package.json`

```json
"dev:ssr:dev": "cross-env NODE_TLS_REJECT_UNAUTHORIZED=0 ng run YOU_STORE_NAME:serve-ssr"
```

Replace `YOU_STORE_NAME` with your storefront's name as specified at the top of your `package.json`.

3. Run `yarn dev:ssr:dev` to start your storefront in SSR mode

**Note**: Do not `NODE_TLS_REJECT_UNAUTHORIZED=0` in production.

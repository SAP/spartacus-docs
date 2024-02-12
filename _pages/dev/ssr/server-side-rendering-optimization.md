---
title: Server-Side Rendering Optimization
feature:
- name: Server-Side Rendering Optimization
  spa_version: 3.0
  cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Server-side rendering optimization allows you to fine tune your SSR setup, and gives you more ways to resolve potential issues related to memory and failover.

Without SSR optimization, it is possible for the following to occur:

- Pages do not render quickly enough, which leads to SSR using too much memory, and eventually it fails.
- A response is not received in time, and an HTTP 500 error is returned.

Although these scenarios are fairly rare, they usually occur when the system is under heavy load. Memory leaks are often the result of issues with the SSR implementation, while failover can happen when the SSR response is not cached.

The SSR optimization engine addresses these issues as follows:

- The optimization engine queues incoming requests.
- The engine renders only a certain number of queued pages before the rest of the queue defaults to client-side rendering (CSR), unless you have set the `reuseCurrentRendering` option to ensure incoming requests wait for the current render to finish, instead of falling back to CSR.
- Pages are served in SSR mode if they can be rendered in a given time (that is, within the time that is specified by the timeout setting).
- If the engine falls back to CSR because the SSR render takes too long, once the SSR page is rendered, it is stored in memory and served with the subsequent request.
- The CSR app is served with the `Cache-Control:no-store` header to ensure it is not cached by the caching layer. Note that CSR renders should *never* be cached.
- If the render is taking too long to finish, the engine will release its concurrency slot and provide a warning about the hanging render.

   **Caution:** Notifications about hanging renders should be taken seriously because the optimization engine does not release the resources related to a hanging render. If the root of the problem is not addressed in the application code, the server's resources can quickly become depleted.
- The rendered SSR pages *should* be cached (for example, using a CDN) to ensure subsequent requests do not hit the SSR server. This reduces the server load and reduces CSR fallbacks to the least amount possible. For more information, see [Recommended Setup for Server-Side Rendering]({{ site.baseurl }}{% link _pages/dev/ssr/recommended-server-side-rendering-setup.md %}).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Enabling the SSR Optimization Engine

To enable the SSR optimization engine, use the `NgExpressEngineDecorator` decorator in your `server.ts` file. The following is an example:

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

By default, the SSR optimization engine uses the following configuration:

```ts
{
  "concurrency": 10,
  "timeout": 3_000,
  "forcedSsrTimeout": 60_000,
  "maxRenderTime": 300_000,
  "reuseCurrentRendering": true,
  "debug": false,
  "logger": new DefaultExpressServerLogger(),
}
```

The optimization engine can be configured by providing a configuration object as second parameter. The following is an example:

```ts
const ngExpressEngine = NgExpressEngineDecorator.get(engine, { timeout: 1000 });
```

The full list of parameters is described below.

## Configuring the SSR Optimization Engine

You can configure the SSR optimization engine with a number of settings, which are described in the following sections.

### timeout

The `timeout` setting is a number that indicates the amount of time (in milliseconds) during which the SSR server tries to render a page, before falling back to CSR. Once the delay has expired, the server returns the `index.html` of the CSR, which does not contain any pre-rendered markup. The CSR app (`index.html`) is served with a `Cache-Control:no-store` header. As a result, it is not stored by the cache layer. SSR pages do not contain this header because it is preferable to cache SSR pages.

In the background, the SSR server continues to render the SSR version of the page. Once this rendering finishes, the page is placed in a local cache (in-memory) to be returned the next time it is requested. By default, the server clears the page from its cache after returning it for the first time.

A `timeout` value of `0` will instantly return the CSR page.

The default value is `3000` milliseconds.

**Note:** It is strongly recommended that you use an additional layer, such as a CDN, to cache pages externally. For more information, see [Recommended Setup for Server-Side Rendering]({{ site.baseurl }}{% link _pages/dev/ssr/recommended-server-side-rendering-setup.md %}).

### cache

The `cache` setting is a boolean that enables the built-in, in-memory cache for pre-rendered URLs. This option is not related to any kind of external caching layer, such as a CDN. Even when this value is set to `false`, the cache is used to temporarily store the pages that finish rendering after the CSR fallback, so they can be served with the next request (after which, the cache is cleared).

**Note:** The in-memory cache should be used carefully to avoid running out of memory. Using the `cacheSize` setting can help avoid this. However, the in-memory cache *consumes the server's memory*, and if there are any memory leaks, this can cause the server to stall or even crash if the server runs out of memory.

It is generally recommended to *not* enable the `cache` setting because there are better ways to turn on the caching (such as using a CDN, for example).

### cacheSize

The `cacheSize` setting is a number that limits the cache size to a specific number of entries. This setting helps to keep memory usage under control.

The `cacheSize` setting can also be used when the `cache` setting is set to `false`. This then limits the number of timed-out renders that are kept in a temporary cache and which are waiting to be served with the next request.

It is recommended that the `cacheSize` should be set according to the server's resources (such as the amount of available RAM). It is recommended that you set the `cacheSize`, regardless of whether the `cache` setting is disabled.

### concurrency

The `concurrency` setting is a number that indicates how many concurrent requests are treated before defaulting to CSR. Usually, when the concurrency increases (more renders being done at the same time) the slower the response is for each request. To fine-tune it and keep response time reasonable, you can limit the maximum number of concurrent requests. All requests that are unable to render because of this will fall back to CSR. If the `reuseCurrentRendering` is enabled, multiple requests for the same rendering key (which is the request URL, by default) will take up only one concurrency slot.

The default value is `10`.

It is recommended that the `concurrency` be set according to the server's available resources available (such as the speed of the CPU). A high concurrency number could have a negative impact on the performance because the CPU will try to render a large number of requests concurrently, which effectively slows down the response times.

### ttl

The `ttl` (time to live) setting is a number that indicates the amount of time (in milliseconds) before a cached page is considered stale and needs to be rendered again on the next request. This option is used regardless of whether the `cache` setting is enabled.

It is recommended that `ttl` should be set according to your business needs, and for how long you want to keep stale renders in cache before evicting them. It is recommended that you set the `ttl`, regardless of whether the `cache` setting is enabled.

### renderKeyResolver

The `renderKeyResolver` setting is a function with the signature `(req: Request) => string`, which maps the current request to a specific render key. The `renderKeyResolver` allows you to override the default key generator so that you can differentiate between rendered pages with custom keys.

By default, `renderKeyResolver` uses the full request URL.

It is recommended that you use the default Spartacus rendering key resolver, especially in cases where your domain contains base site information (such as `my.site.au` or `my.site.rs`, for example).

### renderingStrategyResolver

The `renderingStrategyResolver` setting is a function with the signature `(req: Request) => RenderingStrategy`, which allows you to define custom rendering strategies for each request. The available `RenderingStrategy` strategies work as follows:

- `ALWAYS_CSR` always returns client-side rendered pages
- `DEFAULT` is the default behavior, which obeys the provided `SsrOptimizationOptions`.
- `ALWAYS_SSR` attempts to always return the server-side rendered pages, with the exception of the `forcedSsrTimeout` setting, where the rendering falls back to CSR if the `forcedSsrTimeout` is exceeded.

It is recommended that you provide a custom rendering strategy for cases where you want to serve SSR only to specific requests (such as serving SSR only to crawling bots, for example).

For more information on the default rendering strategy resolver settings that are provided with Spartacus, see [Using SSR Only for Certain Pages](#using-ssr-only-for-certain-pages).

### forcedSsrTimeout

The `forcedSsrTimeout` setting is a number that indicates the time (in milliseconds) to wait for rendered pages when the render strategy for the request is set to `ALWAYS_SSR`. This prevents SSR rendering from blocking resources for too long if the server is under heavy load, or if the page contains errors.

The default value is `60000` milliseconds (that is, 60 seconds).

It is recommended that you adjust the `forcedSsrTimeout` setting according to your needs.

### maxRenderTime

The `maxRenderTime` setting is the maximum amount of time expected for a render to complete. If the render exceeds this timeout, the concurrency slot is released, which allows the next request to be server-side rendered. However, this may not release the rendering resources for a render that has not completed, which may cause additional memory usage on the server. The `maxRenderTime` logs the renders that have exceeded the render time, which is useful for debugging. The value should always be higher than the values for the `timeout` and `forcedSsrTimeout` settings. For more information, see [Incomplete Renders and Memory Leaks](#incomplete-renders-and-memory-leaks).

The default value is `300000` milliseconds (5 minutes).

It is recommended that you experiment with the `maxRenderTime` to find a value that meets to your needs.

### reuseCurrentRendering

The `reuseCurrentRendering` setting is a boolean that, when set to `true`, will make the subsequent requests for a rendering key wait for the current render, instead of immediately falling back to CSR when a render for the same rendering key is in progress. All pending requests for the same rendering key will take up only one concurrency slot, because there is only one actual rendering task being performed. Each request independently honors the `timeout` option.

For example, consider the following setup, where the `timeout` is set to 3 seconds, and the given request takes 4 seconds to render. The flow is as follows:

- The first request arrives and triggers SSR.
- The second request for the same URL arrives 2 seconds after the first one. Instead of falling back to CSR, it waits (with its own timeout) for the render of the first request.
- The first request times out after 3 seconds, and falls back to CSR.
- One second after the timeout, the current render finishes.
- The second request returns using SSR after only 2 seconds of waiting.

The default value is `true`.

It is recommended that you enable `reuseCurrentRendering` because it can smartly provide server-side rendered content to multiple requests for the same URL. However, this might require more server resources, such as RAM.

### debug

The `debug` setting is a boolean that, when set to `true`, enables extra logs that are useful for troubleshooting SSR issues. In production environments, you should set `debug` to `false` to avoid an excessive number of logs. Regardless, the SSR timeout log will capture `SSR rendering exceeded timeout...` even if the `debug` flag is set to `false`.

The default value is `false`.

Is is recommended in production environment to turn off the `debug` flag.

### logger

The `logger` setting is an ExpressServerLogger implementation used for improving logged messages with context and JSON structure. It enhances the logs in SSR by adding context, including the request's details, and structuring them as JSON. The logger property is optional. By default, the `DefaultExpressServerLogger` is used. For more, see [{% assign linkedpage = site.pages | where: "name", "server-side-rendering-contextual-logging.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/ssr/server-side-rendering-contextual-logging.md %})

## Troubleshooting

The following sections describe how to resolve potential issues with SSR.

### Verifying That Your Storefront is Running in SSR Mode

If you are encountering issues with SSR, a good first step is to verify that your storefront is running in SSR mode. The following sections describe how to check if your storefront is rendering SSR pages correctly.

#### Using the Curl Command

On Linux and MacOs, you can use the `curl` command to check if your storefront is running in SSR mode. Run the following command, replacing `YOUR_SITE_URL` with the URL of the site you want to test:

```sh
curl YOUR_SITE_URL
```

This should return an HTML markup response that contains rendered elements, such as the following:

```html
[...]
<app-root_nghost-sc293="" ng-version="10.1.6"><cx-storefront _ngcontent-sc293="" tabindex="0" s="LandingPage2Template    stop-navigating"><cx-skip-link><div tabindex="-1" class=""><button> Skip to Header </on><button> Skip to Main Content </  button><button> Skip to Footer </button><!----></div><!----></cx-skip-link><header iplink="cx-header" class=""     tabindex="-1"><cx-page-layout section="header" class="header"><cx-page-slot position="PreHeader" class="PreHeader     has-components"><cx-hamburger-menu><button type="button" aria-label="Menu" -controls="header-account-container,     header-categories-container, header-locale-container" class="cx-hamburger" -expanded="false"><span    class="hamburger-box"><span class="hamburger-inner"></span></span></button></hamburger-menu>
[...]
</app-root>
```

If the `<app-root>` in your response is empty, it means SSR is not working correctly.

#### Using Your Web Browser's Network Tool

You can use your web browser's network tool to check if your storefront is rendering pages in SSR mode, as described in the following steps:

1. Open a new web browser tab and navigate to your storefront.
2. Open your web browser's developer tools, and then open the network tab.
3. Refresh the page if no requests are present.
4. Look for the very first request, which will be a `GET request for the page HTML`.
5. Check if the response contains markup, such as the following example:

   ```html
   [...]
   <app-root_nghost-sc293="" ng-version="10.1.6"><cx-storefront _ngcontent-sc293="" tabindex="0" s="LandingPage2Template    stop-navigating"><cx-skip-link><div tabindex="-1" class=""><button> Skip to Header </on><button> Skip to Main Content </  button><button> Skip to Footer </button><!----></div><!----></cx-skip-link><header iplink="cx-header" class=""     tabindex="-1"><cx-page-layout section="header" class="header"><cx-page-slot position="PreHeader" class="PreHeader     has-components"><cx-hamburger-menu><button type="button" aria-label="Menu" -controls="header-account-container,     header-categories-container, header-locale-container" class="cx-hamburger" -expanded="false"><span    class="hamburger-box"><span class="hamburger-inner"></span></span></button></hamburger-menu>
   [...]
   </app-root>
   ```
  
   If the `<app-root>` in your response is empty, it means SSR is not working correctly.

### Troubleshooting a Storefront That Is Not Running in SSR Mode

If your storefront is not running in SSR mode, check the logs of your SSR server. This will be in your terminal if you are running SSR locally, or in Kibana if your storefront is hosted on SAP Commerce Cloud.

If you see errors, either locally or in Kibana, you can try debugging them, as described in [Testing Locally](#testing-locally).

If you see the following, it means something is preventing the SSR render from completing:

```text
SSR rendering exceeded timeout, falling back to CSR for ...
```

In this case, you can try increasing the `timeout` values of the SSR optimization engine to see if this solves the issue. For more information, see [Configuring the SSR Optimization Engine](#configuring-the-ssr-optimization-engine), above.

If adjusting these values does not resolve the issue, it means the server cannot render the page. In this case, you can try the following:

- Ensure your server has a valid certificate. For more information, see [Testing SSR With a Self-Signed or Untrusted SSL Certificate](#testing-ssr-with-a-self-signed-or-untrusted-ssl-certificate).
- If your storefront is on hosted on SAP Commerce Cloud, check the IP restriction of your API. It is possible that the SSR server's IP is being blocked. If this is the case, you can try changing the configuration on the API to "Allow All" and see if that resolves the issue. If using a caching layer (such as a CDN), check if it blocked the SSR server's IP address due to possibly many requests coming from it.

If these solutions do not fix the SSR rendering issue, there may be a problem in the code. Review the [{% assign linkedpage = site.pages | where: "name", "server-side-rendering-coding-guidelines.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/ssr/server-side-rendering-coding-guidelines.md %}), and review your custom code to ensure you are not using any browser functions that are not available with SSR.

### SSR Issues with SAP Commerce Cloud in the Public Cloud

If your SAP Commerce Cloud build is failing, check whether you have an error such as the following:

```text
Execution failed for task ':buildJsApps'
[...]
```

If so, run `npm run build:ssr` locally to get a more detailed error log.

### Testing Locally

If SSR is not functioning on your hosted SAP Commerce Cloud, you can try running your Spartacus application locally to pinpoint the issue, as follows:

1. Ensure the `baseUrl` configuration in your app module is pointing to an accessible back end that has a valid certificate.

   If you think certificate validity could be an issue, see [Testing SSR With a Self-Signed or Untrusted SSL Certificate](#testing-ssr-with-a-self-signed-or-untrusted-ssl-certificate).

   **Note**: At the end of these steps, before committing any code, make sure to undo the change in this step so that SAP Commerce Cloud can use the `occ-backend-base-url` from the `index.html`. For more information, see [{% assign linkedpage = site.pages | where: "name", "configuring-base-url.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/configuring-base-url.md %}).

2. Run `npm run dev:ssr`.

   This allows you to run a "development" SSR server that will pick up the changes you make in your source code.

   Refer to [{% assign linkedpage = site.pages | where: "name", "how-to-debug-server-side-rendered-storefront.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/ssr/how-to-debug-server-side-rendered-storefront.md %}) for more information on debugging an SSR application.

### Testing SSR With a Self-Signed or Untrusted SSL Certificate

During development, it is possible to use self-signed certificates that, by default, are not supported by SSR. If you are using such a certificate, you can allow SSR to support it with the following steps:

1. Run `npm install -D cross-env`.

   This adds `cross-env` to your `devDependencies`.

2. Add the following script to your `package.json`:

   ```json
   "dev:ssr:dev": "cross-env   NODE_TLS_REJECT_UNAUTHORIZED=0 ng run   YOU_STORE_NAME:serve-ssr"
   ```

   Replace `YOU_STORE_NAME` with your storefront's name, as specified at the top of your `package.json`.

3. Run `npm run dev:ssr:dev` to start your storefront in SSR mode.

   **Note**: Do not use `NODE_TLS_REJECT_UNAUTHORIZED=0` in a production environment.

### The URL or Routes Break SSR

Often, a malformed URL can break the server-side rendering by preventing the SSR from finishing the rendering, which prevents the allocated resources from being released.

The following is an example of a malformed URL: `http://localhost:4200/electronics-spa/en/USD/Brands/Canon/c/brand_10%20or%20(1,2)=(select*from(select%20name_const(CHAR(82,88,106,99,113,78,74,70,73,118,87),1),name_const(CHAR(82,88,106,99,113,78,74,70,73,118,87),1))a)%20--%20and%201%3D1`.

This is is usually the case when the  `initialNavigation` Router setting is `enabled`.

This is a bug in Angular's Router that never resolves the route when a `NavigationError` occurs. You can implement [this workaround](https://github.com/SAP/spartacus/pull/10541/files) in your application, which uses Angular's private API.

If you are implementing the workaround, be aware of the following line from the workaround:

```ts
import { ..., ɵangular_packages_router_router_h as RouterInitializer } from '@angular/router';
```

The `ɵangular_packages_router_router_h` symbol that is used here may change in a future release of Angular.

### Incorrect Site Information Embedded in the Domain

If you are embedding the site information as part of the domain (for example, the language, currency, base-site, and so on), and your `cache` is set to `true`, then you might have stumbled upon an issues that can be illustrated with the following example:

- A request for `my.shop.**ca**` triggers the render and successfully returns it to the client for the given site, which is `ca` in this case.
- The subsequent request for `my.shop.**rs**` hits the SSR node, but it wrongly receives the cached render for `ca`, instead of a render for `rs`.

To address this issue, upgrade to the latest patch version, or implement [this workaround](https://stackoverflow.com/a/69527063/5252849).

### SSR Shows Only a Global Error Message

If you are getting an SSR render which shows only a global error message, such as `You are not authorized to perform this action. Please contact your administrator if you think this is a mistake`, please check the following:

- If the API server has the SSR server's IP on its allowed IP list.
- If you are using a caching layer (such as a CDN), make sure it allows the SSR server's IP address, which might get blocked at some point if there are many requests coming from it.

### Detecting a Bot or Crawler

A common requirement is to be able to detect when a request is coming from a bot or web crawler. The recommended way of doing this is to provide a custom `renderingStrategyResolver` setting, which allows you to inspect the request and, based on certain parameters, determine which rendering strategy to use.

The following is an example of how to set the `renderingStrategyResolver`, but it is just an example, and may or may not be complete, and may not match the requirements specific to your implementation:

```ts
import { Request } from 'express';

...

const ssrOptions: SsrOptimizationOptions = {
  ...,
  renderingStrategyResolver: (req: Request) => req.get('User-Agent')?.match(/bot|crawl|slurp|spider|mediapartners/) ? RenderingStrategy.ALWAYS_SSR : RenderingStrategy.DEFAULT,
};
```

## Using SSR Only for Certain Pages

If you want to enable SSR only for certain pages, you can provide a custom `renderingStrategyResolver` function (as described in the previous section) that can inspect the requested URL, and return an appropriate rendering strategy.

Spartacus also includes a default rendering strategy resolver that allows you to control the server-side rendering behavior of your storefront app on a per-request basis.

You can customize your SSR strategy by disabling SSR for specific URLs and query parameters. By configuring the `excludedUrls` and `excludedParams` properties in `defaultRenderingStrategyResolverOptions`, you can specify which URLs and query parameters should trigger SSR to be bypassed, and enable client-side rendering (CSR) instead. This fine-grained control allows you to optimize SSR for your specific use cases, ensuring flexibility and efficient management of your SSR rendering strategy.

The `defaultRenderingStrategyResolver` takes one parameter, `RenderingStrategyResolverOptions`, as follows:

```ts
const defaultRenderingStrategyResolver = (options: RenderingStrategyResolverOptions) => (req: Request) => RenderingStrategy
```

The `RenderingStrategyResolverOptions` interface defines the following optional properties:

- `excludedUrls`, which is an array of URLs that are disabled for SSR.
- `excludedParams`, which is an array of query parameters that are disabled for SSR.

### Determining the Rendering Strategy

The `defaultRenderingStrategyResolver` function works as follows:

- If the request matches any of the excluded query parameters defined in `excludedParams`, or if the request URL matches any of the excluded URLs defined in `excludedUrls`, then SSR is disabled for that request. In such cases, the function returns `RenderingStrategy.ALWAYS_CSR`.
- If the request does not meet any of the exclusion criteria, the default rendering strategy (`RenderingStrategy.DEFAULT`) is used, indicating that SSR should proceed as usual.

### Default Configuration

In Spartacus, the default configuration for `defaultRenderingStrategyResolverOptions` is defined as follows:

```ts
export const defaultRenderingStrategyResolverOptions: RenderingStrategyResolverOptions = {
   excludedUrls: ['checkout', 'my-account', 'cx-preview'],
   excludedParams: ['asm'],
};
```

This configuration specifies that SSR is disabled for requests with URLs containing `checkout`, `my-account`, or `cx-preview`, as well as for requests containing the query parameter `asm`. When Spartacus receives requests matching these criteria, SSR is bypassed and CSR is used instead.

**Note:** The `cx-preview` URL is used for disabling SSR in SmartEdit.

The `defaultRenderingStrategyResolver` function is set as the value for the `renderingStrategyResolver` property in the Spartacus SSR optimization settings, as follows:

```ts
export const defaultSsrOptimizationOptions: SsrOptimizationOptions = {
   // Other SSR optimization options...
   renderingStrategyResolver: defaultRenderingStrategyResolver(
      defaultRenderingStrategyResolverOptions
   ),
};
```

This ensures that whenever Spartacus applies SSR optimization, the `defaultRenderingStrategyResolver` function determines the appropriate rendering strategy for each incoming request, based on the configuration that you have specified.

## Incomplete Renders and Memory Leaks

A `Rendering of ${URL} was not able to complete. This might cause memory leaks!` message may appear if you have the `maxRenderTime` setting enabled. This error message indicates that a render is hanging and may or may not complete at some point in the future. Unfortunately, Spartacus is not able to release the related resources from [`@angular/universal`](https://github.com/angular/universal/), which will likely lead to memory overflow at some point.

If you see this message, you can try the following:

- There is a chance the render will complete at some point in the future. You can look for a message that says `Rendering of ${URL} completed after the specified maxRenderTime, therefore it was ignored.`.
- The OCC API may be slow to respond. If you are using a CDN in front of the API, check if the CDN has some kind of a rate limiter enabled for the SSR servers, or it may have even completely blocked the SSR server's IP addresses. For more information, see [SSR Shows Only a Global Error Message](#ssr-shows-only-a-global-error-message).

## Load Testing of SSR in Spartacus

When you wish to do load testing of SSR in Spartacus, it is important to keep in mind the following potential issues while designing your load testing scenarios.

### Working with reuseCurrentRendering

If you have set `reuseCurrentRendering` to `true` in `SsrOptimizationOptions` (which is recommended), and you use the same URL multiple times in parallel for your load testing requests, the SSR in Spartacus will only perform a single rendering for that particular URL, despite the many parallel requests waiting for a response. To effectively perform load testing of SSR in Spartacus, you need to send multiple requests using a variety of different URLS, rather than using the same URL multiple times in parallel.

### Working with concurrency

The `concurrency` setting limits the number of renderings (in other words, actual computations) that can be performed at the same time. If there are already pending `concurrency` renderings happening in a NodeJS replica, then new requests with different URLs will instantly fall back to CSR instead of rendering through SSR. As a result, to effectively load test SSR in Spartacus, you should not send too many parallel requests for various URLs to a single NodeJS replica at the same time. If the number of URLs requested at the same time from a single replica is higher than its configured `concurrency`, then you can expect a higher rate of requests falling back to CSR. This is expected behavior, but it will not cause actual pressure on computations for SSR in Spartacus.

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

Server-Side Rendering optimization allows you to fine tune your SSR setup, and gives you more ways to resolve potential issues related to memory and failover.

Without SSR optimization, it is possible for the following to occur:

- Pages do not render quickly enough, which leads to SSR using too much memory, and eventually it fails.
- A response is not received in time, and an HTTP 500 error is returned.

Although these scenarios are fairly rare, they usually occur when the system is under heavy load. Memory leaks are often the result of issues with the SSR implementation, while failover can happen when the SSR response is not cached.

The SSR optimization engine addresses these issues as follows:

- The optimization engine queues incoming requests
- Only a certain number of queued pages are rendered before the rest of the queue defaults to Client-Side Rendering (CSR)
- Pages are served in SSR mode if they can be rendered in a given time (that is, within the time that is specified by a timeout)
- If the engine falls back to CSR because the SSR render takes too long, once the SSR page is rendered, it is stored in memory and served with the subsequent request
- The CSR app is served with the `Cache-Control:no-store` header to ensure it is not cached by the caching layer.

  **Note:** CSR renders should never be cached.
- The rendered SSR pages should be cached (for example, using CDN) to ensure subsequent requests do not hit the SSR server. This reduces the server load and reduces CSR fallbacks to the least amount possible.

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

```json
{
  "concurrency": 20,
  "timeout": 3000
}
```

The optimization engine can be configured by providing a configuration object as second parameter. The following is an example:

```ts
const ngExpressEngine = NgExpressEngineDecorator.get(engine, { timeout: 1000 });
```

The full list of parameters is described in the following section.

## Configuring the SSR Optimization Engine

You can configure the SSR optimization engine with a number of parameters, which are described as follows:

- `timeout` is a number that indicates the amount of time (in milliseconds) during which the SSR server tries to render a page, before falling back to CSR. Once the delay has expired, the server returns the `index.html` of the CSR, which does not contain any pre-rendered markup. The CSR app (`index.html`) is served with a `Cache-Control:no-store` header. As a result, it is not stored by the cache layer. SSR pages do not contain this header because it is preferable to cache SSR pages.

  In the background, the SSR server continues to render the SSR version of the page. Once this rendering finishes, the page is placed in a local cache to be returned the next time it is requested. By default, the server clears the page from its cache after returning it for the first time. It is assumed that you are using an additional layer to cache pages externally.

  A value of 0 will instantly return the CSR page.

  The default value is `3000` milliseconds.

- `cache` is a boolean that enables the built-in in-memory cache for pre-rendered URLs. Even when this value is `false`, the cache is used to temporarily store the pages that finish rendering after the CSR fallback, so they can be served with the next request (after which, the cache is cleared).

  **Note:** The cache should be used carefully to avoid running out of memory. Using the `cacheSize` attribute can help avoid this.

- `cacheSize` is a number that limits the cache size to a specific number of entries. This property helps to keep memory usage under control.

  The `cacheSize` property can also be used when the `cache` option is set to false. This then limits the number of timed-out renders that are kept in a temporary cache, waiting to be served with the next request.

- `concurrency` is a number that indicates how many concurrent requests are treated before defaulting to CSR. Usually, when the concurrency increases (more renders being done at the same time) the slower the response is for each request. To fine-tune it and keep response time reasonable, you can limit the maximum number of concurrent requests. All requests that are unable to render because of this will fall back to CSR.

  The default value is `20`.

- `ttl` (time to live) is a number that indicates the amount of time (in milliseconds) before a pre-rendered page is considered stale and needs to be rendered again.

- `renderKeyResolver` is a function that accepts `(req: Request) => string`, which maps the current request to a specific render key. The `renderKeyResolver` allows you to override the default key generator so that you can differentiate between rendered pages with custom keys.

  By default, `renderKeyResolver` uses `req.originalUrl`.

- `renderingStrategyResolver` is a function that accepts `(req: Request) => RenderingStrategy`, which allows you to define custom rendering strategies for each request. The available `RenderingStrategy` strategies work as follows:

  - `ALWAYS_CSR` always returns client-side rendered pages
  - `DEFAULT` is the default behavior
  - `ALWAYS_SSR` aLways returns server-side rendered pages

- `forcedSsrTimeout` is a number that indicates the time (in milliseconds) to wait for rendered pages when the render strategy for the request is set to `ALWAYS_SSR`. This prevents SSR rendering from blocking resources for too long if the server is under heavy load, or if the page contains errors.

  The default value is `60000` milliseconds (that is, 60 seconds).

- `debug` is a boolean that, when set to `true`, enables extra logs that are useful for troubleshooting SSR issues. In production environments, you should set `debug` to `false` to avoid an excessive number of logs. Regardless, the SSR timeout log will capture `SSR rendering exceeded timeout...` even if the `debug` flag is set to `false`.

  The default value is `false`.

  **Note**: This property is available in version 3.1.0 and later.

- `maxRenderTime` is the maximum amount of time expected for a render to complete. If the render exceeds this timeout, the concurrency slot is released, which allows the next request to be server-side rendered. However, this may not release the rendering resources for a render that has not completed, which may cause additional memory usage on the server. The `maxRenderTime` logs which render exceeds the render time, which is useful for debugging. The value should always be higher than `timeout` and `forcedSsrTimeout`.

  The default value is 300,000 milliseconds (5 minutes).

  **Note**: This property is available in the latest patch versions of 3.1.x and later.

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
2. Open your web browser's developer tools, and then open the Network tab.
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

If your storefront is not running in SSR mode, check the logs of your SSR server. This will be in your terminal if you are running SSR locally, or in Kibana if your storefront is hosted on CCv2.

If you see errors, either locally or in Kibana, you can try debugging them, as described in [Testing Locally](#testing-locally), below.

If you see the following, it means something is preventing the SSR render from completing:

```text
SSR rendering exceeded timeout, falling back to CSR for ...
```

In this case, you can try increasing the `timeout` and `concurrency` values of the SSR optimization engine to see if this solves the issue. For more information, see [Configuring the SSR Optimization Engine](#configuring-the-ssr-optimization-engine).

If increasing these values does not resolve the issue, it means the server cannot render the page. In this case, you can try the following:

- Ensure your server has a valid certificate. For more information, see [Testing SSR With a Self-Signed or Untrusted SSL Certificate](#testing-ssr-with-a-self-signed-or-untrusted-ssl-certificate).
- If your storefront is on CCv2, check the IP restriction of your API. It is possible that the SSR server's IP is being blocked, in which case, you can try changing the configuration on the API to "Allow All" and see if that resolves the issue.

If these solutions do not fix the SSR rendering issue, there may be a problem in the code. Review the [{% assign linkedpage = site.pages | where: "name", "server-side-rendering-coding-guidelines.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/ssr/server-side-rendering-coding-guidelines.md %}), and review your custom code to ensure you are not using any browser functions that are not available with SSR.

### SSR Issues with CCv2

If your CCv2 build is failing, check whether you have an error such as the following:

```text
Execution failed for task ':buildJsApps'
[...]
```

If so, run `yarn build:ssr` locally to get a more detailed error log.

#### Testing Locally

If SSR is not functioning on CCv2, you can try running your Spartacus application locally to pinpoint the issue, as follows:

1. Ensure the `baseUrl` configuration in your app module is pointing to an accessible back end that has a valid certificate.

    If you think certificate validity could be an issue, see [Testing SSR With a Self-Signed or Untrusted SSL Certificate](#testing-ssr-with-a-self-signed-or-untrusted-ssl-certificate).

    **Note**: At the end of these steps, before committing any code, make sure to undo the change in this step so that CCv2 can use the `occ-backend-base-url` from the `index.html`. For more information, see [{% assign linkedpage = site.pages | where: "name", "configuring-base-url.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/configuring-base-url.md %}).

2. Run `yarn dev:ssr`.

    This allows you to run a "development" SSR server that will pick up the changes you make in your source code.

3. Refer to [{% assign linkedpage = site.pages | where: "name", "how-to-debug-server-side-rendered-storefront.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/ssr/how-to-debug-server-side-rendered-storefront.md %}) for more information on debugging an SSR application.

### Testing SSR With a Self-Signed or Untrusted SSL Certificate

During development, it is possible to use self-signed certificates that, by default, are not supported by SSR. If you are using such a certificate, you can allow SSR to support it with the following steps:

1. Run `yarn add -D cross-env`.

    This adds `cross-env` to your `devDependencies`.
2. Add the following script to your `package.json`:

    ```json
    "dev:ssr:dev": "cross-env   NODE_TLS_REJECT_UNAUTHORIZED=0 ng run   YOU_STORE_NAME:serve-ssr"
    ```

    Replace `YOU_STORE_NAME` with your storefront's name, as specified at the top of your `package.json`.

3. Run `yarn dev:ssr:dev` to start your storefront in SSR mode.

    **Note**: Do not use `NODE_TLS_REJECT_UNAUTHORIZED=0` in a production environment.

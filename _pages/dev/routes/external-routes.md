---
title: External Routes (DRAFT)
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

As long as we are in the scope of SPA, Spartacus performs only 'inside' navigations due to usage of Angular's `routerLink` directive, which  by design doesn't load pages from backend. 

However many Customers may want to migrate step-by-step (route-by-route) from the old storefront system (i.e. Hybris accelerator) to the modern Spartacus SPA (Single Page Application), which means temporarily using different systems to drive parts of the storefronts at the same time. 

Thanks to *external routes* feature of Spartacus, some routes can be loaded from backend or even redirected to a different domain.

## How to use Spartacus and other storefront systems at the same domain

The URL patterns need to be defined to distinguish the storefront systems. Those patterns should be applied in 3 places: *backend server*, *Spartacus* configuration and *Angular service worker* (when PWA is enabled), because of the following reasons:

1. When accessing a deep link, the *backend server* should:
    - serve Spartacus; **or**
    - serve other storefront's page
2. When navigating by the Angular's `routerLink`, *Spartacus* should:
    - activate a SPA route; **or**
    - full (re)load a page
3. When full (re)loading page, *Angular service worker* should:
    - intercept navigation request and return cached `index.html` of SPA; **or**
    - bypass the cache - to let the backend serve the response

### Configuration of backend server

The configuration of URL patterns for backend server depends on the used backend technology. Please refer to its documentation.

### Configuration of Spartacus

Provide the configuration with URL patterns for internal routes, i.e. by importing `ConfigModule.withConfig()`. 

> The URL patterns use a limited glob format:
>   * `**` matches 0 or more path segments
>   * `*` matches 0 or more characters excluding `/`
>   * `?` matches exactly one character excluding `/` 
>   * The `!` prefix marks the pattern as being negative, meaning that only URLs that don't match the pattern will be included

Here are two examples:

1. Let only the *homepage*, *cart* and *product details pages* be rendered in SPA, but all other URLs should be loaded from the backend:

    ```typescript
    ConfigModule.withConfig({
      routing: {
        internal: [
          '/',
          '/cart',
          '/product/*/*',
          '/**/p/**',
        ]
      }
    })
    ```

2. Let any route render in SPA, but not the exceptions: *homepage*, *cart* and *product details pages*:
  
    ```typescript
    ConfigModule.withConfig({
      routing: {
        internal: [
          '/**', // wildcard

          // exceptions:
          '!/'
          '!/cart',
          '!/product/*/*',
          '!/**/p/**',
        ]
      }
    })
    ```

*Note: The pattern must start with `/` or `!/`*.

## Configuration of Angular service worker (when PWA is enabled)

To bypass the cache of the service worker and let the backend serve the response after full page (re)load, you need to define property `navigationUrls` of your service worker's config `ngsw-config.json` and specify the URL patterns for internal routes (similar to config of Spartacus). It uses the same glob-like syntax as Spartacus, so you can **almost** copy-paste it. 

**Almost**, because those patterns take into account also the URL part with the site context, like. `/electronics/en/USD/...` (see docs of the [Context Configuration]({{ site.baseurl }}{% link _pages/dev/context/context-configuration.md %}).

Here are two examples (assuming that URL starts with configured three segments of the site context):

1. Let only the *homepage*, *cart* and *product details pages* be rendered in SPA, but all other URLs should be loaded from the backend:

    ```typescript
    // ngsw-config.json

    "navigationUrls": [
      // prefix `/*/*/*/` handles 3 URL segments of site-context
      '/*/*/*/',
      '/*/*/*/cart',
      '/*/*/*/product/*/*',
      '/*/*/*/**/p/**',
    ]
    ```

2. Let any route render in SPA, but not the exceptions: *homepage*, *cart* and *product details pages*:

    ```typescript
    // ngsw-config.json

    "navigationUrls": [
      // wildcard:
      "/**",

      // your custom exceptions with the prefix `/*/*/*/`:
      '!/*/*/*/',
      '!/*/*/*/cart',
      '!/*/*/*/product/*/*',
      '!/*/*/*/**/p/**',

      // re-define the default Angular's exceptions: 
      "!/**/*.*",       // files with extensions
      "!/**/*__*",      // paths containing `__`
      "!/**/*__*/**",
    ]
    ```

For more, see the official documentation of the Angular [service worker configuration](https://angular.io/guide/service-worker-config#navigationurls).

## How to redirect to a different domain

It may happen that a part of the storefront is hosted on a different domain. Then we would like to redirect to a different domain instead of (re)loading the page, by extending the logic of `ExternalRoutesGuard`. Here is how to:

Please provide in your app.module the internal routes config and the custom guard implementation:

```typescript
imports: [
  ConfigModule.withConfig({
    routing: { internal: [ /*...*/ ] }
  })
],
providers: [
  { provide: ExternalRoutesGuard, useClass: CustomExternalRoutesGuard }
],
```

... where the implementation is ...

```typescript
@Injectable()
export class CustomExternalRoutesGuard extends ExternalRoutesGuard {
  protected redirect(_: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
    const window = this.winRef.nativeWindow;

    if (window && window.location) {
      window.location.href = 'https://external-domain.com/' + state.url;
    }
  }
}
```

*Note: Similarly, for SEO, the backend server should perform http **30x redirects** to a different domain for specified URL patterns.*

## Advanced cases

For advanced custom cases, like multiple external routes hosted on multiple domains, you can extend the logic of the method `ExternalRoutesService.getRoutes()` to prepend custom Angular `Routes` with custom `UrlMatcher`s and guards (i.e. each `Route` can redirect to a different domain).

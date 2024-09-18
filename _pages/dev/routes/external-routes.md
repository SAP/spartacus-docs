---
title: External Routes
feature:
- name: External Routes
  spa_version: 1.2
  cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

As a single-page application (SPA), Spartacus makes use of the Angular `routerLink` directive that, by design, does not load pages from the back end. As a result, Spartacus typically allows you to navigate only within the application itself. In other words, Spartacus typically only loads views that are within the single-page application.

However, if you should wish to use Spartacus along with another system to run a single storefront, the external routes feature in Spartacus allows you to use different systems to drive different parts of the storefront at the same time. With external routes, you can designate which routes to load from another system, and you can even redirect routes to a different domain.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Using Spartacus and Another System to Run a Single Storefront

To run a storefront at a single domain using Spartacus along with another system, you define URL patterns to distinguish between the two storefront systems. These patterns should be applied in the back end server, in the Spartacus configuration, and in the Angular service worker (when PWA is enabled). The patterns should be applied as follows:

- When accessing a deep link, the back end server should serve a Spartacus view, or it should serve a page from the other storefront system.

- When using the Angular `routerLink` to navigate, Spartacus should activate a SPA route, or it should fully load the page from the back end.

- When PWA is enabled, the Angular service worker intercepts the navigation request. When fully loading (or reloading) a page, the service worker should return the cached `index.html` of the single-page application, or it should bypass the cache so that the back end can serve the page.

### Configuring the Back End Server

Configuring the URL patterns for the back end server depends on what technology you are using for your back end. Please refer to the relevant back end documentation for more information.

### Configuring Spartacus

You can provide a configuration with the URL patterns for internal routes by importing `ConfigModule.withConfig()`.

The URL patterns use a limited glob format, as follows:

- `**` matches 0 or more path segments
- `*` matches 0 or more characters, excluding `/`
- `?` matches exactly one character, excluding `/`
- `!` is a prefix that marks the pattern as being negative, meaning that only URLs that do not match the pattern will be included

**Note:** Each URL pattern must start with `/` or `!/`.

In the following example, only the homepage, the cart, and the product details pages are rendered in the SPA, and all other URLs are loaded from the back end:

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

In the following example, any route can be rendered in the SPA, except for the homepage, the cart, and the product details pages:

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

## Configuration the Angular Service Worker

**Note:** You only need to configure the Angular service worker if PWA is enabled.

To bypass the service worker cache and let the back end serve the response after a full page load (or a full page reload), you need to define the `navigationUrls` property of your service worker's `ngsw-config.json` configuration, and you need to specify the URL patterns for the internal routes. The service worker configuration uses the same glob-like syntax as Spartacus, but the URL patterns for the service worker configuration also take into account the site context aspect of the URL, such as `/electronics/en/USD/...`. For more information on site context, see [{% assign linkedpage = site.pages | where: "name", "context-configuration.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/context/context-configuration.md %}).

In the following examples, the URL patterns start with three configured segments for the site context.

In the first example, the homepage, the cart, and the product details pages are rendered in the SPA, and all other URLs are loaded from the back end:

```typescript
// ngsw-config.json

"navigationUrls": [
  // prefix `/*/*/*/` handles the three site context URL segments
  '/*/*/*/',
  '/*/*/*/cart',
  '/*/*/*/product/*/*',
  '/*/*/*/**/p/**',
]
```

In the following example, any route can be rendered in the SPA, except for the homepage, the cart, and the product details pages:

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

  // re-define Angular's default exceptions: 
  "!/**/*.*",       // files with extensions
  "!/**/*__*",      // paths containing `__`
  "!/**/*__*/**",
]
```

For more information, see [Service worker configuration](https://angular.io/guide/service-worker-config#navigationurls) in the official Angular documentation.

## Redirecting to a Different Domain

If a part of your storefront is hosted on a different domain, then you need to redirect to the other domain for those parts of the storefront, instead of loading a page (or reloading a page). You can do this by extending the logic of `ExternalRoutesGuard`, which you can do by providing the internal routes configuration and the custom guard implementation in your `app.module`. The following is an example:

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

The following is an example of the relevant implementation:

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

**Note:** For specified URL patterns, the back end server should perform URL forwarding to a different domain. This is similar to using HTTP redirect codes for SEO (such as `301`, `302`, and so on).

## Advanced Cases

For advanced custom cases, such as multiple external routes hosted on multiple domains, you can extend the logic of the `ExternalRoutesService.getRoutes()` method to prepend custom Angular `Routes` with custom `UrlMatcher` functions and guards. For example, each `Route` can redirect to a different domain.

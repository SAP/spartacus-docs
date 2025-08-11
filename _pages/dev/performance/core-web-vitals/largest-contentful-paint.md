---
title: Optimizing Largest Contentful Paint in Spartacus
---

The Largest Contentful Paint (LCP) is a Core Web Vitals metric that measures the render time of the largest image, text block, or video that is visible in the viewport, relative to when a user first navigates to the page. Spartacus provides a set of features to achieve a good LCP metric.

For more general information on LCP, see [Largest Contentful Paint (LCP)](https://web.dev/articles/lcp) in the official Google web.dev documentation.

## Eliminating Resource-Load Delays

To improve the LCP metric, Spartacus implements the recommendations provided by Google on [eliminating resource-load delays for the LCP](https://web.dev/articles/optimize-lcp#1_eliminate_resource_load_delay). The following sections describe in detail how these recommendations have been implemented.

### Setting High Fetch Priority for LCP Image

To improve the LCP metric, you can set the `fetchpriority` HTML attribute to `high` on the `<img>` elements that represent the LCP image.

The implementation of this in Spartacus is described in more detail in [Prioritizing the Largest Contentful Paint image](./prioritize-largest-content-paint-image.md).

### Lazy Loading Non-LCP Media

To prevent unnecessary images from competing for network bandwidth with the LCP image, you can enable default lazy loading for all images in Spartacus `<cx-media>` components. With this configuration, the network bandwidth is used only for necessary requests, and not for images that are outside of the initially-visible part of the website. You can do this in one of the following ways:

- Set the global Spartacus configuration `provideConfig({ imageLoadingStrategy: ImageLoadingStrategy.LAZY })` in your `spartacus-configuration.module.ts`.
- Enable the `lazyLoadImagesByDefault` feature toggle, which is available starting in Spartacus 2211.43. Under the hood, this is the same as setting the `provideConfig({ imageLoadingStrategy: ImageLoadingStrategy.LAZY })`.

**Note:** Even if you set the global configuration to lazy load all images by default, any `<cx-media>` with the input set to `[fetchPriority]="'ImageFetchPriority.HIGH'"` will not be lazy loaded. This behavior ensures that the LCP image is loaded as soon as possible.

For the browser to lazy load images that are not in the viewport, the page layout needs to be stable from the moment the browser starts displaying the page. Otherwise, all the images that are initially in the viewport might be considered by the browser as candidates for eager loading, despite being configured to be lazy loaded. On such example is images that have an initial height of `0 px`, and which are moved outside the initial viewport only after a delay. This makes the lazy loading of such images ineffective.

To have a stable layout, you need to maintain a good Cumulative Layout Shift metric. The implementation of CLS is described in more detail in [Optimizing Cumulative Layout Shift in Spartacus](./cumulative-layout-shift.md).

### Preconnecting to the Media Domain

To further improve the LCP metric, Spartacus automatically creates a `<link rel="preconnect" href="<MEDIA DOMAIN>">` link for the LCP image based on the configured `mediaBaseUrl`. This allows Spartacus to perform the DNS and TLS requests as soon as possible, to later be able to fetch the images from that domain without any additional round trips. This is supported starting in Spartacus 2211.43, and requires the `createMediaPreconnectLink` feature toggle to be enabled.

Although this preconnecting link is provided to improve performance, it is recommended to avoid the need to preconnect altogether. You can do this by serving images from **the same domain** as the storefront domain. In this case, you do not to preconnect to a separate media domain.

### Automatic Preloading of LCP Images

Although preloading images with the `<link rel="preload">` attribute is a common technique to improve LCP, Spartacus does not automatically create this type of link for the LCP image. Instead, the Spartacus `<cx-media>` component relies on the HTML `<picture>` element to support displaying different art direction for responsive images for various media queries. Additionally, as noted in Google's article [Preload Responsive Images](https://web.dev/articles/preload-responsive-images#picture), there are still a number of technical issues to sort out for preloading `<picture>`.

Spartacus helps to prioritize LCP images by setting the `fetchpriority="high"` HTML attribute on the `<img>` elements. However, if you prefer to force the browser to preload the image even earlier, you can implement your own custom logic to preload the LCP image using `<link rel="preload">` in your custom storefront app. For more information on the workaround, see [Preload Responsive Images](https://web.dev/articles/preload-responsive-images#picture) in the official Google web.dev documentation.

### LCP and Server-Side Rendering

To improve the LCP metric, it is recommends that you enable server-side rendering (SSR) in your storefront app and cache the rendered HTML. You can cache the rendered HTML in a CDN, for example.

When the browser receives the HTML that was server-side rendered ahead of time and served nearly immediately from the CDN's cache, the time to first byte is shortened. As a result, the browser can see all the HTML tags sooner, including the `<img>` tags with the `fetchpriority="high"` attribute. This allows the browser to start fetching prioritized images (such as the LCP image) as soon as possible.

Otherwise, in the absence of SSR, the browser first downloads nearly-empty HTML with JavaScript URLs to be downloaded. The browser needs to wait for the JavaScript to load and execute, after which point, the Spartacus JavaScript fetches the CMS data, and the Angular JavaScript creates an HTML structure, including `<img>` elements. Only then can the browser see those elements and download those images, including the LCP image.

For more information on how to enable SSR in your Spartacus app, see [Server-Side Rendering](../../../dev/ssr/server-side-rendering-in-spartacus.md).

For more information on Spartacus CDN recommendations, see [Performance Best Practices](./performance-best-practices.md#Caching-Recommendations).

## Using Optimized Images

The smaller and more optimized your images are, the faster they can be downloaded and displayed in the browser. This in turn improves the LCP metric.

For more information, see [Image Format Recommendations](./performance-best-practices.md#Image-Format-Recommendations).

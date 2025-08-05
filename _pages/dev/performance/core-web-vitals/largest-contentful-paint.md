# Largest Contentful Paint (LCP)

The Largest Contentful Paint (LCP) metric is a Core Web Vitals metric that measures the render time of the largest image, text block, or video visible in the viewport, relative to when the user first navigates to the page. For more information, see [Largest Contentful Paint (LCP)](https://web.dev/articles/lcp).

Spartacus provides a set of features to keep a good LCP metric. 

## Eliminating Resource-Load Delays

Spartacus implements guidelines from Google's article on [Eliminating resource-load delays of Largest Contentful Paint](https://web.dev/articles/optimize-lcp#1_eliminate_resource_load_delay) to improve the LCP metric. 

### Setting High Fetch Priority for LCP Image

To improve the LCP metric, you can set the `fetchpriority` HTML attribute to `high` on your `<img>` elements that represent the LCP image. For more information, see [Prioritizing the Largest Contentful Paint image](./prioritize-largest-content-paint-image.md).

### Lazy Loading

To prevent unnecessary images from competing for the network bandwidth with the LCP image, you can enable lazy loading by default for all images in Spartacus `<cx-media>` components. As a result, the network bandwidth is used only for necessary requests, but not for images that are outside of the initially-visible part of the website. You can do this with one of the following methods:

- Set the global Spartacus configuration `provideConfig({ imageLoadingStrategy: ImageLoadingStrategy.LAZY })` in your `spartacus-configuration.module.ts`.
- Enable the feature toggle `lazyLoadImagesByDefault`, which is available with Spartacus 2211.43. Under the hood, this does the same as setting the `provideConfig({ imageLoadingStrategy: ImageLoadingStrategy.LAZY })`.

Despite setting the global configuration to lazy-load all images by default, any `<cx-media>` with the input `[fetchPriority]="'ImageFetchPriority.HIGH'"` is not lazy loaded. This behavior ensures that the LCP image is loaded as soon as possible.

For the browser to lazy-load images that are not in the viewport, the page layout needs to be stable from the beginning of displaying the page. Otherwise, all the images that are initially in the viewport, for example, due to an initial height of `0px`, and are moved outside the initial viewport only after a delay, might all be considered by the browser as candidates for eager loading, despite being configured to be lazy loaded. It will make the lazy loading ineffective. 

To have a stable layout, maintain a good Cumulative Layout Shift metric. For more information, see [Cumulative Layout Shift](./cumulative-layout-shift.md).

### Preconnecting to the Media Domain (Unless It Is the Same As the Storefront Domain)

To further improve the LCP metric, Spartacus automatically creates a link `<link rel="preconnect" href="<MEDIA DOMAIN>">` for the LCP image based on the configured `mediaBaseUrl`, to perform the DNS and TLS requests as soon as possible, to later be able to fetch the images from that domain without additional roundtrip. This is supported with Spartacus 2211.43, when the feature toggle `createMediaPreconnectLink` is enabled.

That said, it's even recommended to avoid the need to preconnect, meaning it's recommended to serve images from **the same domain** as the storefront's domain, if possible. That way, no preconnection to a media domain is needed.

### Automatic Preloading of LCP Images with `<link rel="preload">`

Although preloading images with the `<link rel="preload">` attribute is a common technique to improve LCP, Spartacus does not create such links automatically for the LCP image. Under the hood, the Spartacus `<cx-media>` component relies on the HTML `<picture>` element to support displaying different art direction for responsive images for various media queries. Additionally, as noted in Google's article [Preload Responsive Images](https://web.dev/articles/preload-responsive-images#picture), there are still a number of technical issues to sort out for preloading `<picture>`.

Spartacus helps to prioritize LCP images by setting the `fetchpriority="high"` HTML attribute on the `<img>` elements. That said, if this method doesn't suffice in your case and you'd like to force the browser to preload the image even earlier, you can implement your own custom logic to preload the LCP image with `<link rel="preload">` in your custom storefront. For more information on the workaround, see [Preload Responsive Images](https://web.dev/articles/preload-responsive-images#picture).

### Server-Side Rendering (SSR)

To improve the LCP metric, Spartacus recommends enabling server-side rendering (SSR) in your Spartacus app and caching the rendered HTMLs, for example, in a CDN.

When the browser gets the HTML that was server-side rendered ahead of time and served nearly immediately from CDN's cache, the time to first byte is shortened. As a result, the browser can see all the HTML tags like `<img>` with the `fetchpriority="high"` attribute sooner, so the browser can start fetching such an image (such as the LCP image) as soon as possible.

Otherwise, in the absence of SSR, the browser first downloads a nearly-empty HTML with JavaScript URLs to be downloaded. The browser needs to wait for the JavaScript to load and execute, after which point, the Spartacus JavaScript fetches the CMS data, and the Angular JavaScript creates an HTML structure including `<img>` elements. Only then can the browser see those elements and download those images, including the LCP image.

For more information on how to enable SSR in your Spartacus app, see [Server-Side Rendering](../../../dev/ssr/server-side-rendering-in-spartacus.md).

For more information on Spartacus CDN recommendations, [Performance Best Practices](./performance-best-practices.md#Caching-Recommendations).

## Using Optimized Images

The smaller and more optimized your images are, the faster they can be downloaded and displayed in the browser, which improves the LCP metric.

For more information, see the Image Format Recommendations section in [Performance Best Practices](./performance-best-practices.md#Image-Format-Recommendations).

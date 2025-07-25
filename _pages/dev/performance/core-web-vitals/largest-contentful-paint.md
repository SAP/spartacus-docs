# Largest Contentful Paint (LCP)

Spartacus provides a set of features to keep good [Largest Contentful Paint (LCP)](https://web.dev/articles/lcp) Core Web Vital metric. The LCP metric measures the time of the largest image, text block, or video visible in the viewport, relative to when the user first navigated to the page.

## Eliminate resource-load delays

Spartacus implements guidelines from Google's article on [Eliminating resource-load delays of Largest Contentful Paint](https://web.dev/articles/optimize-lcp#1_eliminate_resource_load_delay) to improve the LCP metric. The following features are available:

### Set high Fetch Priority for LCP image

To improve the LCP metric, you can set the `fetchpriority` HTML attribute to `high` on your `<img>` elements that represent the Largest Contentful Paint image. It can be done in various ways, which is described in a separate document which we recommend to follow: [Prioritize Largest Contentful Paint image](./prioritize-largest-content-paint-image.md).

### Lazy load all non-LCP media by default

To prevent unnecessary images from competing for the Network bandwidth with the Largest Contentful Paint image, you can enable lazy loading by default of all images in Spartacus `<cx-media>` components. Thanks to this, the network bandwidth will be used only for necessary requests, but not for images that are outside of the initially visible part of the website. 

Please do one of the following

a) set the global Spartacus configuration `provideConfig({ imageLoadingStrategy: ImageLoadingStrategy.LAZY })`. 

or

b) alternatively, enable the feature toggle `lazyLoadImagesByDefault`, which is available since Spartacus v2211.43 (which under the hood does the same thing as the option a).

### LCP image in won't and shouldn't be lazy loaded
Please mind that the `<cx-media>` with the input `[fetchPriority]="'ImageFetchPriority.HIGH'"` (the feature that is described below) will not be lazy loaded despite the global config of lazy loading all images by default.This is a desired behavior to ensure that the Largest Contentful Paint image is loaded as soon as possible.

### Page layout must be stable from the beginning to lazy-load images outside of the viewport
For the browser to lazy-load images that are not in the viewport, the page layout needs to be stable from the beginning of displaying the page. Otherwise, all the images that initially are in the viewport (e.g due to having an initial height of `0px`) and are moved outside the initial viewport only after a delay, they might be all considered by the browser as candidates for eager loading, despite they being configured to be lazy loaded. It will make the lazy-loading ineffective. 

To have a stable layout, please follow the Spartacus guide on keeping good [Cumulative Layout Shift (CLS)](./cumulative-layout-shift.md) metric.

### Preconnect to the media domain unless it is the same as the storefront domain

To further improve the LCP metric, Spartacus automatically creates `<link rel="preconnect" href="<MEDIA DOMAIN>">` based on the configured `mediaBaseUrl`, to perform the DNS and TLS requests as soon as possible, to later being able to fetch the images from that domain without additional roundtrip. This is supported since Spartacus v2211.43 when the feature toggle `createMediaPreconnectLink` is enabled.

That said, it's even recommended to avoid the need to preconnect, i.e. it's recommended to serve images from **the same domain** as the storefront's domain, if only possible. Then no preconnection to a media domain is needed.

### Automatic preloading of LCP images with `<link rel="preload">`

Although preloading images with `<link rel="preload">` is a common technique to improve LCP, Spartacus does not create such links automatically for the Largest Contentful Paint image. This is because Spartacus `<cx-media>` component relies under the hood on the HTML `<picture>` element to support displaying different art direction for responsive images for various media queries. And, as noted in Google's article [Proload Responsive Images](https://web.dev/articles/preload-responsive-images#picture), there are still a number of technical issues to sort out for preloading `<picture>` .

As mentioned in previous sections, Spartacus helps to prioritize LCP images by setting the HTML attribute `fetchpriority="high"` attribute on the `<img>` elements.
That said, if this doesn't suffice in your case and you'd like to force the browser to preload the image even earlier, nothing prevents you from implementing your own custom logic to preload LCP images with `<link rel="preload">` in your custom storefront. Then you might need to use the workaround described in Google's article [Proload Responsive Images](https://web.dev/articles/preload-responsive-images#picture).

### Use Server-Side Rendering (SSR)

To improve the LCP metric, it is recommended to enable Server-Side Rendering (SSR) in your Spartacus app and cache the rendered HTMLs e.g. in a CDN.

When the browser gets the HTML that was  Server-Side-Rendered ahead of time and served nearly immediately from CDN's cache, the time to first byte is shortened. Thanks to that, the browser can see all the HTML tags like `<img>` with `fetchpriority="high"` attribute sooner, so the browser can start fetching such an image (e.g. Largest Contentful paint image) as soon as possible.

Otherwise (in absence of SSR) the browser would first download just a nearly empty HTML with Javascript URLs to be downloaded. So the browser would need to wait for the JavaScript to load and execute, then the Spartacus Javascript would fetch the CMS data, then Angular Javascript create HTML structure including `<img>` elements, and only then the browser could see those elements and download those images, including the Largest Contentful Paint image.

For more information on how to enable SSR in your Spartacus app, see docs on [Server-Side Rendering](../../../dev/ssr/server-side-rendering-in-spartacus.md).

Please also see the "CDN recommendations" section in the document [Performance Best Practices](./performance-best-practices.md#Caching-Recommendations).

## Use optimized images

The smaller and more optimized the images are, the faster they can be downloaded and displayed in the browser, which improves the LCP metric.

Please follow the "Image Format Recommendations" section in the document [Performance Best Practices](./performance-best-practices.md#Image-Format-Recommendations).

# Largest Contentful Paint (LCP)

Spartacus provides a set of features to achieve good [Largest Contentful Paint (LCP)](https://web.dev/articles/lcp) Core Web Vital metric. The LCP metric measures how long it takes for the largest content element on a page to become visible to the user.

Below are the recommended practices to keep good LCP metric in Spartacus:

## Eliminate resource-load delays

Spartacus implements guidelines from Google's article on [Eliminating resource-load delays of Largest Contentful Paint](https://web.dev/articles/optimize-lcp#1_eliminate_resource_load_delay) to improve the LCP metric. The following features are available:

### Set high Fetch Priority for LCP media

To improve the LCP metric, you can set the `fetchpriority` HTML attribute to `high` on your `<img>` elements that represent the Largest Contentful Paint image. It can be done in various ways, which is described in the document [Prioritize Largest Contentful Paint image](./prioritize-largest-content-paint-image.md).

### Lazy load all non-LCP media by default

To prevent other images from competing with the Largest Contentful Paint image, you can enable lazy loading of all images by default in your storefront - all images that are within Spartacus `<cx-media>` components. Thanks to this, the network bandwidth will be used only for necessary requests, but not for images that are outside of the initially visible part of the website. This can be done by setting the global Spartacus configuration `provideConfig({ imageLoadingStrategy: ImageLoadingStrategy.LAZY })`. Alternatively, you can enable the feature toggle `lazyLoadImagesByDefault` available since Spartacus v2211.43 (which does the same thing).

Please mind that the `<cx-media>` with the input `[fetchPriority]="'ImageFetchPriority.HIGH'"` (including those configured via will not be lazy loaded, so it will be loaded eagerly and with high priority. This is to ensure that the Largest Contentful Paint image is loaded as soon as possible.

Note: For the browser to lazy-load images that are not in the viewport, the page layout needs to be stable and not change during the loading of the page. This means that all the elements on the page should have a defined size (e.g. with CSS rules or HTML attributes), so the browser can reserve the space for them before they are loaded. Otherwise, the browser might think that all the images are in the viewport and load them eagerly, which will make the lazy-loading ineffective. For example, to reserve the space for the images, see the document [Reserve space for images with `width` and `height` attributes (or CSS aspect ratio)](./cumulative-layout-shift.md#Reserve-space-for-images-with-width-and-height-attributes-or-CSS-aspect-ratio).

### Preconnect to the media domain unless it is the same as the storefront domain

To further improve the LCP metric, Spartacus automatically creates `<link rel="preconnect" href="<MEDIA DOMAIN>">` based on the configured `mediaBaseUrl`, to speed up the extra network DNS and TLS roundtrip needed to fetch the images from a different domain. This is supported since Spartacus v2211.43 when the feature toggle `createMediaPreconnectLink` is enabled.

That said, it's recommended to serve images from the same domain as the storefront's domain, if only possible - to avoid even the need for the preconnecting. But if they happen to be different, Spartacus will create the preconnect link automatically.

### Automatic preloading of LCP images with `<link rel="preload">` is not supported

Although preloading images with `<link rel="preload">` is a common technique to improve LCP, Spartacus does not create such links automatically for the Largest Contentful Paint image. This is because Spartacus `<cx-media>` component relies under the hood on the HTML `<picture>` element to support responsive images for various media queries. And, as noted in Google's article [Proload Responsive Images](https://web.dev/articles/preload-responsive-images#picture), there are still a number of technical issues to sort out for preloading `<picture>` .

As mentioned in previous sections, Spartacus helps to prioritize LCP images by setting the HTML attribute `fetchpriority="high"` attribute on the `<img>` elements.

That said, nothing prevents you from implementing your own custom logic to preload LCP images with `<link rel="preload">` in your custom storefront.

### Use Server-Side Rendering (SSR)

To improve the LCP metric, it is recommended to enable Server-Side Rendering (SSR) in your Spartacus app and cache the rendered HTMLs e.g. in a CDN.

When the browser gets immediately from CDN's cache the Server-Side-Rendered HTML with all HTML tags like `<img>` with `fetchpriority="high"` attribute, then browser can start fetching such an image as soon as possible.

Otherwise (in absence of SSR) the browser would need to wait first for the JavaScript to load and execute, then fetch CMS data, then create HTML structure including `<img>` elements, and only then it could download and display the Largest Contentful Paint image.

For more information on how to enable SSR in your Spartacus app, see docs on Server-Side Rendering (SSR) [TODO ADD LINK TO DOCS].

## Use optimized images

See Image Format Recommendations in the document [Performance Best Practices](./performance-best-practices.md#Image-Format-Recommendations).

## Use CDN to serve SSR pages as fast as possible

See CDN recommendations in the document [Performance Best Practices](./performance-best-practices.md#Caching-Recommendations).

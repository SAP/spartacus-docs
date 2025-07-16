# Largest Contentful Paint (LCP)

Spartacus provides a set of features to achieve good [Largest Contentful Paint (LCP)](https://web.dev/articles/lcp) Core Web Vital metric. The LCP metric measures how long it takes for the largest content element on a page to become visible to the user.

## Eliminate resource-load delays

Spartacus implements guidelines from Google's article on [Eliminating resource-load delays of Largest Contentful Paint](https://web.dev/articles/optimize-lcp#1_eliminate_resource_load_delay) to improve the LCP metric. The following features are available:

## Set high Media Fetch Priority for LCP image

To improve the LCP metric, you can set the `fetchpriority` HTML attribute to `high` on your `<img>` elements that represent the Largest Contentful Paint image. This can be done in three ways (from most convenient to least convenient):

- For Spartacus OOTB components (like `BannerComponent`, `ProductCarouselComponent`, `ProductImagesComponent`) you can simply use the Spartacus configuration `lcpCmsComponents` to specify CMS component IDs that should set the `fetchpriority` attribute on their main `<cx-media>` component. This is supported since Spartacus v2211.43. More on `lcpCmsComponents` configuration in the section below.
- For your custom components that use directly the Spartacus component `<cx-media>`, you can set the input `[fetchPriority]="'ImageFetchPriority.HIGH"` (supported since Spartacus v2211.42).
- For your custom components that use directly `<img>` elements you can set the native HTML attribute `fetchpriority="high"` on the `<img>` elements.

Please mind to not overuse the `fetchpriority` attribute on many images on a single page. Otherwise the Largest Contentful Paint image will not be enough prioritized by the browser.

## Lazy load all other media by default

To improve the LCP metric, you can enable lazy loading of all images by default in your storefront - all images that are within Spartacus `<cx-media>` components. Thanks to this, the network bandwidth will be used only for necessary requests for images that are outside of the visible part of the website). This can be done by setting the global Spartacus configuration `provideConfig({ imageLoadingStrategy: ImageLoadingStrategy.LAZY })`. Alternatively, you can enable the feature toggle `lazyLoadImagesByDefault` available since Spartacus v2211.43 (which does the same thing).

Please mind that the `<cx-media>` with the input `[fetchPriority]="'ImageFetchPriority.HIGH'"` (including those configured via will not be lazy loaded, so it will be loaded eagerly and with high priority. This is to ensure that the Largest Contentful Paint image is loaded as soon as possible.

## Preconnect to the media domain unless it is the same as the storefront domain

To further improve the LCP metric, Spartacus automatically creates `<link rel="preconnect" href="<MEDIA DOMAIN>">` based on the configured `mediaBaseUrl`, to speed up the extra network DNS and TLS roundtrip needed to fetch the images from a different domain. This is supported since Spartacus v2211.43 when the feature toggle `createMediaPreconnectLink` is enabled.

That said, it's recommended to serve images from the same domain as the storefront's domain, if only possible - to avoid even the need for the preconnecting. But if they happen to be different, Spartacus will create the preconnect link automatically.

## Not preloading images with `<link rel="preload">`

Although preloading images with `<link rel="preload">` is a common technique to improve LCP, Spartacus does not create such links automatically for the Largest Contentful Paint image. This is because Spartacus `<cx-media>` component relies under the hood on the HTML `<picture>` element to support responsive images for various media queries. And, as noted in Google's article [Proload Responsive Images](https://web.dev/articles/preload-responsive-images#picture), there are still a number of technical issues to sort out for preloading `<picture>` .

Fortunately, as mentioned in previous sections, Spartacus effectively prioritizes LCP images with a different method: by setting the HTML attribute `fetchpriority="high"` attribute on the `<img>` elements.

## Server-Side Rendering (SSR)

To improve the LCP metric, it is recommended to enable Server-Side Rendering (SSR) in your Spartacus app and cache the rendered HTMLs e.g. in a CDN. SSR allows the server to render the initial HTML of the page, which can significantly reduce the time it takes for the Largest Contentful Paint image to become visible to the user. Otherwise, the browser would need to wait for the JavaScript to load and execute, then fetch CMS data, then create `<img>` elements - all of that before it can render the Largest Contentful Paint image.

For more information on how to enable SSR in your Spartacus app, see docs on Server-Side Rendering (SSR) [TODO ADD LINK TO DOCS].

# Core Web Vitals

## What you need to do

- apply HTML attribute `fetchpriority="high"` on your LCP (Largest Contentful Paint) `<img>` elements to improve the LCP Web Vital metric. This can be done in two ways:
  - either manually in your custom components, e.g. by setting `[fetchPriority='ImageFetchPriority.HIGH"]` on your `<cx-media>` (supported since v2211.42)
  - or for Spartacus OOTB components, you can configure the CMS components IDs containing LCP images via the Spartacus config `lcpCmsComponents` - for more see the specific docs (TODO: add link to docs)
- enable lazy loading of all images by default in your storefront, by setting the global Spartacus config `provideConfig({ imageLoadingStrategy: ImageLoadingStrategy.LAZY })`. Alternatively you can enable the feature toggle `lazyLoadImagesByDefault` available since v2211.43. Thanks to this, only the LCP (Largest Contentful Paint) image will be loaded eagerly and with high priority, which should improve the LCP Web Vital metric
- ensure you have SSR enabled in your app. Apps can have SSR enabled, by passing `--ssr` flag during the installation of Spartacus with the command `ng add @spartacus/schematics`
- setup configure CDN over your SSR server, to cache SSR pages and serve them faster to your users (moreover, to offload the SSR server from serving the same pages over and over again)
- serve images optimized and converted into modern lightweight format (faster to download). Some CDN providers can do this automatically for you
- if possible, serve the images from the same domain as the storefront domain (to avoid extra network DNS and TLS network roundtrip). Some CDN providers can do this
- ensure all `<img>` elements have HTML attributes `"width"` and `"height"` on your `<img>` elements, so the browser can reserve the space for the image before it is downloaded and rendered. It helps to avoid layout shifts and improves the Web Vital metric CLS (Cumulative Layout Shift)
  - a) apply it on `<img>` elements in your custom components
  - b) set `width` and `height` properties in the Media model passed to Spartacus component `<cx-media>` (supported since v2211.31 when the feature toggle `useExtendedMediaComponentConfiguration` is enabled)
    - those properties are not returned yet from the OOTB Commerce OCC backend, but you can augment the OCC backend response to send width & height with your custom backend customization, eg. by extracting the dimensions from the image filename, or other CMS custom properties (e.g. description etc.) (TODO: link to docs with the workaround code snippet)
- in your custom components, follow the guidelines Google's on Core Web Vitals: https://web.dev/explore/learn-core-web-vitals
  or by configuring `lcpCmsComponents` via the global Spartacus config

## What is done automatically by Spartacus

- it's recommended to serve images from the same domain as the storefront's domain. But if they happen to be different, Spartacus automatically creates `<link rel="preconnect" href="<MEDIA DOMAIN>">` based on the configured `mediaBaseUrl`, to speedup the extra network DNS and TLS roundtrip needed to fetch the images from a different domain.
  - needs feature toggle `createMediaPreconnectLink` available since 2211.43
- Angular's non-destructive hydration
  - OOTB Spartacus components on Server-Side Rendered pages (i.e. meant for anonymous users) are compliant with Angular's non-destructive hydration requirements, so they will not cause any hydration errors
  - but you need to review your custom components to ensure they are compliant with Angular's non-destructive hydration requirements too

---

TODO:

- write docs for the LCP context feature
  - which components are supported
  - what configuration options are supported
- write docs for setting width & height on images
  - `<cx-media>` component supports setting `width` and `height` properties via Media model since 2211.31 when the feature toggle is enabled `useExtendedMediaComponentConfiguration`
  - sending width & height is not yet supported by the out-of-the-box OCC CMS backend
  - but you can augment the OCC backend response to send width & height with your custom backend customization
    - OR you can put the dimensions into the image filename, or other CMS custom properties (e.g. description etc.)
      - and then write a custom Spartacus data Normalizer to extract the dimensions from the filename or other CMS custom properties and assign to the `width` and `height` properties of the media model
- write docs on Angular's non-destructive hydration (since 2211.43)
  - enabled in fresh apps created since 2211.43
  - you can enable it in existing apps by adding a provider to your app.module
  - your custom components will need to comply with the Angular's non-destructive hydration requirements
- write docs on using optimized image formats - reuse https://jira.tools.sap/browse/CXSPA-9614
- write docs on compressing network responses from your server (it can be handled by your CDN) - reuse https://jira.tools.sap/browse/CXSPA-9615
- document SSR page caching on CDN - reuse https://jira.tools.sap/browse/CXSPA-9617
- write docs with workaround code snippet to extract width & height from the image filename or other CMS custom properties

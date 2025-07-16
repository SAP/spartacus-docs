# Cumulative Layout Shift (CLS)

Spartacus provides a set of features to achieve good [Cumulative Layout Shift (CLS)](https://web.dev/articles/cls) Core Web Vital metric. The CLS metric measures how much the content on a page shifts around while the page is loading, which can lead to a poor user experience.

Below are the recommended practices to keep good CLS metric in Spartacus:

## Reserve space for images with `width` and `height` attributes (or CSS aspect ratio)

To improve the Cumulative Layout Shift metric, you can ensure that all `<img>` elements have HTML attributes `width` and `height` set. This allows the browser to reserve the space for the image before it is downloaded and rendered, which helps to avoid layout shifts.

This can be done in two ways:

- For components using the child component `<cx-media>`, you can set the `width` and `height` properties in the Media model passed to the `<cx-media>` component as an input. This is supported since Spartacus v2211.31 when the feature toggle `useExtendedMediaComponentConfiguration` is enabled.
  - That said, at the moment of writing, the OOTB Commerce CMS OCC backend does not return the `width` and `height` properties for Media model. However, you can augment the OCC backend response to send these properties with your custom backend customization, or by writing a custom logic in Spartacus data adapter/normalizer layer. For example you can extract the dimensions from the image filename (if the filename contains it, e.g. `someImage-800x600.jpg`) or from other CMS properties (e.g., description). The example code snippet for this workaround is presented in the section below.
- For your custom components that use directly `<img>` elements, you can set the native HTML attributes `width` and `height` on the `<img>` elements.

Please note that the `width` and `height` attributes should be set to the intrinsic dimensions of the image. But the actual dimensions of the displayed image might be different, for example, if the image is resized by CSS, which is often the case in responsive designs (e.g. with CSS rules `img { width: 100%; height: auto; }`). In such cases, the browser still needs the HTML `width` and `height` attributes to calculate the aspect ratio. Without it, the browser would not know the space it should reserve for the image. Alternatively the aspect ratio can be defined explicitly with CSS rules (e.g. `img { aspect-ratio: 1 / 1; }`), if its know in advance (e.g. for square product images).

## Don't change the layout with JavaScript after the page has loaded

To avoid layout shifts, it is recommended to not change the DOM or layout with JavaScript after the page has loaded. In particular it's not recommended to use the Spartacus `BreakpointService` to dynamically change the layout of the page.
Ideally the layout should be controlled just with the CSS media queries, and the HTML structure should be the same for all breakpoints.

This includes not recommending to use Spartacus breakpoint-specific layout configurations [TODO add link to layout-config.md#Choosing-an-Adaptive-or-Responsive-Layout]. The problem will happen when transitioning from the Server-Side Rendered (SSR) HTML to Client-Side Rendered (CSR) HTML, as it can cause layout shifts when the JavaScript is executed and the DOM is changed. In Spartacus, the SSR HTML blindly assumes the configured `xs` DOM layout (without knowing the client's viewport), which is then changed to the configured `lg` DOM layout when the JavaScript of Spartacus is loaded and executed on desktop. This can negatively impact the Cumulative Layout Shift metric. Instead, it's recommended to configure one common DOM layout for all breakpoints for both SSR and CSR, and to not change it after the page has loaded. The HTML should be the same for all breakpoints, and the layout should be controlled just with CSS media queries.

Note: Angular's feature of inlining critical CSS is responsible for ensuring that the CSS is applied immediately after loading the SSR HTML, so the layout is correct from the start. This is done automatically by Angular and does not require any additional configuration in Spartacus.

## Example code snippet to extract width and height from the image filename or other CMS custom properties

```typescript
// TODO
```

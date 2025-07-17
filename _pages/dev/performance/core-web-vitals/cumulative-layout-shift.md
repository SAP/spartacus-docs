# Cumulative Layout Shift (CLS)

Spartacus provides a set of features to achieve good [Cumulative Layout Shift (CLS)](https://web.dev/articles/cls) Core Web Vital metric. The CLS metric measures how much the content on a page shifts around while the page is loading, which can lead to a poor user experience.

Below are the recommended practices to keep good CLS metric in Spartacus:

## Reserve space for images

To improve the Cumulative Layout Shift metric, you can ensure that all `<img>` elements have HTML attributes `width` and `height` set. This allows the browser to reserve the space for the image before it is downloaded and rendered, which helps to avoid layout shifts.

Since Spartacus v2211.31, when the feature toggle `useExtendedMediaComponentConfiguration` is enabled the `<cx-media>` component starts supporting the `width` and `height` properties, which is useful for example for banner images. You'll need to set those properties explicitly, which is described in the section below.

Since Spartacus v2211.43, when the feature toggle `reserveSpaceForImagesOnPdpAndPlp` is enabled, Spartacus automatically reserves space for square product images on the Product Details Page and Product Listing Page by setting CSS rules with `aspect-ratio: 1 / 1`.

# Pass with `width` and `height` properties to `<cx-media>` component

This can be done in two ways:

- For components using the child component `<cx-media>`, you can set the `width` and `height` properties in the Media model passed to the `<cx-media>` component as an input. This is supported since Spartacus v2211.31 and you need to enable the feature toggle `useExtendedMediaComponentConfiguration`:
  - That said, at the moment of writing, the OOTB Commerce CMS OCC backend does not return the `width` and `height` properties for Media model. However, you can augment the OCC backend response to send these properties with your custom backend customization, or by writing a custom logic in Spartacus data adapter/normalizer layer. For example you can extract the dimensions from the image filename (if the filename contains it, e.g. `someImage-800x600.jpg`) or from other CMS properties (e.g., description). The example code snippet for this workaround is presented in the section below.
- For your custom components that use directly `<img>` elements, you can set the native HTML attributes `width` and `height` on the `<img>` elements.

Note: The `width` and `height` attributes should be set to the intrinsic dimensions of the image. But the actual dimensions of the displayed image might be different, for example, if the image is resized by CSS, which is often the case in responsive designs (e.g. with CSS rules `img { width: 100%; height: auto; }`). In such cases, the browser still needs the HTML `width` and `height` attributes to calculate the aspect ratio. Without it, the browser would not know the space it should reserve for the image. Alternatively the aspect ratio can be defined explicitly with CSS rules (e.g. `img { aspect-ratio: 1 / 1; }`), if its know in advance (e.g. for square product images). Since version v2211.43, when you enable the feature toggle `reserveSpaceForImagesOnPdpAndPlp`, Spartacus automatically reserves space for square product images on the Product Details Page and Product Listing Page.

## Don't change the layout with JavaScript after the page has loaded

When you're using Spartacus Server-Side Rendering (which is recommended), then to avoid layout shifts, we should not change the DOM structure with JavaScript after the page has loaded. In particular it's not recommended to use the Spartacus `BreakpointService` to dynamically change the layout of the page. It's because Javascript is loaded after a delay and changing the layout with JavaScript after the page has loaded can cause layout shifts, which negatively impacts the Cumulative Layout Shift metric.

Ideally the layout should be controlled just with the CSS media queries, and the HTML structure should be the same for all breakpoints.

Note: [Angular SSR default behavior of inlining critical CSS](https://angular.dev/reference/configs/workspace-config#styles-optimization-options) is responsible for ensuring that the CSS embedded in the SSR HTML and therefore it's applied by the browser immediately after loading the SSR HTML, so the visual layout is correct from the start. This is done automatically by Angular SSR and does not require any additional configuration in Spartacus.

Spartacus v2211.43 introduced 2 feature toggles to help avoiding layout shifts:

- `unifiedDefaultHeaderSlotsAcrossBreakpoints` - this feature toggle ensures that the header layout is the same for all breakpoints, so it does not change when the page is loaded on desktop. Additionally, for apps created before v2211.43 you'll need to also change the deprecated `provideConfig(layoutConfig)` to `provideConfigFactory(layoutConfigFactory)` in your `spartacus-features.module.ts`. More on this in the section below [Use the same Header layout configuration for all breakpoints](#Use-the-same-Header-layout-configuration-for-all-breakpoints).
- `productCarouselScrolling` - this feature toggle uses the improved carousel implementation in the `ProductCarouselComponent` (it uses `<cx-carousel-scrolling>` instead of the old `<cx-carousel>`). The new carousel implementation, as opposed to the old one, does not change the DOM structure after transitioning from SSR to CSR, so it avoids layout shifts. Moreover it also more mobile-friendly thanks the swipe gestures allowing to continuously scroll the carousel items (instead of the previous need to click on the next/previous buttons to change slides).

In your custom components it's not recommended to the [Spartacus breakpoint-specific layout configurations](../../styling-and-page-layout/page-layout.md#choosing-an-adaptive-or-responsive-layout). The problem will happen when transitioning from the Server-Side Rendered (SSR) HTML to Client-Side Rendered (CSR) HTML, as it can cause layout shifts when the JavaScript is executed after a delay and the DOM is changed. In Spartacus, the SSR HTML renderer blindly assumes the DOM structure for the `xs` layout configuration (without knowing the client's viewport), which is then changed to the configured `lg` layout when the JavaScript of Spartacus is loaded and executed on desktop. This can cause a layout shift and can negatively impact the Cumulative Layout Shift metric. Instead, it's recommended to configure one common DOM layout for all breakpoints for both SSR and CSR, and to not change it after the page has loaded. The DOM structure should be the same for all breakpoints, but the visual layout should be controlled ideally just with CSS rules.

### Use the same Header layout configuration for all breakpoints

If you created your storefront before Spartacus v2211.43, your `spartacus-configuration.module.ts` likely contains the deprecated default Spartacus `layoutConfig`, which included the non-recommended breakpoint-specific layout configuration for the page `header` which caused the layout shift on desktop when transitioning from SSR to CSR.

You can fix this in one of the two following ways:

Option 1 (if you're still using Spartacus version below Spartacus v2211.43) - overwrite the default config:

Override the `lg` property from the `header` layout configuration with `undefined` in your `spartacus-configuration.module.ts`, like in the example below:

```typescript
provideConfig({
  layoutSlots: {
    header: {
      lg: undefined,
    },
  },
});
```

Option 2 (if you upgraded to at least v2211.43): use the new default configuration in 2 steps:

First, replace the deprecated config `provideConfig(layoutConfig)` with the `provideConfigFactory(layoutConfigFactory)` in your `spartacus-configuration.module.ts` file, so it looks like this:

```typescript
import { provideConfigFactory } from '@spartacus/storefront';

providers: [
  /*...*/
  provideConfigFactory(layoutConfigFactory),
  // don't use `provideConfig(layoutConfig)` anymore
],
```

... and then enable the feature toggle `unifiedDefaultHeaderSlotsAcrossBreakpoints` in your `spartacus-features.module.ts` file, so it looks like this:

```typescript
provideFeatureToggles({
  /*...*/
  unifiedDefaultHeaderSlotsAcrossBreakpoints: true,
}),
```

## Example code snippet to extract width and height from the image filename or other CMS custom properties

```typescript
// TODO
```

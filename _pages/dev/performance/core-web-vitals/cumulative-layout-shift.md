# Cumulative Layout Shift (CLS)

Spartacus provides a set of features to keep good [Cumulative Layout Shift (CLS)](https://web.dev/articles/cls) Core Web Vital metric. The CLS metric measures how much the content on a page shifts around while the page is loading, which can lead to a poor user experience.

Below are the recommended practices to keep good Cumulative Layout Shift metric in Spartacus:

## Reserve space for images

To keep good Cumulative Layout Shift metric, you should ensure that all `<img>` elements have HTML attributes `width` and `height` set. This allows the browser to reserve the space for the image before it is downloaded and rendered, which helps to avoid layout shifts after the image is loaded.

In your custom components using Spartacus child component `<cx-media>`, you can set the `width` and `height` properties in the `Image` model passed to the `[container]` input of  `<cx-media>` (see the [source code](https://github.com/SAP/spartacus/blob/9d5489df04640c2a075a26db9072ad3d356d33db/projects/core/src/model/image.model.ts#L18-L33)). This is supported since Spartacus v2211.31 when the feature toggle `useExtendedMediaComponentConfiguration` is enabled.

For square images, like product images on Product Details Page and Product Listing Page, Spartacus automatically reserves space by setting CSS rules with `aspect-ratio: 1 / 1`.
This is supported since Spartacus v2211.43, when the feature toggle `reserveSpaceForImagesOnPdpAndPlp` is enabled.

### Pass with `width` and `height` properties to `<cx-media>` component

For components using the child component `<cx-media>`, you can set the `width` and `height` properties in the `Image` model passed to the `[container]` input of the `<cx-media [container]="...">` component. This is supported since Spartacus v2211.31, when the  feature toggle `useExtendedMediaComponentConfiguration` is enabled.

**CMS data caveat**: At the moment of writing, the OOTB Commerce CMS OCC backend does not return the `width` and `height` properties for Media model. However, you can augment the OCC backend response to send these properties with your custom backend customization, or by writing a custom logic in Spartacus data adapter/normalizer layer. For example you can extract the dimensions from the image filename (if the filename contains it, e.g. `someImage-800x600.jpg`) or from other CMS properties (e.g., description). The example code snippet for this workaround is presented in the section below [Appendix: Example code snippet to extract width and height from the image filename or other CMS custom properties](#Appendix-Example-code-snippet-to-extract-width-and-height-from-the-image-filename-or-other-CMS-custom-properties).

#### Using `<img>` element directly
For your custom components that don't use `<cx-media>`, component, but the native `<img>` HTML elements, you can set the native HTML attributes `width` and `height` on the `<img>` elements.

#### Responsive images need `width` and `height` just for  knowing the aspect ratio
The `width` and `height` attributes should be set to the intrinsic dimensions of the image. But the actual dimensions of the displayed image might be different, for example, if the image is resized by CSS, which is often the case in responsive designs (e.g. with CSS rules `img { width: 100%; height: auto; }`). In such cases, the browser still needs the HTML `width` and `height` attributes to calculate the aspect ratio. Without it, the browser would not know the space it should reserve for the flexibly-resized responsive image. 

Alternatively the aspect ratio can be defined explicitly with CSS rules (e.g. `img { aspect-ratio: 1 / 1; }`), if its know in advance (e.g. for square product images). For example Spartacus automatically reserves space for square product images on the Product Details Page and Product Listing Page since version v2211.43, when you enable the feature toggle `reserveSpaceForImagesOnPdpAndPlp` is enabled.

## Don't change the layout with JavaScript after the page has loaded

When you're using Spartacus Server-Side Rendering (which is recommended for various reasons, including a good Core Web Vital metric Largest Content Paint), then to avoid layout shifts, we should not change the DOM structure with JavaScript after the page has loaded. In particular it's not recommended to use the Spartacus Javascript-based `BreakpointService` to dynamically change the layout of the page. It's because first the Server-Side rendered page is displayed based on the rendered HTML and CSS, but the Javascript is loaded only after a delay and when it changes the layout, it can negatively impact the Cumulative Layout Shift metric.

Ideally the responsive layout should be controlled just with the static HTML and CSS, but not changed with lately-loaded Javascript.

### Why CSS rules are preferred over JavaScript for responsive layout
[Angular SSR native feature of inlining critical CSS](https://angular.dev/reference/configs/workspace-config#styles-optimization-options) is responsible for ensuring that the CSS is inlined in the `<head>` of the Server-Side rendered HTML and therefore it's applied by the browser immediately when loading the SSR HTML. Thanks to this, the visual layout is correct from the beginning user seeing the page. This is done automatically by Angular SSR and does not require any additional configuration in Spartacus.

### Recent Spartacus improvements to avoid layout shifts

#### Avoid header layout shift
Before v2211.43, Spartacus default layout of the header and top navigation on desktop viewport was shifted after the lately-loaded Javascript caused the layout to change. This issue is fixed since Spartacus v2211.43, when the feature toggle `unifiedDefaultHeaderSlotsAcrossBreakpoints` is enabled.

**Important**: Additionally, for apps created before v2211.43 you'll need to also change the deprecated `provideConfig(layoutConfig)` to `provideConfigFactory(layoutConfigFactory)` in your `spartacus-features.module.ts`. 

For more on this issue, read the section below [Appendix: Use the same Header layout configuration for all breakpoints](#Use-the-same-Header-layout-configuration-for-all-breakpoints).

### Use the improved product carousel implementation available since v2211.43
Before v2211.43, Spartacus used the `<cx-carousel>` component to display product carousels. This carousel implementation caused layout shifts when transitioning from Server-Side Rendered (SSR) HTML to Client-Side Rendered (CSR) HTML, as it changed the DOM structure after the JavaScript was loaded and executed on viewport breakpoints other than mobile. This issue is fixed since Spartacus v2211.43, when the feature toggle `productCarouselScrolling` is enabled.

When `productCarouselScrolling` is enabled, the improved carousel implementation `<cx-carousel-scrolling>` is used instead of the old `<cx-carousel>` as a child of the `ProductCarouselComponent` and `ProductReferencesComponent`.
The new carousel implementation, as opposed to the old one, does not change the DOM structure after transitioning from SSR to CSR, so it avoids layout shifts. As an added benefit, it is also more mobile-friendly thanks the swipe gestures allowing to continuously scroll the carousel items (instead of the previous need to click on the next/previous buttons to change slides).

### Why not use breakpoint-specific layout configurations in Spartacus
In your custom components it's not recommended to use the [Spartacus **breakpoint-specific** layout configurations](../../styling-and-page-layout/page-layout.md#choosing-an-adaptive-or-responsive-layout). The problem will happen when transitioning from the Server-Side Rendered (SSR) HTML to Client-Side Rendered (CSR) HTML, as it can cause layout shifts when the lately-loaded JavaScript is executed after a delay and the DOM is changed. In Spartacus, the SSR engine heuristics blindly assume the unknown client's viewport is _probably_ `mobile`, therefore it blindly assumes DOM structure for the `xs` layout configuration (without knowing the client's viewport). Unfortunately, when this heuristic is wrong, i.e. when the actual client's viewport is desktop, the lately-loaded Javascript switches the layout to the configured `lg` layout. This can cause a layout shift and can negatively impact the Cumulative Layout Shift metric. Instead, it's recommended to configure one unified Spartacus layout slots array for all breakpoints, so for both SSR and CSR it wil lbe the same, regardless of the viewport size. Ideally, the HTML should be the same for all breakpoints, but the responsive layout should be controlled just with CSS.

### Appendix: Use the same Header layout configuration for all breakpoints

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

## Appendix: Example code snippet to extract width and height from the image filename or other CMS custom properties

At the moment of writing, the OOTB Commerce CMS OCC backend does not return the `width` and `height` properties for Media model. However, you can augment the OCC backend response to send these properties with your custom backend customization, or by writing a custom logic in Spartacus data adapter/normalizer layer, like in the example below: 

```typescript
import { Injectable, Provider } from '@angular/core';
import {
  CmsBannerComponent,
  CmsBannerComponentMedia,
  CmsResponsiveBannerComponentMedia,
  CmsStructureModel,
  Occ,
  OccCmsPageNormalizer,
} from '@spartacus/core';

/**
 * This is a workaround to extract dimensions from a URL of a banner image, based on a filenames convention in our sample data
 * (yes it's a workaround! ideally dimensions should be defined in CMS!)
 */
@Injectable({ providedIn: 'root' })
export class CustomOccCmsPageNormalizer extends OccCmsPageNormalizer {
  override convert(
    source: Occ.CMSPage,
    target: CmsStructureModel = {}
  ): CmsStructureModel {
    let result = super.convert(source, target);

    result = this.populateBannerImagesDimensions(result);

    return result;
  }

  protected populateBannerImagesDimensions(
    result: CmsStructureModel
  ): CmsStructureModel {
    if (!result.components) {
      return result;
    }

    // Iterate through all components
    (result.components || []).forEach((component) => {
      // ignore components that are not banners
      if (
        !component.typeCode ||
        !['SimpleResponsiveBannerComponent', 'SimpleBannerComponent'].includes(
          component.typeCode
        )
      ) {
        return;
      }

      const copyDimensionsFromUrlToSeparateProperties = (
        media: CmsBannerComponentMedia
      ) => {
        if (media?.url) {
          const dimensions = this.extractDimensionsFromUrl(media.url);
          // Add dimensions to media object if found
          if (dimensions.width) {
            (media as any).width = dimensions.width; // although width is not defined in CMS, we add it here
          }
          if (dimensions.height) {
            (media as any).height = dimensions.height; // although height is not defined in CMS, we add it here
          }
        }
      };

      const bannerComponent = component as CmsBannerComponent;
      // Note:
      // - SimpleBannerComponent has "media" property with a single image
      // - SimpleResponsiveBannerComponent has "media" property with a object containing images
      //    for different media formats (in separate properties)

      if (!bannerComponent.media) {
        return;
      }
      if (bannerComponent.typeCode === 'SimpleBannerComponent') {
        copyDimensionsFromUrlToSeparateProperties(
          bannerComponent.media as CmsBannerComponentMedia
        );
      }
      if (bannerComponent.typeCode === 'SimpleResponsiveBannerComponent') {
        // Process each media format (mobile, tablet, desktop, widescreen)
        Object.values(
          bannerComponent.media as CmsResponsiveBannerComponentMedia
        ).forEach((media) => {
          copyDimensionsFromUrlToSeparateProperties(media);
        });
      }
    });

    return result;
  }

  /**
   * Extracts dimensions from a URL of a banner image, based on a filenames convention in our sample data
   * (yes it's a workaround! ideally dimensions should be defined in CMS!)
   */
  protected extractDimensionsFromUrl(url: string): {
    width?: number;
    height?: number;
  } {
    // Banner images in our sample data happen to follow the pattern `somename-WIDTHxHEIGHT-somename...`
    // so we can leverage it to extract the dimensions
    const pattern = /\/medias\/[^-]+-(\d+)x(\d+)-[^-]+/;
    const match = url.match(pattern);
    if (match) {
      const width = parseInt(match[1], 10);
      const height = parseInt(match[2], 10);
      return { width, height };
    } else {
      return {};
    }
  }
}

export const workaroundExtractBannerDimensionsFromUrl: Provider = {
  provide: OccCmsPageNormalizer,
  useExisting: CustomOccCmsPageNormalizer,
};
```

...and then you can register this custom provider e.g. in your app module:

```typescript
providers: [
  /*...*/
  workaroundExtractBannerDimensionsFromUrl,
],
```

## Enable Angular's native non-destructive hydration

Spartacus supports the [Angular's native non-destructive hydration](source: https://angular.dev/guide/hydration) feature since Spartacus v2211.43. It is enabled by default in fresh apps created with Spartacus v2211.43 or later. But existing apps created before v2211.43 need to enable it manually by adding the following native Angular provider to their `app.module.ts`:

```typescript
import {
  provideClientHydration,
  withEventReplay,
  withNoHttpTransferCache,
} from '@angular/platform-browser';

/*...*/

@NgModule({
  /*..,*/
  providers: [
    /*...*/
    provideClientHydration(
      withEventReplay(),
      withNoHttpTransferCache()
   ),
  ],
})
export class AppModule {}
```

### Comply with Angular non-destructive hydration constraints
Please note that for the Angular non-destructive hydration to work correctly, all components displayed on a Server-Side Rendered page must comply with the special [Angular non-destructive hydration constraints](https://angular.dev/guide/hydration#constraints). Spartacus OOTB components displayed on SSR pages are compliant with those constraints since v2211.43, but you need to review your custom components (especially those displayed on SSR pages) to ensure they are compliant too. Otherwise the Angular hydration will fail and those components might be not displayed correctly. For troubleshooting, you can check the browser console in dev mode for any Angular hydration errors.

## Don't use `pageFold` property in the Spartacus layout config

The `pageFold` property set in the Spartacus layout config can cause some components to be rendered only after a delay even in the SSR pages, which can lead to degrading the CLS (Cumulative Layout Shift) metric.

The `pageFold` property is not used in the OOTB Spartacus layout config since Spartacus v2211.43, when the feature toggle `unifiedDefaultHeaderSlotsAcrossBreakpoints` is enabled. Moreover, to make this feature toggle effective, you need to also change the deprecated `provideConfig(layoutConfig)` to `provideConfigFactory(layoutConfigFactory)` in your `spartacus-features.module.ts`.

Alternatively, if you're using Spartacus version before v2211.43, you can remove the `pageFold` property from your layout config by overriding the default Spartacus layout config in your app module, like in the example below:

```typescript
import { provideConfig } from '@spartacus/core';

/*...*/

providers: [
  /*...*/
  provideConfig({
    layoutSlots: {
      LandingPage2Template: {
        pageFold: undefined,
      },
      CategoryPageTemplate: {
        pageFold: undefined,
      },
      ProductDetailsPageTemplate: {
        pageFold: undefined,
        lg: {
          pageFold: undefined,
        }
      },
    },
  }),
],
```

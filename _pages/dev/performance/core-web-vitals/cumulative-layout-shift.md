---
title: Optimizing Cumulative Layout Shift in Spartacus
---

The Cumulative Layout Shift (CLS) metric is a Core Web Vitals metric that measures how much the content on a page moves around while the page is loading, which can lead to a poor user experience. Spartacus provides a set of features to achieve a good CLS metric.

For more general information on CLS, see [Cumulative Layout Shift (CLS)](https://web.dev/articles/cls) in the official Google web.dev documentation.

## Reserving Space for Images

To maintain a good CLS metric, ensure that all `<img>` elements have the `width` and `height` HTML attributes set. This allows the browser to reserve the space for the image before it is downloaded and rendered, which helps to avoid layout shifts after the image is loaded.

For components that use the `<cx-media>` child component, you can set the `width` and `height` properties in the `Image` model passed to the `[container]` input of the `<cx-media [container]="...">` component. This is supported starting in Spartacus 2211.31, when the `useExtendedMediaComponentConfiguration` feature toggle is enabled.

**Note**: Starting with SAP Commerce Cloud 2211.43, the back end does not return the `width` and `height` properties for the Media model. However, you can augment the OCC back-end response to send these properties through customization of the back end, or by writing custom logic in the Spartacus data adapter or normalizer layer. For example, if the image filename contains the dimensions (such as `someImage-800x600.jpg`), you can extract the dimensions from the image filename, or you can extract this information from some other CMS property, such as the description. For an example code snippet of this workaround, see [Extracting Width and Height From the Image Filename or Other CMS Custom Properties](#extracting-width-and-height-from-the-image-filename-or-other-cms-custom-properties).

For your custom components that use the `<cx-media>` child component, you can set the `width` and `height` properties in the `Image` model passed to the `[container]` input of  `<cx-media>`. For more information, see the [source code](https://github.com/SAP/spartacus/blob/9d5489df04640c2a075a26db9072ad3d356d33db/projects/core/src/model/image.model.ts#L18-L33). This is supported starting in Spartacus 2211.31, when the `useExtendedMediaComponentConfiguration` feature toggle is enabled.

For your custom components that use the HTML `<img>` element rather than the `<cx-media>` component, you can set the native HTML `width` and `height` attributes on the `<img>` elements. Set the `width` and `height` attributes to the intrinsic dimensions of the image. The actual dimensions of the displayed image might be different if, for example, the image is resized by CSS. This is often the case in responsive designs, such as with CSS rules `img { width: 100%; height: auto; }`. In such cases, the browser still needs the `width` and `height` attributes to calculate the aspect ratio. Without them, the browser does not know how much space it should reserve for the flexibly-resized responsive image.

Alternatively, you can explicitly define the aspect ratio with CSS rules, such as `img { aspect-ratio: 1 / 1; }`, for example, for square product images. Starting in version 2211.43, Spartacus automatically reserves space for square product images on the Product Details Page and the Product Listing Page when you enable the `reserveSpaceForImagesOnPdpAndPlp` feature toggle.

## Avoiding Layout Shifts with SSR

To avoid layout shifts when using server-side rendering (SSR) in Spartacus, the DOM structure should not be modified by JavaScript after the page has loaded. In particular, Spartacus does not recommended using the Spartacus JavaScript-based `BreakpointService` to dynamically change the layout of the page. The server-side rendered page is displayed first, based on the rendered HTML and CSS, but the JavaScript is only loaded after a delay. When the layout changes, it negatively impacts the CLS metric.

Ideally, the responsive layout should be controlled just with static HTML and CSS, and should not change with JavaScript that is loaded later on.

The [Angular SSR native feature for inlining critical CSS](https://angular.dev/reference/configs/workspace-config#styles-optimization-options) is responsible for ensuring that the CSS is inlined in the `<head>` of the server-side rendered HTML, and therefore applied by the browser immediately when loading the SSR HTML. As a result, the visual layout is correct from the moment the user first sees the page. This is done automatically by Angular SSR and does not require any additional configuration in Spartacus.

### Avoiding Header Layout Shifts

Before Spartacus 2211.43, in the desktop viewport, the default layout of the header and top navigation would shift because the JavaScript would load after other visual elements had loaded, and cause the layout to change. This issue is resolved starting in Spartacus 2211.43 when you enable the `unifiedDefaultHeaderSlotsAcrossBreakpoints` feature toggle.

**Note**: For apps created before Spartacus 2211.43, you need to change the deprecated `provideConfig(layoutConfig)` to `provideConfigFactory(layoutConfigFactory)` in your `spartacus-features.module.ts`.

For more on this issue, see the [Layout Configurations](#Layout-Configurations) section, below.

### Using the Improved Product Carousel Implementation

Before Spartacus 2211.43, the `<cx-carousel>` component was used to display product carousels. This carousel implementation caused layout shifts when transitioning from server-side rendered HTML to client-side rendered HTML, because it changed the DOM structure after the JavaScript was loaded and run in viewport breakpoints other than `mobile`. This issue is resolved starting in Spartacus 2211.43, when you enable the `productCarouselScrolling` feature toggle.

When the `productCarouselScrolling` feature toggle is enabled, the improved `<cx-carousel-scrolling>` carousel implementation is used, instead of `<cx-carousel>`, as a child of the `ProductCarouselComponent` and the `ProductReferencesComponent`. The `<cx-carousel-scrolling>` implementation does not change the DOM structure after transitioning from SSR to CSR, so it avoids layout shifts. As an added benefit, it is also more mobile-friendly due to the swiping gesture that allows users to continuously scroll through carousel items, instead of the previous need to click the Next and Previous buttons to change slides.

### Layout Configurations

It is no longer recommended to use breakpoint-specific layout configurations in your custom components. When transitioning from server-side rendered HTML to client-side rendered HTML, layout shifts can occur when JavaScript loads and runs after a delay, and the DOM is changed. In Spartacus, the SSR engine heuristics assume the unknown client's viewport is `mobile`. Therefore, it loads the DOM structure for the `xs` layout configuration without knowing the client's actual viewport. Unfortunately, when this heuristic is wrong, such as when the client's actual viewport is desktop, JavaScript that is loaded later will switch the layout to the configured `lg` layout. This can cause a layout shift and can negatively impact the CLS metric. Instead, configure one unified array for Spartacus layout slots for all breakpoints, and this should be the same for both SSR and CSR, regardless of the viewport size. Ideally, the HTML should be the same for all breakpoints, but the responsive layout should be controlled just with CSS.

For more information on breakpoint-specific layout configurations in Spartacus, see (../../styling-and-page-layout/page-layout.md#choosing-an-adaptive-or-responsive-layout).

If you created your storefront before Spartacus 2211.43, your `spartacus-configuration.module.ts` likely contains the deprecated default Spartacus `layoutConfig`. The deprecated `layoutConfig` included the non-recommended breakpoint-specific layout configuration for the page `header`, which caused the layout shift on desktop when transitioning from SSR to CSR.

You can fix this in one of the two following ways.

**Option 1:** If you are still using a Spartacus app below version 2211.43, overwrite the default configuration.

Override the `lg` property from the `header` layout configuration with `undefined` in your `spartacus-configuration.module.ts`, as shown in the following example:

```typescript
provideConfig({
  layoutSlots: {
    header: {
      lg: undefined,
    },
  },
});
```

**Option 2:** If you have upgraded your Spartacus app to version 2211.43 or newer, use the new default configuration, as follows:

First, replace the deprecated configuration `provideConfig(layoutConfig)` with the `provideConfigFactory(layoutConfigFactory)` in your `spartacus-configuration.module.ts` file, as shown in the following example:

```typescript
import { provideConfigFactory } from '@spartacus/storefront';

providers: [
  /*...*/
  provideConfigFactory(layoutConfigFactory),
  // don't use `provideConfig(layoutConfig)` anymore
],
```

Then, enable the `unifiedDefaultHeaderSlotsAcrossBreakpoints` feature toggle in your `spartacus-features.module.ts` file, as shown in the following example:

```typescript
provideFeatureToggles({
  /*...*/
  unifiedDefaultHeaderSlotsAcrossBreakpoints: true,
}),
```

## Extracting Width and Height From the Image Filename or Other Custom CMS Properties

Starting with SAP Commerce Cloud 2211.43, the back end does not return the `width` and `height` properties for the Media model. However, you can augment the OCC back-end response to send these properties through customization of the back end, or by writing custom logic in the Spartacus data adapter or normalizer layer. The following is an example:

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
 * This is a workaround to extract dimensions from the URL of a banner image, based on a filename convention in our sample data
 * (Yes, it's a workaround! Ideally, dimensions should be defined in CMS!)
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
      // - SimpleResponsiveBannerComponent has "media" property with an object containing images
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
   * Extract dimensions from the URL of a banner image, based on a filename convention in our sample data
   * (Yes, it's a workaround! Ideally, dimensions should be defined in CMS!)
   */
  protected extractDimensionsFromUrl(url: string): {
    width?: number;
    height?: number;
  } {
    // Banner images in our sample data happen to follow the pattern `somename-WIDTHxHEIGHT-somename...`
    // so we can leverage this to extract the dimensions
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

You can the register this custom provider in your app module (for example), as follows:

```typescript
providers: [
  /*...*/
  workaroundExtractBannerDimensionsFromUrl,
],
```

## Enabling Angular Native Non-Destructive Hydration

Starting in version 2211.43, Spartacus supports [Angular native non-destructive hydration](https://angular.dev/guide/hydration). This feature is enabled by default when you create a new storefront app using version 2211.43 libraries or newer. For existing apps created before Spartacus 2211.43, you need to enable this feature manually by adding the following native Angular provider to your `app.module.ts`:

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

For Angular non-destructive hydration to work, all components displayed on a server-side rendered page must comply with the special [Angular non-destructive hydration constraints](https://angular.dev/guide/hydration#constraints). Out-of-the-box Spartacus components displayed on SSR pages are compliant with those constraints starting in Spartacus 2211.43. However, you need to review your custom components, especially those displayed on SSR pages, to ensure they are compliant as well. Otherwise, Angular hydration will fail, and those components might not display correctly. For troubleshooting, you can check the browser console in developer mode for any Angular hydration errors.

## The pageFold Property in Spartacus Layout Configurations

The `pageFold` property that is set in the Spartacus layout configuration can cause some components to be rendered only after a delay, even in server-side rendered pages, which can degrade the CLS metric.

Starting in Spartacus 2211.43, the `pageFold` property is not used in the default Spartacus layout configuration when the `unifiedDefaultHeaderSlotsAcrossBreakpoints` feature toggle is enabled. To make this feature toggle effective, you also need to change the deprecated `provideConfig(layoutConfig)` to `provideConfigFactory(layoutConfigFactory)` in your `spartacus-features.module.ts`.

Alternatively, if you're using a Spartacus app older than than 2211.43, you can remove the `pageFold` property from your layout configuration by overriding the default Spartacus layout configuration in your app module. The following is an example:

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

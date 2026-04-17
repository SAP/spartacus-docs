---
title: Media Component
feature:
- name: Media Component
  spa_version: 2.0
  cx_version: n/a
- name: Image Lazy Loading
  spa_version: 3.0
  cx_version: n/a
  anchor: "#image-lazy-loading"
---

{% capture version_note %}
{{ site.version_note_part1 }} 2.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The media component is a low-level component that is used to render a single media item. Although the back end could provide any type of media for a media item, the media component is currently limited to render images only. The type of image is not limited to a technical format, such as `png` or `jpg`. Every image format that can be rendered in an image element is supported, including `svg`. The media component renders specific images for different screen sizes and resolutions, so that each user has an optimized version of the image.

There are two main types of images that are rendered in Spartacus: product images and content images. Both types use the same technical implementation, but the semantics of the content is slightly different for each.

**Note:** Icons are a special type of image and are not rendered with the media component. For more information, see [{% assign linkedpage = site.pages | where: "name", "icon-library.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/styling-and-page-layout/icon-library.md %}).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
  {:toc}

***

## Responsive Media

The image structure that is used in SAP Commerce Cloud consists of a media container that holds multiple media items. The media items inside a container are distinguished by a media format. The media format is used to provide the same media for various different screen sizes or placements.

The media formats for product images and for content images are different, and their use also differs.

### Product Images

Product images are driven by product data. Product images are used in a large number of components, such as in the product listing and product details pages, as well as in components that are used for cart and order data, and also in components such as carousels, wish lists, interests, and so on. However, the product image data source is always the same, regardless of the component.

Different product images for different screen sizes are typically generated based on the same source image. This results in a media container that holds a number of media items that only differ in pixel size, but are equal in terms of content and proportions.

The media formats for product images can be configured in both the back end and the front end. The following list shows the (default) formats that are used in the sample data and in the Spartacus configuration:

- cartIcon
- thumbnail
- product
- zoom

### Content Images

Content images are driven by CMS component data. Media items are used in different banner components. Unlike product images, banner images are often manually optimized for various screen sizes. This means that a content manager uploads alternative images to the banner for each media format. The technical structure is the same for product and banner media, but the formats are different. The following list shows the (default) formats that are used in the sample data and in the Spartacus configuration:

- mobile
- tablet
- desktop
- widescreen

For more information, see [{% assign linkedpage = site.pages | where: "name", "banner-component.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/components/banner-component.md %}).

## Localized Media

SAP Commerce Cloud supports localized media, which means that different media items can be used for different languages. This is sometimes used for content images that contain localized text.

Localized media works transparently for the media component. Whenever the site context changes in Spartacus (including for languages), the CMS and product data are cleared from the state, which results in a reload of the data for the given context.

## Implementation Details for Spartacus 2211.31 and newer

**Note:** This section applies to new installations of Spartacus version 2211.31 and newer, as well as to Spartacus apps that have been upgraded to version 2211.31 or newer and have also activated the `useExtendedMediaComponentConfiguration` feature toggle. If you have upgraded to 2211.31 or newer and wish to enable the new behavior and functionality related to `<img>` and `<picture>` tags, see [Activating Use Extended Media Component Configuration](link provided after conversion to xml).

Starting with Spartacus 2211.31, the media component provides you with better control of image rendering, improved performance metrics, and also allows you to optimize for different device viewports. In version 2211.31 and newer, the media component supports the following features:

- Flexibility in rendering that allows you to switch between `<img>` and `<picture>` elements based on your requirements.
- Manual width and height attributes to improve page performance and Core Web Vitals.
- Support for the `sizes` attribute, which allows you to fine-tune the image display based on media conditions, such as screen width.
- Configurable `<picture>` formats that allow you to define format-specific media queries, as well as the order of formats for optimal image delivery.

The following sections describe these features in further detail.

### Flexible Support for `<picture>` and `<img>` HTML Elements

By default, the media component renders `<img>` elements. The only exception is for banner components, which continue to use the `<picture>` element by default.

If you wish to use the `<picture>` element instead of the `<img>` element, you can pass `[elementType]="'picture'"` as an input to the media component.

The following is an example of how to use the `<picture>` element in the media component:

```html
<cx-media [elementType]="'picture'"></cx-media>
```

If the image container only contains a single image, `cx-media` automatically renders an `<img>` element.

### Configuring Manual Width and Height Attributes for Images

You can manually set the width and height attributes for images to improve page performance and Core Web Vitals. To do this, extend the image object with `width` and `height` properties, as shown in the following example:

```ts
export interface Image {
  altText?: string;
  role?: string;
  format?: string;
  galleryIndex?: number;
  imageType?: ImageType;
  url?: string;
  width?: number; // Allows manual width setting
  height?: number; // Allows manual height setting
}
```

### Configuring the `sizes` Attribute for `<img>` Elements

You can specify the `sizes` attribute for `<img>` elements using the `sizesForImgElement` input. The `<sizes>` attribute allows you to define media conditions, such as screen widths, and also allows you to suggest optimal image sizes.

The following is an example:

```html
<cx-media
  [container]="getImage(data)"
  [sizesForImgElement]="'(max-width: 600px) 480px, 800px'"
></cx-media>
```

The above configuration renders the following HTML:

```html
<img
  srcset="test.jpg 480w, test-800w.jpg 800w"
  sizes="(max-width: 600px) 480px, 800px"
  src="test-800w.jpg"
/>
```

### Configuring the Formats and Order of the `<picture>` Element

You can define format-specific media queries and also define the order of formats for the `<picture>` element.

This is done with the `pictureElementFormats` and `pictureFormatsOrder` configuration properties, as shown in the following example:

```ts
media?: {
  pictureElementFormats?: {
    [format: string]: {
      mediaQueries?: string;
    };
  };
  pictureFormatsOrder?: string[];
}
```

The `pictureElementFormats` property allows you to define media queries for each format. You must also specify the order of the formats because the browser processes `<source>` elements in the order that you specify them. The `pictureFormatsOrder` property specifies the order of the `<source>` elements inside the `<picture>` tag.

The following is an example:

```ts
media: {
  pictureElementFormats: {
    mobile: {
      mediaQueries: '(max-width: 480px)',
    },
    tablet: {
      mediaQueries: '(max-width: 770px)',
    },
    desktop: {
      mediaQueries: '(max-width: 960px)',
    },
    widescreen: {
      mediaQueries: '(min-width: 961px)',
    },
  },
  pictureFormatsOrder: ['mobile', 'tablet', 'desktop', 'widescreen'],
}
```

This above configuration renders the following HTML:

```html
<picture>
  <source
    media="(max-width: 480px)"
    srcset="
      https://composable-storefront-demo.eastus.cloudapp.azure.com:8443/medias/Elec-480x320-HomeSpeed-EN-01-480W.jpg
    "
  />
  <source
    media="(max-width: 770px)"
    srcset="
      https://composable-storefront-demo.eastus.cloudapp.azure.com:8443/medias/Elec-770x350-HomeSpeed-EN-01-770W.jpg
    "
  />
  <source
    media="(max-width: 960px)"
    srcset="
      https://composable-storefront-demo.eastus.cloudapp.azure.com:8443/medias/Elec-960x330-HomeSpeed-EN-01-960W.jpg
    "
  />
  <source
    media="(min-width: 961px)"
    srcset="
      https://composable-storefront-demo.eastus.cloudapp.azure.com:8443/medias/Elec-1400x440-HomeSpeed-EN-01-1400W.jpg
    "
  />
  <img
    loading="null"
    alt="Save Big On Select SLR DSLR Cameras"
    title="Save Big On Select SLR DSLR Cameras"
    src="https://composable-storefront-demo.eastus.cloudapp.azure.com:8443/medias/Elec-1400x440-HomeSpeed-EN-01-1400W.jpg"
  />
</picture>
```

### Rending Responsive Images Within the `<img>` Tag

You can render responsive images within the `<img>` HTML tag by defining the formats within the `mediaConfig` configuration object.

The following is an example of the default config:

```ts
export const mediaConfig: MediaConfig = {
  mediaFormats: {
    // banner formats
    mobile: { width: 400 },
    tablet: { width: 1070 },
    desktop: { width: 1140 },
    widescreen: { width: 1400 },
    // product formats
    cartIcon: { width: 65 },
    thumbnail: { width: 96 },
    product: { width: 284 },
    zoom: { width: 515 },
  },
};
```

**Note:** These are separate configuration objects. The `pictureElementFormats` property is used to define formats with media queries for the `<picture>` HTML tag, while `mediaConfig` is used to define formats with width descriptors for the `<img>` HTML tag.

## Implementation Details for Spartacus 2211.29 and older

**Note:** This section applies to Spartacus version 2211.29 and older, as well as to Spartacus apps that have been upgraded to version 2211.31 or newer but have not activated the `useExtendedMediaComponentConfiguration` feature toggle. If you have upgraded to 2211.31 or newer and wish to enable the new behavior and functionality related to `<img>` and `<picture>` tags, see [Activating Use Extended Media Component Configuration](link provided after conversion to xml).

The `cx-media` media component renders images with the native `picture` HTML element. To support an optimized image for the given element, a container with multiple images is expected. The various images in the container are evaluated by their media format and compared to a media format configuration in Spartacus.

The `picture` element allows the specification of multiple image sources within nested source elements, facilitating precise control over which image is displayed, based on the browser's current conditions.

While the `picture` element offers extensive customization for image selection based on various factors, it maintains compatibility by including an `img` element as a fallback. This ensures that an image is displayed even in scenarios where no source elements match, or if the browser does not support the `picture` element.

The mapping from an image format to the `srcset` width descriptor is driven by the media configuration in Spartacus. The main image `src` and the various image descriptions for the `srcset` are collected by the `MediaService`. This service compares the images from the media container with a configuration set of media formats and their sizes. The matching sizes are collected and sorted, and the `srcset` is generated for the `picture` element, so that the browser can select and download the correct image.

You can provide a custom configuration using the `MediaConfig` typing. The following is an example of the default media configuration:

```ts
export const mediaConfig: MediaConfig = {
  mediaFormats: {
    // banner formats
    mobile: { width: 400 },
    tablet: { width: 1070 },
    desktop: { width: 1140 },
    widescreen: { width: 1400 },
    // product formats
    cartIcon: { width: 65 },
    thumbnail: { width: 96 },
    product: { width: 284 },
    zoom: { width: 515 },
  },
};
```

## Using the Img Element Instead of the Picture Element

**Note:** This section applies to Spartacus version 2211.29 and older, as well as to Spartacus apps that have been upgraded to version 2211.31 or newer but have not activated the `useExtendedMediaComponentConfiguration` feature toggle. If you have upgraded to 2211.31 or newer and wish to enable the new behavior and functionality related to `<img>` and `<picture>` tags, see [Activating Use Extended Media Component Configuration](link provided after conversion to xml).

To enable the legacy approach of using `<img>` tags by default, you need to provide `MediaConfig` in the `SpartacusConfigurationModule`, and set `useLegacyMediaComponent` to `true`. The following is an example:

```ts
provideConfig(<MediaConfig>{
  useLegacyMediaComponent: true,
});
```

**Note:** Starting with Spartacus 2211.31, the `USE_LEGACY_MEDIA_COMPONENT` token and `useLegacyMediaComponent` are deprecated.

## Missing Media

Whenever a media item is unavailable, the `img` element is not written in the DOM. The `cx-media` host element will get an `is-missing` class, so that the correct style can be applied by CSS. In this scenario, Spartacus provides an empty image through the background image.

If no matching image format is available in the media container, nor in the media configuration, Spartacus takes a random image from the container. This might not be an accurate format, but at least it helps to show content.

## Image Lazy Loading

{% capture version_note %}
{{ site.version_note_part1 }} 3.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Images can be created with a lazy loading strategy, as follows:

```html
<img src="..." loading="lazy" />
```

This lazy loading strategy is a relatively new browser capability that was [adopted recently in various browsers](https://caniuse.com/loading-lazy-attr). The lazy loading strategy is used to defer the loading of the image if it is not in the viewport. When the user scrolls down the page, the image is loaded automatically.

While Spartacus offers more advanced techniques to lazy load full portions of the page, using deferred loading and above-the-fold loading, these techniques do not apply to a server-Side rendered page. In this case, users who access the storefront for the first time will not benefit from the deferred loading technique, so all page content is loaded at once. This is where image lazy loading provides an additional performance improvement.

The lazy loading strategy is not enabled by default, but can be configured using the following configuration:

```ts
provideConfig({
  imageLoadingStrategy: ImageLoadingStrategy.LAZY,
} as MediaConfig);
```

For more information, see [{% assign linkedpage = site.pages | where: "name", "deferred-loading.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/performance/deferred-loading.md %}) and [{% assign linkedpage = site.pages | where: "name", "above-the-fold.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/performance/above-the-fold.md %}).

**Note:** When SSR is enabled, image lazy loading does not always work on initial page load. This only affects certain browsers, and is fixed in composable storefront version 2211.23.

## SEO

To ensure that crawlers get an optimized image from the `img` element, the main `src` of the `img` element is provided with the largest image available. This is done in `MediaService.resolveBestFormat()`, and you can further customize this behavior if needed.

Note that the actual image for the page is not driven by the `img` element, because crawlers will use other sources to indicate the image. Spartacus supports both page meta tags (for example, `'og:image'`) and structural data (`json-ld`) to provide that data to crawlers. For more information, see [{% assign linkedpage = site.pages | where: "name", "html-tags.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/seo/html-tags.md %}) and [{% assign linkedpage = site.pages | where: "name", "structured-data.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/seo/structured-data.md %}).

Another important aspect for SEO is the usage of the alternative (`alt`) text for images. The `alt` text is automatically selected by the `MediaService` if it is available in the media container data. However, you can also input a custom `alt` text through the component input.

## Configuring the Media Base URL and Media Prefix

In the `projects/core/src/occ/config/occ-config.ts` file, the `BackendConfig` interface defines extension points that allow customers to configure the backend connection settings for OCC API calls, as well as how media asset loading behaves within Spartacus.

Starting with Spartacus version 221121.10, you can configure the `media.baseUrl` and the `media.prefix` to control how media asset loading works in Spartacus, as described in the following table:

| Property | Description | Default value | Feature Flag |
| --- | --- | --- | --- |
| `media.baseUrl` | Separate base URL for media assets | `occ.baseUrl` or `''` (if `occ.baseUrl` is not defined) | None |
| `media.prefix` | Path prefix for media URLs | `''` | `enableMediaPrefix` |

**Note:** If you have upgraded your storefront to version 221121.10, to use the `media.prefix` property, you need to ensure the `enableMediaPrefix` is set to `true` in your `spartacus-features.module.ts` file. For newly installed storefront apps that are version 221121.10 or newer, this feature toggle is already enabled. For more information, see [Activating Enable Media Prefix](link-to-be-added-after-conversion-to-doc-tool).

The following is an example of how you can configure these media properties:

```ts
provideConfig({
  backend: {
    // ...
    media: {
      baseUrl: "https://cdn.example.com", // Optional separate media host
      prefix: "/media", // Optional media path prefix (appended to the media.backendUrl)
    },
  },
});
```

With the configuration shown above, Spartacus tries to resolve any media (which is defined using the relative path within the CMS or the application code) by prepending it with `https://cdn.example.com/media`. In other words, if the media path in Backoffice is defined as `/HeroBanner-1-widescreen-en.jpg`, then in Spartacus, the `MediaService` resolves the media path to `https://cdn.example.com/media/HeroBanner-1-widescreen-en.jpg`.

### Using Environment Variables for Media Configuration

In the `projects/storefrontapp/src/environments/models/environment.model.ts`, the `Environment` interface defines two optional properties for controlling the media configuration properties, as follows:

- `mediaBaseUrl` sets the media base URL value, and maps to the `media.baseUrl` backend config.
- `mediaApiPrefix` appends a prefix to the base URL, and maps to the `media.prefix` backend config.

If both of these properties are `undefined`, the media resolution falls back to the `occBaseUrl` value.

The following is an example of how you can configure these properties:

```ts
export const environment: Environment = {
  occBaseUrl: "https://api.example.com",
  occApiPrefix: "/occ/v2/",
  mediaBaseUrl: "https://cdn.example.com", // Optional CDN for media
  mediaApiPrefix: "/media", // Optional media path
  // ...
};
```

**Note:** As described above for the `media.prefix`, to use the `mediaApiPrefix`, you need to ensure that the `enableMediaPrefix` feature toggle is set to `true` in your `spartacus-features.module.ts` file.

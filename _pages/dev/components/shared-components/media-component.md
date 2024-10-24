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

## Implementation Details

The `cx-media` media component renders images with the native `picture` HTML element. To support an optimized image for the given element, a container with multiple images is expected. The various images in the container are evaluated by their media format and compared to a media format configuration in Spartacus.

The `picture` element allows the specification of multiple image sources within nested source elements, facilitating precise control over which image is displayed, based on the browser's current conditions.

The `srcset`  attribute enables the browser to choose from multiple image resolutions and sizes, ensuring that the best fitting image is selected for the user's device, leading to faster load times and improved visual quality. While the `picture` element offers extensive customization for image selection based on various factors, it maintains compatibility by including an `img` element as a fallback. This ensures that an image is displayed even in scenarios where no source elements match, or if the browser does not support the `picture` element. With this approach, you do not need to provide a specific format for the media component, although you can do this with the format input.

The `srcset`  attribute also supports the pixel density descriptor, but it is (currently) not supported in Spartacus. The pixel density descriptor can be used to select different images for different devices. For example, an image width descriptor of 400 px might be rendered on retina devices at a maximum of 200 px, because these devices double the pixels to provide an optimized image resolution for their device screens.

The mapping from an image format to the `srcset` width descriptor is driven by the media configuration in Spartacus. The main image `src` and the various image descriptions for the `srcset`  are collected by the `MediaService`. This service compares the images from the media container with a configuration set of media formats and their sizes. The matching sizes are collected and sorted, and the `srcset` is generated for the `picture` element, so that the browser can select and download the correct image.

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

To enable the legacy approach of using `<img>` tags by default, you need to provide `MediaConfig` in the `SpartacusConfigurationModule`, and set `useLegacyMediaComponent` to `true`. The following is an example:

```ts
provideConfig(<MediaConfig>{
    useLegacyMediaComponent: true,
})
```

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
<img src="..." loading="lazy">
```

This lazy loading strategy is a relatively new browser capability that was [adopted recently in various browsers](https://caniuse.com/loading-lazy-attr). The lazy loading strategy is used to defer the loading of the image if it is not in the viewport. When the user scrolls down the page, the image is loaded automatically.

While Spartacus offers more advanced techniques to lazy load full portions of the page, using deferred loading and above-the-fold loading, these techniques do not apply to a server-Side rendered page. In this case, users who access the storefront for the first time will not benefit from the deferred loading technique, so all page content is loaded at once. This is where image lazy loading provides an additional performance improvement.

The lazy loading strategy is not enabled by default, but can be configured using the following configuration:

```ts
provideConfig({
  imageLoadingStrategy: ImageLoadingStrategy.LAZY
} as MediaConfig)
```

For more information, see [{% assign linkedpage = site.pages | where: "name", "deferred-loading.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/performance/deferred-loading.md %}) and [{% assign linkedpage = site.pages | where: "name", "above-the-fold.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/performance/above-the-fold.md %}).

**Note:** When SSR is enabled, image lazy loading does not always work on initial page load. This only affects certain browsers, and is fixed in composable storefront version 2211.23.

## SEO

To ensure that crawlers get an optimized image from the `img` element, the main `src` of the `img` element is provided with the largest image available. This is done in `MediaService.resolveBestFormat()`, and you can further customize this behavior if needed.

Note that the actual image for the page is not driven by the `img` element, because crawlers will use other sources to indicate the image. Spartacus supports both page meta tags (for example, `'og:image'`) and structural data (`json-ld`) to provide that data to crawlers. For more information, see [{% assign linkedpage = site.pages | where: "name", "html-tags.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/seo/html-tags.md %}) and [{% assign linkedpage = site.pages | where: "name", "structured-data.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/seo/structured-data.md %}).

Another important aspect for SEO is the usage of the alternative (`alt`) text for images. The `alt` text is automatically selected by the `MediaService` if it is available in the media container data. However, you can also input a custom `alt` text through the component input.

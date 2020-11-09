---
title: Media Component
feature:
- name: Media Component
  spa_version: 2.0
  cx_version: n/a
---

The media component is a low-level component that is used to render a single media. While media can be considered of any type, including image, video, PDF, etc, the media component renders current only images.
The media component renders specific images for different screen sizes and resolutions, so that each end user has an optimized version of the image.

There are two main types of images being rendered in Spartacus, product images and content images. They use the same technical implementation, but the semantics of the content is slightly different.

Icons are a special type of "images" and are not rendered with the media component, you can read more about icons in the [Icon Library documentation]({{ site.baseurl }}{% link _pages/dev/styling-and-page-layout/icon-library.md %}).

## Responsive Media

The image structure that is used in the commerce backend exists of a media container that contains multiple media. The media inside a container are distinguished by a media _format_. The media format is used to provide the same media for various screen sizes.

The media formats for product images and content images are different and their use also differs.

### Product images

Product images are driven by product data. Product images are used in a large number of components, not only in the product listing and detail page, but also in components used for cart and order data as well as components like carousels, wishlists, interest, etc. The product image data source is however always the same, regardless of the component.

Different product images for different screen sizes are typically generated based on the same master image. This results in a media container that holds a number of media that only differ in pixel size, but are equal from content and proportions.

The media formats for product images are configurable in both the backend and front-end. The following list shows the (default) formats that are used in sample data and Spartacus configuration:

- cartIcon
- thumbnail
- product
- zoom

### Content images

Content images are driven by CMS component data. Media are used in different banner components. Unlike product images, banner images are often manually optimized for various screen sizes. This means that a content manager uploads alternative images per media format to the banner. The technical structure is the same for product and banner media, however, the formats are different. The following list shows the (default) formats that are used in sample data and Spartacus configuration:

- mobile
- tablet
- desktop
- widescreen

## Localized Media

The backend supports localized media, which means that different media can be used for different languages. This is sometimes used for content images, that contain localized text.

Localized media work transparent for the media component. Whenever the size context (including languages) changes in Spartacus, cms and product data is cleared from the state, which will result in a reload of the data for the given context.

## Implementation Details

The media component (`cx-media`) renders an images with the native `img` html element. To support an optimized image for the given element, a container with multiple images is expected. The various images in the container are evaluated by their media format and compared to a media format configuration in Spartacus.

The native `img` element supports multiple images with the `srcset` attribute. This attribute takes various image sources and combines them with an associated _width descriptor_ . The browser will select and download the right image based on the used dimensions of the img element. With this approach, you do not need to provide a specific format for the media component, although you can do this with the `format` input.

The `srcset` also supports the _pixel density descriptor_, but it is (currently) not supported in Spartacus. This _pixel density descriptor_ can be used to select different images for different devices. For example, an image width descriptor of 400px, might be rendered on retina devices on maximum 200px, since the device will double the pixel to provide an optimized image resolution for the device screen.

The mapping from an image format to the `srcset` _width descriptor_ is driven by the media configuration in Spartacus. The given media container

The main image src and the various image descriptions for the `srcset` are collected by the `MediaService`. This services compares the images from the media container with a configuration set of media format and their size. Whenever a matching format is found, the size is written into the width descriptor.

You can provide a custom configuration using the `MediaConfig` typing. The default media configuration is given below:

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

## Missing media

Whenever a media is unavailable, the `img` element is not written in the DOM. The `cx-media` host element will get a `is-missing` class, so that a the right style can be applied by CSS. Spartacus will provide an empty image through the background-image in such a case.

If there's no matching image format available in the media container or the media configuration, Spartacus will take a random image from the container. This might not be an accurate format, but will help to at least show content.

## SEO

To ensure that crawlers will get an optimized image from the `img` element, the main `src` of the `img` element is provided with the
largest image available. This is done in the `MediaService.resolveBestFormat()` and you can further customize this behavior if needed.

Also note, that the actual image for the page is not driven by the `img` element, as crawlers will use other sources to indicate the image. Spartacus supports both page meta tag (i.e. `'og:image'`) and structural data (json-ld) to provide that data to crawlers.

Another important aspect for SEO is the usage of the alternative (`alt`) text for images. The `alt` text is automatically selected by the `MediaService` if available in the media container data. You can however also input a custom `alt` text through the component input.

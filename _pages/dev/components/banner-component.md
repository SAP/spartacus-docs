---
title: Banner Component
---

The banner component is used to render a media item in a given page slot. The media item can be optimized for the given slot size. The banner is typically used to link to another internal or external page.

## CMS Component Binding

There are multiple banner component types in the CMS, as follows:

- `BannerComponent`
- `SimpleBannerComponent`
- `SimpleResponsiveBannerComponent`

There is also a `RotatingImagesComponent`, which renders one or multiple instances of `BannerComponent` in a carousel.

The different banner component types have been created for historical reasons, but there is not much to distinguish them anymore: in Spartacus, there is only component implementation for banners. Spartacus always renders banners using adaptive and responsive features to render the optimal image for the given device.

The CMS banner component is mapped to the Spartacus implementation as follows:

```typescript
<CmsConfig>{
  SimpleResponsiveBannerComponent: {
    component: BannerComponent,
  },
  BannerComponent: {
    component: BannerComponent,
  },
  SimpleBannerComponent: {
    component: BannerComponent,
  },
};
```

You can use this component mapping to configure an alternative banner implementation. For example, you might need to map all CMS banner component types if multiple types are used in your project.

## Adaptive and Responsive Images

The banner component supports both responsive images and adaptive images. Responsive images are simply driven by CSS rules, which allow you to reuse the same images across different devices and screen sizes. Adaptive images can be used simultaneously, and are driven by the images provided by the back end. The back end provides different media items according to the media format. The `cx-media` component adds the different formats in a `srcset` so that the browser can decide when to use which image. Media items are rendered in the `cx-media` component. For more information, see [Media Component]({{ site.baseurl }}{% link _pages/dev/components/shared-components/media-component.md %}).

## Component Data

The banner component renders the following properties:

| Config     | Description                                                                                                          |
| --- | --- |
| `urlLink` | |
| `external` | If set to true, the URL will not use the Angular routerLink, but an ordinary href instead. |
| `media` | The `media` contains different media items for each format, so that an optimized media item can be used for the given space and usage. |
| `headline` | The `headline` is rendered as a paragraph tag before the media. |
| `content` | The `content` is rendered in a paragraph tag below the media. |

## Component Logic

There is no component logic in the banner component. The component simply renders component data. You can use the component-specific `CmsBannerComponent` to access the component data.

## Component Styling

The component styles are provided by the `%cx-banner` placeholder selector in the styles library. The media style is made available in the default `sparta` theme. You can opt out of the banner styles by adding the selector to the list of `skipComponentStyles`.

## Known limitations

The banner component currently only renders images, including SVGs. There is no support yet for video.

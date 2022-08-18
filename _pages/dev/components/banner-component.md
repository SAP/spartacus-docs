---
title: Banner Component
feature:
- name: Banner Component
  spa_version: 1.0
  cx_version: n/a
---

The banner component is used to render different banners that are created in the CMS. Banners contain one or multiple images, as well as some optional content, such as a header. A banner is often used to link to other content.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## CMS Component Binding

There are multiple banner component types in the CMS, as follows:

- `BannerComponent`
- `SimpleBannerComponent`
- `SimpleResponsiveBannerComponent`

There is also a `RotatingImagesComponent`, which is a so-called container component. A container component holds multiple components. The `RotatingImagesComponent` is used to render multiple `BannerComponent` components in a carousel.

The different banner component types have been created for historical reasons, but there is not much to distinguish them anymore: in Spartacus, there is only component implementation for banners. Spartacus renders the banner media using the media component, which includes lazy loading and loading specific media for specific dimensions. For more information, see [{% assign linkedpage = site.pages | where: "name", "media-component.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/components/shared-components/media-component.md %}).

The CMS banner component is mapped to the Spartacus implementation as follows:

```ts
<CmsConfig>{
  cmsComponents: {
    SimpleResponsiveBannerComponent: {
      component: BannerComponent
    },
    BannerComponent: {
      component: BannerComponent
    },
    SimpleBannerComponent: {
      component: BannerComponent
    }
  }
}
```

You can use a similar component mapping to configure an alternative banner implementation. If you introduce an alternative component, you must map all the CMS banner component types to your new component implementation, similar to the configuration above.

## Adaptive and Responsive Images

The banner component supports both responsive images and adaptive images. Responsive images are simply driven by CSS rules, which allow you to reuse the same images across different devices and screen sizes. Adaptive images can be used simultaneously, and are driven by the images provided by the back end. The back end provides different media items according to the media format. The `cx-media` component adds the different formats in a `srcset` so that the browser can decide when to use which image. Media items are rendered in the `cx-media` component. For more information, see [{% assign linkedpage = site.pages | where: "name", "media-component.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/components/shared-components/media-component.md %}).

## Component Data

The banner component renders the following properties:

| Config     | Description                                                                                                          |
| --- | --- |
| `urlLink` | An optional link to an internal or external page. |
| `external` | If set to true, the URL will not use the Angular routerLink, but an ordinary href instead. |
| `media` | The `media` contains different media items for each format, so that an optimized media item can be used for the given space and usage. |
| `headline` | The `headline` is rendered as a paragraph tag before the media. |
| `content` | The `content` is rendered in a paragraph tag below the media. |

**Note:** Some of these properties might not be available, depending on the banner component type you receive from the back end.

## Component Logic

There is no component logic in the banner component. The component simply renders component data. You can use the injected component data (of type `CmsBannerComponent`) to access the component data.

## Component Styling

The component styles are provided by the `%cx-banner` placeholder selector in the styles library. The media style is made available in the default `sparta` theme. You can opt out of the banner styles by adding the selector to the list of `skipComponentStyles`.

## Known Limitations

The banner component currently only renders images, including SVGs. There is no support yet for video.

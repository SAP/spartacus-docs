---
title: Banner Component (DRAFT)
---

The purpose of the Banner component is to render a media in a given page slot. The media can be optimized for the given slot size. The banner is typically used to link to another internal or external page.

## CMS Component Binding

There are multipe banner component types in the CMS:

-   `BannerComponent`
-   `SimpleBannerComponent`
-   `SimpleResponsiveBannerComponent`

There is also a `RotatingImagesComponent` which renders a one or multiple `BannerComponents` in a carousel.

The different types have been created for historical reasons, there's not much of a point to distinquish them anymore; there's only component implementation in Spartacus for banners. Sparatacus always renders banners using adaptive and responsive features to render the most optimal image for the given device.

The CMS Banner component is mapped to the Spartacus implementation as follows:

```typescript
<CmsConfig>{
    SimpleResponsiveBannerComponent: {
        component: BannerComponent
    },
    BannerComponent: {
        component: BannerComponent
    },
    SimpleBannerComponent: {
        component: BannerComponent
    }
};
```

You can use this component mapping to configure an alternative banner implementation. You might need to map all CMS banner component types in case multiple types are used in your project.

## Adaptive vs responsive images

The banner component supports both _responsive_ images as well as _adaptive_ images. Responsive images are simply driven by the CSS rules, which allow to reuse the same images cross different devices and screen sizes. Adaptive images can be used simultaneouly, and are driven by the images provided by the backend. The backend provides different medias by media formats. The `cx-media` components adds the different formats in a so-called `srcset`, so that the browser decides when to use which image.

## Component Data

The banner component renders the following properties:

| config     | description                                                                                                         |
| ---------- | ------------------------------------------------------------------------------------------------------------------- |
| `urlLink`  |                                                                                                                     |
| `external` | If set to true, the URL will not use the Angular routerLink, but an ordinary href instead.                          |
| `media`    | The media contains different media per format, so that an optimzed media can be used for the given space and usage. |
| `headline` | The headline is rendered as paragraph tag before the media.                                                         |
| `content`  | The content is rendered in a paragraph tag below the media.                                                         |

## Component Logic

There's no component logic in the banner component, the component just renders component data. You can use the component specific `CmsBannerComponent` to access the component data.

## Component Styling

The component styles are provided by the `%cx-banner` placeholder selector in the styles library. The media style is made available in the default sparta theme. You can opt out of the banner styles by adding the selector to the list of `skipComponentStyles`.

## Known limitations

The banner component currently only renders images, including SVGs. There's no support yet for video.

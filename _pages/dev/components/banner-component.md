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
- `DynamicBannerComponent`

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
| `urlLink` | Link to an internal or external page. |
| `external` | If set to true, the URL will not use the Angular routerLink, but an ordinary href instead. |
| `media` | The `media` contains different media items for each format, so that an optimized media item can be used for the given space and usage. |
| `headline` | The `headline` is rendered as a paragraph tag before the media. |
| `content` | The `content` is rendered in a paragraph tag below the media. |

**Note:** Some of these properties might not be available, depending on the banner component type you receive from the back end.

## Component Logic

There is no component logic in the banner component. The component simply renders component data. You can use the injected component data (of type `CmsBannerComponent`) to access the component data.

## Component Styling

The component styles are provided by the `%cx-banner` placeholder selector in the styles library. The media style is made available in the default `sparta` theme. You can opt out of the banner styles by adding the selector to the list of `skipComponentStyles`.

## Known limitations

The banner component currently only renders images, including SVGs. There is no support yet for video.

## Adding a New Banner

The easiest way to add new links to the Organization homepage is to create a new **Banner Component** in Backoffice, as follows:

1. Log in to Backoffice as an administrator.

1. In the left sidebar of Backoffice, select **WCMS**, and then **Component**.

    A list of components is displayed.

1. Above the list of components, click on the down-arrow next to the plus (`+`) icon, select **Abstract Banner Component**, and then **Banner Component**.

    The **Create New Banner Component** dialog is displayed.

1. Select the **Catalog Version**, provide an ID in the **ID** field, and then click **Done**.

1. Select the new component.

    It should appear at the top of the **Components** list, but you may have to refresh the view before it appears (for example, you could click on any other entry in the Backoffice navigation sidebar, and then return to **Components**).

1. Once you have selected your new component, click on the **Administration** tab.

1. In the **Unbound** section of the **Administration** tab, fill in the following fields:

   - **Headline** is title of the link.
   - **Content** is the text displayed below link title.
   - **Media** is a reference to a specific media object that has been added to the media library. In this case, it is used to define a banner icon. For more information, see [Adding a Custom Icon]({{ site.baseurl }}#adding-a-custom-icon), below.
   - **URL link** is the target URL address.

1. Click the **Content Slots** tab and select **My Company Slot**.

    This allows you display the new banner by assigning it to an appropriate content slot.
    
    ### Adding a New Banner using impex
    
    It is possible to create a banner by exporting impex statement via **Hybris administration console** or by editing sample data scripts.
    
    **Impex statement**
    
    INSERT_UPDATE BannerComponent;$contentCV[unique=true];uid[unique=true];name;headline;media(code, $contentCV);slots(uid,$contentCV);
    
    Example:
    
    INSERT_UPDATE BannerComponent;$contentCV[unique=true];uid[unique=true];name;headline;media(code, $contentCV);slots(uid,$contentCV);
    ;;MyBannerComponent4;My Banner Component 4;My headline;Elec_240x180_HomeKid_EN_01_240W.jpg;Section1Slot-Homepage

## Hiding a Banner

The easiest way to hide a banner is to set the component visibility to **False** in Backoffice, as follows:

1. Log in to Backoffice as an administrator.

1. In the left sidebar of Backoffice, select **WCMS**, and then **Component**.

    A list of components is displayed.

1. Select the banner component assigned to **My Company Slot** that you want to hide.

1. Click the **Properties** tab and set the **Visible** radio button to **False**.

## Adding a Custom Icon

You can upload any image file and use it as an icon in the banner link, as follows:

1. Log in to Backoffice as an administrator.

1. In the left sidebar of Backoffice, select **Multimedia**, and then **Media**.

1. Click the plus (`+`) icon.

    The **Create New Media** dialog appears.

1. Fill in the **Identifier** field, specify a **Catalog version**, and then click **Next**.

    You now see the **Content: Upload media content** step.

1. Upload the image you want to use, click **Next** if you want to define additional properties, then click **Done**.

    When you are creating a new banner, you can now select this image in the **Media** field to use as an icon in the banner link, as described in [Adding a New Banner]({{ site.baseurl }}#adding-a-new-banner), above.


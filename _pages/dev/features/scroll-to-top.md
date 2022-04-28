---
title: Scroll to Top
feature:
- name: Scroll to Top
  spa_version: 5.0
  cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 5.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The scroll to top feature provides a button that lets users quickly return to the top of the page they are viewing. Using CMS content slots, you can add the button to any page of your Spartacus storefront.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Enabling Scroll to Top

Scroll to top is CMS-driven and consists of one CMS component, called the `ScrollToTopComponent`.

To enable the scroll to top feature in your storefront, add the `ScrollToTopComponent` to a content slot on each page where you wish to make the scroll to top button available. To add the scroll to top button to every page in your storefront, you can add the `ScrollToTopComponent` to a shared content slot, such as the footer.

If you are using version 5.0 or newer of the `spartacussampledata` extension, the `ScrollToTopComponent` is already enabled. If you wish to enable the scroll to top feature and you are not using the `spartacussampledata` extension, you can create the scroll to top CMS component using ImpEx, as described in the following section.

For more information about the `spartacussampledata` extension, see [{% assign linkedpage = site.pages | where: "name", "spartacussampledata-extension.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/spartacussampledata-extension.md %}).

### Adding the Scroll to Top CMS Component Manually

You can add the `ScrollToTopComponent` CMS component to Spartacus using ImpEx.

**Note:** The `$contentCV` variable that is used in the following ImpEx examples, and which stores information about the content catalog, is defined as follows:

```text
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]
```

1. Create the `ScrollToTopComponent` CMS component with the following ImpEx:

   ```text
   INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef
   ;;ScrollToTopComponent;Scroll To Top Component;ScrollToTopComponent;ScrollToTopComponent
   ```

1. Add the `ScrollToTopComponent` to a content slot on each page where you wish to make the scroll to top button available.

   For example, if you want to add the scroll to top button to every page of your storefront, you can use ImpEx to add the `ScrollToTopComponent` to the footer slot, as shown in the following:

   ```text
   INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)
   ;;FooterSlot;FooterNavigationComponent,AnonymousConsentOpenDialogComponent,NoticeTextParagraph,AnonymousConsentManagementBannerComponent,ProfileTagComponent,ScrollToTopComponent 
   ```

## Configuring Scroll to Top

You can configure the scroll to top feature using the `scrollBehavior` and `displayThreshold` properties of the `CmsScrollToTopComponent` interface.

### Configuring the Scroll Behavior

You can adjust the experience of the scroll to top feature by setting the scroll behavior to `smooth` or `auto`. When the scroll behavior is set to `smooth`, the page scrolls quickly upward through the contents of the page until it reaches the top. When the scroll behavior is set to `auto`, the page jumps instantly from the current position to the top of the page.

By default, the scrolling behavior is set to `smooth`, but you can change this value to `auto`, as shown in the following example:

```ts
provideConfig(<CmsConfig>{
  cmsComponents: {
    ScrollToTopComponent: {
      data: {
        scrollBehavior: ScrollBehavior.AUTO,
      }
    },
  },
}),
```

In the above example, `ScrollBehavior.AUTO` is part of the `ScrollBehavior` enum that is defined in `cms.model.ts` in the `@spartacus/core` library.

### Configuring the Display Threshold

For pages that have scroll to top enabled, the display threshold property determines how far down the page a user must scroll before the scroll to top button appears. By default, the display threshold is set to half the height of the page, but you can change this display threshold to an absolute number of pixels. For example, if you set the value to 1000, the scroll to top button appears only when the user has scrolled down 1000 pixels from the top of the page.

The following is an example of how to set the `displayThreshold` property to an absolute value of pixels:

```ts
provideConfig(<CmsConfig>{
  cmsComponents: {
    ScrollToTopComponent: {
      data: {
        displayThreshold: 1000,
      }
    },
  },
}),
```

In this example, the scroll to top button appears when the page's `window.scrollY` value reaches `1000`.

**Note:** You can provide values for both the `scrollBehavior` and `displayThreshold` properties in a single configuration. The following is an example:

```ts
provideConfig(<CmsConfig>{
  cmsComponents: {
    ScrollToTopComponent: {
      data: {
        scrollBehavior: ScrollBehavior.AUTO,
        displayThreshold: 1000,
      }
    },
  },
}),
```

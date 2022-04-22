---
title: Scroll to Top
feature:
  - name: Scroll to Top
    spa_version: 5.0
---

{% capture version_note %}
{{ site.version_note_part1 }} 5.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The scroll to top feature allows users to quickly scroll back to the top of the page.

---

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

---

## Enabling Scroll to Top

To enable this feature in your storefront, add the scroll to top CMS component to a content slot in the web site pages you wish to use the feature with. To add Scroll to Top to the whole web site, you can add the scroll to top component in a shared content slot, like the footer. 

### CMS Component

Scroll to top is CMS-driven and consists of the following CMS component:

- `ScrollToTopComponent`

If you are using the version 5.0 or greater of [{% assign linkedpage = site.pages | where: "name", "spartacussampledata-extension.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/spartacussampledata-extension.md %}), the scroll to top component is already enabled. However, If you decide not to use the spartacussampledata extension, you can create the scroll to top CMS component with ImpEx.

**Note:** The `$contentCV` variable that is used throughout the following ImpEx examples, and which stores information about the content catalog, is defined as follows:

```text
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]
```

#### Adding Scroll to Top CMS Component Manually

This section describes how to add the scroll to top CMS component to Spartacus using ImpEx.

You can create the **Scroll to Top** component with the following ImpEx:

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef
;;ScrollToTopComponent;Scroll To Top Component;ScrollToTopComponent;ScrollToTopComponent
```

You can enable the **Scroll to Top** feature by adding the scroll to top component in the **Footer** slot with the following ImpEx:

```text
INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)
;;FooterSlot;FooterNavigationComponent,AnonymousConsentOpenDialogComponent,NoticeTextParagraph,AnonymousConsentManagementBannerComponent,ProfileTagComponent,ScrollToTopComponent 
```

## Configuring Scroll to Top

Scroll to top has two configurable properties, scroll behavior and display threshold, as shown in the following interface:

```ts
export interface CmsScrollToTopComponent extends CmsComponent {
  scrollBehavior?: ScrollBehavior;
  displayThreshold?: number;
}
```

### Scroll Behavior

By default, the scrolling behavior is set to `smooth` scroll, but you can modify this value to `auto` by providing a different configuration. You can provide your configuration as shown in the following example:

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

In the above example, `ScrollBehavior.AUTO`, is part of an `enum` located in `@spartacus/core`.

### Display Threshold

Display threshold determines after how many pixels from the top of the page will the button be displayed on the screen. By default, the display threshold is set to half the height of the window, but you can modify this value by providing an absolute number via configuration. You can provide your configuration as shown in the following example:

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

In the above example, display threshold is fixed and will display the scroll to top button at a `window.scrollY` value of 1000.

Both of these examples can be combined into a single configuration as shown in the following example:

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


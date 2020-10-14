---
title: Above-the-Fold Loading
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Above-the-fold loading is a technique that prioritizes the creation of components that are "above the fold". The term "above the fold" is traditionally known as the upper-half of a newspaper, where the most important stories are located. When this concept is transferred to the web, it refers to all the components that are placed at the top of the page, where the experience starts.

Above-the-fold loading requires the following important ingredients:

1. Deferred loading, which is a technique that postpones the creation of components that are "below the fold". For more information, see [Deferred Loading]({{ site.baseurl }}{% link _pages/dev/performance/deferred-loading.md %}).
2. The notion of the "page fold". The page fold is not static, and differs from device to device, from screen to screen, and even changes depending on the size of the browser.
3. A couple of CSS rules that initially move components below the page fold.

## Page Fold Configuration

The page fold is configurable for each page template and breakpoint. The page fold configuration is only an indication to speed up the initial creation of page slots that are above the fold. All page slots are eventually rendered if they happen to be above the fold. You designate the page fold by assigning a page slot to the `pageFold` parameter. This page slot, and all previous, sibling page slots, are "above the fold". These page slots are prioritized ahead of page slots that are "below the fold".

The page fold is part of the `LayoutConfig` configuration. The page fold indicates the last page slot that should be rendered above the fold.

The following example includes the page fold configuration for the `LandingPage2Template` page template:

```typescript
LandingPage2Template: {
    pageFold: 'Section2B',
    slots: [
        'Section1',
        'Section2A',
        'Section2B',
        [...]
    ]
}
```

If you need a configuration for specific breakpoints, you can configure the page fold for every breakpoint, as shown in the following example:

```typescript
ProductDetailsPageTemplate: {
    md: {
        pageFold: 'UpSelling'
    },
    xs: {
        pageFold: 'Summary'
    },
    slots: [
        'Summary',
        'UpSelling',
        [...]
    ]
}
```

For more information on page layout configuration, see [Configuring the Layout](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/page-layout/#configuring-the-layout).

## CSS Configuration

By default, when page slots are loaded on the page, there is no minimum height available for the page slots or components. The actual height is only added when components are loaded, and the associated CSS rules are applied to the components. The page slots adjust their height automatically when components are loaded. Therefore, page slots do not have an initial height, which is why they initially end up in the viewport. This prevents the deferred loading technique from working, because it depends on content not being in the viewport.

Given that content can be added at runtime, it is not possible to implement a (hard-coded) minimum height for page slots or components – it all depends on what the business will add at runtime.

While this lack of minimum height could be filled up by so-called "ghost design" CSS rules, there will always be a gap between the ghost design and the actual content. Furthermore, ghost design rules require an implementation effort that might not be available.

To make it possible to defer the loading of below-the-fold content, Spartacus marks page slots that are below the page fold while page slots above the fold are being loaded. All page slots are marked with an `is-pending` class as long as all the inner components are not loaded. Additionally, the page fold slot has a `page-fold` class. With these two classes, Spartacus can apply various CSS rules to control deferred loading of below-the-fold content.

### Moving Page Slots Below the Fold

The following CSS shows all pending page slots after the `pending` page-fold, and moves them below the fold with a margin-top.

```scss
cx-page-slot.cx-pending.page-fold ~ cx-page-slot.cx-pending {
    margin-top: 100vh;
}
```

### Increasing Pending Slots Below the Fold

The following CSS shows how all pending page slots after the page fold are given a minimum height so that they do not come into the viewport all at once.

```scss
cx-page-slot.page-fold ~ cx-page-slot.cx-pending {
    min-height: 100vh;
}
```

There are a few additional CSS rules that enable deferred loading of below-the-fold content. Without these rules, the concept of "above the fold" will not work.

These CSS rules have been introduced with the Calydon theme in the 1.4 release. You can enable them by setting the `calydon` theme, as follows:

```scss
theme$: calydon;
```

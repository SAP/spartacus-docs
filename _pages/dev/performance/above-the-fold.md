---
title: Above-the-Fold Loading (DRAFT)
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Above the fold loading is a technique to prioritize creation of components which are above the fold. Above the fold is traditionally known as the upper half of a news paper where the most important stories are located. This transfers to the web as all components which are placed at the top of the page, where the experience starts.

Above the fold loading requires two important ingredients:

1. [Deferred loading({{ site.baseurl }}{% link _pages/dev/performance/deferred-loading.md %}), a technique to postpone the creation of components _below_ the fold. Deferred loading is documented [separately]({{ site.baseurl }}{% link _pages/dev/performance/deferred-loading.md %}).
2. The notion of the _page fold_. The page fold is not static, and differs from device to device, screen to screen and even the size of the browser.
3. A couple of CSS rules to control the page fold.

## Page Fold Configuration

The page fold is configurable per page template and breakpoint. The page fold configuration is only an indication to speed up the initial creation of page slots above the fold. Page slots are eventually rendered if they're above the fold. The indicated page slot however will be used to prioritize all above the fold page slots over page slots below the fold.

The page fold is added to the `LayoutConfig` configuration. The page fold indicates the last page slot that should be rendered above the fold.

The following configuration details the page fold for the `LandingPage2Template` page template:

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

If you need a configuration per breakpoint, you can configure the page fold for every breakpoint:

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

## CSS configuration

By default, when page slots are loaded on the page, there's no minimum height of page slots or components available. Page slots will initally all have no height, which brings them all in the view port. This eliminates the concept of deferred loading, which is based on content not being the viewport.

Given that content can be added at runtime, it is not possible to implement a (hard-coded) minimum heights for page slots or components; it all depends on what the business will add at runtime.

While this lack of minimum height could be filled up by so-called _ghost design_ CSS rules, there will always be a gap between the ghost design and the actual content.

In order to come up with a design system to defer below the fold content, we've introduced a concept to _mark_ page slots below the page fold indication as long as the above the page fold slots are being loaded. All page slots are marked with an `is-pending` class as long as all the inner components are not loaded. Additionally, the page fold slot has a `page-fold` class. With these two classes we can apply various CSS rules to control deferred loading of below the fold content.

### Move page slots below the fold

The following CSS shows how all pending page slots after the _pending_ page-fold, and move them below the fold with a margin-top.

```scss
cx-page-slot.cx-pending.page-fold ~ cx-page-slot.cx-pending {
    margin-top: 100vh;
}
```

### Increase pending slots below the fold

The following CSS rules shows how all pending page slots after the page fold will get a minimum height so they would not come in the view port all at once.

```scss
cx-page-slot.page-fold ~ cx-page-slot.cx-pending {
    min-height: 100vh;
}
```

There are a few additional CSS rules which enables deferred loading of below the fold content. Without these rules, above the fold is not working.

The CSS rules have been introduced with Calydon theme in 1.4 release. You can enable them by setting the `calydon` theme:

```scss
theme$: calydone;
```

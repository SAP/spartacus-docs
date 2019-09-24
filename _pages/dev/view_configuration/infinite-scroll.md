---
title: Infinite Scroll
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Infinite scroll is a web-design technique that loads content continuously as the user scrolls down the page, removing the need for pagination.

When infinite scroll is enabled in Spartacus, it applies to the product search page, as well as the category pages in both the list and grid views. When infinite scroll is disabled, Spartacus uses pagination instead. By default, infinite scroll is disabled in Spartacus.

You can enable infinite scroll with the following settings in `app.module.ts`:

```typescript
    view: {
      infiniteScroll: {
        active: true,
        productLimit: 500,
        showMoreButton: false,
      },
    },
    ...
```

The `view` container contains all of the configurations that affect the display of the Spartacus storefront, including the `infiniteScroll` container. The `infiniteScroll` container contains all of the configurations that affect the infinite scroll feature.

Use the `active` property to enable and disable infinite scroll. Infinite scroll is enabled when `active` is set to `true`. If the value for `active` is empty, or set to `false`, all other `infiniteScroll` settings are ignored, and Spartacus uses pagination instead.

Use the `productLimit` property to control the number of products a user can scroll through before they are prompted to load more items. For example, if the value for `productLimit` is set to `50`, then a **Show More** button appears after the user has scrolled through 50 items. When the user presses the **Show More** button, the user can scroll through another 50 items before the button appears again. 

By limiting the number of products that are shown, you can prevent users from experiencing degraded browser performance, which could occur when displaying very large lists of products. Note that if the value for `productLimit` is empty, or set to `0`, then the `productLimit` property is disabled.

Use the `showMoreButton` property to explicitly set a display limit of 10 products before the **Show More** button appears. For example, if the `showMoreButton` property is set to `true`, a user sees a **Show More** button after scrolling through 10 items. When the user presses **Show More**, 10 more items are loaded, and this process is repeated until there are no more products to display. Note that if the value for `showMoreButton` is set to `false`, then a **Show More** button only appears when a user has viewed the number of products specified by the `productLimit` property. If the value for `showMoreButton` is set to `true`, then the value for `productLimit` is ignored.

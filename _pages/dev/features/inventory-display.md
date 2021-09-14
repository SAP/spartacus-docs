---
title: Inventory Display
feature:
  - name: Inventory Display
    spa_version: 4.1
    cx_version: 2005
---

{% capture version_note %}
{{ site.version_note_part1 }} 4.1 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The inventory display feature lets you show customers how much of a given item is available for purchase on your storefront. When the inventory display feature is enabled, customers can see the quantity of items that are available for purchase. When the feature is disabled, customers see only that an item is either "In Stock" or "Out of Stock".

## Enabling Inventory Display

To enable inventory display, set the `inventoryDisplay` flag to `true`, as shown in the following example:

```ts
      provideConfig(<CmsConfig>{
        cmsComponents: {
          ProductAddToCartComponent: {
            data: {
              inventoryDisplay: true,
            },
          },
        },
    }),
```

For more information on providing a configuration, see [provideConfig]({{ site.baseurl }}/global-configuration-in-spartacus/#provideconfig).

**Note:** Inventory display is disabled by default.

## Configuring

No special configuration is needed for this feature.

## Extending

No special extensibility is available for this feature.

---
title: Inventory Display
feature:
  - name: Inventory Display
    spa_version: 3.4
    cx_version: 2005
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Inventory Display allows Spartacus to notify users of availabile stock for products they wish to purchase. Spartacus supports configuration to now allow storefront owners to display available inventory for product in additional to a 'In Stock/Out of Stock' label.

## Enabling Inventory Display and Configuration

Enabling inventory display is very straightforward. Simply set the `inventoryDisplay` flag to `true | false` when you wish to render available inventory on a product's detail page. Configuration is found in the AddToCart module.

```javascript
      cmsComponents: {
        ProductAddToCartComponent: {
          component: AddToCartComponent,
          data: {
            inventoryDisplay: 'true',
          },
        },
      },
```

## Extending

No special extensibility is available for this feature.

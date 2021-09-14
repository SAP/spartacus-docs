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

The B2B Inventory Display display allows sellers to control the maximum stock displayed for a given category or base site. This feature is only available for B2B channel. For example, if there are 200 of something in stock, and B2B Inventory Display for the site is 25, then "25 in stock" is displayed, despite the actual stock number. For more information on the Commerce Cloud feature, see https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/2105/en-US/8ac35e1d866910148876ef95adde0c60.html.

The changes to Spartacus to make this work are two independent settings:

1) Before this improvement, Spartacus only displayed either "in stock" or "out of stock". Spartacus was updated to allow display of actual stock numbers. This change works for any site (B2C or B2B).
2) Setting the inventory display field for B2B sites in the backend will then display the maximum stock number.

When the Spartacus inventory display feature is enabled, customers can see the quantity of items that are available for purchase (the actual number can be affected by the backend B2B Inventory Display feature). When the Spartacus feature is disabled, customers see only that an item is either "In Stock" or "Out of Stock".

## Enabling Inventory Display in Spartacus

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

## Enabling B2B Inventory Display limits in backend using Backoffice

See https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/2105/en-US/8ac35e1d866910148876ef95adde0c60.html.

If the Spartacus inventory display feature is disabled, setting a value in the backend will have no effect on frontend (Spartacus will display "in stock" or "out of stock" only).

## Configuring

No special configuration is needed for this feature.

## Extending

No special extensibility is available for this feature.

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

When inventory display is enabled on a Spartacus B2B site, it allows sellers to control the maximum stock displayed for a given category or base site. For example, if there are 200 units of an item in stock, and B2B Inventory Display for the site is set to `25`, then "25 in stock" is displayed, regardless of the actual stock number. For more information, see [B2B Inventory Display](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac35e1d866910148876ef95adde0c60.html) on the SAP Help Portal.

To make this functionality possible, changes were made to the following settings in Spartacus:

- Previously, Spartacus only displayed either "in stock" or "out of stock". Spartacus was updated to allow the display of actual stock numbers. This change works for any site (B2C or B2B).
- It is then possible to set the inventory display field for B2B sites in the back end to display the maximum stock number.

When the Spartacus inventory display feature is enabled, customers can see the quantity of items that are available for purchase (the actual number can be affected by the SAP Commerce Cloud B2B Inventory Display feature). When the Spartacus feature is disabled, customers see only that an item is either "In Stock" or "Out of Stock".

## Enabling Inventory Display in Spartacus

To enable inventory display, set the `inventoryDisplay` flag to `true` in `app.module.ts`, as shown in the following example:

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

## Enabling B2B Inventory Display Limits in the Back End using Backoffice

If the inventory display feature is disabled in Spartacus, setting a value in the back end has no effect on the front end. In other words, Spartacus will display "in stock" or "out of stock" only.

For more information, see [B2B Inventory Display](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/2105/en-US/8ac35e1d866910148876ef95adde0c60.html) on the SAP Help Portal.

## Configuring

No special configuration is needed for this feature.

## Extending

No special extensibility is available for this feature.

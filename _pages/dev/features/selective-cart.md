---
title: Selective Cart
feature:
- name: Selective Cart
  spa_version: 1.5
  cx_version: 1905
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.5 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The Selective Cart feature (also known as "save for later") allows customers to select which items in the cart they wish to purchase, and to leave other items in the cart for future consideration. This improves the shopping experience and increases the conversion rate.

## Requirements

The Selective Cart feature requires release **1905.11** of SAP Commerce Cloud.

The `selectivecartaddon` AddOn is also required.

For more information, see [Selective Cart Architecture](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/923b6bd803734e168a6b2e7c1087caec.html) on the SAP Help Portal.

## Enabling Selective Cart

The Selective Cart feature has corresponding CMS-component data that allows you to enable or disable the feature.

Furthermore, you need to configure the `selectiveCart` in the cart configuration to enable or disable the feature. The following is an example:

```typescript
cart: {
  selectiveCart: {
    enabled: true,
  }
}
```

## Configuring

No special configuration is needed.

## Extending

No special extensibility is available for this feature.

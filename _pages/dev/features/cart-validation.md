---
title: Cart Validation
feature:
- name: Cart Validation
  spa_version: 4.2
  cx_version: 2011
---

{% capture version_note %}
{{ site.version_note_part1 }} 4.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The cart validation feature allows Spartacus to verify a user's cart at every step during checkout to ensure that the requested quantity of each item is available. If the quantity of an item is reduced, or an item is out of stock and no longer available, the user is redirected to the cart page, and Spartacus displays a global message about the change to the user's cart.

## Requirements

The cart validation feature requires SAP Commerce Cloud 2011 or newer.

## Enabling Cart Validation

To enable cart validation, set the `enabled` flag to `true` in the cart validation configuration. The following is an example:

```typescript
cart: {
  validation: {
    enabled: true
  }
}
```

## Configuring

Cart validation is enabled for every step in the checkout process. You can turn off validation for any individual step by removing the `CartValidationGuard` class from the CMS component configuration in the relevant checkout module.

## Extending

No special extensibility is available for this feature.

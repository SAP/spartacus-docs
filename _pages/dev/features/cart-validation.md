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

## Displaying Minimum and Maximum Order Quantity Validation in the Cart

When the `cartValidationDisplayBackendMessages` feature toggle is enabled (in addition to the `cart.validation.enabled` configuration), Spartacus surfaces backend minimum and maximum order quantity validation directly on the cart page, instead of only redirecting the user during checkout. Specifically, when an item's quantity is below the allowed minimum or above the allowed maximum, Spartacus:

- highlights the violating cart row;
- displays a per-item `Min qty` / `Max qty` hint under the quantity stepper, parsed from the backend `statusMessage`;
- re-validates the cart when the cart page is opened and whenever an item quantity changes.

If the user attempts to proceed to checkout while a quantity limit is still violated, the `CartValidationGuard` blocks navigation and displays a message.

This behavior requires a SAP Commerce Cloud backend that returns `below_min_quantity` / `exceed_max_quantity` cart modification statuses with a `statusMessage` containing the `Min=` / `Max=` values.

To enable it, add the feature toggle to your Spartacus configuration:

```typescript
featureToggles: {
  cartValidationDisplayBackendMessages: true,
}
```

## Extending

No special extensibility is available for this feature.

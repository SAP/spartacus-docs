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

In Spartacus 221121.19 and later, the storefront can display directly on the cart page the minimum and maximum order quantity validations that are received from the back end, instead of only redirecting the user during checkout. When the quantity of an item is below the allowed minimum, or above the allowed maximum, the following occurs:

- the violating cart row is highlighted
- a per-item `Min qty` or `Max qty` hint is displayed under the quantity stepper, which is parsed from the `statusMessage` received from the back end
- the cart is re-validated when the cart page is opened, and whenever an item quantity changes.

If a user tries to proceed to the checkout while a quantity limit is still violated, the `CartValidationGuard` blocks navigation and displays a message.

To enable this behavior, you need to use Backoffice to configure SAP Commerce Cloud to return `below_min_quantity` or `exceed_max_quantity` cart modification statuses with a `statusMessage` that contains the `Min=` or `Max=` values. You also need to ensure the `cartValidationDisplayBackendMessages` feature toggle is enabled. If you have installed a new instance of Spartacus version 221121.19 or later, the toggle is enabled by default. However, if you have updated your storefront to version 221121.19 or later, you need to enable the toggle manually. For more information, see [Activating Cart Validation Display Backend Messages](link-to-be-created-in-doc-tool).

## Extending

No special extensibility is available for this feature.

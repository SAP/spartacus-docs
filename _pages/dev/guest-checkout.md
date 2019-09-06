---
title: Guest Checkout (DRAFT)
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Spartacus supports Guest Checkout which gives the ability to guests to checkout without creating an account. After making a purchase, a guest user has the possibility to create an account with the email he provided. This account will retain the order history of the guest as well as the informations that were preivously entered.

## Enabling the Feature

This feature is disabled by default but can be enabled by setting the `guestCheckout` feature flag to true. The following configuration shows how to enable this feature:

(in app.module.ts)
```ts
B2cStorefrontModule.withConfig({
  [...]
  features: {
    [...]
    guestCheckout: true
  }
})
```

## Extensibility

The Guest Checkout feature leverages the existing pages and components from the regular checkout. Therefore, the extensibility described in [Extending-Checkout](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/extending-checkout/) will be supported.
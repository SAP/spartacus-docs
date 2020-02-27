---
title: Selective Cart
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.5 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

The Selective Cart feature (also known as "save for later") allows customers to select which items in the cart they wish to purchase, and to leave other items in the cart for future consideration. This improves the shopping experience and increases the conversion rate.

## Requirements

The Selective Cart feature requires release **1905.11** of SAP Commerce Cloud.

The **selectivecartaddon** AddOn is also required for the Selective Cart feature to work.

For more information, see [Selective Cart Architecture](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/923b6bd803734e168a6b2e7c1087caec.html) on the SAP Help Portal.

## Enabling Selective Cart

The Selective Cart feature has corresponding CMS-component data that allows you to enable or disable the feature. The configuration is provided in the `B2cStorefrontModule`.

Furthermore, you need to configure the `saveForLater` feature flag to enable or disable the feature. The following is an example:

```typescript
features: {
   saveForLater: true
}
```

For more information on feature flags and feature levels, see [Configuring Feature Flags]({{ site.baseurl }}{% link _pages/install/configuring-feature-flags.md %}).


## Configuring

No special configuration is needed.


## Extending

No special extensibility is available for this feature.


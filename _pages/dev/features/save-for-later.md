---
title: Save for Later (DRAFT)
---

## Overview

The save for later feature allows customers to select what items in the cart for checking out, while leaving other items remain in the cart for future considerations, thus improving shopping experience and increasing conversion rate.

## Requirements

The save for later feature requires the following extensions to work:

- selectivecartaddon AddOn

For more information, see [Selective Cart Architecture](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/923b6bd803734e168a6b2e7c1087caec.html) in the SAP Help Portal.

## Enabling Save for Later

The save for later feature has corresponding CMS-component data that allows you to enable or disable the feature. The configuration is provided in the `B2cStorefrontModule`.

Besides, you need to configure the `saveForLater` feature flag in order to enable or disable the feature, as follows:

```typescript
features: {
   saveForLater: true
}
```

For more information on feature flags and feature levels, see [Configuring Feature Flags]({{ site.baseurl }}{% link _pages/install/configuring-feature-flags.md %}).


## Configuring

No special configuration needed. 


## Extending

No special extensibility available for this feature. 


---
title: Stock Notification (DRAFT)
---

## Intro

The stock notification feature allows customers to register product interests for receiving back-in-stock notifications, so that customers can buy interested products in time. 

## Requirements

The stock notification feature requires the following extensions to work:

-  
-  
-  

For more information, see [Stock Notification Architecture](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/7afe618e1ff4437ea6a7a0c6e0c8f32b.html) in the SAP Help Portal.

## Enabling Stock Notification

The stock notification feature has a `stockNotification` feature flag that allows you to enable or disable the feature, as follows:

```typescript
features: {
   stockNotification: true
}
```

This feature is enabled automatically for feature level 1.2 and above.

For more information on feature flags and feature levels, see [Configuring Feature Flags]({{ site.baseurl }}{% link _pages/install/configuring-feature-flags.md %}).


## Configuring

No special configuration needed.


## Extending

No special extensibility available for this feature.

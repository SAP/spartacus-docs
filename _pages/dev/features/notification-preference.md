---
title: Notification Preference (DRAFT)
---

## Intro

The notification preference feature provides a page under user account for customers to set preferred channels for receiving notifications by activating and deactivating the corresponding switches. 


## Requirements

The notification preference feature requires the following extensions to work:

- 
- 
- 

For more information, see [Notification Architecture](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/b090364cfbe94c6da1b69af62f585d79.html) in the SAP Help Portal.


## Enabling Notification Preference

The notification preference feature has a `notificationPreference` feature flag that allows you to enable or disable the feature, as follows:

```typescript
features: {
   notificationPreference: true
}
```

This feature is enabled automatically for feature level 1.2 and above.

For more information on feature flags and feature levels, see [Configuring Feature Flags]({{ site.baseurl }}{% link _pages/install/configuring-feature-flags.md %}).


## Configuring

No special configuration needed. (if there's any, create a new topic and add a link here.)


## Extending

No special extensibility available for this feature. (if there's any, create a new topic and add a link here.)


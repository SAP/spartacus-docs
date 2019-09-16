---
title: Notification Channels (DRAFT)
---

## Intro

The notification preference feature provides a page under user account for customers to set preferred notification channels by activating and deactivating the corresponding switches. 


## Requirements

The notification preference feature requires the following extensions to work:

- 
- 
- 

See https://help.sap.com/ for more information.

## Enabling Notification Preference

Customer interests has a `notificationPreference` feature flag that allows you to enable or disable the feature, as follows:

```typescript
features: {
   notificationPreference: true
}
```

The notification preference feature is enabled automatically for feature level 1.2 and above.

For more information on feature flags and feature levels, see [Configuring Feature Flags]({{ site.baseurl }}{% link _pages/install/configuring-feature-flags.md %}).


## Configuring

No special configuration needed. (if there's any, create a new topic and add a link here.)


## Extending

No special extensibility available for this feature. (if there's any, create a new topic and add a link here.)


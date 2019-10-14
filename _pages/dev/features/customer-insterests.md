---
title: Customer Interests (DRAFT)
---

## Intro

The customer interests feature provides a page under user account for customers to view, as well as managing registered product interests, such as removing product interests, and updating the notification receiving channels. 

## Requirements

The customer interests feature requires the following extensions to work:

- 
- 
- 

For more information, see [Customer Interests Architecture](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/f096456e586c44a29bd833a88536855a.html) in the SAP Help Portal.

## Enabling Customer Interests

The customer interests feature has a `customerInterests` feature flag that allows you to enable or disable the feature, as follows:

```typescript
features: {
   customerInterests: true
}
```

This feature is enabled automatically for feature level 1.2 and above.

For more information on feature flags and feature levels, see [Configuring Feature Flags]({{ site.baseurl }}{% link _pages/install/configuring-feature-flags.md %}).


## Configuring

No special configuration needed. (if there's any, create a new topic and add a link here.)


## Extending

No special extensibility available for this feature. (if there's any, create a new topic and add a link here.)


---
title: Configuring feature flags
---

Each minor version of spartacus libraries comes with new features, often those features will be improvements to exiting components.
Usually those features are anticipated by users, but in some cases could be considered as breaking changes, especially 
when customers build their own customizations on top of specific behaviors or DOM structure.

## Feature levels

To maintain strict backward compatibility, spartacus uses concept of configurable feature levels, that helps to maintain predictable behavior while improving existing components.
By default, each minor version will have all new improvements enabled. To force strict compatibility with previous version, configure feature level as in below example:

```typescript
{
  features: {
    level: '1.0'
  }
}
``` 

Thanks to this, you can use 1.3.x release that will work in strict compatibility with '1.0.x' releases. 
Each consecutive feature level contains all of the features from previous one.

## Feature flags

Some important features can be selectively toggled using specific feature flags:

```typescript
{
  features: {
    someFeature: false
  }
}
``` 

Feature flags can be linked to feature levels, which basically means that feature is enabled by default if defined feature level is available.

You can mix both feature level and feature flags:

```typescript
{
  features: {
    level: '1.1',
    feature1: false,
    feature2: true
  }
}
``` 
 
In the above example:
   - feature level is set to `1.1`.
   - If `feature1` is a part of `1.1` feature level, with feature flag you can selectively disable that feature while keeping '1.1' feature set.  
   - If `feature2` is a part of `1.5` feature level, you can still enable it while keeping `1.1` feature set.
    
## **NOTE**:

It is advised to additionally test your application when selectively enabling features. While we try to use feature flags for separate features, 
we can't guarantee that all functionalites will work for all possible combinations of feature flags and feature levels. 

---
title: Configuring Feature Flags (DRAFT)
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.1 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Each minor version of the Spartacus libraries includes new features, which are often improvements to exiting components. These features are usually expected by users, but in some cases, these could be considered breaking changes, especially when customers build their own customizations on top of specific behaviors or the DOM structure.

## Feature levels

To maintain strict backward compatibility, spartacus uses concept of configurable feature levels, that helps to maintain predictable behavior while improving existing components.
By default, feature level is set to latest major version (i.e. 1.0). To make use of new behaviors and improvements introduced in minor version (i.e. 1.3), configure feature level as below:

```typescript
{
  features: {
    level: '1.3'
  }
}
``` 

Each consecutive feature level contains all of the features from previous one.

If you want your feature level to always be set to the most recent version, you can use the latest flag (`'*'`), as follows:

```typescript
features: {
  level: '*'
}
```

You can also disable a feature for a specific feature level by including an exclamation mark (`!`) before the version number. The following is an example:

```typescript
<newComponent *cxFeatureLevel="'!1.1'"></newComponent>
```

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

It is advised to additionally test your application when selectively enabling features. While we try to use feature flags for separate features, we can't guarantee that all functionalities will work for all possible combinations of feature flags and feature levels.

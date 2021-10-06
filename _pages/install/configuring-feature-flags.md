---
title: Configuring Feature Flags
feature:
- name: Feature Flags
  spa_version: 1.1
  cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.1 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Each minor version of the Spartacus libraries includes new features, which are often improvements to existing components. These features are usually expected by users, but in some cases, these updates could be considered breaking changes, especially when you have built your own customizations on top of specific behaviors, or on top of the DOM structure.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Feature Levels

To maintain strict backwards compatibility, Spartacus includes configurable feature levels, which help to maintain predictable behavior while improving existing components.

By default, the feature level is set to the latest major version (such as 1.0). To make use of new behaviors and improvements introduced in a minor version (such as 1.3), you can configure the feature level as shown in the following example:

```typescript
{
  features: {
    level: '1.3'
  }
}
```

**Note:** Each consecutive feature level contains all of the features from the previous feature level.

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

## Feature Flags

Some important features can be selectively toggled using specific feature flags.

The following is an example:

```typescript
{
  features: {
    someFeature: false
  }
}
```

Feature flags can be linked to feature levels, which results in a feature being enabled by default if the defined feature level is available.

You can configure the feature level and feature flags at the same time, as shown in the following example:

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
    
## Note

It is advised to additionally test your application when selectively enabling features. While we try to use feature flags for separate features, we can't guarantee that all functionalities will work for all possible combinations of feature flags and feature levels.

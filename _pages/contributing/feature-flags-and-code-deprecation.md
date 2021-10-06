---
title: Feature Flags and Code Deprecation
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.1 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Code Deprecation

For complex and rapidly evolving libraries, maintaining backwards compatibility while improving existing features can be challenging. Code deprecation allows you to properly mark obsolete code, and by warning users, it helps them in transitioning to better alternatives.

### Deprecated JSDoc Annotation

To mark functions, classes, methods, or properties as deprecated, use the `@deprecated` mark. The following is an example:

```typescript
/**
* @deprecated since 1.0.2
* Use better alternative instead
*/
```

Depending on the actual deprecation policy, such code will become a candidate for removal in one of the next major versions.

### Marking Deprecated Logic

Often, to accommodate backwards compatibility, some indirectly related code needs to contain additional logic that should be removed when the related deprecated functionality is removed. When it is not obvious which additional logic should be removed, the best way to make sure that obsolete code is removed is to mark it with the proper `TODO` comment, preferably linked to a GitHub issue with additional details. These tickets should be properly labelled (for example, having a label of `deprecated-1.x`) to make it easier to reference in the future as a candidate for removal.

The following is an example of a `TODO` comment:

 
```typescript
// TODO(issue:3313) Deprecated since 1.1.1
```

## Feature Flags

With each new minor version, new features are released. Sometimes, new features are added to existing components that can already be used by customers, which makes these changes breaking change, either because of an addition to the DOM, or because of different behavior. To avoid breaking customer's code, and to have the flexibility to improve the functionality of existing components without the need of releasing new major versions too frequently, Spartacus makes use of feature flags.

Feature flags allow us to do the following:

- Differentiate features based on feature level, which corresponds to the minor version number
- Differentiate features based on an explicit feature flag

  **Note:** Explicit feature flags can be linked to feature level, which means they are enabled by default for that particular level.

### Deciding If You Need a Feature Flag

It is best to avoid creating new feature flags if they are not needed. This helps to keep our config clean and to make eventual maintenance easier. The following guideline can help you to decide which feature flag you should use, if any:

1. If possible, try to avoid using feature flags.
   - Instead, implement your feature as a separate module that could be imported optionally by a customer.
   - If your functionality already has a separate config, determine which of the following will be more convenient:
       - creating a new option in the module configuration (for general features, where there is an actual value in making them toggleable).
       - using a feature flag (especially when the only reason for a flag is backwards compatibility).
2. If possible, try to avoid creating an explicit feature flag. Instead, try to enable features for specific feature levels, such as for minor releases.
3. If you want to create an explicit feature flag, be sure the reason for doing so is justified (for example, the feature is important enough to be explicitly disabled or enabled).

### Detecting the Feature Level

If your service or component already has the global config injected, you can use a simple utility function to check for the feature level, as shown in the following example:

```typescript
if (isFeatureLevel(this.config, '1.1')) {
  // code that is meant to be executed for feature level 1.1 and above
}
```

If your component or service does not have access to the global config, you can inject the `FeatureConfigService` and use it, as shown in the following example:

```typescript
  constructor(
    // ...
    protected featureConfig: FeatureConfigService
  ) {}

  // set a feature flag based on the feature level
  readonly isSomeNewFeatureEnabled = this.featureConfig.isLevel('1.1');
```

If you want to conditionally show a component in a template, you can use the `cxFeatureLevel` directive, as shown in the following example:

```typescript
<newComponent *cxFeatureLevel="'1.1'"></newComponent>
```

### Explicit Feature Flags

Explicit feature flags are simple string identifiers. You can check their status similarly to checking the feature level.

You can use a simple utility function that consumes the global config, as shown in the following example:

```typescript
if (isFeatureEnabled(this.config, 'consignmentTracking')) {
  // code that is meant to be executed when feature consignmentTracking is enabled
}
```

The following is an example using the `FeatureConfigService`:

```typescript
consignmentTrackingEnabled = this.featureConfig.isEnabled('consignmentTracking');
```

The following is an example using a directive:

```typescript
<newFeature *cxFeature="'consignmentTracking'"></newFeature>
```

You can introduce explicit flags without additional configuration, but it is recommended that you include them in the type definition of the storefront configuration to expose them to customers. To do this, add your flag to the `FeatureToggles` interface in the `feature-toggles.ts` file as a new property with a type of `boolean`. The following is an example:

```typescript
export interface FeatureToggles {
  features?: {
    // ...

    /**
     * Sample feature description
     */
    consignmentTracking: boolean;
  };
}
```

In this way, you can also add a description to the flag, and even deprecation annotation, if needed.

#### Linking the Feature Flag to the Feature Level

By linking your feature flag to the feature level, your flag will be enabled by default for that feature level, and all higher levels. To do this, provide the default value for a feature flag as a string representing the feature level. You can add this config to your module configuration, as show in the following example:
  
```typescript
ConfigModule.withConfig({
  // ...
  features: {
    consignmentTracking: '1.1',
  },
})
```

In this example, the consignment tracking feature is enabled by default if the feature level is set to at least `'1.1'`.
  
**Note:** If you want your feature level to always be set to the most recent version, you can use the latest flag `'*'`, as follows:

```typescript
features: {
  level: '*'
}
```

#### Disabling a Feature for a Specific Feature Level

You can disable a feature for a specific feature level by including an exclamation mark `!` before the version number. The following is an example:

```typescript
<newComponent *cxFeatureLevel="'!1.1'"></newComponent>
```

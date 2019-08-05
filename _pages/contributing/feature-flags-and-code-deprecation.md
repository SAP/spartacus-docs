---
title: Feature flags and code deprecation
---

## Code deprecation

For a complex and rapidly evolving libraries maintaining backward compatibility while improving existing features can be challenging. 
Code deprecation allows to properly mark obsolete code and by warning users, helps them in transitioning for better alternatives.   

### @deprecated JSDoc annotation

To mark function, class, method or property as deprecated, use `@deprecated` mark, like in the example:

```typescript
/**
* @deprecated since 1.0.2
* @deprecated since 1.0.2
* Use better alternative instead
*/
```

Depending on actual deprecation policy, such a code will become a candidate to removal in one of the next major version. 

### Marking deprecated logic

Often, to accommodate backward compatibility, some indirectly related code need to contain additional logic that can be removed when removing deprecated functionality.
When such a removal is not obvious enough, the best way to make sure that obsolete code will be removed is to mark it with proper TODO comment, preferably linked 
to a ticket/issue with additional details. 
Such a ticket should be properly labelled (example label: 'deprecated-1.x') to make it easy to reference it in future as a candidate for removal.

 
```typescript
// TODO(issue:3313) Deprecated since 1.1.1
```

## Feature flags

With each next minor version we release new features. 
Sometimes new features are added to existing components that can be already used by customers, making them a breaking change because of some DOM addition or different behavior.
To avoid breaking customer's code and have a flexibility to improve functionality of existing components without the need of releasing next major version too often, we introduced feature flags.

Feature flags allows to:
1. Differentiate features based on feature level, which corresponds to minor version number
2. Differentiate features based on explicit feature flag
   -  Explicit feature flags can be linked to feature level, which effectively means they are enabled by default for this level 


### Deciding if you need a feature flag

We try to avoid creating new feature flags if they are not needed, to keep our config clean and ease eventual maintenance.
Please follow this guideline to decide, which feature flag you should use (if any):

1. If possible, try to avoid using feature flags 
   - Implement feature as a separate module, that could be imported optionally by customer
   - If your functionality already has separate config, check if what will be more convenient: 
       - creating new option in module configuration (for general features, where there is an actual value in making them toggleable)
       - using feature flag (especially, when the only reason for a flag is the backward compatibility)
2. If possible, try to avoid creating explicit feature flag
    - Try to enable features for specific feature levels, i.e. major releases
3. If you want to create the explicit feature flag make sure it's justified, for example: feature is important enough to be explicitly disabled or enabled.

### Detecting feature level

1. If your service or component has already the global config injected, you can use a simple utility function to check for feature level:

    ```typescript
    if (isFeatureLevel(this.config, '1.1')) {
      // code that is meant to be executed for feature level 1.1
    }
    ```
     
2. If your component or service doesn't have access to global config you can inject FeatureConfigService and use it:
   
    ```typescript
      constructor(
        // ...
        protected featureConfig: FeatureConfigService
      ) {}
    
      // set a feature flag based on feature level
      readonly isSomeNewFeatureEnabled = this.featureConfig.isLevel('1.1');
    ```

3. If you want to conditionally show show components in templates you can use `cxFeatureLevel` directive:

    ```typescript
    <newComponent *cxFeatureLevel="'1.1'"></newComponent>
    ```

### Explicit feature flags

1. Explicit feature flags are simple string identifiers, available out of the box. You can check their status similarly to checking feature level.

    You can use simple utility function (that consumes global config):
    
    ```typescript
    if (isFeatureEnabled(this.config, 'consignmentTracking')) {
      // code that is meant to be executed when feature consignmentTracking is enabled
    }
    ```
    
    FeatureConfigService:
    
    ```typescript
    consignmentTrackingEnabled = this.featureConfig.isEnabled('consignmentTracking');
    ```   

    or directive:

    ```typescript
    <newFeature *cxFeature="'consignmentTracking'"></newFeature>
    ```

2. You can introduce explicit flags without additional configuration, but it's recommended to include them in the type definition of storefront configuration to expose them to customers.
To achieve that, just add your flag to `FeatureToggles` interface in `feature-toggles.ts` file as a new property with `boolean` type:

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
    
    In this way you can also add description to the flag or even deprecation annotation, if needed. 

3. Linking feature flag to feature level

    By linking your feature flag to feature level, you'll get your flag enabled by default for this and all above levels.
    To achieve that, provide default value for a feature flag as a string representing feature level. You can add this config to your general module configuration:
    
    ```typescript
        ConfigModule.withConfig({
          features: {
            consignmentTracking: '1.1',
          },
        })
    ```
    In above example, consignment tracking feature will be enabled by default, if feature level is at least '1.1'.

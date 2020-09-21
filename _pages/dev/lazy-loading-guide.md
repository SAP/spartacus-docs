---
title: Lazy Loading Guide
---

Lazy loading, also known as code splitting, lets you divide your JavaScript code into multiple chunks. The result is that you do not have to load all the JavaScript of the full application when a user accesses the first page. Instead, only the chunks that are required for the given page are loaded. While navigating the storefront, additional chunks might be loaded when needed.

Such an approach can substantially improve "Time To Interactive", especially in the case of complex web applications being accessed by low-end mobile devices.

## Spartacus Approach to Lazy Loading

Code splitting is a technique that has to be done at application build time. Code splitting provided by Angular is typically route-based, which means there is a chunk for the landing page, another chunk for the product page, and so on. Since Spartacus is mostly CMS driven, the actual application logic for each route cannot be decided at build time. Business users will eventually alter the page structure by introducing or removing components. This is why an alternative approach to lazy-loading is required, which Spartacus provides in the following ways:

- Lazy loading of CMS components
- CMS-driven lazy loading of feature modules

## General Concepts

The following sections offer some important information about how lazing loading works in Spartacus.

### Define Dynamic Imports Only in the Main Application

Dynamic imports, a technique that is used to facilitate lazy loading and that also allows code splitting, can only be used in the main application. It is not possible to define dynamic imports in the prebuilt libraries.

This is an unfortunate limitation, which results in some application code that must be added by customers. Although the amount of custom code is limited to the bare minimum, we'll add a feature in a future version of the schematics library to automatically add lazy loaded modules.

### Avoiding Static Imports for Lazy Loaded Code

To make code spitting possible, your static JavaScript code (the main app bundle) should not have any static imports to code that you want to lazy load. The builder will notice that the code is already included, and as a result, will not generate a separate chunk for it. This is especially important in the case of importing symbols from libraries.

At the time of writing (Angular 9 and Angular 10), mixing static imports with dynamic imports for the same library entry point, even for distinct symbols, will break lazy loading and tree shaking for this library entry point. This includes the whole entry point statically into the build. For this reason, it is highly recommended you create separate entry points for the code that has to be loaded statically, and for the code that can be loaded lazily.

### Configuration in Lazy Loaded Modules

If additional configuration is provided inside the lazy-loaded module, this configuration is not merged in the global application configuration. As a result, the configuration will not affect any component other than the lazy-loaded components.

This limitation will be addressed in Spartacus 3.x with the concept of unified configuration. For Spartacus 2.x, you should import modules with configuration statically.

### Providers in Lazy Loaded Modules

Injection tokens provided in lazy-loaded modules are not visible to services provided in the app root. This applies especially to multi-provided tokens, such as `PageMetaResolvers`, various Handlers, and so on. This problem will be partially addressed in Spartacus 3.0 with the Unified Injector mechanism. For Spartacus 2.x, you should always provide these tokens in modules statically imported to your app root module.

### Avoiding Importing the HttpClientModule in Your Lazy Loaded Modules

In general, the `HttpClientModule` should be imported in the root application, not in the library. For example, if you import it inside a lazy-loaded library, all injectors from the root library will be invisible to HTTP calls originating from the lazy-loaded module.

Although technically it is possible to import the `HttpClientModule` in the library, in most cases it is not something that is expected, and it might cause errors that are difficult to explain, so please keep this in mind.

## Lazy Loading of CMS components

{% capture version_note %}
{{ site.version_note_part1 }} 2.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}


### Configuration of Lazy Loading CMS Components

Lazy loading of CMS code is achieved by specifying a dynamic import in place of a statically-referenced components class in the CMS Mapping configuration. The following is an example:

```typescript
{
  cmsComponents: {
    SimpleResponsiveBannerComponent: {
      component: () => import('./lazy/lazy.component').then(m => m.LazyComponent)
    }
  }
}
```

For more information on CMS mapping, see [Customizing CMS Components]({{ site.baseurl }}{% link _pages/dev/customizing-cms-components.md %}).

### Technical Details

Support for dynamic imports in CMS component mapping is implemented using customizable component handlers (specifically, the `LazyComponentHandler`).

It is possible to extend this handler to customize its behavior, to add special hooks, or different triggers, or to implement a completely new handler that can optionally reuse existing ones.

## Lazy Loading of Modules

{% capture version_note %}
{{ site.version_note_part1 }} 2.1 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

CMS-driven lazy loading of feature modules allows the following:

- Lazy loading not only component code, but also the core part (including NgRx state)
- Loading a feature only once, when first needed
- Providing shared, lazy-loaded dependency modules

Lazy loading of the feature module is triggered by the CMS requesting a component when the implementation is covered by the relevant feature configuration.

### Configuration of Lazy Loaded Modules

Configuration of the feature involves the following aspects:

- The dynamic import of the feature module (which has to be defined in main application)
- The information about what CMS components are covered by a specific feature (which can become part of the library and imported statically). This information is provided as an array of strings under the `cmsComponents` key. The following is an example:

  ```typescript
  {
    featureModules: {
      organization: {
        module: () =>
          import('@spartacus/my-account/organization').then(
            (m) => m.OrganizationModule
          ),
        cmsComponents: [
          'OrderApprovalListComponent',
          'ManageBudgetsListComponent',
          'ManageCostCentersListComponent',
          'ManagePermissionsListComponent',
          'ManageUnitsListComponent',
          'ManageUserGroupsListComponent',
          'ManageUsersListComponent',
        ],
      },
    },
  }
  ```

### Component Mapping Configuration in Lazy-Loaded Modules

Default CMS mapping configuration in lazy-loaded modules should be defined in exactly the same fashion as in statically-imported ones.

Spartacus is able to extract a CMS component mapping configuration from a lazy-loaded feature and use it to resolve component classes and factories covered by the feature. That is why it is possible and recommended to use the standard way of providing the default CMS mapping configuration inside a lazy loaded module. As a result, the exact same module and library entry point can be imported dynamically or statically, depending on the needs, and it is still possible to overwrite a lazy-loaded CMS configuration from the application level by providing configuration overrides in the application.

### Defining Shared-Dependency Modules

It is possible to extract some logic to a shared, lazy-loaded module that can be defined as a lazy-loaded dependency for a feature module by providing an array of dynamic imports in the `dependencies` property of the feature configuration. The following is an example:  

```typescript
{
  featureModules: {
    organization: {
      module: () =>
        import('@spartacus/my-account/organization').then(
          (m) => m.OrganizationModule
        ),
      dependencies: [
        () =>
          import('@spartacus/storefinder/core').then(
            (m) => m.OrganizationModule
          ),
        // ,,
      ],
    },
  },
}
```

Such unnamed dependency modules are instantiated only once, when lazy loading the first feature that depends on it. Its providers contribute to the combined injector that is passed to the CMS component that is covered by the feature.  

### Combined Injector

When a CMS component that is covered by a lazy-loaded module is instantiated, it can inject (have access to) services from the following:

- the app root injector, taking into account the hierarchical injector component tree (that is, providers defined in the parent components)
- the feature module injector
- the dependency modules injectors

This is achieved thanks to the `CombinedInjector` that is created on the fly by the CMS rendering logic. As a rule of thumb, local hierarchical providers take precedence over feature module providers, which in turn takes precedence over dependency module injectors, which take precedence over the root application injector.

## Preparing Libraries to Work with Lazy Loading

### Providing Fine-Grained Entry Points in Your Library

Mixing static and dynamic imports from the same entry points breaks lazy loading and affects tree shaking, so any library that will be used directly in dynamic imports should expose fine-grained secondary entry points to optimize code splitting.

For more information, see [Secondary Entry Points](https://github.com/ng-packagr/ng-packagr/blob/master/docs/secondary-entrypoints.md) in the ng-packagr documentation on GitHub.

### Separating Static Code from Lazy Loaded Code

When you work with Angular Dependency Injection, the list of providers in the injector should not change after the injector is initialized. This paradigm specifically affects the following:
  
- The Spartacus configuration, which is defined by providing configuration chunks that are merged in the global Configuration Factory Provider.

- Any multi-provided tokens, handlers such as `PageMetaResolver`, `ErrorHandler`, and so on.
  
- Any Angular native multi-provided tokens, such as `HTTP_INTERCEPTOR`, `APP_INITIALIZER`, and so on.
  
The result is that any configuration or multi-provided token in a lazy-loaded module will not be visible to modules and services provided in the root, or in other lazy-loaded chunks.

The easiest way to fix this is to always include this kind of code in a statically-linked module that is available upfront. It is recommended to create a separate entry point in your library (by convention, named _root_, such as `my-library/root`) that contains minimal code, and that will be included in the main bundle and will be available from the beginning.

### Wrapping Library Code in a Lazy-Loaded Module

To address some specific customizations on top of a lazy loaded library, it is possible to wrap static imports from one or more libraries into a single module that will be imported dynamically instead. This technique can also be an effective optimization strategy, because the builder will be able to use tree shaking for all of the static imports inside the module.

## Additional Mechanisms (Planned for Spartacus 3.0)

### Unified Configuration

**Note:** A preview will be available in the _3.0-next_ releases.

Unified configuration provides a way to get a global configuration that includes both the root configuration and the configuration from already-loaded lazy-loaded modules.

### Unified Injector

**Note:** A preview will be available in the _3.0-next_ releases.

The unified injector provides a way to inject a token, or multi-provided tokens, taking into account the root injector and the injectors from lazy-loaded modules. The injector exposes an Observable that emits a new set of injectables for a specified token each time the status of the Unified Injector changes. This status changes whenever Spartacus instantiates a new lazy-loaded module, because the module contains an injector that can be added to the Unified Injector.

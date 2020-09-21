---
title: Lazy Loading Guide
---

**Lazy loading or code splitting** lets you divide the JavaScript code into multiple chunks, so they don't have to be loaded upfront, but only when actually needed, greatly improving Time To Interactive, especially in case of complex web applications and on lower-end mobile devices. 

## Spartacus Approach to Lazy Loading
   
As Spartacus is mostly CMS driven, there is not much of the usage of the built-in route based lazy loading offered by Angular out of the box. Code splitting has to be done at app build time, while Spartacus never knows upfront what components or features a specific route can contain, before actually loading them. 
There is always a room for manual tweaking it based on app knowledge, but such a solution breaks the flexibility that Spartacus offers and requires additional prerequisites.
   
To meet those requirements, Spartacus provides CMS driven lazy loading on two levels:
 
   	1. Lazy loading of CMS components (simplest)
   	
    2. CMS driven lazy loading of feature modules
    
    
## Important information

### Dynamic imports can only be defined in the main application

**Dynamic imports**, a technique used to facilitate lazy loading and allow for code splitting, can be only used in the main application, it's not possible to define them in prebuild libraries.

### Avoid static imports for lazy loaded code

To make code spitting possible, your static javascript code (main app bundle) shouldn't have any static imports to code that you want to lazy load. The builder will notice, that the code is already included and won't generate a separate chunk for it.

It's especially important in the case of importing symbols from libraries. 
At the time of writing (Angular 9 and Angular 10), mixing static imports with dynamic imports for the same library entry point, even for distinct symbols, will break lazy loading and tree shaking for this library entry point, including the whole entry point statically. 
That's why **it's recommended to create separate entry points** for the code, that has to be loaded statically and the code that can be loaded lazily. 

### Configuration in lazy loaded modules

Lazy loaded configuration won't be visible for other modules and won't contribute to the global configuration of the running app. 

This will be addressed in Spartacus 3.x with the concept of unified configuration, for Spartacus 2.1 you should import modules with configuration statically.

### Providers in lazy loaded modules

Injection tokens provided in lazy loaded modules won't be visible to services provided in the app root, it especially applies to multi provided tokens, like PageMetaResolvers, various Handlers, etc. 

This problem will be partially addressed in Spartacus 3.0 with the Unified Injector mechanism, for Spartacus 2.1 you should always provide those tokens in modules statically imported to your app root module. 

### Avoid importing **HttpClientModule** in your lazy loaded modules

Generally **HttpClientModule** should be imported in the root application, not in the library.
For example: importing it inside a lazy loaded library will make all injectors from the root library invisible to http calls originating from lazy loaded module.

Technically it's possible, but in most cases, it's not something that is expected and might cause some hard to explain errors, so please take it into consideration. 


## Lazy loading of CMS components
_(available in Spartacus 2.0 and above)_


### The Configuration

Lazy loading of CMS code is achieved by specifying dynamic import in place of statically referenced components class in CMS Mapping configuration:

```typescript
{
  cmsComponents: {
    SimpleResponsiveBannerComponent: {
      component: () => import('./lazy/lazy.component').then(m => m.LazyComponent)
    }
  }
}
```

You can find more information about CMS Mapping here: [Customizing CMS Components]({{ site.baseurl }}{% link _pages/dev/customizing-cms-components.md %}) 


### Technical details

Support for dynamic imports in Cms Component Mapping is implemented using customizable Component Handlers, specificially the **LazyComponentHandler**. 

It's possible to extend this handled to customize its behavior, add special hooks, different triggers, or implement a completely new handler that can optionally reuse existing ones.    


## Lazy loading of modules
_(available in Spartacus 2.1 and above)_

CMS driven lazy loading of feature modules allows to:

  - Lazy load not only component code, but also core part (including NgRx state)
  - Feature is loaded only once, when first needed
  - Provide shared, lazy loaded dependency modules

Lazy loading of the feature module is triggered by CMS requesting a component, which implementation is provided specific feature. 

### The Configuration

Configuration for the feature contains two parts: 

  1. The dynamic import of the feature module (has to be defined in main application)
  2. The information about what CMS components are covered by this feature (can become part of the library and imported statically). The information is provided as an array of strings under __cmsComponents__ key. 

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

### Defining shared dependency modules 

It's possible to extract some logic to shared lazy loaded module that can be defined as lazy loaded dependency for feature module by providing array of dynamic imports in __dependencies__ property in feature configuration.  

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

Such a unnamed dependency modules are instantiated only once, when lazy loading the first feature that depends on it, and its providers are contributing to Combined Injector that is passed to CMS Component covered by the  feature.  


### Combined Injector

When CMS component covered by lazy-loaded module is instantiated, it can inject (have access to) services from:
 
   - app root injector, taking into account hierarchical injector component tree (i.e. providers defined in parent components)
   - feature module injector
   - dependency modules injectors
   
It's achieved thanks to **CombinedInjector** that is created on the fly by CMS rendering logic. By the rule of thumb, local hierarchical providers take precedence before feature module providers, which in turn takes precedence before dependency module injectors, which take precedence before the root Application injector. 


## Preparing libraries to work with lazy loading

### Providing fine-grained entry points in your library

Because mixing static and dynamic imports from the same entry points break lazy loading and affects tree shaking, any library that will be used directly in dynamic imports should expose fine-grained secondary entry points to optimize code splitting. 

For more information, please read about 
[Secondary Entry Points](https://github.com/ng-packagr/ng-packagr/blob/master/docs/secondary-entrypoints.md) in **ng-packagr**.


### Separating static code from lazy loaded

Because of how Angular Dependency Injection works, the list of providers in the Injector should not change after Injector was initialized. 
This paradigm specifically affects:
  
  1. Spartacus configuration which is defined by providing configuration chunks that are merged in global Configuration Factory Provider.
  
  2. Any multi provided tokens, handlers like PageMetaResolver, ErrorHandler, etc.
  
  3. Any Angular native multi provided tokens, like HTTP_INTERCEPTOR, APP_INITIALIZER, etc.   
  
It means, that any configuration or multi provided token in lazy loaded module won't be visible to modules and services provided in root or in other lazy loaded chunks.
 
The easiest way to fix it is to always include such a code in a statically linked module, available upfront. We recommend creating a separate entry point in your library, by convention named _root_ (i.e. 'my-library/root') that contains minimal code that will be included in the main bundle and will be available from the beginning.

### Wrapping library code in lazy loaded module

To address some specific customizations on top of a lazy loaded library, it's possible to wrap static imports from one or more libraries in one module that will be imported dynamically instead.
This technique can be also an effective optimization strategy, as the builder will be able to use tree shaking for all the static imports inside the module.   


## Additional mechanisms (planned for Spartacus 3.0)

### Unified Configuration
_(preview available in 3.0-next releases)_

Provides a way to get a global configuration that will include both root configuration + configuration from already loaded lazy loaded modules.

### Unified Injector
_(preview available in 3.0-next releases)_

Provides a way to inject a token or multi provided tokens taking into and account root injector and injectors from lazy loaded modules.
Injector exposes an Observable, that will emit each time status of the Unified Injector for specified token will change.

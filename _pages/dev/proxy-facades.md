---
title: Proxy Facades
---

Proxy Facades is very flexible mechanism that can abstract functionality from lazy loadable feature modules for any part of the application (components, services, directives, etc.). 

In lazy-loaded configuration, facade is defined as a very thin layer, which is just an empty class with some metadata, which dynamically creates proxy to the facade implementation. As soon as any part of the code will access any method or property of such a Proxy Facade, the necessary feature is loaded and initialized under the hood, and the call is proxied to the actual implementation.

Proxy facades, by the design, are completely transparent for lazy and eager loading scenarios. For eager loading scenarios, when code is statically linked, the actual implementation overshadows proxy provider, and is accessed directly, without any proxy layer.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
  {:toc}

***

## Feature modules

Feature modules allows encapsulating core, business logic and components and load them at one go, whenever any of the components is requested or some logic is required.   
Proxy Facades leverages Feature Modules configuration to both know, which feature contains the implementation of the facade. Such a feature is under the hood loaded and initialized on demand (when is accessing properties or calling methods).

## How to define proxy facade

### Define proxy in a root entry point

As mentioned above, proxy facades are a very thin layer, which is a JavaScript class with some metadata, that should be available in the root injector. This lightweight injector can then be used in any eager or lazy loaded part of the application.

Below is an example of UserAccountFacade proxy definition, which has one `get` method and is implemented by USER_ACCOUNT_CORE_FEATURE. 

```typescript
@Injectable({
  providedIn: 'root',
  useFactory: () =>
    facadeFactory({
      facade: UserAccountFacade,
      feature: USER_ACCOUNT_CORE_FEATURE,
      methods: ['get'],
    }),
})
export abstract class UserAccountFacade {
  abstract get(): Observable<User | undefined>;
}
```

Such a module is a part of an eager loaded bundle (usually `root` entrypoint in case of default Spartacus libraries), while the implementation (UserFacadeService) is provided inside lazy loaded chunk (usually exposed from the `core` entrypoint). Here is an example of the implementation:

```typescript
@Injectable()
export class UserAccountService implements UserAccountFacade {
  // ...
    
  get(): Observable<User | undefined> {
    // ...
  }
}
```
and standard way to provide it in lazy loaded chunk:

```typescript
export const facadeProviders: Provider[] = [
  UserAccountService,
  {
    provide: UserAccountFacade,
    useExisting: UserAccountService,
  },
];
```

For convenience, facade is both provided as UserAccountFacade and as UserAccountService. It makes overriding a bit easier (only UserAccountService implementation has to be overridden) and facilitates eager-loading scenarios, where UserAcountFacade provider will override default facade proxy provider. 


## Implementation details

FacadeFactory creates simple facade proxy class, based on methods and properties configuration. Accessing any property (property has to be an Observable) or calling any methods, triggers loading feature module referenced with the facade proxy. After feature is loaded, feature module injector is used to inject facade implementation, which is provided inside feature module under the same token, as facade proxy. Then respective properties or methods from implementation are called and handed over to the caller.

Facade factories can also be created with an `async` flag set to true. Such a facade will slightly delay passing calls to facade implementation after feature module was initialized, allowing for asynchronous facade initialization. This is a recommended settings, where facades are using NgRx store, which is initialized asynchronously. 

## Default approach in Spartacus

By default, in Spartacus, facade proxies are defined in a `root` entry point, which means, are statically linked with the main bundle. Because of this, with minimal overhead, any component or service, can inject its lightweight proxy token, without having to know if this facade is a part of any lazy or eager loaded feature.

Usually, facade definition references `feature_name_CORE` feature, while by default, feature are provided under `feature_name` features, while `feature_name_CORE` is used as an alias for `feture_name`. By this design, facade proxies works in default configuration, where `core`, `occ` and `components` modules are bundled into one lazy loaded module. On the other hand, it's very easy to split it and only load core part (without components) to achieve fine-grained lazy loading, by defining configuration and lazy import for `feature_name_CORE` feature.

## Extending and customizing facades behind the proxy

Recommended way to extend or customize facades, is to override its implementation service, by providing it under the same token. To keep it lazy-loadable, it's possible to use default approach for extending and customising lazy-loaded features, which is wrapping lazy loaded modules inside new custom module, with customized providers, and lazy loading this module instead. 

---
title: Proxy Facades
feature:
- name: Proxy Facades
  spa_version: 3.2
  cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Proxy facades are a flexible mechanism that can abstract functionality from lazy-loadable feature modules, and this can be done for any part of the application, such as components, services, directives, and so on.

In lazy-loaded configurations, a facade is defined as a very thin layer that is just an empty class with some metadata, and this facade dynamically creates a proxy to the facade implementation. As soon as any part of the code accesses any method or property of the proxy facade, the necessary feature is loaded and initialized under the hood, and the call is proxied to the actual implementation.

By design, proxy facades are completely transparent for lazy loading and eager loading scenarios. For eager loading scenarios, when code is statically linked, the actual implementation overshadows the proxy provider, and is accessed directly without any proxy layer.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Feature Modules

Feature modules allow you to encapsulate core business logic along with components, and to load them at once whenever any of the components is requested, or some logic is required. Proxy facades leverage feature module configurations to know which feature contains the implementation of the facade. Whenever properties of the feature are accessed or methods are called, the feature is loaded and initialized under the hood.

## Defining Proxy Facades

This section describes how to define a proxy in a root entry point.

As mentioned earlier, proxy facades are a very thin layer that is comprised of a JavaScript class and some metadata, which should be available in the root injector. This lightweight injector can then be used in any eager loaded or lazy loaded part of the application.

The following is an example of a `UserAccountFacade` proxy definition that has one `get` method and is implemented by the `USER_ACCOUNT_CORE_FEATURE`:

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

This kind of module is part of an eager-loaded bundle (usually the `root` entry point, in the case of default Spartacus libraries), and the implementation (`UserAccountService`) is provided inside a lazy-loaded chunk (which is usually exposed in the `core` entry point). The following is an example of the implementation:

```typescript
@Injectable()
export class UserAccountService implements UserAccountFacade {
  // ...
    
  get(): Observable<User | undefined> {
    // ...
  }
}
```

The following is an example of the standard way to provide the implementation in a lazy-loaded chunk:

```typescript
export const facadeProviders: Provider[] = [
  UserAccountService,
  {
    provide: UserAccountFacade,
    useExisting: UserAccountService,
  },
];
```

For convenience, the facade is provided both as a `UserAccountFacade` and as a `UserAccountService`. This makes overriding a bit easier (only the `UserAccountService` implementation has to be overridden), and facilitates eager-loading scenarios, where the `UserAccountFacade` provider will override the default facade proxy provider.

## Implementation Details

The `FacadeFactory` creates a simple facade proxy class that is based on the configuration of methods and properties. Accessing any property (which must be an `Observable`), or calling any method triggers the loading of the feature module that is referenced with the facade proxy. After the feature is loaded, the feature module injector is used to inject the facade implementation, which is provided inside the feature module under the same token as a facade proxy. Then the respective properties or methods from the implementation are called and handed over to the caller.

Facade factories can also be created with an `async` flag set to `true`. This sort of facade will briefly delay passing calls to the facade implementation after the feature module was initialized, which allows for asynchronous facade initialization. This is a recommended setting when facades are using the NgRx store, which is initialized asynchronously.

## Default Approach in Spartacus

In Spartacus, facade proxies are defined by default in a `root` entry point, which means they are statically linked to the main bundle. As a result, with minimal overhead, any component or service can inject its lightweight proxy token without having to know if the facade is a part of any lazy-loaded or eager-loaded feature.

Usually, the facade definition references the `feature_name_CORE` feature, while by default, features are provided under `feature_name` features, and the `feature_name_CORE` is used as an alias for the `feature_name`. With this design, facade proxies work in the default configuration, where `core`, `occ` and `components` modules are bundled into one lazy-loaded module. On the other hand, it is very easy to split this module and load only the core part (without components) to achieve fine-grained lazy loading. This can be done by defining the configuration and lazy import for the `feature_name_CORE` feature.

## Extending and Customizing Facades Behind the Proxy

The recommended way to extend or customize a facade is to override its implementation service, which is done by providing it under the same token. To keep it lazy-loadable, it is possible to use the standard approach for extending and customizing lazy-loaded features, which is to wrap lazy-loaded modules inside a new custom module, with customized providers, and to then lazy load this module instead.

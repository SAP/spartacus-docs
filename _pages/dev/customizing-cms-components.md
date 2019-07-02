---
title: Customizing CMS Components
---

The Spartacus storefront is based on JavaScript, and accordingly, it is composed of a large number of fine-grained JavaScript components. However, there is a special kind of component to render CMS content. CMS components are dynamically added at runtime. The CMS component type, given by the back end, is mapped to an equivalent JS component. The mapping is provided in a configuration that can be customized. This allows you to configure a custom component to render a specific CMS component.

In addition, component-specific business logic can be customized. This requires an additional configuration where the custom service can be provided to the (default) component.

With this setup, CMS components can be customized in the following ways:

| Scenario          | Approach                                             | Example                                              |
| ----------------- | ---------------------------------------------------- | ---------------------------------------------------- |
| Customize style   | Add custom CSS rules<br/>(Out of scope for this doc) | Customize component style for the `LanguageSelector` |
| Replace component | Configure a custom component                         | Provide a custom `BannerComponent`                   |
| Customize logic   | Configure a custom service                           | Provide a custom `SearchBoxComponentService`         |

## Configuring Custom Components

There are two types of components that can be configured: angular components, and web components (for which we currently provide experimental support).

### Custom Angular CMS Components

You can provide a CMS component configuration to the `ConfigModule`, or directly to the `B2cStorefrontModule`. The following configuration shows how to configure a custom Angular component for the CMS `BannerComponent`:

```typescript
ConfigModule.withConfig({
  cmsComponents: {
    BannerComponent: {
      component: CustomBannerComponent;
    }
  }
});
```

It's important to note that with this setup, the components must be loaded up front (using so-called `entryComponents`), and it does not allow for lazy loading.

Both of these related downsides will be improved in a future release. With that in mind, a change in this API is expected.

### Accessing CMS Data in CMS Components

The CMS data that is related to a component is provided to the component by the `CmsComponentData` service during instantiation. The `CmsComponentData` service contains the component `uid`, and also `data$`, which is an observable to the component payload. By making use of the Angular dependency injection (DI) system, components and component-specific services can use the `CmsComponentData`.


### Using Web Components as CMS Components (Experimental Support)

**Warning:** This feature is experimental. Some functionality may not work as expected, and the API may mature or change in the future.

Web components have a lot of benefits, and as soon as some of the fundamentals of Angular are ready for this, Spartacus will most likely begin to use them. Some preparation has already been made to allow for loading web components, but the current recommendation is to use Angular components.

To configure a web component as a CMS component, the configuration must consist of the path to the JS file (web component implementation) and its tag name, separated by a hash symbol (`#`). The following is an example:

```typescript
ConfigModule.withConfig({
  cmsComponents: {
    BannerComponent: {
        selector: 'path/to/banner/component/file.js#custom-banner';
    }
  }
});
```

One JS file can contain more that one web component implementation, used as different CmsComponents.

This requires a separate build process to generate the JS chunk that holds the web component(s), which is out of scope for this documentation.

#### Accessing API and CMS Data

Web components do not have access to the application DI system, regardless of whether they are built in Angular or not. They are isolated from the core application and can only interact with inputs and outputs. Therefore, they cannot access `CmsComponentData`, and would also suffer from not being able to reuse any of the services provided by Spartacus.

For these reasons, Spartacus uses the `cxApi` input to provide web components with both component-related data, as well as a generic API to the core services of Spartacus.

## Customizing Services

Spartacus CMS components that use (complex) business logic will delegate this to a service. This simplifies extensibility, and is also recommended for the following reasons:

- components only depend on a single service
- the service might have other dependencies
- a custom service can be provided for custom business logic

Component services are designed to be non-singleton services, scoped to the component, so that they have direct access to the `CmsComponentData` provided in the component scope. This design does not work well with the Angular DI system, because the DI system does not provide a mechanism to override component services without changing the component.

However, to configure a custom component service, you can provide a service in a similar fashion. The configuration is done in-line with the component configuration. In the following example, the `SearchComponent` is provided with a custom `SearchBoxComponentService`:

```typescript
ConfigModule.withConfig({
  cmsComponents: {
    SearchBoxComponent: {
        providers: [
        {
          provide: SearchBoxComponentService,
          useClass: CustomSearchBoxComponentService,
          deps: [CmsComponentData, ProductSearchService, RoutingService]
        }
      ];
    }
  }
});
```

## Controlling Server Side Rendering (SSR)

You might not want to render all CMS components in the server. The following are some examples of when not to render a CMS component in the server:

- a CMS component requires personalized input and should not, or cannot, be rendered without it
- a CMS component is not required for SSR output, and for performance reasons, it will be removed from the rendering process
- a CMS component interacts with external services (latency) and is not relevant for indexing and social sharing

While it is possible to add conditional logic in a component to render (parts of) the view in SSR, Spartacus offers a configuration for components to make this more generic, and to avoid any specific logic in components. The following is an example:

```typescript
ConfigModule.withConfig({
  cmsComponents: {
    SearchBoxComponent: {
      disableSSR: true
    }
  }
});
```

## Placeholder Components

For Angular or web components that do not need any data from CMS (for example, login), you can use the CMS component of type `CMSFlexComponent` as a placeholder. This CMS component contains the special `flexType` attribute. Spartacus use the `flexType` attribute in its CMS mapping instead of the original component type.

In the same manner, the `uid` attribute of `JspIncludeComponent` is used in the CMS mapping instead of the original component type.

**Note:** It is recommended to use `CMSFlexComponent` instead of `JspIncludeComponent`, because the `uid` attribute in `JspIncludeComponent` must be unique, which means you cannot have two instances of the same `JspIncludeComponent`.

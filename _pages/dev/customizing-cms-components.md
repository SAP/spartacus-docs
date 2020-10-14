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
        component: 'path/to/banner/component/file.js#custom-banner'
    }
  }
});
```

If you prefer to load web component implementation script eagerly, you can manually include it in your index.html file using usual `script` tag, and skip it from mapping configuration:

```typescript
ConfigModule.withConfig({
  cmsComponents: {
    BannerComponent: {
        component: '#custom-banner'
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

## Guarding Components

It's often a case that some routes should be accessible only in certain conditions (i.e. Personal Details page should be opened only for signed-in user). For this purpose we can use Angular [Route Guards](https://angular.io/guide/router#milestone-5-route-guards) to perform some logic before entering a route (i.e fetch data from backend or check if user is authenticated) and decide whether it can be opened or we should redirect to other page.

The pages' content is often CMS-driven, so in Spartacus comes up with *configuring guards per CMS component*. Just after loading CMS components for a page from backend, all Guards of those components are executed. It allows for redirecting to other page if at least one guard decides so (i.e. due to missing authentication).

*Note: When many components at the same page have the same guard (i.e. AuthGuard), it will be executed only once.*

Below there's an example how to configure guards for CMS component:

```typescript
ConfigModule.withConfig({
  cmsComponents: {
    CheckoutProgress: {
      component: CheckoutProgressComponent,
      guards: [AuthGuard, CartNotEmptyGuard],
    },
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

## Handling Nested CMS Components (DRAFT)

The CMS allows the creation of nested components inside so-called container components. An example of such component is the `TabPanelContainer` that is used in the product details page to display the tabs. In this case, the container contains the different tab components.

Spartacus supports the dynamic rendering of nested components. This can be achieved by iterating over the list of child components and using the `cxComponentWrapper` directive to dynamically load each component. The list of child components is returned by the component container in the `components` field. Using the list of uids it's possible to fetch their conent using the `CmsService`'s `getComponentData` method.

The following example demontrate how the tabs are rendered in the product details page:

```typescript
// tab-paragraph-container.component.ts

/*...*/

constructor(
  public componentData: CmsComponentData<CMSTabParagraphContainer>,
  private cmsService: CmsService
) {}

components$: Observable<any[]> = this.componentData.data$.pipe(
  switchMap(data =>
    combineLatest(
      data.components.split(' ').map(component =>
        this.cmsService.getComponentData<any>(component).pipe(
          map(tab => {
            return {
              ...tab,
              title: `CMSTabParagraphContainer.tabs.${tab.uid}`, //Custom mapping to pass additional data to the HTML. If not required the map can be omitted.
            };
          })
        )
      )
    )
  )
);
```

In container component HTML file

```html
<!-- tab-paragraph-container.component.html -->

<ng-container *ngFor="let component of (components$ | async)">
  <h3>
    {{ component.title | cxTranslate }}
  </h3>
  <div>
    <!-- Renders the child component-->
    <ng-template [cxComponentWrapper]="component"> </ng-template>
  </div>
</ng-container>
```

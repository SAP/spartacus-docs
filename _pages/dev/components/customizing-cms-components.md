---
title: Customizing CMS Components
---

The Spartacus storefront is based on JavaScript, and accordingly, it is composed of a large number of fine-grained JavaScript components. However, there is a special kind of component to render CMS content. CMS components are dynamically added at runtime. The CMS component type, provided by the back end, is mapped to an equivalent JavaScript component. The mapping is provided in a configuration that can be customized. This allows you to configure a custom component to render a specific CMS component.

In addition, component-specific business logic can be customized. This requires an additional configuration where the custom service can be provided to the (default) component.

With this setup, CMS components can be customized in the following ways:

| Scenario          | Approach                                             | Example                                              |
| ----------------- | ---------------------------------------------------- | ---------------------------------------------------- |
| Customize style   | Add custom CSS rules<br/>(Out of scope for this doc) | Customize component style for the `LanguageSelector` |
| Replace component | Configure a custom component                         | Provide a custom `BannerComponent`                   |
| Customize logic   | Configure a custom service                           | Provide a custom `SearchBoxComponentService`         |

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Configuring Custom Components

There are two types of components that can be configured: Angular components, and web components (for which we currently provide experimental support).

### Custom Angular CMS Components

You can provide a CMS component configuration using `provideConfig`. The following configuration shows how to configure a custom Angular component for the CMS `BannerComponent`:

```typescript
provideConfig({
  cmsComponents: {
    BannerComponent: {
      component: CustomBannerComponent;
    }
  }
});
```

### Lazy-Loaded CMS Components (Code Splitting)

It is possible to use dynamic imports in CMS mapping to achieve lazy-loaded CMS components and code splitting.

The dynamic import should be defined as an arrow function, as shown in the following example:

```typescript
provideConfig({
  cmsComponents: {
    BannerComponent: {
      component: () =>
        import('./lazy-banner/lazy-banner.component').then(
          (m) => m.LazyBannerComponent
        ),
    }
  }
});
```

**Note:** Resolving chunks for code splitting is done at build time, and depends on how the code is imported. If there is even one static import included in the main chunk, the code will be bundled statically, and separate chunks will not be generated.

### Accessing CMS Data in CMS Components

The CMS data that is related to a component is provided to the component by the `CmsComponentData` service during instantiation. The `CmsComponentData` service contains the component `uid`, and also `data$`, which is an observable to the component payload. By making use of the Angular dependency injection (DI) system, components and component-specific services can use the `CmsComponentData`.

The following is an example:

```typescript
export class BannerComponent {
  constructor(protected component: CmsComponentData<CmsBannerComponent>) {}

  data$: Observable<CmsBannerComponent> = this.component.data$;
}
```

{% raw %}
```html
<ng-container *ngIf="data$ | async as data">
  Access `data` here, for example:
  <pre>{{ data | json }}</pre>
</ng-container>
```
{% endraw %}

### Using Web Components as CMS Components (Experimental Support)

**Warning:** This feature is experimental. Some functionality may not work as expected, and the API may mature or change in the future.

Web components have a lot of benefits, and as soon as some of the fundamentals of Angular are ready for this, Spartacus will most likely begin to use them. Some preparation has already been made to allow for loading web components, but the current recommendation is to use Angular components.

To configure a web component as a CMS component, the configuration must consist of the path to the JS file (web component implementation) and its tag name, separated by a hash symbol (`#`). The following is an example:

```typescript
provideConfig({
  cmsComponents: {
    BannerComponent: {
        component: 'path/to/banner/component/file.js#custom-banner'
    }
  }
});
```

If you prefer to load a web component implementation script eagerly, you can manually include it in your `index.html` file using the usual `script` tag, and skip it from the mapping configuration. The following is an example:

```typescript
provideConfig({
  cmsComponents: {
    BannerComponent: {
        component: '#custom-banner'
    }
  }
});
```

One JS file can contain more that one web component implementation, with each implementation used as a different `CmsComponent`.

This requires a separate build process to generate the JS chunk that holds the web component (or components), which is out of scope for this documentation.

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
provideConfig({
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

It is often the case that certain routes should only be accessible under certain conditions (for example, the account details page should only be accessible to a user who is signed in). Accordingly, you can use [Angular Route Guards](https://angular.io/guide/router#milestone-5-route-guards) to execute logic before loading a route (such as fetching data from the back end, or checking whether a user is authenticated), and then decide if the page should be opened, or whether Spartacus should redirect to another page.

The content of each page is often CMS-driven, so Spartacus allows you to configuring guards for each CMS component. Immediately after loading the CMS components for a page from the back end, all the relevant guards for those components are executed. This allows Spartacus to redirect to another page if even a single guard requires it (for example, because of missing authentication).

**Note:** When many components on the same page have the same guard (such as AuthGuard), the guard is executed only once.

The following is an example of how to configure guards for a CMS component:

```typescript
provideConfig({
  cmsComponents: {
    CheckoutProgress: {
      component: CheckoutProgressComponent,
      guards: [AuthGuard, CartNotEmptyGuard],
    },
  }
});
```

### Global Routing Guards Logic

Sometimes, you need to apply routing logic across all CMS pages (regardless of the specific CMS components presence). Examples include:
- Checking user authentication on every page.
- Verifying special query parameters on every page and redirecting if necessary.

Spartacus introduced `BEFORE_CMS_PAGE_GUARD` injection token to allow multiple global routing guards. Each guard provided with this token runs before the main `CmsPageGuard` logic (i.e. before all CMS-mapping driven guards) on every CMS page route. Here's how to implement it:

```ts
@Injectable({ providedIn: 'root' })
export class MyCustomGlobalGuard implements CanActivate { ... }
```

```ts
// In app.module.ts:
providers: [
  {
    provide: BEFORE_CMS_PAGE_GUARD,
    useExisting: MyCustomGlobalGuard,
    multi: true,
  },
]
```

These guards run on every CMS page route. If all emit `true`, `CmsPageGuard` logic executes. If any emit `false` or a `UrlTree`, `CmsPageGuard` logic is skipped, and navigation is blocked or redirected.

CAUTION: Use CMS-mapping driven guards rather than global ones when possible. Global logic runs on every page change, potentially affecting performance. Opt for CMS-mapping driven guards if the logic isn't applicable to every CMS page route.

## Controlling Server-Side Rendering

There may be cases where you do not want to use SSR to render all CMS components on the server. The following are some examples of when you should not render a CMS component on the server:

- a CMS component requires personalized input and should not, or cannot, be rendered without this input
- a CMS component is not required for SSR output, and for performance reasons, it is removed from the rendering process
- a CMS component interacts with external services (latency) and is not relevant for indexing and social sharing.

Although it is possible to add conditional logic in a component to render (parts of) the view in SSR, Spartacus offers a configuration for components to make this more generic, and to avoid any specific logic in components. The following is an example:

```typescript
provideConfig({
  cmsComponents: {
    SearchBoxComponent: {
      disableSSR: true
    }
  }
});
```

## Placeholder Components

For Angular or web components that do not need any data from CMS (for example, login), you can use the `CMSFlexComponent` as a placeholder. This CMS component contains the special `flexType` attribute. Spartacus uses the `flexType` attribute in its CMS mapping instead of the original component type.

In the same manner, the `uid` attribute of `JspIncludeComponent` is used in the CMS mapping instead of the original component type.

**Note:** It is recommended to use `CMSFlexComponent` instead of `JspIncludeComponent` because the `uid` attribute in `JspIncludeComponent` must be unique, which means you cannot have two instances of the same `JspIncludeComponent`.

## Handling Nested CMS Components

The CMS allows the creation of nested components inside so-called container components. An example of such a component is the `TabPanelContainer`, which is used in the product details page to display the tabs. In this case, the container contains the different tab components.

Spartacus supports the dynamic rendering of nested components. This can be achieved by iterating over the list of child components and using the `cxComponentWrapper` directive to dynamically load each component. The list of child components is returned by the component container in the `components` field. Using the list of `uid` attributes, it is possible to fetch their content using the `getComponentData` method of the `CmsService`.

The following example demonstrates how a container component TypeScript file and a container component HTML file are used together to render the tabs in the product details page:

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

# Largest Contentful Paint CMS Components

Supposing that you've analyzed each type of page in your storefront (e.g. Homepage, Product Details Page, Product Listing Page, ...) and you already know which CMS components on those pages contain the Largest Contentful Paint image (for each page type it can be a different CMS component), you should prioritize loading of such image.

## `fetchPriority` input on `<cx-media>` component

Since Spartacus v2211.42, in your custom components, you can do this by setting the input `[fetchPriority]="ImageFetchPriority.HIGH"` on the Spartacus `<cx-media>` component that contains the LCP image.

## `lcpCmsComponents` configuration

Since Spartacus v2211.43, in selected OOTB Spartacus components (listed below), it can be automatically done this for you, if you configure just the CMS component IDs that contain the LCP images. This way, you don't need to modify the OOTB components directly.

- `lcpCmsComponents.ids` allows for configuring a static list of CMS component IDs
- `lcpCmsComponents.idMarker` allows for configuring a special marker (by default `"__cxLCP__"`) - when it's present in the CMS component ID, the component will be automatically recognized

The selected OOTB Spartacus components implementations that currently can be controlled with `lcpCmsComponents` are:

- `BannerComponent`
- `ProductCarouselComponent`
- `ProductImageComponent` (and its related `ProductImageZoomProductImagesComponent`)
  (if you need it in other components, you can implement a custom component or request it as a feature in Spartacus)

Now let me give and example with example component IDs. Supposing I've analyzed my pages and I know that the LCP images in the following types of pages are:

- on Homepage: it's CMS component with ID `"ElectronicsHomepageSplashBannerComponent"`
- on Product Details Page: it's CMS component with ID `"ProductImagesComponent"`
- on Product Listing Page: it's CMS component with ID `"ProductListComponent"`

... then I can configure the `lcpCmsComponents` in my Spartacus app like this:

Option 1: static list of CMS component IDs:

```typescript
provideConfig({
  lcpCmsComponents: {
    ids: [
      'ElectronicsHomepageSplashBannerComponent',
      'ProductImagesComponent',
      'ProductListComponent',
    ],
  },
}),
```

Option 2: Change the CMS component IDs in the CMS backend to include the special marker `__cxLCP__`, for example:

```
ElectronicsHomepageSplashBannerComponent__cxLCP__
ProductImagesComponent__cxLCP__
ProductListComponent__cxLCP__
```

Then you don't need to configure Spartacus `lcpCmsComponents.ids` at all, as Spartacus will automatically recognize the components with the marker in their IDs (default marker is `__cxLCP__`).

If you want to change the marker, you can do it like this:

```typescript
provideConfig({
  lcpCmsComponents: {
    idMarker: '--myLCPMarker--,
  },
}),
```

## Implementation details

`CmsLcpService` takes CMS component's data of each CMS component and returns the `LcpPresence` enum value (`HAS_LCP` or `NO_LCP`) based on the configured `lcpCmsComponents` configuration and the CMS component's ID.

The information about the `LcpPresence` is provided on the DOM level via Angular Dependency Injection with the token `LCP_CONTEXT`, by the `CmsInjectorService` (which is used by the `[cxComponentWrapper]` directive).

Descendant components can inject the `LCP_CONTEXT` in their Typescript class. Alternatively they can inject it directly in the HTML template with the help of the `[cxLcpContext]` directive.
When the `LcpPresence` is `HAS_LCP`, then they can pass the input `[fetchPriority]="ImageFetchPriority.HIGH"` to the relevant child `<cx-media>` component.

See the following example of how to use the `LCP_CONTEXT` in a custom component:

```html
<ng-container *cxLcpContext="let lcpContext">
  <cx-media
    [fetchPriority]="lcpContext.fetchPriority$ | async"
    ...other-inputs-here...
  ></cx-media>
</ng-container>
```

Note: If your component contains multiple `<cx-media>` components, please mind to apply the input `[fetchPriority]="ImageFetchPriority.HIGH"` only on the `<cx-media>` component that contains the Largest Contentful Paint image, and not on all of them. Otherwise all those images to be loaded eagerly with high priority, which is not recommended.

## Custom logic of marking CMS components as containing LCP image

If you need more advanced custom logic to determine if a CMS component contains the LCP image, you can provide your own implementation of the `CmsLcpService`, e.g. in your app module.

The following is an example of how such a custom implementation:

```typescript
import { CmsLcpService } from '@spartacus/storefront';

/**
 * Tells whether the given CMS component is marked as containing
 * the LCP (Largest Contentful Paint) element.
 *
 * The CMS component with ID '"SharedBanner"` is displayed on all pages,
 * but it's the Largest Contentful Paint only on the homepage, but not on other pages.
 */
export class CustomCmsLcpService extends CmsLcpService {
  routingService = inject(RoutingService);

  getLcpPresence(
    componentData: ContentSlotComponentData
  ): Observable<LcpPresence> {
    return this.routingService.getRouterState().pipe(
      switchMap((routerState) => {
        const semanticRoute = routerState?.state?.semanticRoute;

        // Handle "SharedBanner" specially - mark it as LCP only on the homepage
        if (componentData?.uid === 'SharedBanner') {
          return of(
            semanticRoute === 'home' ? LcpPresence.HAS_LCP : LcpPresence.NO_LCP
          );
        }

        // For other CMS components, use the default logic (which checks the configured `lcpCmsComponents`)
        return super.getLcpPresence(componentData);
      })
    );
  }
}
```

# Largest Contentful Paint CMS Components

// Ideas-list (draft):

- purpose - seting the `fetchpriority` attribute on their main `<cx-media>` component
- `lcpCmsComponents` configuration:
  - static list of CMS component IDs
  - marker in the CMS component IDs

## `lcpCmsComponents` configuration

Supposing that you've analyzed each type of page in your storefront (e.g. Homepage, Product Details Page, Product Listing Page, ...) and you already know which CMS components on those pages contain the Largest Contentful Paint image (for each page type it can be a different CMS component), you should prioritize loading of such image.

In your custom components, you can do this by setting the input `[fetchPriority]="ImageFetchPriority.HIGH"` on the Spartacus `<cx-media>` component that contains the LCP image. This is supported since Spartacus v2211.42.

In OOTB some Spartacus components (listed in the end of this section), it can be automatically done this for you, if you just configure the CMS component IDs that contain the LCP images. This way, you don't need to modify the OOTB components directly.
Such a configuration is supported since Spartacus v2211.43.

- `lcpCmsComponents.ids` allows for configuring a static list of CMS component IDs
- `lcpCmsComponents.idMarker` allows for configuring a special marker (by default `__cxLCP__`) - when it's present in the CMS component ID, the component will be automatically recognized by Spartacus

The OOTB Spartacus components that currently support the `lcpCmsComponents` configuration are:

- `BannerComponent`
- `ProductCarouselComponent`
- `ProductImageComponent` (and its related `ProductImageZoomProductImagesComponent`)
  (in the future, more components might be added to this list)

For example, supposing I've analyzed my pages and I know that the LCP images in the following types of pages are:

- Homepage: CMS component ID `"ElectronicsHomepageSplashBannerComponent"`, which is a Spartacus `BannerComponent`
- Product Details Page: CMS component ID `"ProductImagesComponent"`, which contains a Spartacus `ProductImagesComponent`
- Product Listing Page: CMS component ID `"ProductListComponent"`, which contains a Spartacus `ProductListComponent`

... then I can configure the `lcpCmsComponents` in my Spartacus app like this:

Option 1:

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

Option 2:
Change the CMS component IDs in the CMS backend to include the marker `__cxLCP__`, for example:

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

`CmsLcpService` takes CMS component's data of each CMS component and returns the `LcpPresence` enum value (`HAS_LCP` or `NO_LCP`) based on the configured `lcpCmsComponents` and the CMS component's ID.

The information about the `LcpPresence` is provided on the DOM level via Angular Dependency Injection with the token `LCP_CONTEXT`, by the `CmsInjectorService` (which is used by the `[cxComponentWrapper]` directive), which provides also `CmsComponentData` at the DOM level.

Descendant components can inject the `LCP_CONTEXT` with the help of the `[cxLcpContext]` directive.
When the `LcpPresence` is `HAS_LCP`, then they can pass the input `[fetchPriority]="ImageFetchPriority.HIGH"` to the relevant child `<cx-media>` component.

## Customization of CmsLcpService

If you need more advanced logic to determine if a CMS component contains the LCP image, you can provide your own implementation of the `CmsLcpService`, e.g. in your app module.

The following is an example of how to provide a custom `CmsLcpService`:

```typescript
import { CmsLcpService } from '@spartacus/storefront';

/**
 * Tells whether the given CMS component is marked as containing
 * the LCP (Largest Contentful Paint) element.
 *
 * If a certain component is shared across multiple pages, but it's the LCP only on some of them,
 * this customized service can handle that. For example, a '"SharedBanner"` is displayed on all pages,
 * but it's LCP only on the homepage, but not on other pages.
 */
export class CustomCmsLcpService extends CmsLcpService {
  routingService = inject(RoutingService);

  getLcpPresence(
    componentData: ContentSlotComponentData
  ): Observable<LcpPresence> {
    return this.routingService.getRouterState().pipe(
      switchMap((routerState) => {
        const semanticRoute = routerState?.state?.semanticRoute;

        // Handle "SharedBanner" specially
        if (componentData?.uid === 'SharedBanner') {
          return of(
            semanticRoute === 'home' ? LcpPresence.HAS_LCP : LcpPresence.NO_LCP
          );
        }

        // For other components, use the default logic
        return super.getLcpPresence(componentData);
      })
    );
  }
}
```

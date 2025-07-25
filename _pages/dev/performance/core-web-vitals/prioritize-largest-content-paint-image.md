# Prioritize Largest Contentful Paint image

Supposing that you've analyzed each page in your storefront (e.g. Homepage, Product Details Page, Product Listing Page, ...) and you already know which CMS components on those pages contain the Largest Contentful Paint image (for each page it can be a different CMS component). Then you should implement hints for the browsers to prioritize loading of such image to improve the Largest Contentful Paint (LCP) metric.

## `fetchPriority` input on `<cx-media>` component

In your custom components that use `<cx-media>` as a child component, you can set the input `[fetchPriority]="ImageFetchPriority.HIGH"` on the Spartacus `<cx-media>` .This is supported since Spartacus v2211.42.

Under the hood, this will set the HTML attribute `fetchpriority="high"` on the `<img>` element inside the `<cx-media>` component, which will tell the browser to prioritize loading of this image. If it's the Largest Contentful Paint image, then it should help to achieve good LCP metric.

## CMS-driven configuration `lcpCmsComponents` 

In selected OOTB Spartacus components (listed below), the setting of the `fetchpriority="high"` can be automatically done this for you, if you configure just the CMS component IDs that contain the LCP images. This way, you don't need to modify directly the HTML templates of the OOTB components just to add the `fetchpriority` attribute.
This feature is supported only since Spartacus v2211.43.

The Spartacus global configuration:
- `lcpCmsComponents.ids` allows for configuring a static list of CMS component IDs
- `lcpCmsComponents.idMarker` allows for configuring a special marker (by default `"__cxLCP__"`) - when it's present in the CMS component ID coming from CMS data, the component will be automatically recognized as having  the Largest Contentful Paint image.

You can use either of those two options or both of them, depending on your needs.


### OOTB components that support `lcpCmsComponents` configuration
The selected OOTB Spartacus components implementations that currently can be controlled with `lcpCmsComponents` are:

- `BannerComponent`
- `ProductCarouselComponent`
- `ProductImageComponent` (and its related `ProductImageZoomProductImagesComponent`)
  (if you need it in other components, you can implement a custom component or request it as a new feature in OOTB Spartacus)

### Example of configuring `lcpCmsComponents`
To give an example, supposing I've analyzed my pages in my storefront and I know that the LCP images in the following types of pages are:

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

Option 2: Change the CMS component IDs in the CMS data to include the special marker `__cxLCP__`, for example:

```
ElectronicsHomepageSplashBannerComponent__cxLCP__
ProductImagesComponent__cxLCP__
ProductListComponent__cxLCP__
```

Then you don't need to configure Spartacus `lcpCmsComponents.ids` at all, as Spartacus will automatically recognize the components with the marker in their IDs (default marker is `__cxLCP__`).

If you want to change the default marker, you can do it like this:

```typescript
provideConfig({
  lcpCmsComponents: {
    idMarker: '--myCustomLcpMarker--,
  },
}),
```

### Implementation details of components supporting `lcpCmsComponents`

The components that support the `lcpCmsComponents` configuration will automatically set the input `[fetchPriority]="ImageFetchPriority.HIGH"` on the `<cx-media>` component inside them, if the CMS component is recognized as containing the Largest Contentful Paint image. They take this information from the Spartacus directive `*cxLcpContext` in the HTML template of the component. Alternatively, they can inject the `LCP_CONTEXT` injection token in their typescript code.
For example, the `BannerComponent` HTML template looks like this:

```html
<ng-container *cxLcpContext="let lcpContext">
  <cx-media
    [fetchPriority]="lcpContext.fetchPriority$ | async"
    ...other-inputs-here...
  ></cx-media>
</ng-container>
```

Note: If the CMS component contains multiple `<cx-media>` components (e.g. main image and a few thumbnails), the input `[fetchPriority]="ImageFetchPriority.HIGH"` should on the `<cx-media>` component that contains the Largest Contentful Paint image, and not on all of them. Otherwise all those images to be loaded eagerly with high priority, which is not recommended.

The Spartacus directive `*cxLcpContext` under the hood injects the injection token `LCP_CONTEXT` in their Typescript class. The token as the `lcpPresence$` observable, which emits the `LcpPresence` enum value (`HAS_LCP` or `NO_LCP`) based on the configured `lcpCmsComponents` configuration and the CMS component's ID.

The `LcpPresence` enum has two values:
- `HAS_LCP`: Indicates that the CMS component contains the Largest Contentful Paint image.
- `NO_LCP`: Indicates that the CMS component does not contain the Largest Contentful Paint image.

This value is then converted to the `fetchPriority$` observable which emits the value `ImageFetchPriority.HIGH` when the `LcpPresence` is `HAS_LCP`, or `undefined` when the `LcpPresence` is `NO_LCP`. This value can be then passed to the `<cx-media>` component as the input `[fetchPriority]`.

The injection token `LCP_CONTEXT` is provided at the DOM element level by the `CmsInjectorService`, which is used by the `[cxComponentWrapper]` directive that instantiates each CMS component in the DOM. The `CmsInjectorService` uses the `CmsLcpService` as a source of truth to determine if a CMS component contains the Largest Contentful Paint image.

`CmsLcpService` looks up the `lcpCmsComponents` configuration and checks if the CMS component's ID is in the list of configured IDs or contains the configured marker.

## Custom logic of marking CMS components as containing LCP image

If you need more advanced custom logic to determine if a CMS component contains the LCP image (i.e. other logic than just listing the component IDs), you can provide your own custom implementation of the `CmsLcpService`, e.g. in your app module.

The following is an example of how such a custom implementation, which marks the CMS component with ID `"SharedBanner"` as containing the LCP image, but only when it's present on the homepage, but not other pages:

```typescript
import { CmsLcpService } from '@spartacus/storefront';

/**
 * Tells whether the given CMS component is marked as containing
 * the LCP (Largest Contentful Paint) element.
 *
 * The CMS component with ID '"SharedBanner"` is displayed on all pages,
 * however it's the Largest Contentful Paint only on the homepage, but not on other pages.
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

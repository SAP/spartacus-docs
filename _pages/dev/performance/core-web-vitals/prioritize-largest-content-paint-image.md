# Prioritizing the Largest Contentful Paint Image

Once you analyze each page in your storefront, such as the Homepage, Product Details Page, and Product Listing Page, and determine which CMS components contain the Largest Contentful Paint (LCP) image (which can be in a different CMS component for each page), you can implement hints for the browsers to prioritize the loading of such image to improve the LCP metric.

## Setting the `fetchPriority` Input on the `<cx-media>` Component

In your custom components that use `<cx-media>` as a child component, you can set the `[fetchPriority]="ImageFetchPriority.HIGH"` input on the `<cx-media>` Spartacus component. This is supported with Spartacus 2211.42.

Under the hood, this sets the HTML attribute `fetchpriority="high"` on the `<img>` element inside the `<cx-media>` component, which tells the browser to prioritize the loading of this image. If it's the LCP image, then it helps to achieve a good LCP metric.

## CMS-Driven Configuration `lcpCmsComponents` 

In select out-of-the-box Spartacus components, the setting of the `fetchpriority="high"` attribute automatically improves the LCP metric, if you configure only the CMS component IDs that contain the LCP images. This way, you don't need to directly modify the HTML templates of the out-of-the-box components just to add the `fetchpriority` attribute.

In the Spartacus global configuration, the `lcpCmsComponents.ids` allows for configuring a static list of CMS component IDs. The `lcpCmsComponents.idMarker` allows for configuring a special marker (by default `"__cxLCP__"`). When it's present in the CMS component ID coming from CMS data, the component is automatically recognized as having the Largest Contentful Paint image. You can use either of the two options or both of them, depending on your needs.

The following out-of-the-box Spartacus component implementations can be controlled with `lcpCmsComponents`:

- `BannerComponent`
- `ProductCarouselComponent`
- `ProductImageComponent` (and its related `ProductImageZoomProductImagesComponent`)
  
If you need the `lcpCmsComponents` configuration in other components, you can implement a custom component or request it as a new feature in out-of-the-box Spartacus.

### Example: Configuring `lcpCmsComponents`

For example, if you analyzed the pages in your storefront and know that the LCP images in the following types of pages are the following:

- On the Homepage: A CMS component with the ID `"ElectronicsHomepageSplashBannerComponent"`
- On the Product Details Page: A CMS component with the ID `"ProductImagesComponent"`
- On the Product Listing Page: A CMS component with the ID `"ProductListComponent"`

You can the configure the `lcpCmsComponents` in your Spartacus app in one of the following ways.

1. Static list of CMS component IDs:

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

2. Change the CMS component IDs in the CMS data to include the special marker `__cxLCP__`, for example:

```
ElectronicsHomepageSplashBannerComponent__cxLCP__
ProductImagesComponent__cxLCP__
ProductListComponent__cxLCP__
```

Then you don't need to configure Spartacus `lcpCmsComponents.ids` at all, as Spartacus will automatically recognize the components with the marker in their IDs (default marker is `__cxLCP__`).

If you want to change the default marker, you can do it as follows:

```typescript
provideConfig({
  lcpCmsComponents: {
    idMarker: '--myCustomLcpMarker--,
  },
}),
```

### Implementation Details of Components Supporting `lcpCmsComponents`

The components that support the `lcpCmsComponents` configuration automatically set the `[fetchPriority]="ImageFetchPriority.HIGH"` input on the `<cx-media>` component inside them, if the CMS component is recognized as containing the LCP image. They take this information from the `*cxLcpContext` Spartacus directive in the component's HTML template. Alternatively, they can inject the `LCP_CONTEXT` injection token in their TypeScript code.

For example, the `BannerComponent` HTML template looks like the following:

```html
<ng-container *cxLcpContext="let lcpContext">
  <cx-media
    [fetchPriority]="lcpContext.fetchPriority$ | async"
    ...other-inputs-here...
  ></cx-media>
</ng-container>
```

Note: If the CMS component contains multiple `<cx-media>` components (such as a main image and a few thumbnails), the `[fetchPriority]="ImageFetchPriority.HIGH"` input should be on the `<cx-media>` component that contains the LCP image, and not on all of them. Otherwise, all those images will be loaded eagerly with high priority, which is not recommended.

Under the hood, the `*cxLcpContext` Spartacus directive injects the `LCP_CONTEXT` injection token in its TypeScript class. The token is the `lcpPresence$` observable, which emits the `LcpPresence` enum value (`HAS_LCP` or `NO_LCP`) based on the configured `lcpCmsComponents` configuration and the CMS component's ID.

The `LcpPresence` enum has two values:
- `HAS_LCP`: Indicates that the CMS component contains the Largest Contentful Paint image.
- `NO_LCP`: Indicates that the CMS component does not contain the Largest Contentful Paint image.

This value is then converted to the `fetchPriority$` observable, which emits the value `ImageFetchPriority.HIGH` when the `LcpPresence` is `HAS_LCP`, or `undefined` when the `LcpPresence` is `NO_LCP`. This value can be then passed to the `<cx-media>` component as the `[fetchPriority]` input.

The `LCP_CONTEXT` injection token is provided at the DOM element level by the `CmsInjectorService`, which is used by the `[cxComponentWrapper]` directive that instantiates each CMS component in the DOM. The `CmsInjectorService` uses the `CmsLcpService` as a source of truth to determine if a CMS component contains the LCP image.

`CmsLcpService` looks up the `lcpCmsComponents` configuration and checks if the CMS component's ID is in the list of configured IDs or contains the configured marker.

## Custom Logic of Marking CMS Components as Containing LCP Image

If you need more advanced custom logic to determine if a CMS component contains the LCP image (such as other logic than just listing the component IDs), you can provide your own custom implementation of the `CmsLcpService`, for example, in your app module.

The following is an example of how such a custom implementation, which marks the CMS component with a `"SharedBanner"` ID as containing the LCP image, but only when it's present on the homepage, and not other pages:

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

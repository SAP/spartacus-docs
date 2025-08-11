---
title: Prioritizing the Largest Contentful Paint Image
---

After you have analyzed each page in your storefront (such as the Homepage, Product Details Page, and Product Listing Page), and you have determined which CMS components contain the Largest Contentful Paint (LCP) image for each page (the LCP image may be in a different CMS component for each page), you can then provide information to the browser that prioritizes the loading of the LCP images. This can improve the LCP metric.

## Setting the `fetchPriority` Input on the `<cx-media>` Component

In your custom components that use `<cx-media>` as a child component, you can set the `[fetchPriority]="ImageFetchPriority.HIGH"` input on the `<cx-media>` Spartacus component. This is supported starting in Spartacus 2211.42.

This sets the `fetchpriority="high"` HTML attribute on the `<img>` element inside the `<cx-media>` component, which tells the browser to prioritize the loading of this image. If this is the LCP image, then it helps to achieve a good LCP metric.

## CMS-Driven Configuration of lcpCmsComponents

In certain out-of-the-box Spartacus components, when you set the `fetchpriority="high"` attribute, it automatically improves the LCP metric if you configure only the CMS component IDs that contain the LCP images. This way, you don't need to directly modify the HTML templates of the out-of-the-box components just to add the `fetchpriority` attribute.

In the Spartacus global configuration, the `lcpCmsComponents.ids` allow you to configure a static list of CMS component IDs. The `lcpCmsComponents.idMarker` allow you to configure a special marker (by default, this is `"__cxLCP__"`). When this is present in the CMS component ID coming from the CMS data, the component is automatically recognized as having the Largest Contentful Paint image. You can use either of the two options, or both of them, depending on your needs.

The following out-of-the-box Spartacus component implementations can be controlled using `lcpCmsComponents`:

- `BannerComponent`
- `ProductCarouselComponent`
- `ProductImageComponent` (and the related `ProductImageZoomProductImagesComponent`)
  
If you need the `lcpCmsComponents` configuration in other components, you can implement a custom component, or request it as a new feature in Spartacus.

### Configuring lcpCmsComponents

The following is an example of how to configure `lcpCmsComponents`.

In this example, you have analyzed the pages in your storefront and have determined that the LCP images in the Homepage, Product Details Page, and the Product Listing Page are the following:

- On the Homepage: a CMS component with the ID `"ElectronicsHomepageSplashBannerComponent"`
- On the Product Details Page: a CMS component with the ID `"ProductImagesComponent"`
- On the Product Listing Page: a CMS component with the ID `"ProductListComponent"`

You can the configure the `lcpCmsComponents` in your Spartacus app in one of the following ways:

You can provide a static list of CMS component IDs, as shown in the following example:

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

Or you can change the CMS component IDs in the CMS data to include the special marker `__cxLCP__`, as shown in the following example:

```text
ElectronicsHomepageSplashBannerComponent__cxLCP__
ProductImagesComponent__cxLCP__
ProductListComponent__cxLCP__
```

In this case, you don't need to configure Spartacus `lcpCmsComponents.ids` at all, because Spartacus will automatically recognize the components with the marker in their IDs (the default marker is `__cxLCP__`).

If you want to change the default marker, you can do it as follows:

```typescript
provideConfig({
  lcpCmsComponents: {
    idMarker: '--myCustomLcpMarker--',
  },
}),
```

### Implementation Details of Components Supporting lcpCmsComponents

The components that support the `lcpCmsComponents` configuration automatically set the `[fetchPriority]="ImageFetchPriority.HIGH"` input on the `<cx-media>` component inside them, if the CMS component is recognized as containing the LCP image. They take this information from the `*cxLcpContext` Spartacus directive in the component's HTML template. Alternatively, they can inject the `LCP_CONTEXT` injection token in their TypeScript code.

For example, the following is an example of the `BannerComponent` HTML template:

```html
<ng-container *cxLcpContext="let lcpContext">
  <cx-media
    [fetchPriority]="lcpContext.fetchPriority$ | async"
    ...other-inputs-here...
  ></cx-media>
</ng-container>
```

**Note:** If the CMS component contains multiple `<cx-media>` components (such as a main image and a few thumbnails), the `[fetchPriority]="ImageFetchPriority.HIGH"` input should be on the `<cx-media>` component that contains the LCP image, and not on all of them. Otherwise, all those images will be loaded eagerly with high priority, which is not recommended.

The `*cxLcpContext` Spartacus directive injects the `LCP_CONTEXT` injection token in its TypeScript class. The token is the `lcpPresence$` observable, which emits the `LcpPresence` enum value (`HAS_LCP` or `NO_LCP`) based on the configured `lcpCmsComponents` configuration and the ID of the CMS component.

The `LcpPresence` enum has two values:

- `HAS_LCP`, which indicates that the CMS component contains the Largest Contentful Paint image.
- `NO_LCP`, which indicates that the CMS component does not contain the Largest Contentful Paint image.

This value is then converted to the `fetchPriority$` observable, which emits the value `ImageFetchPriority.HIGH` when the `LcpPresence` is `HAS_LCP`, or `undefined` when the `LcpPresence` is `NO_LCP`. This value can then be passed to the `<cx-media>` component as the `[fetchPriority]` input.

The `LCP_CONTEXT` injection token is provided at the DOM element level by the `CmsInjectorService`, which is used by the `[cxComponentWrapper]` directive that instantiates each CMS component in the DOM. The `CmsInjectorService` uses the `CmsLcpService` as a source of truth to determine if a CMS component contains the LCP image.

`CmsLcpService` looks up the `lcpCmsComponents` configuration and checks if the ID of the CMS component is in the list of configured IDs or contains the configured marker.

## Custom Logic for Marking CMS Components as Containing the LCP Image

If you need more advanced logic to determine if a CMS component contains the LCP image (such as logic other than just listing the component IDs), you can provide your own custom implementation of the `CmsLcpService`. This custom implementation can be provided in your app module, for example.

The following is an example of a custom implementation that marks the CMS component with a `"SharedBanner"` ID as containing the LCP image, but only when this component is present on the Homepage. Other pages are not affected.

```typescript
import { CmsLcpService } from '@spartacus/storefront';

/**
 * Tells whether the given CMS component is marked as containing
 * the LCP (Largest Contentful Paint) element.
 *
 * The CMS component with ID '"SharedBanner"' is displayed on all pages,
 * however it's the Largest Contentful Paint image only on the Homepage, and not on other pages.
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

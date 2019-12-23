---
title: Deferred Loading
---

Deferred Loading is a technique to postpone rendering of CMS Components. Components which are outside the user's visible area (the *viewport*), will not be rendered in advance. This technique is introduced to improve the initial rendering of the complete page. This does not only saves the creating of components but also defers further loading of component specific data.

The following examples illustrate how deferred loading improves the page load:

-   The components used in the hamburger menu are deferred on mobile, since they're not inside the viewport as long as the menu is collapsed. This saves the creation of those components as well as loading languages, currencies, navigation and CMS links.
-   Product reviews are loaded in the product review component. As long as the user hasn't tabbed or scrolled into the review component, those reviews are not loaded.
-   Carousel slides outside the viewport are deferred until the user "scrolls" to them. This will not only reduce backend calls for additional carousel data (i.e. products), but also deferres loading of images.

Deferred loading is currently mainly driven by page slots. As soon as a page slot enters the viewport, all components of the slot are getting rendered. Additionally, embedded components in container components benefit from deferred loading.

## Enable Deferred loading

Deferred loading is available sine version 1.4, but is disabled by default. In order to enable it, you must configure the `DeferLoadingStrategy` in the `LayoutConfig` Configuration. There are two strategies available:

-   `INSTANT` (default)
-   `DEFER`

The following `LayoutConfig` demonstrate enabling of the deferred loading feature:

```typescript
b2cLayoutConfig: LayoutConfig = {
  deferredLoading: {
    strategy: DeferLoadingStrategy.DEFER,
    intersectionMargin: '50px',
  },
  layoutSlots: {
      [...]
  }
}
```

An optional `intersectionMargin` can be specified to control the so-called _bounding box_ of the components before they intersect the viewport. Increasing the margin will accelerate loading of the page slot components before the slot intersects the viewport.

## Component Loading Strategy

The deferred loading strategy can be customised per CMS component, using the CMS component configuration. This is required for some components which are structured in page slots outside the initial view port, but moved into the viewport by component specific CSS rules; as long as the component is not rendered, the CSS rules that move the component in the viewport are not applied. The consent banner component is a component that follows this pattern. The following configuration shows the configuration for this compnent and it's `INSTANT` loading strategy:

```typescript
ConfigModule.withConfig(<CmsConfig>{
    cmsComponents: {
        AnonymousConsentManagementBannerComponent: {
            component: AnonymousConsentManagementBannerComponent,
            deferLoading: DeferLoadingStrategy.INSTANT
        }
    }
});
```

Components can also be configured to use `DEFER` loading strategy while the global strategy is set to `INSTANT`.

### SSR

Deferred loading does not applied to SSR, so that crawlers will receive the full DOM.

## Related Techniques

There are a number of related techniques that we like to highlight:

-   Lazy loading of JS chunks – Deferred Loading does _not_ lazy-load the component JS bundles; it is only concerned with the creation / rendering of the components.
-   Above-the-fold loading – Deferred Loading is tightly coupled to so-called [Above the fold loading({{ site.baseurl }}{% link _pages/dev/performance/above-the-fold.md %}), but this is documented in another section.
-   Deferred Loading is not related to the native lazy loading of images which has recently landed in Chrome. This new API is not yet fully supported, but could be used in combination with deferred loading for CMS components.

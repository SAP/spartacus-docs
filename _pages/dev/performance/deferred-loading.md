---
title: Deferred Loading
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Deferred loading is a technique that is used to postpone the rendering of CMS components. Any component that is outside the viewport (that is, the area that is visible to the user) is not rendered in advance. This improves the initial rendering of the complete page. Deferred loading not only defers the creation of components, it also defers the loading of any component-specific data, such as media or back end calls.

The following examples illustrate how deferred loading improves the page load:

- The components used in the hamburger menu are deferred on mobile devices, since they are not inside the viewport when the menu is collapsed. This defers the creation of those components, as well as loading languages, currencies, navigation, and CMS links.
- Product reviews are loaded in the product review component. As long as the user has not tabbed or scrolled into the review component, those reviews are not loaded.
- Carousel slides outside the viewport are deferred until the user "scrolls" to them. This not only reduces back end calls for additional carousel data (such as products), but it also defers the loading of images.

Deferred loading is currently driven mainly by page slots. As soon as a page slot enters the viewport, all components of the slot are rendered. Additionally, embedded components in container components benefit from deferred loading.

## Enable Deferred Loading

Deferred loading is disabled by default. To enable deferred loading, you must configure the `DeferLoadingStrategy` in the `LayoutConfig` Configuration. The following strategies are available:

- `INSTANT` (default)
- `DEFER`

In the following `LayoutConfig` example, the deferred loading feature is enabled:

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

An optional `intersectionMargin` can be specified to control the so-called "bounding box" of the components before they intersect the viewport. Increasing the margin accelerates the loading of the page slot components before the slot intersects the viewport.

## Component Loading Strategy

The deferred loading strategy can be customized per CMS component, using the CMS component configuration. This is required for some components that are structured in page slots outside the initial viewport, but which are moved into the viewport by component-specific CSS rules: as long as the component is not rendered, the CSS rules that move the component in the viewport are not applied. The consent banner component is a component that follows this pattern. The following example shows the configuration for the consent banner component, with its `INSTANT` loading strategy:

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

**Note:** Components can also be configured to use the `DEFER` loading strategy while the global strategy is set to `INSTANT`.

### Server-Side Rendering

Deferred loading is not applied to server-side rendering, so that crawlers can receive the full DOM.

## Related Techniques

There are a number of related techniques to be aware of:

- Lazy loading of JS chunks: Deferred loading does not lazy-load the component JS bundles. Deferred loading is only concerned with the creation or rendering of components.

- Above-the-fold loading: Deferred loading is tightly coupled to so-called "above-the-fold loading". For more information, see [Above-the-Fold Loading]({{ site.baseurl }}{% link _pages/dev/performance/above-the-fold.md %}).

- Native lazy loading of images: Deferred loading is not related to the native lazy loading of images that has recently been implemented in some browsers. This new API is not yet fully supported, but could be used in combination with deferred loading for CMS components.

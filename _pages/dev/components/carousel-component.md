---
title: Carousel Component
feature:
- name: Carousel Component
  spa_version: 1.0
  cx_version: n/a
---

The carousel component provides a generic UI component for displaying list items in a carousel. The component is not tied to specific items, such as products, pages, categories, or images. The focus of the component is on the sliding layout, and on the navigation elements that allow users to access the different slides.

The carousel component is highly reusable, and is used by various CMS components, such as the following:

- `ProductCarouselComponent`: a carousel of products.
- `ProductReferenceComponent`: a carousel of products that is used to show product references, such as upselling, cross selling, related accessories, and so on.
- `ProductImageComponent`: a carousel of product images on the **Product Details** page.
- `RotatingImageComponent`: a carousel of (banner) components that is typically used to slide _hero images_ on the landing page.

## Flexible Template for Carousel Items

The flexibility of the carousel component to render any item is driven by the input template that is used to render a given item. The carousel component delegates the rendering of the actual item to the given template. The following is an example of handing over a template:

```html
<cx-carousel title="Example Carousel Usage" [items]="items$ | async" [template]="carouselItem"> </cx-carousel>

<ng-template #carouselItem let-item="item">
    <!-- custom template implemention 
  for the items goes here... -->
</ng-template>
```

With this setup, the carousel component can serve the rendering of any carousel item, as long as the overarching UI fits the carousel design.

## Slides

The carousel component works with the concept of slides. A slide holds one or more items. While the rendering of the carousel item is the concern of the "calling" component, the carousel component takes care of creating the slides and the required navigation.

### Slide Navigation

There are two types of navigation for the carousel, as follows:

- Previous and Next buttons
- Slide Indicator Buttons, which are optional

The buttons use icons by default, but the icons are configurable. This is a result of both the way Spartacus implements its [{% assign linkedpage = site.pages | where: "name", "icon-library.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/styling-and-page-layout/icon-library.md %}), as well as the fact that there is an input for icons available in the component, as shown in the following example:

```typescript
@Input() indicatorIcon = ICON_TYPE.CIRCLE;
@Input() previousIcon = ICON_TYPE.CARET_LEFT;
@Input() nextIcon = ICON_TYPE.CARET_RIGHT;
```

When there are no slides to navigate, the buttons do not appear. When a button interaction is not available (for example, there is no previous button on the first slide), the button moves into a disabled state. Additionally, the `indicatorIcon` navigation can be turned off completely by setting the `hideIndicators` to `true`.

## Responsive Calculation of Items in Each Slide

The number of carousel items in each slide is calculated. The calculation is driven by the minimum width per item and the available space.
The given item width (`itemWidth`) can be specified in pixels or percentages. The calculation for the number of items per slide uses this `itemWidth` and the host element `clientWidth`. This makes the carousel reusable in different layouts (such as a one-column grid or a two-column grid), and enables the carousel to be fully responsive at the same time.

## Configuring Slide Actions

You can configure the actions for a slide in the `ProductCarouselComponent`. For example, you can add an **Add to Cart** button to each slide to make it more efficient for customers to add certain recommended products to their cart.

You can configure which CMS components render with a product, as shown in the following example:

```typescript
provideConfig({
  cmsComponents: {
    ProductCarouselComponent: {
      data: {
        composition: {
          inner: [
            // Names of your CMS components here, such as "ProductAddToCartComponent", "ConfigureProductComponent", and so on.
          ]
        }
      }
    }
  }
})
```

To get the data for a specific product, your CMS component must inject the `ProductListItemContext` to retrieve the relevant data.

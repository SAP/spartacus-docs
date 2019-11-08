---
title: Carousel Component
---

The Carousel Component provides a generic UI component list items in carousel. The component is not concerned with specific items, such as products, pages, categories or images. It is only concerned with the sliding layout and provides navigation elements to navigate through the different slides.

The Carousel Component is highly reusable, and is already used by various CMS components:

-   `ProductCarouselComponent` – a carousel of products
-   `ProductReferenceComponent` - a carousel of products, used to show product references, such as upsell, cross-sell, accessoiries, etc.
-   `ProductImageComponent` – a carousel of product images on the Product Detail Page.
-   `RotatingImageComponent` – a carousel of (Banner) components, typically used to slide _hero images_ on the landing page.

## Flexible Template for Carousel Item

The flexiblity of the Carousel Component to render any item is driven by the input template which is used to render the given item. The Carousel Component will delegate the rendering of the actual item to the given template. An example of handing over a template is given below:

```html
<cx-carousel title="Example Carousel Usage" [items]="items$ | async" [template]="carouselItem"> </cx-carousel>

<ng-template #carouselItem let-item="item">
    <!-- custom template implemention 
  for the items goes here... -->
</ng-template>
```

With this setup, the Carousel Component can serve the rendering any Carousel Item, as long as the overarching UI fits the carousel design.

## Slides

The Carousel Component has the notion of _slides_. A slide holds one or multiple items. While the rendering of the carousel item is the concern of the _calling_ component, the Carousel Component takes care of creating slides and the requried navigation.

### Slide Navigation

There are 2 types of navigation for the Carousel:

-   Previous / Next buttons
-   (optional) Slide Indicator Buttons

The buttons are using icons by default, but the icons are configurable. Not only because of the Icon Configuration concept (https://sap.github.io/cloud-commerce-spartacus-storefront-docs/icon-library/) in Spartacus, but also because there's an input icons available on the component:

```typescript
@Input() indicatorIcon = ICON_TYPE.CIRCLE;
@Input() previousIcon = ICON_TYPE.CARET_LEFT;
@Input() nextIcon = ICON_TYPE.CARET_RIGHT;
```

When there are no slides to navigate, the buttons will not appear. When a button interaction is not available (i.e. previous button on the first slide), the buttton will move in disabled state. Additionally, the indicatorIcon navigation can be completely turned off by setting the `hideIndicators` to false.

## Calculated Items per Slide (Responsive)

The number of carousel items per slide is calculated. The calculation is driven by the minimum width per item and the available space.
The given item width (`itemWidth`) can be specified in pixels or percentages. The calculation for the number of items per slide uses this `itemWidth` and the host element `clientWidth`. This makes the carousel reusable in different layouts (i.e. 1-column grid vs 2-column grid) and is fully responsive at the same time.

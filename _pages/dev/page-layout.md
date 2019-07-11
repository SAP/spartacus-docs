---
title: Page Layout (DRAFT)
---

Spartacus is based on a Single Page Application design pattern, but there are still pages that are rendered in the storefront. The concept of a "page" is key to the web and cannot be avoided: pages are identified by URLs, indexed by search engines, shared through social media, stored in browser history, and so on. Pages are fundamental to end users, and to the content creation process as well.

## Page Structure

Pages in CMS are constructed with slots and components. A page contains slots, and slots contain components. To organize common slots and components, Spartacus supports page templates. A page template contains layout and components that can be used globally, such as header and footer sections.

The CMS provides the page structure, but it does not provide a clear layout definition. The page structure only provides an ordered list of components per slot, but the slots themselves do not have meta info on how they should be rendered in the layout.

To provide layout information to the view logic, Spartacus uses a `LayoutConfig` configuration object to render the page slots in a given order. Additionally, you can use CSS rules to provide a specific layout.

## Configuring the Layout

Spartacus makes no distinction between page templates and page sections, and you can configure both with the `LayoutConfig`. As with any Spartacus configuration, you can provide the `LayoutConfig` to the `ConfigModule`.

For each template or section, the slots can be configured in a specific order. The following is an example:

```typescript
const defaultLayoutConfig: LayoutConfig = {
  header: {
    slots: [
      'TopHeaderSlot',
      'NavigationSlot'
    ]
  },
  footer: {
    slots: ['FooterSlot']
  },
  LandingPageTemplate: {
    slots: [
      'Section1',
      'Section2A',
      'Section2B'
    ]
  }
};
```

**Note**: To simplify the initial setup for projects, if the page layout configuration is incomplete, all page slots are rendered on the page. In addition, a warning is printed to the console, along with information about the available page slots that could be configured.

## Using Outlets to Override Page Templates

When page templates, slots or components are rendered dynamically rendered in Spartacus, outlets get added for each slot. Outlets can be use to replace part of a page template in Spartacus. The outlets for the slots are easy to find as their label corresponds to name of the element being wrapped.

The following is an example of how to replace the `ProductAddToCartComponent` using an outlet:

```html
<ng-template cxOutletRef="ProductAddToCartComponent">
  <div>Custom Title</div>
  <custom-add-to-cart></custom-add-to-cart>
</ng-template>
```

### Outlet Context

Outlets contain a context which is an object containing various attributes that can be used within the outlet. The context is different per outlet based on the element it contains.

#### Page Template

- `templateName$`: Name of the template. (Observable)
- `slots$`: Slots in the template. (Observable)
- `sections$`: Sections in the template. (Observable)

#### Slot

- `components$`: List of components in the slot. (Observable)

#### Component

- `component`: The component data as returned by the backend.

The following example demonstrates how to use the context to get the list of components within a slot:

{% raw %}
```html
<ng-template cxOutletRef="Section1" let-model>
  "Section1" position
  <pre>{{ model.components$ | async | json }}</pre>
</ng-template>
```
{% endraw %}

### Outlet Position

In addition to context the outlets have another attribute for positioning, `cxOutletPos`. This attibute allows the code from the outlet to be injected `before`, `after` or `replace` the reference. If no value is specified the code will be replaced.

This following example demonstate addidng a label before the `ProductDetailsPageTemplate`:

```html
<ng-template cxOutletRef="ProductDetailsPageTemplate" cxOutletPos="before">
  <div class="before-pdp">
    Campaign UI for Canon
  </div>
</ng-template>
```

**Note**: Some slots have the same name therefore, their outlets have the same label. This can lead to code being injected in unwanted parts of the site. This is a known issue and the team is working on fixing it.

## CSS Layout Rules

While the slots of the page layout or section layout are rendered, the page template name is added as a CSS class. You can also select each and every slot by using the `cx-page-slot` or `position` name of the slot. You can use these CSS classes to map specific style rules to the layout in a loosely-coupled way. The CSS provided by Spartacus is optional, so that you can add new styles or modify existing ones.

Because the page layout is driven by page template codes and position names, the layout is tightly coupled to the installation data of the back end. If you decide to add or replace page templates and slot positions, you need to adjust the relevant CSS rules as well.

## Choosing an Adaptive or Responsive Layout

The Spartacus storefront is implemented using responsive design, rather than adaptive design. For storefront software development, as well as for content production, responsive design is widely accepted as being faster to implement and more cost effective.

However, nothing stops you from using an adaptive design approach in your Spartacus storefront. The SAP Commerce back end supports multi-site implementations, and can be configured to have different content (catalogs) for different sites.

Adaptive design in the UI layer can lead to an improved experience for the end user, both in terms of accessibility and performance. For both of these aspects, Spartacus allows for an adaptive configuration for each breakpoint. A specific slot configuration can be provided for each breakpoint. The sample configuration below shows an alternative slot configuration for extra-small (xs) screens, with a different order (to improve accessibility), and a limited number of slots (to improve performance).

```typescript
const defaultLayoutConfig: LayoutConfig = {
  header: {
    slots: [
      'FirstSlot',
      'SecondSlot',
      'LastSlot'
      ],
    xs: [
      'LastSlot',
      'FirstSlot'
      ]
  }
};
```

### Accessibility

A responsive-only approach cannot address all use cases for accessibility, such as the ability to re-order components. You may also need to re-order components to optimize the user experience for different devices that access your storefront. The header in Spartacus is a good example: for large screens, all elements are visible, but on small devices, some of the components are hidden behind a hamburger menu, and some components are rearranged.

Although CSS supports the re-ordering of DOM elements, both with `flex-box` and `grid`, the re-ordered DOM elements are not synchronized with the HTML tab system. This does not provide an optimal experience for people who use the tab system to navigate through the storefront. A slot configuration for each breakpoint solves this problem. The layout is (re)build for each breakpoint.

### Performance

A potential bottleneck with responsive design is the amount of content that is rendered on a mobile device. Especially on slower networks (such as 2G), there is a performance concern for storefronts that render all content immediately. While this could (and should) be solved at the back end, the layout configuration can be used to remove some of the content of the page.

### Server-Side Rendering

Special attention is required when pages are rendered on the server, using server-side rendering (SSR). Whenever the SSR process or the edge cache layers are not able to address the client device, the process should decide on the preferred breakpoint. A breakpoint that renders all content is better for search engines, and this would be typical for a desktop breakpoint. On the other hand, a breakpoint that is optimized for performance may provide a better experience for end users who are accessing the storefront on a mobile device.

In Spartacus, all content is always rendered. There is an open ticket for improving the server-side rendering based on device detection, if possible, or else providing a standard viewport (mobile first).

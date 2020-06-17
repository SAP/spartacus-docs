---
title: CSS Architecture
---

This document provides a high level overview of the CSS architecture of Spartacus.

## Style Library

Spartacus is provided as a set of standard components, distributed in so-called _npm libraries_. Libraries are used to ensure both extensibility and upgradability at the same time.

To deliver full flexibility for styling, all CSS rules are provided in a separate library (`@spartacus/styles`). This make the styles completely optional, configurable and extendible. Customers can extend or replace the standard styles as well as implement their own style rules.

Additionally, an existing UI framework such as Bootstrap can be used in Spartacus without making it a hardcoded dependency.

### Versioning

Spartacus libraries support Semantic Versioning, which means that breaking changes are not allowed during the lifetime of a major version. This is also true for the style library. A new style rule, or adjusted rule, will influence the existing storefront experience. Customers who trust on the semantic version scheme, should not be surprised with new styles during the lifetime of a stable release.

At the same time, Spartacus likely evolves from minor to minor version. To allow for gradual changes in the style layer, new or adjusted style rules are added for a specific version. These changes are not added in the style build process, unless you would explicitly "opt-in" for those changes. You need to set a single variable, to leverage the latest breaking styles changes.
Non-breaking changes will be added regardless.

The following code snippet illustrates an additional style for version 2.2:

```scss
cx-mini-cart {
  @include forVersion(2.1) {
    background: blue;
  }
  @include forVersion(2.2) {
    background: blue;
  }
}
```

If you use any `2.x` Spartacus release, you would not get the styles added through the mixin `forVersion`. Only if you explicitly request for a `styleVersion` of 1 or higher, you will have those rules applied. The versioning cumulates all the previous changes, which means that you'd receive all breaking changes until the given version. The following snippet illustrates opting-in of all style rules until minor version 2.

```scss
// Add this in styles.scss, before importing
// the library styles.
$styleVersion: 2;
```

Alternatively, you can use a special flag to always receive the latest styles. This can be useful for development, demos or proof of concepts.

```scss
// Add this in styles.scss, before importing
// the library styles.
$useLatestStyles: true;
```

The minor version driven styles are typically being merged to the next major release.

#### Versioning of styles in version 1.x

In version 1.0, style versioning was managed with an optional _theme_. The `Calydon` theme was used to add new style rules into the style layer.
The new versioning technique describe in the previous section makes the former theme based versioning obsolete. The calydon theme is therefor no longer used and supported in Spartacus 2.0.

## CSS Technology

Spartacus is developed with a combination of CSS techniques:

- [SASS](https://github.com/sass/node-sass) is used as the pre-processing language, like most of todays UI frameworks do
- [CSS custom properties](https://www.w3schools.com/css/css3_variables.asp) are used for global theming
- [CSS post processing](https://postcss.org/) is intended to be used to polyfill any of required syntax for older browsers.

### View encapsulation

View encapsulation ensures isolation of styles in single DOM. View encapsulation can be used to ensure that the component style rules from one component do not interfere with other components. View encapsulation is standardized in a web component architecture and provided by the so-called `shadow-dom`. For applications that do not leverage the shadow-dom there are a few alternatives available:

- **Emulated encapsulation**  
  Angular provides _emulated_ view encapsulation by adding a (random) component ID to the generated CSS, so that the CSS rules are tightly coupled ot the component and will not interfere with other components.
- **BEM**  
  BEM is an older technique that use a very specific class name convention to make the component styles specific to the given element(s).
- **iFrames**  
  We only mention this to be complete, but it's not a viable option due to a number of disadvantages including bad user experience.

None of the above techniques work for spartacus:

- Angular's emulated encapsulation cannot be used since the component styles are provided by the style library.
- BEM is considered old-fashion and complex. Moreover, a well defined fine-grained component architecture doesn't need BEM to encapsulate the styles.

Instead, the fine-grained component selectors are used to encapsulate the styling. You can read more on this in the section regarding component styling.

## Global Theming

Global theming is organized with variables, so that theming isn't hardcoded. For variables there are 2 common approach that can be applied:

- SASS variables
- CSS custom properties (CSS variables)

Spartacus is using CSS variables for theming. CSS variables have the advantage of being runtime configurable. Moreover, they can pierce through the so-called shadow-dom (web components). Additionally, CSS variables are inherited and offer more flexibility than SASS variable.

Theming variables contribute to the so-called contract that Spartacus provides to customers. This contract is intended to be stable and should rarely change. Only with major releases, Spartacus could introduce a new set of variables, although this is not considered best practice.

In order to provide a stable set of variables, variables will be mainly used for color-schemes and font definitions. It can be considered as a set of global theming definition.

The following snippet shows an example of a CSS variable:

```css
:root {
  --cx-color-primary: red;
}

cx-link {
  color: var(--cx-color-primary);
}
```

The CSS variables can be customized on the root of the document or for specific selectors.

## Component Styles

Spartacus consists of a large number of components that can be used by customers to build their storefront experience. While commerce becomes a commodity, styling is by default opinionated. Not only the colors and fonts, but also the real estate of components as well as backgrounds, lines, etc.

Whatever Spartacus delivers, it will _not_ represent the customers brand/corporate identity. To this reason, Spartacus intends to be highly flexible, so that component styles can be skipped entirely or extended by customers.

Since Spartacus components are built and distributed in libraries, component styles cannot be used. These styles would be pre-processed and baked into the component library. This means that the CSS rules would not be optional, nor would they be easily customizable.

Instead, component styles have been delivered optionally in the styles library. Customers can use those styles, extend them or completely skip them and build the CSS rules from scratch. The `contract` between the style library and the component library is done through the (unique) component selector.

### Placeholder selectors

To make the css rules provided in the style library completely optional, the styles are wrapped in so-called _placeholder_ selectors. Placeholder selectors are a sass technique that start with a percentage, for example `%cx-mini-cart`. Placeholder selectors are not added to the final CSS, they need to be explicitly extended to end up in the final CSS.

The following snippet provides an example of a component style, using placeholder selector.

```scss
%cx-link {
  a {
    display: inline;
    padding: 0;
    margin: 0;
    color: currentColor;
    display: block;
  }
}
```

While the placeholder selector can be safely imported, it will only affect the final css if it's been used explicitly. The styling can therefore be extended as follows:

```scss
cx-link {
  @extend %cx-link !optional;
  a {
    color: red;
  }
}
```

The `optional` flag ensures that code will not break during build whenever a specific import is not part of the imported styles.

Spartacus will generate the component by iterating over the configured component selectors.

### Skipping Specific Component Styles

Component styles are optional, because they are pulled in from the style library. Therefore, you might want to disable some standard component styles entirely. To disable standard component styles, you can add the component selectors to the `$skipComponentStyles` list. The following is an example that demonstrates skipping two standard components from the style library:

```scss
$skipComponentStyles: (cx-product-carousel, cx-searchbox);
```

Skipping specific component styles might be beneficial if you need to create styles from scratch and do not want to override specific style rules coming from the Spartacus style library.

## Page layout styles

Global theming and component styles are most important to render components on the page, however the overall layout that orchestrates components on a page is another important style layer. This layer is detailed in [Page Layout]({{ site.baseurl }}{% link _pages/dev/page-layout.md %}).

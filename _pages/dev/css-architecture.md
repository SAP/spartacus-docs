---
title: CSS Architecture (DRAFT)
---

This document provides a high level overview of the CSS architecture of Spartacus.

## Style Library

Spartacus is provided as a set of standard components, distributed in so-called _npm libraries_. Libraries are used to ensure both extensibility and upgradability at the same time.

To deliver full flexiblity for styling, all CSS rules are provided in a separate library (`@spartacus/styles`). This make the styles completely optional, configurable and extendible. Customers can extend or replace the standard styles as well as implement their own style rules.

Additionally, an existing UI framework such as Bootstrap can be used in Spartacus without making it a hardcoded dependency.

### Style Library Versioning

Spartacus libraries support Semantic Versioning, which means that no breaking changes are allowed during a major version. Uncontrolled style changes in Spartacus would have a bad effect on customers, as unexpected styling could appear without notice.

To provide a stable style release for a major version of the library, the style library is shipped with the same semantic versioning scheme as the `core` and `component` libraries. Customers can rely on a major version of the style library, so that only new features and bugs can be expected in minor and patch releases.
This means that the style rules for a major version cannot get any changes other then new (optional) styles (for example for a new component) or to patch a bug.

In order to continuously improve the styles during a major release, new styles might be isolated in special theme. This theme could be shipped already during the major release. This allows to demonstrate and use right away, without interfering with existing users.

The table below shows an example of some potential releases.

| Version | Theme                     | Note                                                                                                            |
| ------- | ------------------------- | --------------------------------------------------------------------------------------------------------------- |
| 1.0.0   | sparta                    | standard theme for 1.0.0 release                                                                                |
| 1.0.1   | sparta                    | _patch_ release with a sparta theme fix                                                                         |
| 1.1.0   | sparta, coconut-beta-1    | new features for sparta and new beta release for new coconut theme                                              |
| 2.0.0   | cocunut (default), sparta | New major version could promote a new theme as the default. The sparta style could become deprecated over time. |

## CSS Technology

Spartacus is developed with a combination of CSS techniques:

- [SASS](https://github.com/sass/node-sass) is used as the pre-processing language, like most of todays UI frameworks do
- [CSS custom properties](https://www.w3schools.com/css/css3_variables.asp) are used for global theming
- [CSS post processing](https://postcss.org/) is intended to be used to polyfil any of required syntax for older browsers.

### View encapsulation

View encapsulation ensures isolation of styles in single DOM. View encapsulation can be used to ensure that the component style rules from one component do not interfere with other components. View encapsulation is standardized in a web component architecture and provided by the so-called `shadow-dom`. For applications that do not leverage the shadow-dom there are a few alternatives avaiable:

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

## Gobal Theming

Global theming is organized with variables, so that theming isn't hardcoded. For variables there are 2 common approach that can be applied:

- SASS variables
- CSS custom properties (CSS variables)

Spartacus is using CSS variables for theming. CSS variables have the advantage of being runtime configurable. Moreover, they can pierce through the so-called shadow-dom (web components). Additionally, CSS variables are intherited and offer more flexibility than SASS variable.

Theming variables contribute to the so-called contract that Spartacus provides to customers. This contract is intended to be stable and should rarely change. Only with major releases, Spartacus could introduce a new set of variables, although this is not considered best practice.

In order to provide a stable set of variables, variables will be mainly used for color-schemes and font definitions. It can be considerd as a set of global theming definition.

The following snippet shows an example of a CSS variable:

```css
:root {
  --cx-color-primary: red;
}

cx-link {
  color: var(--cx-color-primary);
}
```

The CSS variables can be customised on the root of the document or for specific selectors.

## Component Styles

Spartacus consists of a large number of components that can be used by customers to build their storefront experience. While commerce becomes a comodity, styling is by default opiniated. Not only the colors and fonts, but also the real estate of components as well as backgrounds, lines, etc.

Whatever Spartacus delivers, it will _not_ represent the customers brand/corporate identity. To this reason, Spartacus intends to be highly flexible, so that component styles can be skipped entirely or extended by customers.

Since Spartacus components are built and distributed in libraries, component styles cannot be used. These styles would be pre-processed and baked into the component library. This means that the CSS rules would not be optional, nor would they be easily customizabe.

Instead, component styles have been delivered optionally in the styles library. Customers can use those styles, extend them or competely skip them and build the CSS rules from skratch. The `contract` between the style library and the component library is done through the (unique) component selector.

### Placeholder selectors

To make the css rules provided in the style library completely optional, the styles are wrapped in so-called _placeholder_ selectors. Placeholder selectors are a sass technique that start with a percentage, for example `%cx-mini-cart`. Placeholder selectors are not added to the final CSS, they need to be explicetly extended to end up in the final CSS.

The follpowing snippet provides an example of a component style, using placeholder selector.

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

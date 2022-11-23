---
title: CSS Architecture
feature:
- name: Style Versioning
  spa_version: 2.0
  cx_version: n/a
  anchor: "#style-versioning"
---

This page provides a high level overview of the CSS architecture in Spartacus.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Style Library

Spartacus is provided as a set of standard components that are distributed in npm libraries. These libraries help to ensure that Spartacus remains both extensible and upgradable at the same time.

To deliver as much flexibility as possible for styling, all of the CSS rules are provided in a separate `@spartacus/styles` library. This makes the styles completely optional, configurable, and extensible. You can extend or replace the standard styles, and also implement your own style rules.

Additionally, an existing UI framework, such as Bootstrap, can be used in Spartacus without making it a hard-coded dependency.

## Style Versioning

Spartacus libraries support semantic versioning, which means that breaking changes are not allowed during the life cycle of a major version. This is also true for the style library. A new style rule, or an adjusted rule, that would lead to a difference in the UI experience, is considered a breaking change. Spartacus libraries are released with the assumption that customers are relying on the semantic versioning scheme, so breaking changes, such as implicit changes to the style library, will not be made during the life cycle of a major release.

At the same time, it is likely that Spartacus will evolve from one minor version to the next. To allow for gradual changes in the style layer, new or adjusted style rules are added for a specific version, but these changes are not added in the style build process unless you explicitly opt in to receive these changes. You need to set a single variable to leverage the latest breaking styles changes. Note that non-breaking changes are added regardless.

## Configuring the Styling Version in a Spartacus App

A Spartacus app can declare the style version it wants to use by overriding the `$styleVersion` variable.

By default, the `$styleVersion` value is the `.0` version of the latest major version (such as, `3.0`, `4.0`, or `5.0`). To use Spartacus version 4.3 as an example, the default `$styleVersion` in the styling library is 4.0.

When you install Spartacus using the schematics installer, the installer generates the line of style code that overrides the `$styleVersion` value. The installer sets the value to the Spartacus version being installed or to the feature level that is provided to the installer from the command line.

The Spartacus installer defines the `$styleVersion` value in the `<sourceRoot>/styles.scss` file. In this file, if you install Spartacus 4.3, you should find the following line:

```scss
$styleVersion: 4.3;
@import "~@spartacus/styles/index";
```

The `$styleVersion` override needs to happen before the style import.

## Spartacus Upgrades

When you upgrade Spartacus, the `$styleVersion` that your app uses is not be updated. This way, backwards compatibility of styling can be preserved for minor version upgrades. You can choose to manually opt in on the updated styling, but be aware that these updates may contain breaking changes. To opt in on the updated styling, you need to manually update the `$styleVersion` value to the feature level you wish to use. To update the style version, update the `<sourceRoot>/styles.scss` and any other files where you might have `$styleVersion` overrides.

## Configuring Styling Versioning for Feature Libraries

By default, the Spartacus installer initializes the `$styleVersion` value for the "core" or "main" styles file, `<sourceRoot>/styles.scss`. However, the installer does not propagate the `$styleVersion` override to the feature library styling files. Therefore, by default, the styling feature level of feature libraries will stick to the `.0` version of the major version you are using.

If you wish to control the style version of a feature library that is used in your app, you need to manually propagate a `$styleVersion` override to the feature library styles root file.

The Spartacus installer creates the feature libraries styling root files in the `<sourceRoot>/styles/spartacus/` folder. In this folder, you should find root styling files corresponding to the feature libraries you have installed, such as `cart.scss` or `checkout.scss`. These files initially contain one statement that imports the feature styles from the corresponding feature library. To propagate the feature level to the feature library, you need to override `$styleVersion` in each feature styling root file. The `$styleVersion` override needs to happen before the style import. As an example, the manually updated `<sourceRoot>/styles/spartacus/cart.scss` cart library style file would then contain the following:

```scss
$styleVersion: 4.3;
@import "@spartacus/cart";
```

**Note:** The schematics command that installs one feature in an existing Spartacus app does not add the `$styleVersion` override to the feature root styling file. You need to add it manually afterwards.

## Creating a Style Config File to Propagate Style Versioning

Creating a style config file to propagate style versioning is optional, but can be convenient.

Managing many copies of `$styleVersion` can become cumbersome and error prone. Instead of managing multiple `$styleVersion` overrides, you can create a `styles-config.scss` file next to the main `styles.scss` file in your `<srcRoot>` folder. The `styles-config.scss` file can be the central place where you define the `$styleVersion` override.

The following is an example of the `<sourceRoot>/styles-config.scss` file:

```scss
$styleVersion: 4.3;
```

Then, in `styles.scss` and in all the feature library files, you import `styles-config.scss`. The following is an example of the `<sourceRoot>/styles.scss` file:

```scss
@import "styles-config";
@import "@spartacus/styles/index";
```

For feature libraries, taking the cart style as an example, the `<sourceRoot>/styles/spartacus/cart.scss` file would also import `styles-config.scss`, as follows:

```scss
@import "../../styles-config";
@import "@spartacus/cart";
```

Afterwards, this allows you to manage the styles version in one centralized place.

## Using useLatestStyles for Developer Environments

Instead of overriding `$styleVersion`, you can set the boolean variable `$useLatestStyles` to `true` to always apply the latest styling version in your app. This can be useful for development, demos, or proofs of concept. The following is an example:

```scss
$useLatestStyles: true;
```

## Styles for Future Releases

If for some reason there are styles defined for a version that is higher than the one that is currently installed, these styles will never apply. This is true regardless of the version defined in `$styleVersion` or if `$useLatestStyles` is `true`.

For example, you could have a storefront app that is using the Spartacus 4.3 libraries, while in a feature library, there are styles defined for version 4.5 and above. Regardless of whether `$styleVersion` is set to 4.5 in the app or if `$useLatestStyles` is set to to `true`, the styles defined for version 4.5 and above will not display because 4.5 is higher than the current version of the Spartacus libraries that are being used, which is 4.3.

## Implementing Versioned Styles

Spartacus developers can handle breaking changes in styles with the `forVersion` mixin. The styles wrapped in the `forVersion` mixin then apply or not depending on the `$styleVersion` variable (or `$useLatestStyles`).

The `forVersion` mixin accepts a version parameter. The version parameter is the minimum version at which the styles wrapped in the `forVersion` mixin will apply. If the application's style version is below the version specified by `forVersion`, the styles wrapped in `forVersion` are not present in the generated CSS and as a result, they do not apply.

The following example illustrates a style that requires a defined style version of 2.2 or above to apply:

```scss
cx-mini-cart {
  @include forVersion(2.2) {
    background: blue;
  }
}
```

It is also possible to provide a version range for which a given style applies. The following example has a styling element that will only apply if the application's style version is at least 2.2, and not higher than 2.9.

```scss
cx-mini-cart {
  @include forVersion(2.2, 2.9) {
    background: blue;
  }
}
```

**Note:** The optional style changes that are introduced in minor versions are typically included by default in the following major release.

## CSS Technology

Spartacus is developed with a combination of the following CSS techniques:

- [SASS](https://github.com/sass/node-sass), which is used as the pre-processing language, just like in most of today's UI frameworks.
- [CSS custom properties](https://www.w3schools.com/css/css3_variables.asp), which are used for global theming.
- [CSS post-processing](https://postcss.org/), which is intended to be used to polyfill any of the required syntax for older browsers.

### View Encapsulation

View encapsulation ensures the isolation of styles in a single DOM. View encapsulation can be used to ensure that the component style rules from one component do not interfere with other components. View encapsulation is standardized in a web component architecture, and is provided by the shadow DOM. For applications that do not leverage the shadow DOM, there are a few alternatives that are available, such as the following:

- **Emulated encapsulation:** Angular provides emulated view encapsulation by adding a (random) component ID to the generated CSS, so that the CSS rules are tightly coupled with the component and will not interfere with other components.
- **BEM:** BEM is an older technique that uses a very specific class name convention to make the component styles specific to the given element(s).
- **iFrames:** This technique is only mentioned for completeness, but is not a viable option due to a number of disadvantages, including poor user experience.

None of the above techniques work for Spartacus. Angular's emulated encapsulation cannot be used because the component styles are provided by the style library. BEM is considered old-fashioned and complex. Moreover, a well defined, fine-grained component architecture does not need BEM to encapsulate the styles.

Instead, the fine-grained component selectors are used to encapsulate the styling. For more information, see [Component Styles](#component-styles), below.

## Global Theming

Global theming is organized with variables so that the theming is not hard coded. For variables, there are two common approaches that you can work with:

- SASS variables
- CSS custom properties (in other words, CSS variables).

Spartacus uses CSS variables for theming. CSS variables have the advantage of being runtime configurable. Moreover, they can pierce through the shadow DOM (that is, web components). Additionally, CSS variables are inherited and offer more flexibility than SASS variables.

Theming variables contribute to the so-called "contract" that Spartacus provides to customers. This contract is intended to be stable, and should rarely change. Only with major releases, Spartacus could introduce a new set of variables, but this is not considered best practice.

To provide a stable set of variables, the CSS variables in Spartacus are mainly used for color schemes and font definitions. These can be considered as a set of the global theming definition.

The following is an example of a CSS variable:

```css
:root {
  --cx-color-primary: red;
}

cx-link {
  color: var(--cx-color-primary);
}
```

CSS variables can be customized on the root of the document, or for specific selectors.

### Customizing Global Variables

You can customize global variables in the `styles.scss` file. To avoid using the `!important` CSS property in the `:root`, it is recommended that you use the `body` selector instead. The following is an example:

```scss
// Always bump to the latest (breaking) styles during development.
$useLatestStyles: true;
@import '@spartacus/styles';
@import '@spartacus/styles/scss/theme/santorini';
body {
  --cx-color-primary: #a7fff6;
  --cx-color-secondary: #8aa39b;
  --cx-color-text: #5c6f68;
  --cx-color-background: #95d9c3;
  --cx-color-dark: #a4f9c8;
}
```

## Component Styles

Spartacus consists of a large number of components that you can use to build your storefront experience. While commerce may be a commodity, styling is by nature a subjective topic. Not only the choices of colors and fonts, but also the real estate of components, as well as the backgrounds, the lines, and so on.

No matter what Spartacus delivers, it will not represent your brand or corporate identity. For this reason, Spartacus is meant to be highly flexible, so that you can extend component styles, or skip them entirely.

Since Spartacus components are built and distributed in libraries, component styles cannot be used. These styles would be pre-processed and baked into the component library. This means that the CSS rules would not be optional, nor would they be easily customizable.

Instead, component styles are delivered optionally in the styles library. You can use those styles, extend them, or completely skip them and build your CSS rules from scratch. The contract between the style library and the component library is done through the (unique) component selector.

### Placeholder Selectors

To make the CSS rules provided in the style library completely optional, the styles are wrapped in placeholder selectors. Placeholder selectors are a SASS technique that starts with a percentage, such as `%cx-mini-cart`. Placeholder selectors are not added to the final CSS. Instead, they need to be explicitly extended to end up in the final CSS.

The following is an example of a component style that uses a placeholder selector:

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

While the placeholder selector can be safely imported, it will only affect the final CSS if it has been used explicitly. The styling can therefore be extended as follows:

```scss
cx-link {
  @extend %cx-link !optional;
  a {
    color: red;
  }
}
```

The `optional` flag ensures that the code will not break during the build, whenever a specific import is not part of the imported styles.

Spartacus generates the component by iterating over the configured component selectors.

**Note**: The placeholder selector must be explicitly imported in the file where you extend the placeholder selector. Placeholder selectors are imported from the `@spartacus/styles` library.

#### Extending Default Styles With Placeholder Selectors

You can extend the default Spartacus styles with placeholder selectors in the following ways:

- You can extend the default style in your `styles.scss`, and then define your custom styles in the component scss file.

  The following is an example of `styles.scss` where `custom-product-intro` is the selector of the custom component:

  ```scss
  // styles.scss
  $styleVersion: ...;
  @import "~@spartacus/styles/index";

  custom-product-intro {
    @extend %cx-product-intro !optional;
  }
  ```

  You then define your custom styles in the component scss file, as shown in the following example:

  ```ts
  // custom-product-intro.component.ts
  :host {
    .code {
      color: yellow;
    }
  }
  ```

  In the example above, the `custom-product-intro` uses the style from Spartacus, but the color of the `.code` class now becomes yellow.

- You can extend the placeholder selector and customize the style in the component scss file. The following is an example:

  ```ts
  // custom-product-intro.component.ts

  // Add the following import first (this import is required because most styles have a dependency on it)
  @import "~@spartacus/styles/scss/cxbase/mixins";
  // Then import the default component style before extending it
  @import "~@spartacus/styles/scss/components/product/details/product-intro";

  :host {
    .code {
      color: yellow;
    }
    @extend %cx-product-intro !optional;
  }
  ```

### Skipping Specific Component Styles

Component styles are optional because they are pulled in from the style library. Accordingly, you might want to disable some standard component styles entirely. To disable standard component styles, you can add the component selectors to the `$skipComponentStyles` list. The following is an example that demonstrates skipping two standard components from the style library:

```scss
$skipComponentStyles: (cx-product-carousel, cx-searchbox);
```

Skipping specific component styles might be beneficial if you need to create styles from scratch and do not want to override specific style rules coming from the Spartacus style library.

## Page Layout Styles

Global theming and component styles are most important to render components on the page. However, the overall layout that orchestrates components on a page is another important style layer. For more information about this layer, see [{% assign linkedpage = site.pages | where: "name", "page-layout.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/styling-and-page-layout/page-layout.md %}).

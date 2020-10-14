---
title: Icon Library
---

Like most storefronts, Spartacus uses icons in the UI. You are welcome to use the Spartacus icons in your storefront, but of course, you can also replace them with other icons. The following sections describe how icons are integrated in the storefront, and also how you can replace them.

## Technical Icon Format

There are a a number of techniques to render icons on the web, including images, SVGs, fonts and native CSS.

SVG sprites are considered best practice because they have the following advantages:

- **Scalability:** Vector-based images remain crisp and clear at any resolution or size.
- **Styling:** SVG icons support transparency and styling by CSS. The styling can be applied within the SVG icons file, as well as in the outer DOM.
- **Spriting:** SVG icons can be combined in a single sprite file. The sprite can be created specifically for the storefront so that an optimized file is created.
- **Animations:** Spartacus does not use animations in its icons, but the format allows for animations to be added.

Spartacus is shipped as a library, so there is no straightforward approach to loading SVG files. Libraries are installed in the `node_modules` folder, and using SVG-based icons would require an import from an application location, such as the `/assets` folder. For this reason, Spartacus is configured by default to use a font-based setup for icons. This default configuration uses Font Awesome icons, which are added to the `IconModule` directly with the `fontawesomeIconConfig`. Note, this is not necessarily the best practice for production, because most standard font icon sets cover more icons than are needed for a storefront.

### Icon Component

Icons are added to the storefront with a component called the `IconComponent`. The icon component requires a specific type, as shown in the following example:

```typescript
<cx-icon type="CART"></cx-icon>
```

The type is used to find the relevant icon setup in the configuration. With this approach, the integration of icons in the UI is decoupled from the actual implementation. This makes it easy to replace icons without changing a UI component implementation.

Depending on the configuration, the icon component either creates an inline SVG fragment, or it adds class names to the `cx-icon` element to align with a font library. The CSS class names can also be used for a CSS-based icon solution, or even an image-based icons solution (using CSS background images).

The icon types in Spartacus have been made typesafe by using the `ICON_TYPE` enumeration. The following is an example:

```typescript
export enum ICON_TYPE {
  CART = 'cart',
  SEARCH = 'search',
  ...
}
```

The enum is used when icons are added in the view. The following is an example:

```typescript
<cx-icon [type]="iconType.CART"></cx-icon>
```

## Icon Configuration

Icons are configured in Spartacus using the `ConfigModule`. In the configuration, you can mix different technical icon formats in a single storefront. The following example demonstrates the usage of font-based icons (using Font Awesome) and SVG-based icons:

```typescript
ConfigModule.withConfig(<IconConfig>{
  icon: {
    symbols: {
      CART: 'fas fa-shopping-cart',
      SEARCH: 'glyphicon glyphicon-search',
      VISA: 'fab fa-cc-visa',
      INFO: 'info',
      WARNING: 'warning'
    },
    resources: [
      {
        type: IconResourceType.LINK,
        url: 'https://use.fontawesome.com/releases/v5.8.1/css/all.css',
      },
      {
        type: IconResourceType.SVG,
        url: './assets/sprite.svg',
        types: [ICON_TYPE.INFO,ICON_TYPE.WARNING],
      },
    ]
  }
});
```

The configuration above uses a setup that combines Bootstrap 3 Glyphicons, Font Awesome icons (both fas and fab), and SVG icons.

The Font Awesome icon set provides ready-to-use icons with defined classes, such as `fab fa-cc-visa` for the VISA icon. You can search for icons and find their related class definitions on the [Font Awesome website](https://fontawesome.com/icons).

### SVG-Based Icons

To construct an SVG icon, the component creates an `xlink` to the SVG symbol. If a `url` is given for the icon type, the symbol is constructed using the URL and the symbol configuration. The setup shown in the previous section produces links to `./assets/sprite.svg#info` and `./assets/sprite.svg#warning`.

**Note:** To generate a font sprite for Font Awesome, you can use the [fontawesome-svg-sprite-generator](https://github.com/Minecrell/fontawesome-svg-sprite-generator). This library can automatically generate a sprite with the Font Awesome icons that you are using in your storefront. It is also possible to give the icons a custom icon name.

### Font-Based Icons

To support font-based icons, the component simply adds the icon symbol to the list of style classes. The following is an example:

```html
<cx-icon class="fas fa-shopping-cart"></cx-icon>
```

To load the font-related CSS file, a resource can be added for a specific icon type, or for all types (by leaving out types entirely). When a resource is added, the CSS file is linked to the DOM dynamically. Spartacus ensures that the font is only loaded once.

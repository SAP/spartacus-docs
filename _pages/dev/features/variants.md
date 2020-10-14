---
title: Variants
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.5 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

Variants are products that differ in some aspect from one another, but are based on the same basic model. An example for variants is color and size for t-shirts. When the variants feature is enabled in Spartacus, and products have been configured in SAP Commerce Cloud, then customers can select products in the storefront with the variant (or variants) of their choice.

**Note:** This feature does not currently support multi-dimensional product variants.

For more information, see the following:

- [Styles and Size Variants in the SAP Commerce Product Cockpit](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8af06a1b8669101483c085453d75849e.html)
- [Modeling Product Variants](https://help.sap.com/viewer/d0224eca81e249cb821f2cdf45a82ace/latest/en-US/8c143a2d8669101485208999541c383b.html)

## Enabling Variants

You enable variants by configuring a CMS component. The following is an example from `product-variants.module.ts`:

```ts
ConfigModule.withConfig(<CmsConfig>{
      cmsComponents: {
        ProductVariantSelectorComponent: {
          component: ProductVariantSelectorComponent,
          guards: [ProductVariantGuard],
        },
      },
    }),
```

Products with variants need to have the `ProductVariantSelectorComponent` CMS component present in the `/page` response, and they need to be rendered on the page.

You can find variant elements in locations such as the following:

- Product Details pages
- Product List pages (for example, see the `VariantStyleIconsComponent`, and grid or list item components)
- Cart items (for example, see the `CartItemComponent`)
- Account pages, such as Order History, Order Page, Wish List, Cancellations and Returns, and so on.

By default, the `spartacussampledataaddon` AddOn includes style and size variants in the `apparel-spa` storefront, and a color variant in the `electronics-spa` storefront.

## Adding a Custom Variant Type

To create a custom variant type, you need to extend both the product model and the component template, as follows:

1. Add the new `VariantType` in `product.model.ts`. The following is an example:

   ```ts
   export enum VariantType {
      SIZE = 'ApparelSizeVariantProduct',
      STYLE = 'ApparelStyleVariantProduct',
      COLOR = 'ElectronicsColorVariantProduct',
      MY_CUSTOM_VARIANT = 'MyCustomVariant', // new variant type
   }
   ```

2. Add a new component for the new variant.

   You can see how this has been done for the default variant types in Spartacus by looking at the following source files:

   - `product-size-selector.component.html`
   - `product-style-selector.component.html`
   - `product-color-selector.component.html`

3. Add the new variant type in the back end.

   For more information, see [Styles and Size Variants in the SAP Commerce Product Cockpit](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8af06a1b8669101483c085453d75849e.html).

## About the Variant Guard

The `ProductVariantGuard` allows Spartacus to perform a redirect for products with variants under the following conditions:

- When a selected variant cannot be purchased (because it is the base product), or it is not in stock, the `ProductVariantGuard` finds the "nearest" product variant with stock, and redirects to it.

- When a selected variant can be purchased (because it is not the base product), and it is in stock, no redirects are performed, and the Product Details page for the selected variant is displayed.

## SEO Customizations

When it comes to variants, there is the potential to have a lot of similar product pages, for example, in the case of a base product that has many sizes and colors.

There is no single way to address this issue. To provide a minimal, safe, and extendable setup in Spartacus, the `robots.txt` is set to `FOLLOW, NOINDEX` for products that cannot be purchased.

For more details, see `ProductPageMetaResolver` in the source code.

## Disabling Variants

The variants feature is CMS-driven, so it can be disabled through the CMS by marking the component as inactive, or by removing the component completely from the page template.

In the app module, the configuration for the variants feature should also be removed.

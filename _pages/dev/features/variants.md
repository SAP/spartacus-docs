---
title: Variants
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.5 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The Variants feature make use of backend product variants support. Once enabled and product is set to has variants, product details page contain component with variants selection (eg. style, size) and individual varaints can be ordered.

## Limitations
Due to technical dependencies at the moment only hybris generation 1 varaints are supported.

## Basic information
Assuming backend is configured for spartacus (see [Spartacussampledataaddon AddOn]({{ site.baseurl }}{% link _pages/install/spartacussampledataaddon.md %})) variants functionality is enabled by default once you map it as any other cms component:
```
ConfigModule.withConfig(<CmsConfig>{
      cmsComponents: {
        ProductVariantSelectorComponent: {
          component: ProductVariantSelectorComponent,
          guards: [ProductVariantGuard],
        },
      },
    }),
```
Therefore product with varaints should have `ProductVariantSelectorComponent` cms component present in the `/page` response and should be rendered on the page:
![Variants example PDP]({{ site.baseurl }}/assets/images/variants-example.png)

You can also find variant elements in other places:
- product list page (see `VariantStyleIconsComponent` and grid/list item components):
   ![Variants example PLP]({{ site.baseurl }}/assets/images/variants-example-plp.png)
- cart item (see `CartItemComponent`)
- account pages (order history, order page, wishlist, cancel & returns, etc...)

## Default variant types
By default, with sampledata addon three variant types are available:
- style (apparel)
- size (apparel)
- color (electronics)

## Adding custom variant type
In order to have custom variant type, product model as well as the component's template needs to be extended so the below steps needs to be performed:
- put your desired `VariantType` into `product.model.ts`:
   ```
   export enum VariantType {
      SIZE = 'ApparelSizeVariantProduct',
      STYLE = 'ApparelStyleVariantProduct',
      COLOR = 'ElectronicsColorVariantProduct',
      MY_CUSTOM_VARIANT = 'MyCustomVariant', // new variant type
   }
   ```
   Of courese it should be added on the backend as well.
- Add a new component for custom variant. See `product-variant-selector.component.html` to see how it was done for the default varaint types.

## Note on variant guard
`ProductVariantGuard` has been introduced in order to do "behind the scenes" redirects for products with variants:
- if selected variant is purchasable (not a base product) and in stock - don't do any redirects - just display the PDP;
- if selected variant is not purchasable (base product) or it has no stock - find the "nearest" product variant with stock and redirect to it.

See the actual guard code for the details.

## SEO related customizations
In context of variants several topics should be considered for SEO. This is because potentially lot of similar pages can be present for the same product (same product but different sizes for example). It's a business decision how to deal with it. For a minimal and safe, yet extendable setup we decided to change robots.txt to `FOLOW, NOINDEX` for non purchasable products. See `ProductPageMetaResolver` for details.

## Disabling variants
Since the feature is CMS driven, it can be disabled through the CMS. Just mark it as inactive or remove it completly from the page template. Of course the mentioned mapping in the app module also should be removed.
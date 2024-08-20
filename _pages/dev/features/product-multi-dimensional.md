---
title: Product Multi-Dimensional
feature:
  - name: product-multi-dimensional
    spa_version: 2211.28
    cx_version: 2211.28
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.5 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Multi-dimensional products are products that differ in multiple aspects from one another but are based on the same core
model. An example of multi-dimensional products would be t-shirts that vary by both color and size. Multi-dimensional
products offer more flexibility than standard variants because you can customize the variant options to fit specific
needs. When the multi-dimensional product feature is enabled in Spartacus, and products have been configured in SAP
Commerce Cloud, customers can select products in the storefront with the dimensions of their choice.

**Note:**
While it's possible to have an indefinite number of category variants, this feature implementation supports
only up to three.
Spartacus does not support using Multi-Dimensional products and Variants features simultaneously. You need to choose one
or the other.

For more information, see the following:

- [Multi-Dimensional Products](https://help.sap.com/docs/SAP_COMMERCE/4c33bf189ab9409e84e589295c36d96e/8ae3798c866910149204d455ffe16db5.html)
- [Modeling Product Variants](https://help.sap.com/viewer/d0224eca81e249cb821f2cdf45a82ace/latest/en-US/8c143a2d8669101485208999541c383b.html)

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
  {:toc}

***

## Enabling Multi-Dimensional products

You can enable Multi-Dimensional products by using ```@spartacus/schematics``` and selecting the features:

- Product Multi-Dimensional - Selector - enables the category variant selectors on the PDP
- Product Multi-Dimensional - PLP price range - enables the list item details component on the PLP. Which adds the price
  range to the list item.


1. Selector

### CMS Components

Multi-Dimensional selector is enabled by a CMS component. The following is an example
from `product-multi-dimensional-selector-component.module.ts`:

```ts
    provideDefaultConfig(<CmsConfig>{
    cmsComponents: {
        ProductMultiDimensionalSelectorComponent: {
            component: ProductMultiDimensionalSelectorComponent,
            guards: [ProductMultiDimensionalSelectorGuard],
        },
    },
}),
```

Multi-dimensional products need to have the `ProductMultiDimensionalSelectorComponent` CMS component present in
the `/page` response,
and they need to be rendered on the page.

You can add it using impex:

Create `ProductMultiDimensionalSelector` CMSFlexComponent

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef
;;ProductMultiDimensionalSelector;Product Multi-Dimensional Selector Component;ProductMultiDimensionalSelectorComponent;ProductMultiDimensionalSelector
```

Add newly created flex component to the `ProductSummarySlot`

```text
INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;ProductSummarySlot;Summary for product details;ProductImagesComponent,ProductIntroComponent,QualtricsEmbeddedFeedbackComponent,ProductSummaryComponent,ProductMultiDimensionalSelector,AddToCart,ConfigureProductComponent,AddToWishListComponent,StockNotificationComponent
```

**Note:** you can add `ProductMultiDimensionalSelector` to any component on the PDP, `ProductSummarySlot` is our
preference

You can find variant elements in locations such as the following:

- Product Details pages
- Cart items (for example, see the `CartItemComponent`)
- Account pages, such as Order History, Order Page, Wish List, Cancellations and Returns, and so on.

### Images

Variant categories can use images for selection by setting the `hasImage` attribute to true. This can be configured in
the backoffice or through an impex. The `hasImage` attribute acts as a toggle, informing the frontend to display images
for variant options. However, images will only be shown if each variant option within the category has an image in the
correct format. The default image format for multi-dimensional products is `STYLE_SWATCH`, which is 30W x 30H.

2. List

This feature replaces `ProductListOutlets.ITEM_DETAILS` with the new `ProductMultiDimensionalListItemDetailsComponent`.
Its primary function is to display the price range for multi-dimensional products within the grid or list item
components on the Product Listing Page (PLP).

## About the Multi-Dimensional Guard

The ProductMultiDimensionalSelectorGuard enables Spartacus to redirect users for products with variant categories under
the following conditions:

- If the selected variant cannot be purchased (e.g., it is the base product) or is out of stock, the ProductVariantGuard
  identifies the closest available variant with stock and redirects to its Product Details page.

- If the selected variant is purchasable (i.e., it is not the base product) and in stock, no redirect occurs, and the
  Product Details page for the selected variant is displayed.

- If the selected variant is purchasable but all variants are out of stock, the guard redirects to the first variant
  product.

## Configuration

### Variant Categories

The VariantCategories can be created using
impex https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/7e47d40a176d48ba914b50957d003804/8ae0f0ac86691014b4e0e53c678d8b44.html
or through backoffice.

### Image format

By default, the Multi-Dimensional Selector feature uses the STYLE_SWATCH image format, which is set to 30W x 30H. To
customize this format, use provideConfig to specify the desired image format.

```ts
    provideConfig({
    multiDimensional: {
        imageFormat: VariantQualifier.STYLE_SWATCH,
    }
})
```

and put it in the feature module:

```ts
@NgModule({
    imports: [ProductMultiDimensionalSelectorRootModule],
    providers: [
        provideConfig({
            featureModules: {
                [PRODUCT_MULTI_DIMENSIONAL_SELECTOR_FEATURE]: {
                    module: () =>
                        import('@spartacus/product-multi-dimensional/selector').then(
                            (m) => m.ProductMultiDimensionalSelectorModule
                        ),
                },
            },
            i18n: {
                resources: multiDimensionalSelectorTranslations,
                chunks: multiDimensionalSelectorTranslationChunksConfig,
                fallbackLang: 'en',
            },
        }),
        provideConfig({
            multiDimensional: {
                imageFormat: VariantQualifier.STYLE_SWATCH,
            }
        })
    ],
})
export class ProductMultiDimensionalSelectorFeatureModule {
}
```

## SEO Customizations

With multi-dimensional products, there can be numerous similar product pages, such as when a base product comes in many
sizes and colors.

There is no one-size-fits-all solution to this issue. To ensure a minimal, safe, and extensible setup in Spartacus, the
`robots.txt` is configured to `FOLLOW, NOINDEX` for products that cannot be purchased.

For more details, refer to the `ProductPageMetaResolver` in the source code.

## Disabling Variants

The multi-dimensional feature is CMS-driven, meaning it can be disabled through the CMS by marking the component as
inactive or by removing the component entirely from the page template.

In the app module, the configuration for the multi-dimensional feature should also be removed.

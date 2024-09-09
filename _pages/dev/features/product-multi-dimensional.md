---
title: Multi-Dimensional Products
feature:
  - name: multi-dimensional-products
    spa_version: 2211.28
    cx_version: 2211.28
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.5 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Multi-dimensional products are products that are different from one another in two or more ways, but are based on the same core model. An example of a multi-dimensional product is a T-shirt that varies in both color and size.

Multi-dimensional products offer more flexibility than standard variants because you can customize the variant options to fit your specific needs. When the multi-dimensional product feature is enabled in Spartacus, and corresponding products have been configured in SAP Commerce Cloud, customers can select products in the storefront with the dimensions of their choice.

Spartacus supports an unlimited number of dimensions, but SAP Commerce Cloud only supports three dimensions out-of-the-box. Having said that, you can extend the structure in SAP Commerce Cloud to support as many dimensions as you need. For more information, see [Creating Additional Dimensions for Multi-Dimensional Products](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/7e47d40a176d48ba914b50957d003804/8acce71c866910149e2fe260d49a4997.html).

**Note:** Spartacus does not support using multi-dimensional products and the variants features simultaneously. You need to choose one or the other. For more information, see [Multi-Dimensional Products](https://help.sap.com/docs/SAP_COMMERCE/4c33bf189ab9409e84e589295c36d96e/8ae3798c866910149204d455ffe16db5.html) and [Modeling Product Variants](https://help.sap.com/viewer/d0224eca81e249cb821f2cdf45a82ace/latest/en-US/8c143a2d8669101485208999541c383b.html).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
  {:toc}

***

## Enabling Multi-Dimensional Products

If you are setting up a new Spartacus app, you can enable multi-dimensional products through the schematics by selecting the either or both of the following features:

- `Product Multi-Dimensional - Selector`, which enables the category variant selectors on the product details page
- `Product Multi-Dimensional - PLP price range`, which enables the List Item Details component on the product list page, and which adds the price range to the list item.

If you have already set up your storefront app, you can enable multi-dimensional products by installing the `@spartacus/product-multi-dimensional` library with the following command:

```zsh
ng add @spartacus/product-multi-dimensional
```

For more information, see [Installing Additional Composable Storefront Libraries](https://help.sap.com/docs/SAP_COMMERCE_COMPOSABLE_STOREFRONT/cfcf687ce2544bba9799aa6c8314ecd0/e38d45609de04412920a7fc9c13d41e3.html?locale=en-US#loioaa76b408d0324aea889aeeaed899144a).

## Multi-Dimensional Selector

The multi-dimensional selector is enabled by configuring a CMS component. The following is an example from `product-multi-dimensional-selector-component.module.ts`:

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

Multi-dimensional products need to have the `ProductMultiDimensionalSelectorComponent` CMS component present in the `/pages` response, and they need to be rendered on the page.

### Adding a Multi-Dimensional Selector Using ImpEx

To add a multi-dimensional selector using ImpEx, you create a `ProductMultiDimensionalSelector` CMS flex component, and then add it to a page slot, such as the `ProductSummarySlot`.

**Note:** The `ProductSummarySlot` is the recommended location for adding your `ProductMultiDimensionalSelector`, but you can add the `ProductMultiDimensionalSelector` to any page slot on the product details page (PDP) that you wish.

Variant elements for multi-dimensional products appear in locations such as the following:

- product details pages
- cart items (for example, see the `CartItemComponent`)
- account pages, such as the order page, the order history, wish list, cancellations and returns, and so on.

**Note:** The `$contentCV` variable that is used in the following ImpEx examples, and which stores information about the content catalog, is defined as follows:

```text
$productCatalog=electronicsProductCatalog $contentCatalog=electronics-spaContentCatalog $contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online] $componentRef=ProductMultiDimensionalSelector
```

1. Create a `ProductMultiDimensionalSelector` CMS flex component with the following ImpEx:

   ```text
   INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef
   ;;ProductMultiDimensionalSelector;Product Multi-Dimensional Selector Component;ProductMultiDimensionalSelectorComponent;ProductMultiDimensionalSelector
   ```

2. Add the newly created CMS flex component to the `ProductSummarySlot` with the following ImpEx:

```text
INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;ProductSummarySlot;Summary for product details;ProductImagesComponent,ProductIntroComponent,QualtricsEmbeddedFeedbackComponent,ProductSummaryComponent,ProductMultiDimensionalSelector,AddToCart,ConfigureProductComponent,AddToWishListComponent,StockNotificationComponent
```

## Images

Variant categories can use images for selecting the categories by setting the `hasImage` attribute to true. This can be configured in Backoffice, or through ImpEx. The `hasImage` attribute acts as a toggle that informs the storefront to display images for variant options. However, images are only shown if each variant option within the category has an image in the correct format. The default image format for multi-dimensional products is `STYLE_SWATCH`, which is 30 W x 30 H.

For more information, see [Creating VariantValueCategorys Using ImpEx](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/7e47d40a176d48ba914b50957d003804/8ae0f0ac86691014b4e0e53c678d8b44.html#creating-variantvaluecategorys-using-impex).

## List Item Details Component

This functionality replaces `ProductListOutlets.ITEM_DETAILS` with the new `ProductMultiDimensionalListItemDetailsComponent`. Its primary function is to display the price range for multi-dimensional products within the grid, or to list item components on the product listing page (PLP).

## Multi-Dimensional Product Guard

When a user encounters a product with variant categories, the `ProductMultiDimensionalSelectorGuard` allows Spartacus to redirect the user under the following conditions:

- If the selected variant cannot be purchased (for example, it is the base product, or the variant is out of stock), the `ProductMultiDimensionalSelectorGuard` identifies the closest available variant with stock and redirects the user to its product details page.
- If the selected variant is purchasable (because it is not the base product) but all variants are out of stock, the guard redirects to the first (out-of-stock) variant of the base product.

If the selected variant is purchasable (because it is not the base product) and the variant is in stock, no redirect occurs, and the product details page for the selected variant is displayed.

## Configuration

The following sections describe how you can configure multi-dimensional products in terms of translation, variant categories, and image format.

### Translations

You can configure the translations for the multi-dimensional selector. For example, you can modify the translations by adding the appropriate configuration to the feature module, such as the `ProductMultiDimensionalSelectorFeatureModule`. The following is an example:

```ts
    provideConfig({
    i18n: {
        resources: multiDimensionalSelectorTranslations,
        chunks: multiDimensionalSelectorTranslationChunksConfig,
        fallbackLang: 'en',
    },
}),
```

### Variant Categories

You can create a `VariantCategory` in Backoffice, or by using ImpEx.

For information on how to use ImpEx to create a `VariantCategory`, see [Loading a Multi-Dimensional Product Using ImpEx](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/7e47d40a176d48ba914b50957d003804/8ae0f0ac86691014b4e0e53c678d8b44.html).

### Image Format

By default, the multi-dimensional selector uses the `STYLE_SWATCH` image format, which is set to 30 W x 30 H. To customize this format, use `provideConfig` to specify the desired image format. The following is an example:

```ts
    provideConfig({
    multiDimensional: {
        imageFormat: VariantQualifier.STYLE_SWATCH,
    }
})
```

You can then add this in the feature module, as shown in the following example:

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

With multi-dimensional products, there is the potential to have a lot of similar product pages, for example, in the case of a base product that has many sizes and colors.

There is no single way to address this issue. To ensure a minimal, safe, and extensible setup in Spartacus, the `robots.txt` is set to `FOLLOW, NOINDEX` for products that cannot be purchased.

For more details, refer to the `ProductPageMetaResolver` in the source code.

## Disabling Variants

The multi-dimensional products feature is CMS-driven, so it can be disabled through the CMS by marking the component as inactive, or by removing the component completely from the page template.

In the app module, the configuration for the multi-dimensional products feature should also be removed.

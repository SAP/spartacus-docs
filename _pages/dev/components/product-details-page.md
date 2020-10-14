---
title: Product Details Page (DRAFT)
---

The purpose of this page is to explain the specific CMS structure of the Product Details Page (PDP) and explain the different mechanisms to configure the page.

## CMS Structure

The Product Details Page is entirely driven by CMS. Thus Spartacus's Angular components on this page are mapped to CMS components.

The default CMS structure in the `electronics-spa` content catalog is as follows:

```
{TopHeaderSlot}

{Summary}
                        |  ProductIntroComponent
ProductImagesComponent  |  ProductSummaryComponent
                        |  ProductVariantSelectorComponent
                        |  ProductAddToCartComponent

{UpSelling}
ProductReferencesComponent

{Tabs}
CMSTabParagraphContainer
```
### Tabs

The tabs slot contains `CMSTabParagraphContainer` component container which itself contains the `ProductDetailsTabComponent`, `ProductSpecsTabComponent`, `ProductReviewsTabComponent` and `deliveryTab`.

Spartacus renders the tabs found in the container. Therefore, tabs can be added, removed or reordered inside the container and the changes will appear in Spartacus.

**Note** The title of the tabs is found in the Spartacus translations. This means that when adding a new tab it is also required to add the title on the Spartacus side. Tab titles should be in `CMSTabParagraphContainer > tabs` and formatted as follows:

```ts
CMSTabParagraphContainer: {
    tabs: {
      NEW_TAB_ID: 'My new Tab',
    },
  },
```

NEW_TAB_ID is the id of the new tab and the string associated to it is the title that will be displayed.

## Configuring the Page

Since the Product Details Page is driven by CMS it can be configured using SmartEdit or Backoffice. This can be used to add new components, remove existing one or reoder the components/slots.

For Spartacus configurations, the components listed in the section above can be mapped to new custom components using the method described [Customizing CMS Components](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/customizing-cms-components/#custom-angular-cms-components).

In addition to CMS mapping, outlets can also be used to add or replace certain components on the page. A detail overview of outlets can be found in [Using Outlets](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/page-layout/#using-outlets-to-override-page-templates). The label of the outlets are the same as the name of the slots and components described in the section above.

**Note** when using outlets on the page, it might be necessary to provide custom CSS to align the new elements correctly.
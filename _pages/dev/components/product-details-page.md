---
title: Product Details Page
---

The Product Details Page (PDP) is driven entirely by CMS, and as a result, every Spartacus Angular component on the PDP page is mapped to a CMS component.

The default CMS structure in the `electronics-spa` content catalog is as follows:

```text
{TopHeaderSlot}

{Summary}
                        |  ProductIntroComponent
ProductImagesComponent  |  ProductSummaryComponent
                        |  ProductVariantSelectorComponent
                        |  ProductAddToCartComponent

{UpSelling}
ProductReferencesComponent

{Tabs}
TabPanelContainer
```

### Tabs

The tabs slot contains the `TabPanelContainer` component container, which itself contains the `ProductDetailsTabComponent`, `ProductSpecsTabComponent`, `ProductReviewsTabComponent` and `deliveryTab`.

Spartacus renders the tabs found in the container, so tabs can be added, removed, or reordered inside the container, and the changes appear in Spartacus.

**Note:** The title of each tab is located in the Spartacus translations. As a result, when you add a new tab, you also need to add the title on the Spartacus side. Tab titles should be provided in the `tabs` property of the `TabPanelContainer`, and should be formatted as follows:

```ts
TabPanelContainer: {
    tabs: {
      NEW_TAB_ID: 'My new Tab',
    },
  },
```

The `NEW_TAB_ID` is the id of the new tab, and the string associated with it (in this example, `My new Tab`) is the title that is displayed in Spartacus.

## Configuring the PDP Page

You can configure the PDP page using either SmartEdit or Backoffice, including adding new components, removing existing ones, or reordering the components or slots.

For Spartacus configurations, the components listed above can be mapped to new, custom components using the method described in[Customizing CMS Components]({{ site.baseurl }}/customizing-cms-components/#custom-angular-cms-components).

In addition to CMS mapping, you can also use outlets to add or replace certain components on the page. The labels of the outlets are the same as the names of the slots and components listed above. For more information, see [Using Outlets]({{ site.baseurl }}/page-layout/#using-outlets-to-override-page-templates).

**Note:** When using outlets on the PDP page, it might be necessary to provide custom CSS to align the new elements correctly.

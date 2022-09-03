---
title: Quick Order
feature:
  - name: Quick Order
    spa_version: 4.1
    cx_version: 2011
---

{% capture version_note %}
{{ site.version_note_part1 }} 4.1 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The quick order feature allows users to quickly add multiple items to their cart. There is also the option to add a single product through the cart page quick form.

For more information, see [Quick Order](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/caf95981aa174660b3faf839a9dddbef.html) on the SAP Help Portal.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Enabling Quick Order

You can enable quick order by installing the `@spartacus/cart` feature library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

### CMS Components

Quick order is CMS-driven and consists of the following CMS components:

- `CartQuickOrderFormComponent`
- `QuickOrderComponent`

You can configure quick order by using SmartEdit to display the quick order components in Spartacus, or you can manually add them to content slots using ImpEx.

If you are using the [{% assign linkedpage = site.pages | where: "name", "spartacussampledata-extension.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/spartacussampledata-extension.md %}), the quick order components are already enabled. However, if you decide not to use the `spartacussampledata` extension, you can enable the quick order components through ImpEx.

**Note:** The `$contentCV` variable that is used throughout the following ImpEx examples, and which stores information about the content catalog, is defined as follows:

```text
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]
```

#### Adding Quick Order CMS Components Manually

This section describes how to add Quick Order CMS components to Spartacus using ImpEx.

You can enable the **Quick Order** link in the **My Account** drop-down menu with the following ImpEx:

```text
UPDATE CMSLinkComponent;$contentCV[unique=true];uid[unique=true];url
;;QuickOrderLink;/my-account/quick-order
```

You can add the **Quick Order** link in the **Quick Links** panel with the following ImpEx:

```text
INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(uid,$contentCV)
;;SiteLinksSlot;Slot contains some links;true;QuickOrderLink,OrdersLink,WishListLink,StoreFinderLink,ContactUsLink,HelpLink
```

You can enable quick order by adding the **Cart Quick Order Form** component with the following ImpEx:

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef
;;CartQuickOrderFormComponent;Cart Quick Order Form Component;CartQuickOrderFormComponent;CartQuickOrderFormComponent

UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)
;;CenterRightContentSlot-cartPage;CartTotalsComponent,CartApplyCouponComponent,CartQuickOrderFormComponent
```

You can also enable quick order by adding the **Quick Order Page** with the following ImpEx:

```text
UPDATE ContentPage;$contentCV[unique=true];uid[unique=true];masterTemplate(uid,$contentCV);label
;;quickOrderPage;AccountPageTemplate;/my-account/quick-order

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(&componentRef)
;;BodyContentSlot-quickOrder;Body Content Slot for Quick Order;true;QuickOrderComponent

INSERT_UPDATE ContentSlotForPage;$contentCV[unique=true];uid[unique=true];position[unique=true];page(uid,$contentCV)[unique=true];contentSlot(uid,$contentCV)[unique=true]
;;BodyContent-quickOrder;BodyContent;quickOrderPage;BodyContentSlot-quickOrder

INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef
;;QuickOrderComponent;Quick Order Component;QuickOrderComponent;QuickOrderComponent
```

## Configuring Quick Order

It is possible to modify how many items you can add to the quick order list, as described in the following section.

### Limiting the Quick Order List

By default, you can add up to ten products to the quick order list, but you can modify this value by providing a different configuration. You can either add a new CMS component as a `CmsQuickOrderComponent` with a `quickOrderListLimit` attribute, or you can modify the default configuration, as shown in the following example:

```ts
provideConfig(<CmsConfig>{
  cmsComponents: {
    QuickOrderComponent: {
      data: {
        quickOrderListLimit: 15,
      }
    },
  },
}),
```

In the above example, `quickOrderListLimit` is set to `15`, which is the maximum number of products that can be added to the quick order list.

### Modifying the Quick Order Form Configuration

If you are using version 4.2 or newer of the Spartacus libraries, a suggestion box appears after you have entered three characters in the quick order form, and a maximum of five products with images is displayed. These are defaults that you can modify by providing a different configuration, as shown in the following example:

```ts
provideConfig(<QuickOrderConfig>{
  quickOrderForm: {
    searchForm: {
      displayProductImages: <yourValue>,
      maxProducts: <yourValue>,
      minCharactersBeforeRequest: <yourValue>,
    }
  }
}),
```

The settings of the `QuickOrderConfig` are described as follows:

- `displayProductImages` is a boolean that determines whether or not suggested products include product images. The default is `true`.
- `maxProducts` is a number that determines the maximum number of suggested products to display. The default is `5`.
- `minCharactersBeforeRequest` is a number that sets how many characters a user must enter before product suggestions are displayed. The default is `3`.

## Using Quick Order

The following sections describe how to use the quick order feature in the Spartacus storefront.

### Using the Quick Order Form in the Cart Page

Even if you are not logged in, you can add products to the cart using the quick order form in the **Cart** page, as follows:

1. Add one or more items to your cart, then open the **Cart** page.

   Below the **Order Summary**, the Cart Quick Order Form component appears below the Coupon form, as shown in the following example:

   <img src="{{ site.baseurl }}/assets/images/quick-order-1.png" alt="Shopping Cart" width="700" border="1px" />

1. Add a product SKU and enter the desired quantity.

1. Click **Add To Cart**.

   A global alert then appears and your current active cart is updated. The following is an example:

   <img src="{{ site.baseurl }}/assets/images/quick-order-3.png" alt="Cart Quick Order Form" width="700" border="1px" />

## Using the Quick Order Page

The following sections describe how to use the quick order feature in the Spartacus storefront.

### Adding Products with the Quick Order Page

The **Quick Order** page provides a form for adding new products, and displays a list of products that have already been added. The list includes information about the products that have been added to the **Quick Order** page, such as the product image, name, availability, price, and quantity that you want to add to your cart. The following is an example:

<img src="{{ site.baseurl }}/assets/images/quick-order-4.png" alt="Quick Order Page" width="700" border="1px" />

You can add products to the quick order list and then to your cart, as follows:

1. Enter a product name or a product SKU in the form. You can also enter three or more characters and wait for product suggestions to appear, as shown in the following example:

   <img src="{{ site.baseurl }}/assets/images/quick-order-8.png" alt="Quick Order Form Suggestion Box" width="700" border="1px" />
 
   If there is only one product in the suggestions, you can press <kbd>Enter</kbd> to add the product. If there is more that one  product, you can select which product to add by clicking on it, or by navigating to the product using the arrow keys on your keyboard, and then confirming your selection by pressing <kbd>Enter</kbd>.

   The newly-added product appears in the quick order list.

   **Note:** The suggestions box appears below the form after a user enters three characters. You can change this default value by modifying the `QuickOrderConfig`. For more information, see [Modifying the Quick Order Form Configuration](#modifying-the-quick-order-form-configuration).

   **Note:** The suggestion box only appears if you are using version 4.2 or newer of the Spartacus libraries. If you are using an older version, you can add products to the quick order list by entering a product SKU in the form and pressing <kbd>Enter</kbd>.

1. Click **Add To Cart**.

   A global message informs you that the items have been added to the cart, and the quick order list is reset to an empty state, as shown in the following example:

   <img src="{{ site.baseurl }}/assets/images/quick-order-5.png" alt="Quick Order Page" width="700" border="1px" />

   If any product in the quick order list is out of stock, or if it was not possible to add the full quantity of a product to the cart, an error message is displayed at the top of the page, as shown in the following example:

   <img src="{{ site.baseurl }}/assets/images/quick-order-6.png" alt="Quick Order Page With Errors" width="700" border="1px" />

### Restoring a Deleted Product in the Quick Order Page

{% capture version_note %}
{{ site.version_note_part1a }} 4.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

You can restore deleted products from the quick order list, as described in the following procedure.

1. Add at least one product to the list, and then click **Remove** on any row.

   A global message informs you that the product has been moved to the trash. This message disappears after five seconds, which is the default timeout value. You can modify the timeout value by overriding the `hardDeleteTimeout` property in the `QuickOrderService`.

1. Before the global message disappears, click **Undo** to restore the product.

   The following is an example.

   <img src="{{ site.baseurl }}/assets/images/quick-order-7.png" alt="Quick Order Page With Deleted Product" width="700" border="1px" />

   After clicking **Undo**, the previously deleted product appears again in the quick order list.

### Importing and Exporting in the Quick Order Page

{% capture version_note %}
{{ site.version_note_part1a }} 4.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

You can import a CSV file containing a list of products, and add these products to the quick order list. You can also export the products in the current quick order list to a CSV file.

The functionality for importing a CSV file into the quick order list is dependent on the `quickOrderListLimit`. If there are more products in the CSV file than are permitted by the limit, any products that exceed the limit are not added. For information on configuring the `quickOrderListLimit`, see [Limiting the Quick Order List](#limiting-the-quick-order-list).

**Note:** To import and export in the **Quick Order** page, you need to enable cart import and export. For more information, see [{% assign linkedpage = site.pages | where: "name", "cart-import-export.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/cart-import-export.md %}).

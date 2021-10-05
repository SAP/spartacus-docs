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

The Quick Order feature allows users to quickly add multiple items to their cart. There is also the option to add a single product through the cart page quick form.

For more information, see [Quick Order](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/caf95981aa174660b3faf839a9dddbef.html) on the SAP Help Portal.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
  {:toc}

***

## Enabling Quick Order

You can enable Quick Order by installing the `@spartacus/cart` feature library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

### CMS Components

Quick Order is CMS-driven and consists of the following CMS components:

- `CartQuickOrderFormComponent`
- `QuickOrderComponent`

You can configure Quick Order by using SmartEdit to display the Quick Order components in Spartacus, or you can manually add them to content slots using ImpEx.

If you are using the [{% assign linkedpage = site.pages | where: "name", "spartacussampledata-extension.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/spartacussampledata-extension.md %}), the Quick Order components are already enabled. However, if you decide not to use the spartacussampledata extension, you can enable the Quick Order components through ImpEx.

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

You can enable Quick Order by adding the **Cart Quick Order Form** component with the following ImpEx:

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef
;;CartQuickOrderFormComponent;Cart Quick Order Form Component;CartQuickOrderFormComponent;CartQuickOrderFormComponent

UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)
;;CenterRightContentSlot-cartPage;CartTotalsComponent,CartApplyCouponComponent,CartQuickOrderFormComponent
```

You can also enable Quick Order by adding the **Quick Order Page** with the following ImpEx:

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

It is possible to modify how many items you can add to the **Quick Order List**, as described in the following section.

### Limiting the Quick Order List

By default, you can add up to ten products to the **Quick Order List**, but you can modify this value by providing a different configuration. You can either add a new CMS component as **CmsQuickOrderComponent** with a **quickOrderListLimit** attribute, or you can modify the default config, as shown in the following example:

```ts
provideConfig(<CmsConfig>{
  cmsComponents: {
    QuickOrderComponent: {
      data: {
        quickOrderListLimit: <yourValue>
      }
    },
  },
}),
```

### Modifying Quick Order Form Config

By default, suggestion box appears after 3 characters with maximum 5 products with images. You can modify this value by providing a different configuration.

You can modify the default config, as shown in the following example:

```ts
provideConfig(<QuickOrderFormConfig>{
  quickOrderForm: {
    displayProductImages: <yourValue>,
    maxProducts: <yourValue>,
    displayProductImages: <yourValue>
  }
}),
```

## Using Quick Order

The following sections describe how to use the Quick Order feature in the Spartacus storefront.

### Using the Quick Order Form in the Cart Page

Even if you are not logged in, you can add products to the cart using the Quick Order form in the **Cart** page, as follows:

1. Add one or more items to your cart, then open the **Cart** page.

   Below the **Order Summary**, the Cart Quick Order Form component appears below the Coupon form, as shown in the following example:

   <img src="{{ site.baseurl }}/assets/images/quick-order-1.png" alt="Shopping Cart" width="700" border="1px" />

1. Add a product SKU and enter the desired quantity.

1. Click **Add To Cart**.

   A global alert then appears and your current active cart is updated. The following is an example:

   <img src="{{ site.baseurl }}/assets/images/quick-order-3.png" alt="Cart Quick Order Form" width="700" border="1px" />

### Using the Quick Order Page

The following sections describe how to use the Quick Order feature in the Spartacus storefront.

## Adding Products with the Quick Order Page

The **Quick Order** page provides a form for adding new products from suggestions, and displays a list of products that have already been added. The list includes information about the products that have been added to the Quick Order page, such as the product image, name, availability, price, and quantity that you want to add to your cart. The following is an example:

<img src="{{ site.baseurl }}/assets/images/quick-order-4.png" alt="Quick Order Page" width="700" border="1px" />

You can add products to the Quick Order list and then to your cart, as follows:

1. Enter a product name, SKU or any characters in the form and wait for suggestions box.

   The suggestions box appears below the form after 3 characters (default value, it can be modify with `QuickOrderFormConfig` ).

   <img src="{{ site.baseurl }}/assets/images/quick-order-8.png" alt="Quick Order Form Suggestion Box" width="700" border="1px" />

2. If there is only one product in suggestions you can directly press <kbd>Enter</kbd> to add the product. If there are more products you can select product to add by clicking on it or you can navigate to the product using keyboard arrows <kbd>Up</kbd> or <kbd>Down</kbd> and to confirm selection press <kbd>Enter</kbd>.

   The newly-added product appears in the Quick Order list.

3. Click **Add To Cart**.

   A global message informs you that the items have been added to the cart, and the Quick Order list is reset to an empty state, as shown in the following example:

   <img src="{{ site.baseurl }}/assets/images/quick-order-5.png" alt="Quick Order Page" width="700" border="1px" />

   If any product in the Quick Order list is out of stock, or if it was not possible to add the full quantity of a product to the cart, an error message is displayed at the top of the page, as shown in the following example:

   <img src="{{ site.baseurl }}/assets/images/quick-order-6.png" alt="Quick Order Page With Errors" width="700" border="1px" />

## Restore deleted product in the Quick Order Page

This feature allows to restore deleted products from the Quick Order list. The following is an example:

1. Add at least one product to the list and then click **Remove** on any row.

A global message informs you that the product have been moved to trash. This message will disappear after 5 seconds _(This is the default value of timeout. It is possible to edit it by overwriting property **hardDeleteTimeout** in `QuickOrderService`)_.

1. Click **Undo** to restore the product, before the global message disappears.

Previously deleted product appears again in the Quick Order list.

  <img src="{{ site.baseurl }}/assets/images/quick-order-7.png" alt="Quick Order Page With Deleted Product" width="700" border="1px" />

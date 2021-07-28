---
title: Quick Order
feature:
  - name: Quick Order
    spa_version: 4.1
    cx_version: 2005
---

{% capture version_note %}
{{ site.version_note_part1 }} 4.1 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The quick order feature allows customers to quickly add several products to a form, then add all those products to a cart, using SKUs.

For more information, see [Quick Order](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/2011/en-US/caf95981aa174660b3faf839a9dddbef.html?q=quick%20order) on the SAP Help Portal.

---

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
  {:toc}

---

## Enabling Quick Order

You can enable the quick order feature by installing the `@spartacus/cart` feature library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

### CMS Components

The quick order feature is CMS driven, and consists of the following CMS components:

- `CartQuickOrderFormComponent`
- `QuickOrderComponent`

You can configure the quick order feature by using SmartEdit to display the quick order components in Spartacus, or you can manually add them to content slots using ImpEx.

If you are using the [spartacussampledata extension]({{ site.baseurl }}{% link _pages/install/spartacussampledata-extension.md %}), the quick order components are already enabled. However, if you decide not to use the extension, you can enable them through ImpEx.

**Note:** The `$contentCV` variable that is used throughout the following ImpEx examples, and which stores information about the content catalog, is defined as follows:

```text
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]
```

#### Adding CMS Components Manually

This section describes how to add quick order CMS components to Spartacus using ImpEx.

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

You can enable the **Quick Order** and **Cart Quick Order Form** component with the following ImpEx:

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;fle
;;CartQuickOrderFormComponent;Cart Quick Order Form Component;CartQuickOrderFormComponent;CartQuickOrderFormComponent

UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)
;;CenterRightContentSlot-cartPage;CartTotalsComponent,CartApplyCouponComponent,CartQuickOrderFormComponent
```

You can enable the **Quick Order** and **Quick Order Page** with the following ImpEx:

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

### Cart Page

You can use quick order form in the **Cart** page both for logged in users and anonymous.

Adding products to cart with cart quick order form:

1. Add one or more items to your cart, then open the **Cart** page.

   The **Quick Order form** component appears below the **Coupon form**, as shown in the following example:

   <img src="{{ site.baseurl }}/assets/images/quick-order-1.png" alt="Shopping Cart" width="800" border="1px" />

2. Add product SKU and change quantity if you want.

   <img src="{{ site.baseurl }}/assets/images/quick-order-2.png" alt="Cart Quick Order Form" width="800" border="1px" />

3. Click **Add To Cart**.

   After adding to cart, globall alert appear, your current active cart will refresh and show new product or increase existing product quantity.

   <img src="{{ site.baseurl }}/assets/images/quick-order-3.png" alt="Cart Quick Order Form" width="800" border="1px" />

#### Quick Order Page

The **Quick Order** page shows a form to add new product and a list of added products to quick order with basic information about product like image, name, stock information, price and the quantities.

On the list, you can modify products quantity or remove single product. Also at the bottom of the page thare are two action buttons. You can clear the list or add all products to the active cart.

Adding product to the quick order list:

1. Enter product SKU in the form and press ENTER.

   After success adding, product should appear on the list and form will reset.

The following is and example:

<img src="{{ site.baseurl }}/assets/images/quick-order-4.png" alt="Quick Order Page" width="800" border="1px" />

#### Limit Quick Order List

By default, you can add up to **10** products to **Quick Order List**, but there is possibility to modify this value providing different config. There are two ways to modify list limit:

1. Add new CMS component as **CmsQuickOrderComponent** with **quickOrderListLimit** attribute.

2. Modify default config, as shown in the following example:

```text
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

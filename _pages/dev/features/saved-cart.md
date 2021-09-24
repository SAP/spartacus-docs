---
title: Saved Cart
feature:
- name: Saved Cart
  spa_version: 3.2
  cx_version: 2005
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The saved cart feature allows users to save one or more carts for later use. Users can benefit from the saved cart feature to enhance their online shopping experience. For example, they can create a saved cart for items that they purchase on a regular basis, or they can create different saved carts for specific types of purchases.

For more information, see [Multiple Saved Carts](https://help.sap.com/viewer/e1391e5265574bfbb56ca4c0573ba1dc/latest/en-US/4d094e78a5494963b2d66148167f0553.html) on the SAP Help Portal.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Enabling Saved Cart

You can enable the saved cart feature by installing the `@spartacus/cart` feature library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

### CMS Components

The saved cart feature is CMS driven, and consists of the following CMS components:

- `AddToSavedCartsComponent`
- `AccountSavedCartHistoryComponent`
- `SavedCartDetailsOverviewComponent`
- `SavedCartDetailsItemsComponent`
- `SavedCartDetailsActionComponent`

You can configure the saved cart feature by using SmartEdit to display the saved cart components in Spartacus, or you can manually add them to content slots using ImpEx.

If you are using the [spartacussampledata extension]({{ site.baseurl }}{% link _pages/install/spartacussampledata-extension.md %}), the saved cart components are already enabled. However, if you decide not to use the extension, you can enable them through ImpEx.

**Note:** The `$contentCV` variable that is used throughout the following ImpEx examples, and which stores information about the content catalog, is defined as follows:

```text
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]
```

#### Adding CMS Components Manually

This section describes how to add the various saved cart CMS components to Spartacus using ImpEx.

You can enable the **Saved Carts** link in the **My Account** drop-down menu with the following ImpEx:

```text
INSERT_UPDATE CMSLinkComponent;$contentCV[unique=true];uid[unique=true];name;url;&linkRef;&componentRef;target(code)[default='sameWindow'];restrictions(uid,$contentCV)
;;SavedCartsLink;Saved Carts Link;/my-account/saved-carts;SavedCartsLink;SavedCartsLink;;loggedInUser
```

You can enable the **Saved Carts** history page and **Saved Carts Details** page with the following ImpEx:

```text
INSERT_UPDATE ContentPage;$contentCV[unique=true];uid[unique=true];label
;;saved-carts;/my-account/saved-carts
;;savedCartDetailsPage;/my-account/saved-cart
```

You can enable the **Saved Carts** and **Save Cart for Later** buttons with the following ImpEx:

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;AddToSavedCartsComponent;Add To Saved Carts Component;AddToSavedCartsComponent
```

You can enable the saved cart history component with the following ImpEx:

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;AccountSavedCartHistoryComponent;Account Saved Cart History Component;AccountSavedCartHistoryComponent

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;BodyContent-saved-carts;Body content for Saved Carts History Slot;AccountSavedCartHistoryComponent
```

You can enable the saved cart details components with the following ImpEx:

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;SavedCartDetailsOverviewComponent;Saved Cart Details Overview Component;SavedCartDetailsOverviewComponent
;;SavedCartDetailsItemsComponent;Saved Cart Details Items Component;SavedCartDetailsItemsComponent
;;SavedCartDetailsActionComponent;Saved Cart Details Action Component;SavedCartDetailsActionComponent

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;BodyContent-savedCartDetailsPage;Body content for Saved Carts Details Slot;SavedCartDetailsOverviewComponent,SavedCartDetailsItemsComponent,SavedCartDetailsActionComponent
```

## User Interface

The saved cart feature extends the `Cart` interface with `name`, `description` and `saveTime`. When saving a cart, the name is required, and the description is optional.

### Cart Page

You can only save a cart from the **Cart** page when you are logged in and you have items in your cart. If you are not logged in, the **Saved Carts** and **Save Cart For Later** links re-direct you to the login page.

#### Creating a Saved Cart

1. Add one or more items to your cart, then open the **Cart** page.

   The **Save Cart For Later** link appears next to the **Order Summary**, as shown in the following example:

   <img src="{{ site.baseurl }}/assets/images/saved-carts-1.png" alt="Shopping Cart" width="800" border="1px" />

1. Click **Save Cart For Later**.

   The **Save For Later** dialog box appears:

   <img src="{{ site.baseurl }}/assets/images/saved-carts-2.png" alt="Save For Later dialog box" width="800" border="1px" />

1. Add a name for your saved cart. You can also add a description.

1. Click **Save**.

   After saving the cart, your current active cart is no longer displayed because it has been saved.

### Saved Cart History Page

Once you have saved a cart, you can view a list of your saved carts in the **Saved Carts** history page. You can access the history page by clicking on **Saved Carts** in the **My Account** drop-down menu, as shown in the following example:

<img src="{{ site.baseurl }}/assets/images/saved-carts-3.png" alt="Accessing the Saved Carts History Page" width="800" border="1px" />

From the **Saved Carts** history page, you can access the details of any saved cart by clicking on the saved cart, or on any element in the row, except for the **Make Cart Active** link.

The following is an example of the **Saved Carts** history page:

<img src="{{ site.baseurl }}/assets/images/saved-carts-4.png" alt="Saved Carts History Page" width="800" border="1px" />

When you click **Make cart active**, you have the option to keep a copy of this saved cart before clicking **Restore**. Once you click **Restore**, the saved cart becomes the active cart. After being made active, the saved cart disappears from the list of saved carts, unless you have chosen to keep a copy of that saved cart. If you choose to keep a copy of the saved cart, it appears in your list of saved carts. By default, the name of this new saved cart is **Copy of *existing cart name***, but you can instead set the name of the saved cart in the **Name of copied cart** field, as shown in the following example:

<img src="{{ site.baseurl }}/assets/images/saved-carts-4-dialog-clone.png" alt="Save For Later dialog box with copy saved cart enabled" width="800" border="1px" />

### Saved Cart Details Page

The **Saved Cart Details** page shows all the relevant information about a specific saved cart, such as the items in the cart, the quantities, and the date the cart was saved.

The following is an example:

<img src="{{ site.baseurl }}/assets/images/saved-carts-5.png" alt="Saved Carts Details Page" width="800" border="1px" />

You can update the name and description of the saved cart by clicking the pencil icon. You can also change the quantities of a product, and also remove it from your saved cart.

**Note:** If you remove all of the items from a saved cart, the saved cart is deleted and you are redirected to the **Saved Carts** history page.

## Limitations

The saved cart feature does not currently work with the Configurable Products integration.

The saved cart feature also currently does not allow you to add multiple products to the active cart from the **Saved Cart Details** page.

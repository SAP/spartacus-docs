---
title: Saved Cart
feature:
  - name: Saved Cart
    spa_version: 3.2
    cx_version: 2005
---

**Note:** This feature is introduced with version 3.2 of the Spartacus libraries.

## Overview

The Saved Cart feature lets you save an active cart for later.

Note: The saved cart feature is for B2B storefronts only until further notice.

For more information, see [Saved Carts](https://help.sap.com/viewer/e1391e5265574bfbb56ca4c0573ba1dc/v2011/en-US/4d094e78a5494963b2d66148167f0553.html) on the SAP Help Portal.

## Prerequisites

Saved Carts requires the Saved Cart feature library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

## Usage

Saved cart extends the **Cart** interface with name, description and saveTime. When saving a cart, the name is required in order to save the cart, and adding a description to it is optional.

### Cart page

You can only save the cart from the cart page when there are entries in the active cart. If you are not signed in, the “Saved carts” and “Save cart for later” button links will re-direct you to the login page as you can only save a cart as a logged in user. To save an active cart, click **Save Cart For Later**

![Saved Carts]({{ site.baseurl }}/assets/images/saved-carts-1.png)

When clicking **Save Cart for Later**, you will see a form dialog. As mentioned previously, the input for name is required. After saving the cart, your current active cart will no longer be displayed as it has been saved.

![Saved Carts]({{ site.baseurl }}/assets/images/saved-carts-2.png)

### Saved Cart Listing page

Once you have saved a cart, you can view a list of saved carts in the saved cart listing page. You can access the listing page through the **Saved carts** option from the **My Account** dropdown menu.

![Saved Carts]({{ site.baseurl }}/assets/images/saved-carts-3.png)

You can view a list of saved carts in the listing page, however, there are no pagination, or filters until further notice. More information can be found here [#11157](https://github.com/SAP/spartacus/issues/11157).

From the saved cart list page, you can navigate to the saved cart details page by clicking on the row or by clicking an element on the row except the **Make Cart Active** button link.

![Saved Carts]({{ site.baseurl }}/assets/images/saved-carts-4.png)

Once you click **Make Cart Active**, the selected saved cart will be restored and become an active cart. After the successful restoration, this cart will disappear from the list.

Note:

- If there exist an active cart with entries, it will swap the active cart with the saved cart.
- If there exist an active cart, but with no entries, then it will make the active cart into a saved cart without swapping it with the empty active cart.
- With any restored cart, the form dialog will be prefilled with existing the name and description of the saved cart.

### Saved Cart Details page

On the saved cart details page, you can view all necessary information on the specific saved cart.

![Saved Carts]({{ site.baseurl }}/assets/images/saved-carts-5.png)

You may update the name and/or description of the saved cart by clicking the pencil icon, which will open a form dialog.

- Note: If the description of the saved cart is longer than 30 characters, then it will display a **More** button link to view it in a small customized tooltip.

You can change the quantities of a product, and remove it.

- Note: If you remove the last entry, the saved cart will be deleted automatically and will redirect you to the saved cart list.

You also have two action buttons, where you can **Delete Saved Cart** or **Make Cart Active**. Similarly, deleting a saved cart will delete the cart and redirect you to the listing page, and making the cart active will behave the same way as described in the **Saved Cart Listing page**.

## CMS Components

The feature is cms driven and can be configured in SmartEdit to display the components in Spartacus accordingly, or by manually adding the cms components to a content slot via ImpEx.

The saved cart feature consists of the the following cms components: `AddToSavedCartsComponent`, `AccountSavedCartHistoryComponent`, `SavedCartDetailsOverviewComponent`, `SavedCartDetailsItemsComponent`, and `SavedCartDetailsActionComponent`.

If you are using the `spartacussampledata` extension, the feature is enabled out of the box. However, if you decide to not opt in for the extension, you have the option to enable it through ImpEx.

**Note:** The `$contentCV` variable, which stores information about the content catalog, and which is used throughout the ImpEx in the following procedures, is defined as follows:

```text
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]
```

### MISC

1. Enable saved carts link in the **My Account** menu

```text
INSERT_UPDATE CMSLinkComponent;$contentCV[unique=true];uid[unique=true];name;url;&linkRef;&componentRef;target(code)[default='sameWindow'];restrictions(uid,$contentCV)
;;SavedCartsLink;Saved Carts Link;/my-account/saved-carts;SavedCartsLink;SavedCartsLink;;loggedInUser
```

2. Enable the saved cart listing and details page

```text
INSERT_UPDATE ContentPage;$contentCV[unique=true];uid[unique=true];label
;;saved-carts;/my-account/saved-carts
;;savedCartDetailsPage;/my-account/saved-cart
```

### Cart page

1. Enable the saved cart action buttons: "Saved Carts" and "Save Cart for Later"

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;AddToSavedCartsComponent;Add To Saved Carts Component;AddToSavedCartsComponent
```

### Saved Cart listing page

1. Enable the saved cart listing component

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;AccountSavedCartHistoryComponent;Account Saved Cart History Component;AccountSavedCartHistoryComponent

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;BodyContent-saved-carts;Body content for Saved Carts History Slot;AccountSavedCartHistoryComponent
```

### Saved Cart details page

1. Enable the saved cart details components

```text
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;SavedCartDetailsOverviewComponent;Saved Cart Details Overview Component;SavedCartDetailsOverviewComponent
;;SavedCartDetailsItemsComponent;Saved Cart Details Items Component;SavedCartDetailsItemsComponent
;;SavedCartDetailsActionComponent;Saved Cart Details Action Component;SavedCartDetailsActionComponent

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;BodyContent-savedCartDetailsPage;Body content for Saved Carts Details Slot;SavedCartDetailsOverviewComponent,SavedCartDetailsItemsComponent,SavedCartDetailsActionComponent
```

## Limitations

The Saved Cart feature does not work out of the box with configurable products integration. In the next releases, configurable products will support configurable products in the Saved Cart Details page.

## Future Releases

Saved cart will allow multiple products to be added to the active cart from the saved cart details page.

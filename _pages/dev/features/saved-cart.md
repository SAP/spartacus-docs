---
title: Saved Cart
feature:
  - name: Saved Cart
    spa_version: 3.2
    cx_version: 2005
---

**Note:** This feature is introduced with version 3.2 of the Spartacus libraries.

The Saved Cart feature lets you save an active cart for later.

## Prerequisites

Saved Cart requires the Save Cart feature library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

## Usage

Saved cart extends **Cart** interface with name, description and saved times fields. The name field is mandatory in the dialog form.

You can save the cart from the cart page. If you are not signed in, the “Saved carts” and “Save cart for later” options will indicate that you need to be logged in before you can perform those actions. To save active cart, click **Save Cart For Later**

![Saved Carts]({{ site.baseurl }}/assets/images/saved-carts-1.png)

The saved cart dialog form will open and you have to fill the form. The name field is required. If you want to save the cart you have to click **Save** button. After that, your active cart will be removed and the page refreshed.

![Saved Carts]({{ site.baseurl }}/assets/images/saved-carts-2.png)

Once you have saved a cart, you can view the contents of your saved cart list through the **Saved carts** option in the **My Account** menu.

![Saved Carts]({{ site.baseurl }}/assets/images/saved-carts-3.png)

The number of saved carts is **unlimited**. From the saved cart list page you can navigate to saved cart details by clicking on the row or each row element and you can make the saved cart active.

![Saved Carts]({{ site.baseurl }}/assets/images/saved-carts-4.png)

Once you click **Make Cart Active**, the selected saved cart will restore and became an active cart. After successful restoration, this cart will disappear from the list. During restoration, if there is an active cart, it will be saved and will appear on the list with the default name as cart id.

After that action, if you open the active cart and again would you like to save it. Dialog form will open with filled data.

If you open saved cart details, you can see all information about the saved cart. You can change products quantity and remove it. If you remove the last entry, the saved cart will be deleted automatically and will redirect you to the saved cart list.

![Saved Carts]({{ site.baseurl }}/assets/images/saved-carts-5.png)

From the saved cart details page you can also edit cart name and description by clicking the pencil icon next to the cart name section. Then dialog form will open with filled data.

At the bottom of the page, you have two action buttons. You can **Delete Saved Cart** or **Make Cart Active**. Both actions work the same like describe before.

## Customizing

The saved cart feature consists of the `AddToSavedCartsComponent`, `AccountSavedCartHistoryComponent`, `SavedCartDetailsOverviewComponent`, `SavedCartDetailsItemsComponent`, `SavedCartDetailsActionComponent`, components. All of these components are CMS driven and can be configured in SmartEdit. You can also customize these components in Spartacus using CMS component mapping. For more information, see [Customizing CMS Components]({{ site.baseurl }}{% link _pages/dev/components/customizing-cms-components.md %}).

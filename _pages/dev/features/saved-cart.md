---
title: Saved Cart
feature:
  - name: Saved Cart
    spa_version: 3.2
    cx_version: 2005
---

**Note:** This feature is introduced with version 3.2 of the Spartacus libraries.

The Saved Cart feature lets you save active cart for later.

## Prerequisites

Saved Cart requires the Save Cart feature library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

## Usage

You can save cart from the cart page. If you are not signed in, the “Saved carts” and “Save cart for later” options will indicate that you need to be logged in before you can perform those actions.

Once you have saved a cart, you can view the contents of your saved cart list through the **Saved carts** option in the **My Account** menu.

## Customizing

The saved cart feature consists of the `AddToSavedCartsComponent`, `AccountSavedCartHistoryComponent`, `SavedCartDetailsOverviewComponent`, `SavedCartDetailsItemsComponent`, `SavedCartDetailsActionComponent`, components. All of these components are CMS driven and can be configured in SmartEdit. You can also customize these components in Spartacus using CMS component mapping. For more information, see [Customizing CMS Components]({{ site.baseurl }}{% link _pages/dev/components/customizing-cms-components.md %}).

---
title: Wish List
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The Wish List feature lets you save products for later viewing.

## Usage

You can add products to a wish list from the product details page. If you are not signed in, the "Add to Wish List" option will indicate that you need to be logged in before you can add a product to the wish list.

Once you have added items to the wish list, you can view the contents of your wish list through the **Wish list** option in the **My Account** menu.

## Customizing

The wish list feature consists of the `AddToWishListComponent` and the `WishListService` component. Both of these components are CMS driven and can be configured in SmartEdit. You can also customize these components in Spartacus using CMS component mapping. For more information, see [Customizing CMS Components]({{ site.baseurl }}{% link _pages/dev/customizing-cms-components.md %}).

## Limitations

A user cannot have more than one wish list. Furthermore, each wish list is tied to a specific user, so a wish list cannot be shared with other users. Finally, it is not possible to add a product to a wish list if that product is out of stock.

## Disabling Wish Lists

The wish list feature is enabled by default in Spartacus.

The only way to disable wish lists is through the CMS. You can disable wish lists by making changes to the `spartacussampledataaddon` AddOn, or to your custom AddOn, as follows:

1. Remove the `WishListLink` by removing the following line from the relevant `cms-responsive-content.impex` files:

   ```plaintext
   ;;WishListLink;Wish List Link;/my-account/wishlist;WishListLink;WishListLink;;loggedInUser
   ```

   **Note:** There is a `cms-responsive-content.impex` file for each base site.

1. Remove the link from the `SiteLinksSlot` by removing `WishListLink` from the following line in the relevant `cms-responsive-content.impex` files:

   ```plaintext
   ;;SiteLinksSlot;Slot contains some links;true;OrdersLink,WishListLink,StoreFinderLink,ContactUsLink,HelpLink
   ```

1. Remove the `WishListNavNode` by removing the following line from the relevant `cms-responsive-content.impex` files:

   ```plaintext
   ;WishListNavNode;;Wish List;MyAccountNavNode;;WishListNavNode
   ```

1. Remove the `WishListNavNodeEntry` by removing the following line from the relevant `cms-responsive-content.impex` files:

   ```plaintext
   ;WishListNavNodeEntry;;WishListNavNodeEntry;WishListNavNode;WishListLink;
   ```

1. Remove all references of `WishListPage`, `BodyContentSlot-wishList`, `WishListComponent` and `AddToWishListComponent`.

You can also do these steps in Backoffice.

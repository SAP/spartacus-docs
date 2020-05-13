---
title: Wish List (DRAFT)
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The Wish List feature lets users save (or bookmark) products for later viewing.

## Usage

Products can be added to the wish list from the product details page. If the user is not signed in the add to wish list option will instead say he must login before adding a product to the wish list.

Once a user has added items to the wish list he can view the content of his wish list via the "Wish list" option in the "My Account" menu.

## Customization

The wish list feature consists of two components. Both the `AddToWishListComponent` and `WishListService` are CMS driven therefore they can be configured in SmartEdit. They can also be customized in Spartacus using the [Spartacus CMS component mapping]{{ site.baseurl }}{% link _pages/dev/customizing-cms-components.md %}).

## Limitations

Due to technical limitation at the moment it is only possible for a user to have a single wish list. In addition the each wish list is tied to a user therefore it is not possible to share it. Finally, for the time being it is not possible to add an out of stock product to the wish list.

## Disabling Wish List in Spartacus

The wish list feature is enabled by default in Spartacus.

Since the feature is CMS driven, the only way to disable it is through the CMS. To do so the following changes should be made to the Spartacussampledataaddon or your custom addon:

1. Remove the WishListLink
   `;;WishListLink;Wish List Link;/my-account/wishlist;WishListLink;WishListLink;;loggedInUser`
2. Remove the link from the SiteLinksSlot
   `;;SiteLinksSlot;Slot contains some links;true;OrdersLink,WishListLink,StoreFinderLink,ContactUsLink,HelpLink` (Remove `WishListLink`)
3. Remove the WishListNavNode
   `;WishListNavNode;;Wish List;MyAccountNavNode;;WishListNavNode`
4. Remove the WishListNavNodeEntry
   `;WishListNavNodeEntry;;WishListNavNodeEntry;WishListNavNode;WishListLink;`
5. Remove all references of `WishListPage`, `BodyContentSlot-wishList`, `WishListComponent` and `AddToWishListComponent`

These steps can also be done in Backoffice.

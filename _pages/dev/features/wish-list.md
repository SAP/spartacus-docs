---
title: Wish List (DRAFT)
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The Wish List feature lets users save (or bookmark) products for later viewing.

## Limitations

Due to technical limitation at the moment it is only possible for a user to have a single wish list. In addition the each wish list is tied to a user therefore it is not possbile to share it. Finally, for the time being it is not possible to add an out of stock product to the wish list.

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

---
title: Applied Promotions
feature:
- name: Applied Promotions
  spa_version: 2.0
  cx_version: 1905
---

{% capture version_note %}
{{ site.version_note_part1 }} 2.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

In Spartacus, you can display information about the following types of applied promotions:

- Cart promotions, which offer a discount on the entire cart - for example, a percentage or fixed discount on the entire order.
- Product promotions, which offer a discount on specific products or a specific category of products.
- Total promotions, which combine all promotions to display the total amount the customer has saved.

## Enabling Applied Promotions

You can enable applied promotions using Backoffice. For more information, see the following on the SAP Help Portal:

- [Rule Builder](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/109559e50e8340459e8d25921541f297.html)
- [Creating a Promotion Rule](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/3f8f896e506d4e0bbe19e978ae775577.html)
- [Publishing a Promotion Rule](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/15cdf4e5e27040398d67669506ac931f.html)

## Displaying Applied Promotions

In Spartacus, the `PromotionService` is used to obtain available promotions. The `getOrderPromotions` method retrieves order promotions, and the `getProductPromotion` method retrieves product promotions.

Applied promotions elements are available in the following:

- the add-to-cart modal
- the cart details page
- the review submit component
- the checkout confirmation page
- the order history page

You can use the following template to display existing order promotions:

```html
<ng-container *ngIf="orderPromotions$ | async as orderPromotions">
    <cx-promotions [promotions]="orderPromotions"></cx-promotions>
</ng-container>
```

With this template, if there are no promotions available, then no empty promotions elements are shown in the DOM.

The `PromotionsComponent` can display either product promotions or order promotions.

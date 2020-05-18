---
title: Promotions
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

There are 3 types of "discount info" that one can show in Spartacus:

- Discount that applied to the cart total - Order promotions
Example: Save $20 because you spent more than $200
- Discount you got per item - Product promotions
Example: SKU 123 is $10 off today
- All discounts in total
Total amount the customer saved - all discounts combined.


## Enabling Promotions

Promotions for the specific product / order can be enabled from the backoffice, in the Promotion Rules section. After publishing the promotion rule, `Display in the storefront` check should be checked.

## Displaying Promotions

In order to obtain the available promotions, `PromotionService` is used.
To get the order and product promotions, methods `getOrderPromotions` and `getProductPromotion` should be used, respectively.

You can find promotions elements in locations such as the following:
- Add-to-cart modal window,
- Cart Details page,
- Review submit,
- Checkout confirmation,
- Order history,

In order to show the existing order promotions, the following template can be used:
```html
<ng-container *ngIf="orderPromotions$ | async as orderPromotions">
    <cx-promotions [promotions]="orderPromotions"></cx-promotions>
</ng-container>
```
In that way, when there are no promotions available, one will not show the empty element in the DOM.

`PromotionsComponent` is capable of displaying either product or order promotions.





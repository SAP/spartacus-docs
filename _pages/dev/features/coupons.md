---
title: Coupons
feature:
- name: Coupons
  spa_version: 1.3
  cx_version: 1905
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.3 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The coupons feature allows you to create digital coupons that your customers can redeem for discounts on the storefront.

## Requirements

The coupon feature requires the following extensions:

- `couponbackoffice` Extension
- `couponfacades` Extension
- `couponwebservices` Extension

For more information, see [Coupon Architecture](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/a3fab07560c94b8e9e5d8824c0d88580.html) on the SAP Help Portal.

## Enabling Coupons

The coupon feature has corresponding CMS-component data in the back end that allows you to enable or disable the feature.

## Configuring

No special configuration is needed.

Coupons are managed using Backoffice. For more information, see [Coupon Module](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/d35c247bac2d4c91a6ca4501b63cb2b4.html) on the SAP Help Portal.

## Extending

No special extensibility is available for this feature.

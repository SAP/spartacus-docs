---
title: Customer Coupons
feature:
- name: Customer Coupons
  spa_version: 1.5
  cx_version: 1905
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.5 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The Customer Coupons feature provides a range of functionality for promotion campaigns, such as allowing customers to claim a coupon using the coupon's campaign URL, turning on status notifications for a coupon, allowing users to view their coupons in the **My Coupons** section, and applying usable coupons during checkout.

## Requirements

The Customer Coupons feature requires the `customercouponoccaddon` AddOn to work.

For more information, see [Customer Coupon Architecture](https://help.sap.com/viewer/DRAFT/4e9e1795f3e04125b3e0206dfefbf3a9/latest/en-US/97d91d0c7c3449e6ba4412d721535d6a.html) on the SAP Help Portal.

## Enabling Customer Coupons

The Customer Coupons feature has corresponding CMS-component data that allows you to enable or disable the feature. The configuration is provided in the `MyCouponsModule`.

## Configuring

No special configuration is needed.

Customer coupons are managed using Backoffice. For more information, see [Customer Coupon Management](https://help.sap.com/viewer/DRAFT/4e9e1795f3e04125b3e0206dfefbf3a9/latest/en-US/b307666c232146058353c1f6e8a058fd.html) on the SAP Help Portal.

## Extending

No special extensibility is available for this feature.

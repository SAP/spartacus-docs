---
title: Coupons (DRAFT)
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.3 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

When a coupon promotion has been created, customers apply the applicable coupon to activate the promotion during checkout to get discounts and/or rewards for their orders. 

## Requirements

The coupon feature requires the following extensions to work:

- couponbackoffice Extension 
- couponfacades Extension 
- couponwebservices Extension 

For more information, see [Coupon Architecture](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/a3fab07560c94b8e9e5d8824c0d88580.html) in the SAP Help Portal.

## Enabling Coupons

The coupon feature has corresponding CMS-component data in the back end that allows you to enable or disable the feature.


## Configuring

No special configuration needed.

Coupons are managed using Backoffice. See [Coupon Module](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/d35c247bac2d4c91a6ca4501b63cb2b4.html) for more information.

## Extending

No special extensibility available for this feature.

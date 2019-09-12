---
title: Coupon (DRAFT)
---

## Intro

Customers apply coupons in the cart page to get discounts and/or rewards for their orders. Coupons are applied by entering coupon codes in the **Coupon** field. The applied coupon codes will then display in the **Order Summary** section. 

## Requirements

The coupon feature requires the following extensions to work:
- couponbackoffice Extension 
- couponfacades Extension 
- couponwebservices Extension 

See https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/a3fab07560c94b8e9e5d8824c0d88580.html for more information.

## Enabling Coupon Feature

You can enable and disable the coupon feature with feature flags and feature levels. To enable customer interests, set the feature flag as follows:

```
```
Or set feature level:

```
```

## Configuring

No special configuration needed.

Coupons are managed using Backoffice. See https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/d35c247bac2d4c91a6ca4501b63cb2b4.html for more information.

## Extending

No special extensibility available for this feature. 


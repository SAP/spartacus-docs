---
title: Scheduled Replenishment
feature:
  - name: Scheduled Replenishment
    spa_version: 3.0
    cx_version: 2005
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

A Scheduled Replenishment "order" is a template for future orders, `B2B-only`.

- A normal order is placed automatically
- Scheduled Replenishment orders are "held" and placed automatically at the frequency defined by the user e.g. \* every 28th of the month
- The actual orders show up separately in Order History

For more information, see [Replenishment and Order Scheduling](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/2011/en-US/8c3aa31e86691014a3c085a0e9186e0c.html) on the SAP Help Portal.

## Usage

Proceed to checkout and in the final step before placing an order, you have the option to schedule a replenishment or to place an order. Choosing to schedule a replenishment order, you may choose the specific day, week or month. Once an order is scheduled successfully, you will have an automatic re-order system from the date of your choosing.

You can view replenishments under **My Account** menu, and by choosing **Replenishment Orders**. You will be redirected to the replenishment history page, where you can view a list of replenishments with basic details that you subscribed to. Finally, choosing a specific replenishment from the history page, you can view in more details what the replenishment is about and how many successful re-orders were placed.

## CMS components

All the required CMS data is already included in the `spartacussampledata` AddOn, however the following procedures also applies to your custom AddOn. Moreover, these changes can be made through `backoffice` instead of impex.

Scheduled replenishment is enabled by default in Spartacus. This feature is CMS-driven, where you can opt out of displaying the option of scheduling an order at the final checkout step and the options to remove the visibility to view replenishments under the history and details page of replenishment orders.

**Note:** $contentCV is given as:

```sql
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]
```

### Disabling Scheduled Replenishment through the CMS

To disable `Scheduled Replenishment`, proceed as follows:

1. Remove the `cms component` of the replenishment feature from the last checkout step:

```sql
REMOVE CMSFlexComponent;uid[unique=true];$contentCV[unique=true]
;CheckoutScheduleReplenishmentOrderComponent;
```

2. Remove access to the `content page` for replenishment details, replenishment history, and replenishment order confirmation page:

```sql
UPDATE ContentPage;$contentCV[unique=true];uid[unique=true];label;pageStatus(code,itemtype(code))
;;my-replenishment-details;/my-account/my-replenishment;deleted:CmsPageStatus
;;my-replenishment-orders;/my-account/my-replenishments;deleted:CmsPageStatus
;;replenishmentConfirmationPage;/replenishment/confirmation;deleted:CmsPageStatus
```

3. Remove the `navigation node`, `navigation entry`, and `link` that routes to the replenishments.

```sql
REMOVE CMSNavigationNode;uid[unique=true];$contentCV[unique=true]
;MyReplenishmentOrdersNavNode;

REMOVE CMSNavigationEntry;uid[unique=true];$contentCV[unique=true];
;MyReplenishmentOrdersNavNodeEntry;

REMOVE CMSLinkComponent;$contentCV[unique=true];uid[unique=true]
;;MyReplenishmentOrdersLink
```

### Enabling Scheduled Replenishment through the CMS

1. Add the `cms component` and `content slot` to enable the replenishment feature from the last checkout step:

```sql
INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;SideContentSlot-checkoutReviewOrder;Checkout Place Order Slot;CheckoutOrderSummaryComponent,CheckoutScheduleReplenishmentOrderComponent,CheckoutPlaceOrderComponent

INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;CheckoutScheduleReplenishmentOrderComponent;CheckoutScheduleReplenishmentOrderComponent;CheckoutScheduleReplenishmentOrder
```

2. Enable access to the `content page` for replenishment details, replenishment history, and replenishment order confirmation page:

```sql
UPDATE ContentPage;$contentCV[unique=true];uid[unique=true];label;pageStatus(code,itemtype(code))
;;my-replenishment-details;/my-account/my-replenishment;active:CmsPageStatus
;;my-replenishment-orders;/my-account/my-replenishments;active:CmsPageStatus
;;replenishmentConfirmationPage;/replenishment/confirmation;active:CmsPageStatus
```

3. Create the `cms components` and `content slot` for the replenishment details page

```sql
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;ReplenishmentDetailItemsComponent;Replenishment Detail Items Component;ReplenishmentDetailItemsComponent
;;ReplenishmentDetailTotalsComponent;Replenishment Detail Totals Component;ReplenishmentDetailTotalsComponent
;;ReplenishmentDetailShippingComponent;Replenishment Detail Shipping Component;ReplenishmentDetailShippingComponent
;;ReplenishmentDetailActionsComponent;Replenishment Detail Actions Component;ReplenishmentDetailActionsComponent
;;ReplenishmentDetailOrderHistoryComponent;Replenishment Detail Order History Component;ReplenishmentDetailOrderHistoryComponent

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)
;;BodyContent-my-replenishment-details;ReplenishmentDetailShippingComponent,ReplenishmentDetailItemsComponent,ReplenishmentDetailTotalsComponent,ReplenishmentDetailActionsComponent,ReplenishmentDetailOrderHistoryComponent
```

4. Create the `cms components` and `content slot` for the replenishment history page:

```sql
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;AccountReplenishmentHistoryComponent;Account Replenishment History Component;AccountReplenishmentHistoryComponent

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)
;;BodyContent-my-replenishment-orders;AccountReplenishmentHistoryComponent
```

5. Create the `cms components` and `content slot` for the replenishment order confirmation page:

```sql
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;ReplenishmentConfirmationMessageComponent;Replenishment Confirmation Message Component;ReplenishmentConfirmationMessageComponent
;;ReplenishmentConfirmationOverviewComponent;Replenishment Confirmation Overview Component;ReplenishmentConfirmationOverviewComponent
;;ReplenishmentConfirmationItemsComponent;Replenishment Confirmation Items Component;ReplenishmentConfirmationItemsComponent
;;ReplenishmentConfirmationShippingComponent;Replenishment Confirmation Shipping Component;ReplenishmentConfirmationShippingComponent
;;ReplenishmentConfirmationTotalsComponent;Replenishment Confirmation Totals Component;ReplenishmentConfirmationTotalsComponent
;;ReplenishmentConfirmationContinueButtonComponent;Replenishment Confirmation Continue Button Component;ReplenishmentConfirmationContinueButtonComponent

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)
;;BodyContent-replenishmentConfirmation;ReplenishmentConfirmationMessageComponent,ReplenishmentConfirmationOverviewComponent,ReplenishmentConfirmationItemsComponent,ReplenishmentConfirmationShippingComponent,ReplenishmentConfirmationTotalsComponent,ReplenishmentConfirmationContinueButtonComponent
```

6. Create the `navigation node`, `navigation entry`, and `link` that routes to the replenishments.

**Note:** $lang is defined as any language code that is available to you.

```sql
INSERT_UPDATE CMSNavigationNode;uid[unique=true];$contentCV[unique=true];name;parent(uid, $contentCV);links(&linkRef);&nodeRef
;MyReplenishmentOrdersNavNode;;My Replenishment Orders;MyAccountNavNode;;MyReplenishmentOrdersNavNode

INSERT_UPDATE CMSNavigationEntry;uid[unique=true];$contentCV[unique=true];name;navigationNode(&nodeRef);item(&linkRef);
;MyReplenishmentOrdersNavNodeEntry;;MyReplenishmentOrdersNavNodeEntry;MyReplenishmentOrdersNavNode;MyReplenishmentOrdersLink;

INSERT_UPDATE CMSLinkComponent;$contentCV[unique=true];uid[unique=true];name;url;&linkRef;&componentRef;target(code)[default='sameWindow'];restrictions(uid,$contentCV)
;;MyReplenishmentOrdersLink;My Replenishment Orders Link;/my-account/my-replenishments;MyReplenishmentOrdersLink;MyReplenishmentOrdersLink;;loggedInUser

UPDATE CMSLinkComponent;$contentCV[unique=true];uid[unique=true];linkName[lang=$lang]
;;MyReplenishmentOrdersLink;"Replenishment Orders"
```

## Configuring

No special configuration needed.

## Extending

No special extensibility available for this feature.

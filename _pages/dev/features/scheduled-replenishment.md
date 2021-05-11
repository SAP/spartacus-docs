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

The scheduled replenishment feature allows you to set up orders that are fulfilled automatically on a recurring basis. For example, you might choose to set up an order that is fulfilled on the 15th day of every month. Each time a scheduled replenishment order is placed, the order shows up in the order history.

**Note:** The scheduled replenishment feature is for B2B storefronts only.

For more information, see [Replenishment and Order Scheduling](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8c3aa31e86691014a3c085a0e9186e0c.html) on the SAP Help Portal.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Setting Up a Replenishment Order

Any order can become a replenishment order. On the last checkout step, in the **Order Summary** section, you have the option to auto replenish your order. If you choose to schedule a replenishment, you can select the schedule as follows:

- **Days:** You can specify how often your order is replenished by choosing the number of days until the order is fulfilled again, from 1 to 30.
- **Weeks:** You can specify how often your order is replenished by choosing the number of weeks until the order is fulfilled again, from 1 to 12. You can also specify on which day of the week the order will be replenished.
- **Months:** You can specify how often your order is replenished by choosing **Month**, and then choosing on which day of the month the order will be replenished.

There is also a **Start on** field that lets you specify the date for when the first order will be fulfilled.

Once you have scheduled your order, it will be fulfilled automatically starting from the date you have chosen, and will recur according to the schedule that you have set.

To view your scheduled orders, choose **Replenishment Orders** under the **My Account** menu. On the **Replenishment Orders** page, you can see a list of all of your scheduled replenishment orders. The following is an example:

![Replenishment Orders]({{ site.baseurl }}/assets/images/replenishment-orders-1.png)

When you select a replenishment, you open the **Replenishment Order Details** page, which provides all the details about the replenishment order, including what items are in the replenishment, and how often the replenishment has been fulfilled.

You can cancel your replenishment at any time, either from the **Replenishment Orders** page, or from the **Replenishment Order Details** page.

## CMS Components

If you are using the `spartacussampledata` extension to build your storefront, it includes all of the CMS data that is required for the scheduled replenishment feature, and it is enabled by default. If you are not using the `spartacussampledata` extension, you need to enable the feature before using it. For more information, see [Enabling Scheduled Replenishment](#enabling-scheduled-replenishment).

Scheduled replenishment is CMS-driven, so you can choose to not display the order replenishment option in the final step of checkout. You can also choose to not display replenishment orders on the **Replenishment Orders** page.

The procedures in the following sections describe how to enable and disable scheduled replenishment using ImpEx, but you can also enable and disable the feature using Backoffice.

**Note:** The `$contentCV` variable, which stores information about the content catalog, and which is used throughout the ImpEx in the following procedures, is defined as follows:

```text
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]
```

### Enabling Scheduled Replenishment

The following procedure describes how to enable the scheduled replenishment feature, which is necessary if you are not using the `spartacussampledata` extension to build your storefront.

1. With the following ImpEx, add the `cms component` and `content slot` to enable the replenishment feature in the final checkout step:

   ```text
   INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
   ;;SideContentSlot-checkoutReviewOrder;Checkout Place Order Slot;CheckoutOrderSummaryComponent,CheckoutScheduleReplenishmentOrderComponent,CheckoutPlaceOrderComponent

   INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
   ;;CheckoutScheduleReplenishmentOrderComponent;CheckoutScheduleReplenishmentOrderComponent;CheckoutScheduleReplenishmentOrder
   ```

2. With the following ImpEx, enable access to the `content page` for the replenishment details, replenishment history, and replenishment order confirmation page:

   ```text
   UPDATE ContentPage;$contentCV[unique=true];uid[unique=true];label;pageStatus(code,itemtype(code))
   ;;my-replenishment-details;/my-account/my-replenishment;active:CmsPageStatus
   ;;my-replenishment-orders;/my-account/my-replenishments;active:CmsPageStatus
   ;;replenishmentConfirmationPage;/replenishment/confirmation;active:CmsPageStatus
   ```

3. With the following ImpEx, create the `cms components` and `content slot` for the replenishment details page:

   ```text
   INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
   ;;ReplenishmentDetailItemsComponent;Replenishment Detail Items Component;ReplenishmentDetailItemsComponent
   ;;ReplenishmentDetailTotalsComponent;Replenishment Detail Totals Component;ReplenishmentDetailTotalsComponent
   ;;ReplenishmentDetailShippingComponent;Replenishment Detail Shipping Component;ReplenishmentDetailShippingComponent
   ;;ReplenishmentDetailActionsComponent;Replenishment Detail Actions Component;ReplenishmentDetailActionsComponent
   ;;ReplenishmentDetailOrderHistoryComponent;Replenishment Detail Order History Component;ReplenishmentDetailOrderHistoryComponent

   INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)
   ;;BodyContent-my-replenishment-details;ReplenishmentDetailShippingComponent,ReplenishmentDetailItemsComponent,ReplenishmentDetailTotalsComponent,ReplenishmentDetailActionsComponent,ReplenishmentDetailOrderHistoryComponent
   ```

4. With the following ImpEx, create the `cms components` and `content slot` for the replenishment history page:

   ```text
   INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
   ;;AccountReplenishmentHistoryComponent;Account Replenishment History Component;AccountReplenishmentHistoryComponent

   INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)
   ;;BodyContent-my-replenishment-orders;AccountReplenishmentHistoryComponent
   ```

5. With the following ImpEx, create the `cms components` and `content slot` for the replenishment order confirmation page:

   ```text
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

6. With the following ImpEx, create the `navigation node`, `navigation entry`, and `link` that routes to the replenishment orders.

   **Note:** The `$lang` variable is defined as any language code that is available to you.

   ```text
   INSERT_UPDATE CMSNavigationNode;uid[unique=true];$contentCV[unique=true];name;parent(uid, $contentCV);links(&linkRef);&nodeRef
   ;MyReplenishmentOrdersNavNode;;My Replenishment Orders;MyAccountNavNode;;MyReplenishmentOrdersNavNode

   INSERT_UPDATE CMSNavigationEntry;uid[unique=true];$contentCV[unique=true];name;navigationNode(&nodeRef);item(&linkRef);
   ;MyReplenishmentOrdersNavNodeEntry;;MyReplenishmentOrdersNavNodeEntry;MyReplenishmentOrdersNavNode;MyReplenishmentOrdersLink;

   INSERT_UPDATE CMSLinkComponent;$contentCV[unique=true];uid[unique=true];name;url;&linkRef;&componentRef;target(code)[default='sameWindow'];restrictions(uid,$contentCV)
   ;;MyReplenishmentOrdersLink;My Replenishment Orders Link;/my-account/my-replenishments;MyReplenishmentOrdersLink;MyReplenishmentOrdersLink;;loggedInUser

   UPDATE CMSLinkComponent;$contentCV[unique=true];uid[unique=true];linkName[lang=$lang]
   ;;MyReplenishmentOrdersLink;"Replenishment Orders"
   ```

### Disabling Scheduled Replenishment

You can disable the scheduled replenishment feature through the CMS, as described in the following procedure.

1. With the following ImpEx, remove the `cms component` of the replenishment feature from the final checkout step:

   ```text
   REMOVE CMSFlexComponent;uid[unique=true];$contentCV[unique=true]
   ;CheckoutScheduleReplenishmentOrderComponent;
   ```

2. With the following ImpEx, remove access to the `content page` for the replenishment details, replenishment history, and replenishment order confirmation page:

   ```text
   UPDATE ContentPage;$contentCV[unique=true];uid[unique=true];label;pageStatus(code,itemtype(code))
   ;;my-replenishment-details;/my-account/my-replenishment;deleted:CmsPageStatus
   ;;my-replenishment-orders;/my-account/my-replenishments;deleted:CmsPageStatus
   ;;replenishmentConfirmationPage;/replenishment/confirmation;deleted:CmsPageStatus
   ```

3. With the following ImpEx, remove the `navigation node`, `navigation entry`, and `link` that routes to the replenishment orders:

   ```text
   REMOVE CMSNavigationNode;uid[unique=true];$contentCV[unique=true]
   ;MyReplenishmentOrdersNavNode;

   REMOVE CMSNavigationEntry;uid[unique=true];$contentCV[unique=true];
   ;MyReplenishmentOrdersNavNodeEntry;

   REMOVE CMSLinkComponent;$contentCV[unique=true];uid[unique=true]
   ;;MyReplenishmentOrdersLink
   ```

## Configuring

No special configuration needed.

## Extending

No special extensibility available for this feature.

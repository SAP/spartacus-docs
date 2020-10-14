---
title: Cancellations and Returns
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

The Cancellations and Returns feature in Spartacus allows customers to request a complete or partial cancellation for an order that has been placed, or a return for an order that has already been received. This allows customers to bypass having to call a customer service agent to cancel or return an order that was placed.

For more information, see [Order Cancel Service ](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8c1f345e866910148d68e6ad0f19d930.html) and [Return Service](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8c446a3386691014817dd0941db58607.html) on the SAP Help Portal.

### Back-End Requirements

The Cancellations and Returns feature in Spartacus requires SAP Commerce Cloud version 2005.0 or newer. The minimum version of 2005.0 is required because earlier versions do not include the endpoints related to this feature.

You should also consider installing Order Management in the back end. For more information, see [Installing Order Management](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b44994b86691014b7b7e63c4bd30592.html) on the SAP Help Portal.

## Enabling Cancellations and Returns in Spartacus

The Cancellations and Returns feature is disabled by default in Spartacus.

Since the feature is CMS-driven, the only way to enable it is through the CMS. The following procedure describes the changes you should make to the `spartacussampledataaddon` AddOn, or to your own, custom AddOn.

**Note:** All of the required CMS data is already included in the `spartacussampledataaddon` AddOn.

### Enabling Cancellations and Returns through the CMS

1. Import the following ImpEx to make the `AccountOrderDetailsActionsComponent` visible:

    ```sql
    INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];visible
    ;;AccountOrderDetailsActionsComponent;true
    ```

    When this ImpEx is imported, the cancel or return action buttons are displayed on the Order Details page. The following is an example:

    ![Cancel Items Button]({{ site.baseurl }}/assets/images/cancel-items-button.png)
  
2. Add the **All Orders** and **Returns** tabs to the Order History page by importing the following ImpEx:

    ```sql
    UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)
    ;;BodyContent-orders;AccountOrderHistoryTabContainer
    ```

    By replacing the `AccountOrderHistoryComponent` with the `AccountOrderHistoryTabContainer` component in the `BodyContent-orders` slot, you can then see tabs in the Order History page, as follows:

    ![Order History Tabs]({{ site.baseurl }}/assets/images/order-history-tabs.png)

    These steps can also be done in Backoffice.

## Configuring

No special configuration is required.

## Extending

No special extensibility is available for this feature.

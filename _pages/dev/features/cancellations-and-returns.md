---
title: Cancellations and Returns (DRAFT)
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

This Cancellations and Returns feature allow customer to request a complete or partial cancellation/return using the storefronts. This allows the customer to bypass having to call a customer service agent to cancel/return an order that was placed.

## More Information

For more information on Order Cancel/Return Service, refer to the [Order Cancel Service on SAP Help Portal](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/8c1f345e866910148d68e6ad0f19d930.html) and [Return Service on SAP Help Portal](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/8c446a3386691014817dd0941db58607.html).

### Back End Requirements

Cancellations and Returns in Spartacus require SAP Commerce Cloud version 2005.0 or newer. The minimum version of 2005.0 is required to have the endpoints related to this feature.

Some OMS extensions can be included in backend, such as:

- warehousing
- warehousingbackoffice
- ordermanagementaddon

## Enabling Cancellations and Returns in Spartacus

The feature is disabled by default in Spartacus.

Since the feature is CMS driven, the only way to enable it is through the CMS. (All the required CMS data are already in the Spartacussampledataaddon.) To do so, the following changes should be made to the Spartacussampledataaddon or your custom addon:

1; Make AccountOrderDetailsActionsComponent visible

```typescript
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];visible
;;AccountOrderDetailsActionsComponent;true
```

It will make cancel/return action buttons displayed in order details page, for example:
![Screen Shot 2020-01-20 at 1 36 47 PM](https://user-images.githubusercontent.com/44440575/72750271-62f57300-3b8a-11ea-9ce5-4232071ac466.png)

2; Make the order history page contain tabs (All Orders and All Returns)

```typescript
UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)
;;BodyContent-orders;AccountOrderHistoryTabContainer
```

By replacing the `AccountOrderHistoryComponent` to `AccountOrderHistoryTabContainer` component in the `BodyContent-orders` slot, you will see tabs in Order History page:

![Screen Shot 2020-01-20 at 1 36 23 PM](https://user-images.githubusercontent.com/44440575/72750437-d4cdbc80-3b8a-11ea-8439-6f22239a7df0.png)

These steps can also be done in Backoffice.

## Configuring

No special configuration is required.

## Extending

No special extensibility is available for this feature.

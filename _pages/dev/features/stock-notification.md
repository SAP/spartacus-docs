---
title: Stock Notification (DRAFT)
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Intro

The stock notification feature allows customers to register product interests for receiving back-in-stock notifications, so that customers can buy interested products in time. 

## Requirements

The stock notification feature requires the following extensions to work:

-  stocknotificationservices Extension
-  customerinterestoccaddon AddOn
-  notificationoccaddon AddOn

For more information, see [Stock Notification Architecture](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/7afe618e1ff4437ea6a7a0c6e0c8f32b.html), [Customer Interests Architecture](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/f096456e586c44a29bd833a88536855a.html) and [Notification Architecture](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/b090364cfbe94c6da1b69af62f585d79.html) in the SAP Help Portal.

Note that this feature works only when the notification preference feature and the customer interests feature are already working.


## Enabling Stock Notification

The stock notification feature has corresponding CMS-component data in the back end that allows you to enable or disable the feature.
 

## Configuring

No special configuration needed.


## Extending

No special extensibility available for this feature.

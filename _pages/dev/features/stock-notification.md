---
title: Stock Notification
feature:
- name: Stock Notification
  spa_version: 1.4
  cx_version: 1905
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The stock notification feature gives customers the option to register product interests, which allows them to receive a notification when a registered product is back in stock.

## Requirements

Stock notification requires the following extensions:

- `stocknotificationservices` Extension
- `customerinterestoccaddon` AddOn
- `notificationoccaddon` AddOn

For more information, see [Stock Notification Architecture](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/7afe618e1ff4437ea6a7a0c6e0c8f32b.html), [Customer Interests Architecture](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/f096456e586c44a29bd833a88536855a.html) and [Notification Architecture](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/b090364cfbe94c6da1b69af62f585d79.html) on the SAP Help Portal.

**Note:** Stock notification only works when [{% assign linkedpage = site.pages | where: "name", "notification-preferences.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/notification-preferences.md %}) and [{% assign linkedpage = site.pages | where: "name", "customer-interests.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/customer-interests.md %}) are already enabled.

## Enabling Stock Notification

Stock notification has corresponding CMS-component data in the back end that allows you to enable or disable the feature. The configuration is provided in the `StockNotificationModule`.

## Configuring

No special configuration is needed.

## Extending

No special extensibility is available for this feature.

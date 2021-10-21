---
title: Notification Preferences
feature:
- name: Notification Preferences
  spa_version: 1.4
  cx_version: 1905
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The notification preferences feature allows customers to set their preferred channels for receiving notifications. You can access the **Notification Preference** page from the **My Account** menu.

## Requirements

The notification preferences feature requires the following extension:

- `notificationoccaddon` AddOn

For more information, see [Notification Architecture](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/b090364cfbe94c6da1b69af62f585d79.html) on the SAP Help Portal.

## Enabling Notification Preference

The notification preferences feature has corresponding CMS-component data in the back end that allows you to enable or disable the feature. The configuration is provided in the `NotificationPreferenceModule`.

## Configuring

No special configuration is needed.

## Extending

No special extensibility is available for this feature.

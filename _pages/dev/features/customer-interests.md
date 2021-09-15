---
title: Customer Interests
feature:
- name: Customer Interests
  spa_version: 1.4
  cx_version: 1905
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The customer interests feature allows customers to register an interest for a specific product and then receive notifications about the product, such as price-cut notifications, back-in-stock notifications, and so on. The feature also allows customers to manage their product interests on the **My Interests** page, which is accessed through the **My Account** menu, or by updating their interests directly on the relevant product details page.

## Requirements

The customer interests feature requires the following extensions:

- `customerinterestoccaddon` AddOn

For more information, see [Customer Interests Architecture](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/f096456e586c44a29bd833a88536855a.html) on the SAP Help Portal.

## Enabling Customer Interests

The customer interests feature has corresponding CMS-component data in the back end that allows you to enable or disable the feature. The configuration is provided in the `MyInterestsModule`.

## Configuring

No special configuration is needed.

## Extending

No special extensibility is available for this feature.

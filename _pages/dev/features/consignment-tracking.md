---
title: Consignment Tracking
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

Customers can view consignment tracking information to know the real-time status of their packages.

On the order details page, if the consignment shows its status as **Shipped**, a **Track Package** button is viewable for this consignment. Click the **Track Package** button to get the tracking information for the selected consignment.

## Requirements

The consignment tracking feature requires the `consignmenttrackingoccaddon` AddOn.

**Note:** You can use the `consignmenttrackingmock` extension to help with functional testing for consignment tracking. For more information, see [consignmenttrackingmock Extension](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/965bf5b729b646ac9a3f33cbebfd0a20.html) in the SAP Help Portal.

For more information in general about consignment tracking, see [Consignment Tracking Architecture](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/6eafde9f14e243d6a53e0bfbfd6996bc.html) in the SAP Help Portal.

## Enabling Consignment Tracking

Consignment tracking has a `consignmentTracking` feature flag that allows you to enable or disable the feature, as follows:

```typescript
features: {
   consignmentTracking: true
}
```

Consignment tracking is enabled automatically for feature level 1.2 and above.

For more information on feature flags and feature levels, see [Configuring Feature Flags]({{ site.baseurl }}{% link _pages/install/configuring-feature-flags.md %}).

## Configuring

No special configuration is required.

## Extending

No special extensibility is available for this feature.

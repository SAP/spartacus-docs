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

The consignment tracking feature requires the following extensions:

- consignmenttrackingoccaddon AddOn
- consignmenttrackingfacades  Extension
- consignmenttrackingservices Extension
- consignmenttrackingmock Extension
- consignmenttrackingbackoffice Extension

For more information, see [Consignment Tracking Architecture](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/6eafde9f14e243d6a53e0bfbfd6996bc.html) in the SAP Help Portal.

## Enabling Consignment Tracking

You can enable and disable consignment tracking with feature flags and feature levels. To enable the consignment tracking feature, set the feature flag
features as follows: 
```
features: {
   consignmentTracking: true
}
```
or feature level features: 
```
features: {
   level: ‘1.2’(>=1.2)
}
(This will enable all features configured <=1.2 in `app.module.ts`.)
```

## Configuring

No special configuration is required.

## Extending

No special extensibility is available for this feature.

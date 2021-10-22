---
title: Cart Validation
feature:
- name: Cart Validation
  spa_version: 4.2
  cx_version: 2011
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.3 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}


Cart validation feature provides functionality to validate users' cart and inform them about possible out-of-stock products or reduced quantities. In case of cart invalidity, user will be redirected to the cart page with a proper global message about issues found in the cart.


## Requirements

The Cart validation feature requires release **2011** of SAP Commerce Cloud.

## Enabling Cart validation

Cart validation is enabled by default since 4.2 release.

## Configuring

Cart validation functionality is hooked to every checkout step. You can turn off validation for each step separately by removing `CartValidationGuard` class from CMS components configurations in checkout steps modules.

## Extending

No special extensibility is available for this feature.


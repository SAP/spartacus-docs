---
title: Santorini Theme
feature:
- name: Santorini Theme
  spa_version: 4.0
  cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 4.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

When you enable the Santorini theme, the colors and font sizes of your storefront are changed.

The following is an example:

ADD SANTORINI SCREEN SHOT HERE

## Enabling the Santorini Theme

1. Go to backoffice -> wcms -> website -> open the site, then select Santorini theme.

1. In your `styles.scss` file, below the main Spartacus styles import, add the following:

    ```scss
    @import '~@spartacus/styles/scss/theme/santorini';
    ```

## Configuring

No special configuration is needed.

## Extending

No special extensibility is available for this feature.

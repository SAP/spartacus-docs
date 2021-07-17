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

<img src="{{ site.baseurl }}/assets/images/santorini-home-page.png" alt="Santorini Theme Spartacus Home Page" width="750" border="1px" />

## Enabling the Santorini Theme

1. Log in to Backoffice and click **WCMS -> Website**.

1. Select the Spartacus site that you want to apply the Santorini theme to.

1. In the **Properties** panel that appears, scroll down to **Base Configuration**, and in the **Theme** dropdown list, select **Santorini**.

1. Click **Save**.

1. In your `styles.scss` file, below the main Spartacus styles import, add the following:

    ```scss
    @import '~@spartacus/styles/scss/theme/santorini';
    ```

    You have now enabled the Santorini theme.

**Note**: If you are creating a new storefront, you can use the schematics `--theme=` flag to specify the theme you want to apply to your storefront. This automatically adds the styles import to your `styles.scss` file. The following is an example of the schematics command using the `--theme` flag:

```shell
ng add @spartacus/schematics --theme=santorini
```

## Configuring

No special configuration is needed.

## Extending

No special extensibility is available for this feature.

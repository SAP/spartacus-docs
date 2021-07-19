---
title: Storefront Themes
feature:
- name: Santorini Theme
  spa_version: 4.0
  cx_version: n/a
---

Spartacus includes two storefront themes, Sparta and Santorini. Each theme features distinct font sizes and colours. The Sparta theme features red colors and fonts, while the Santorini theme features blue colors and fonts. The Sparta theme is enabled by default, but you can dynamically switch to the Santorini theme at any time, as described in the procedure below.

The following is an example of a Spartacus product page with the Santorini theme enabled:

<img src="{{ site.baseurl }}/assets/images/santorini-product-page.png" alt="Santorini Theme Spartacus Home Page" width="750" border="1px" />

## Changing the Storefront Theme Dynamically

1. Log in to Backoffice and click **WCMS -> Website**.

1. Select the Spartacus site whose theme you are changing (for example, the Spartacus Electronics Site).

1. In the **Properties** panel that appears, scroll down to **Base Configuration**, and in the **Theme** dropdown list, select a new theme, such as **Santorini**.

1. Click **Save**.

1. If you are enabling the Santorini theme, in your `styles.scss` file, below the main Spartacus styles import, add the following import:

    ```scss
    @import '~@spartacus/styles/scss/theme/santorini';
    ```

    After you save the `styles.scss` file, the storefront refreshes with the new theme enabled.

**Note**: If you are creating a new storefront, you can use the schematics `--theme=` flag to specify the theme you want to apply to your storefront. This automatically adds the styles import to your `styles.scss` file. The following is an example of the schematics command for enabling the Santorini theme using the `--theme` flag:

```shell
ng add @spartacus/schematics --theme=santorini
```

If this flag is not set, the default Sparta theme is used.

## Configuring

No special configuration is needed.

## Extending

No special extensibility is available for this feature.

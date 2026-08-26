---
title: Storefront Themes
feature:
- name: Santorini Theme
  spa_version: 4.0
  cx_version: n/a
---

Spartacus includes three storefront themes: the Santorini theme, and the legacy Sparta and Lambda themes. As a result of changes to the underlying HTML in the 6.0 release, the Sparta and Lambda themes are no longer compatible with composable storefront. Also, the Sparta and Lambda storefront themes have been deprecated and will be removed in a future major release.

The Santorini theme is enabled by default, but you can dynamically switch to another theme at any time, as described below.

Applying a theme to the storefront involves two independent elements:

- A theme name, which is a string (such as `my-theme`) that the storefront resolves at runtime and applies as a CSS class on the application's root element.
- The related theme styles, which are the CSS properties (such as `--cx-color-primary`) that are scoped to a class matching the theme name.

These elements work together. To dynamically change a storefront theme, the target theme name must be defined, along with the styles that apply to that theme name.

## Prerequisites

In Spartacus version 221121.17, the `applyBaseSiteThemeFromCms` feature toggle has been introduced to improve how the storefront handles changing the storefront theme. To take advantage of this update, you must be using version 221121.17 or later of the Spartacus libraries, and have the `applyBaseSiteThemeFromCms` feature toggle enabled. If the toggle is not enabled, your app maintains the same behavior as Spartacus apps from version 221121.15 or earlier. For more information, see [Configuring How the Theme Name Reaches the Storefront](#configuring-how-the-theme-name-reaches-the-storefront), below.

## Providing the Theme Styles

To change the storefront's appearance, you must first define a CSS class that matches an existing theme name. This class is used to override the theme's existing CSS properties.

To do this, create a CSS file in your application (for example, `cms-themes.scss`) and import it in your `styles.scss` after the main Spartacus styles import. It is important that your `cms-themes.scss` comes after the main Spartacus styles import, so that your custom properties override the defaults. The following is an example:

```scss
// styles.scss
@import '@spartacus/styles';

// CMS-driven base-site theme rules (must come after Spartacus styles)
@import 'cms-themes';
```

The `cms-themes.scss` file defines the theme colors using custom CSS properties that are scoped to the theme class. The following is an example:

```scss
// cms-themes.scss
.santorini {
  --cx-color-primary: #055f9f;
  --cx-color-secondary: #556b82;
  // ... other color tokens
}
```

**Note:** The theme name is applied as a CSS class regardless of whether matching styles exist. If a theme name becomes active but no corresponding CSS class is defined, the class is present on the root element, but it overrides nothing, so the storefront falls back to the default theme values defined on `:root`. No error occurs - this simply looks like the default theme.

## Setting the Theme Name in Backoffice

1. Log in to Backoffice and click **WCMS -> Website**.

1. Select the Spartacus site whose theme you are changing (for example, the Spartacus Electronics Site).

1. In the **Properties** panel that appears, scroll down to **Base Configuration**, and in the **Theme** dropdown list, select a new theme, such as **My-Theme**.

1. Click **Save**.

Changing this value in Backoffice does not, on its own, change the storefront theme. Whether the value is picked up depends on the runtime configuration described in the next section.

## Configuring How the Theme Name Reaches the Storefront

Whether the storefront picks up the **Theme** value that you set in Backoffice depends on the `applyBaseSiteThemeFromCms` feature toggle. If you have installed a new storefront app that is version 221121.17 or later, the `applyBaseSiteThemeFromCms` feature toggle is enabled by default. If you have updated to Spartacus version 221121.17 or later, it is important to enable the `applyBaseSiteThemeFromCms` feature toggle. For more information, see [Activating Apply Base Site Theme From CMS](https://help.sap.com/docs/SAP_COMMERCE_COMPOSABLE_STOREFRONT/10a8bc7f635b4e3db6f6bb7880e58a7d/ef882ed019f544ceb26a1527ccb7c245.html?locale=en-US).

When the `applyBaseSiteThemeFromCms` feature toggle is enabled, the storefront's active theme follows the `theme` field of the active base site, reacting to base site changes at runtime, even when `context.baseSite` is statically configured - unless a static `context.theme` is set, which always wins.

The active theme is resolved with the following precedence:

1. A statically configured `context.theme`, which is provided with explicit developer intent, and is never overridden.
1. If the `context.theme` is not statically configured, a theme that the user picks through the Theme Switcher is preserved (from `siteTheme.optionalThemes`, such as high-contrast).
1. Otherwise, the `BaseSite.theme` value from the CMS is applied.

Once a theme name is resolved, the storefront's `ThemeService` applies it as a CSS class on the application's root element, reacting to changes without requiring a page reload.

If the `applyBaseSiteThemeFromCms` feature toggle is not enabled, or you are working with a storefront app that is version 221121.15 or earlier, the CMS `theme` field is only honored through the standard site-context resolution. In practice this means the following:

- If you set the theme statically in your Spartacus configuration (`context.theme`), that value is used.
- The `theme` field from the base site is resolved dynamically from the CMS **only** when `context.baseSite` is **not** statically configured (so that `SiteContextConfigInitializer` runs and fetches the base site).

In the common setup where `context.baseSite` is statically configured, the CMS **Theme** dropdown value is ignored, and only a statically configured `context.theme` (or a theme picked through the Theme Switcher) takes effect. Changing the Backoffice **Theme** dropdown has no visible effect in this case.

## Setting the Theme Statically in Your Spartacus Configuration

The `context.theme` config is a site-context parameter, and it is set in the same way as `context.language`, `context.currency`, and `context.baseSite`. You provide it through `provideConfig` (or a config module), typically alongside your other site-context settings. The following is an example:

```ts
// spartacus-features.module.ts (or wherever you provide the Spartacus config)
import { provideConfig, SiteContextConfig } from '@spartacus/core';

provideConfig(<SiteContextConfig>{
  context: {
    urlParameters: ['baseSite', 'language', 'currency'],
    baseSite: ['electronics-spa'],
    theme: ['my-theme'],
  },
});
```

The value is an array of strings, and the storefront uses the first element as the active theme name. In the example above, `my-theme` becomes the active theme.

**Note:** Statically defining `context.theme` requires you to also statically define `context.baseSite`. If `context.baseSite` is not set, the `SiteContextConfigInitializer` runs at startup, fetches the active base site from the CMS, and writes the base site's `theme` (along with its `baseSite`, `language`, and `currency` values) into `context`, which **overwrites** your static `context.theme`. Providing a static `context.baseSite` disables that initializer, so your static values are preserved.

**Note:** It is also highly recommended that you set `urlParameters` when you set `baseSite` statically. With the initializer disabled, the `urlParameters` value (normally supplied by the base site) is no longer populated automatically. Without it, the site-context parameters (such as `baseSite`, `language`, and `currency`) are dropped from the URL, which breaks routing. For example, a route such as `/electronics-spa/en/USD/` would no longer resolve. Setting `urlParameters: ['baseSite', 'language', 'currency']` restores the expected URL structure.

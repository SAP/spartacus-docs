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

Applying a theme involves two independent layers:

- **The theme name** — a string (for example, `santorini`) that the storefront resolves at runtime and applies as a CSS class on the application's root element. This is a purely runtime concern.
- **The theme styles** — the CSS custom properties (for example, `--cx-color-primary`) scoped to a class matching that name. This is a purely styling concern.

These layers are independent: setting a theme name does not create any styling, and defining styles does not activate them until a matching theme name becomes active. The sections below describe each layer.

### Setting the Theme Name in Backoffice

1. Log in to Backoffice and click **WCMS -> Website**.

1. Select the Spartacus site whose theme you are changing (for example, the Spartacus Electronics Site).

1. In the **Properties** panel that appears, scroll down to **Base Configuration**, and in the **Theme** dropdown list, select a new theme, such as **Santorini**.

1. Click **Save**.

Changing this value in Backoffice does not, on its own, change the storefront. Whether the value is picked up depends on the runtime configuration described in the next section.

### How the Theme Name Reaches the Storefront

Whether the storefront picks up the **Theme** value you set in Backoffice depends on the `applyBaseSiteThemeFromCms` feature toggle. It is `false` by default.

Once a theme name is resolved, the storefront's `ThemeService` applies it as a CSS class on the application's root element, reacting to changes without requiring a page reload.

#### Setting the Theme Statically in Your Spartacus Configuration

The `context.theme` config referenced throughout this page is a site-context parameter, set the same way as `context.language`, `context.currency`, and `context.baseSite`. You provide it through `provideConfig` (or a config module), typically alongside your other site-context settings:

```ts
// app.module.ts (or wherever you provide the Spartacus config)
import { provideConfig, SiteContextConfig } from '@spartacus/core';

provideConfig(<SiteContextConfig>{
  context: {
    urlParameters: ['baseSite', 'language', 'currency'],
    baseSite: ['electronics-spa'],
    theme: ['lambda'],
  },
});
```

The value is an array of strings; the storefront uses the **first** element as the active theme name. In the example above, `lambda` becomes the active theme.

**Important — statically defining `context.theme` requires statically defining `context.baseSite` as well.** If `context.baseSite` is *not* set, the `SiteContextConfigInitializer` runs at startup, fetches the active base site from the CMS, and writes the base site's `theme` (along with its `baseSite`, `language`, and `currency` values) into `context`, **overwriting** your static `context.theme`. Providing a static `context.baseSite` disables that initializer, so your static values are preserved.

**Also set `urlParameters` when you set `baseSite` statically.** With the initializer disabled, the `urlParameters` value (normally supplied by the base site) is no longer populated automatically. Without it, the site-context parameters (such as `baseSite`, `language`, and `currency`) are dropped from the URL, which breaks routing (for example, `/electronics-spa/en/USD/` no longer resolves). Setting `urlParameters: ['baseSite', 'language', 'currency']` restores the expected URL structure.

#### With `applyBaseSiteThemeFromCms: false` (default)

The CMS `theme` field is only honored through the standard site-context resolution. In practice this means:

- If you set the theme statically in your Spartacus configuration (`context.theme`), that value is used.
- The `theme` field from the base site is resolved dynamically from the CMS **only** when `context.baseSite` is *not* statically configured (so that `SiteContextConfigInitializer` runs and fetches the base site).

In the common setup where `context.baseSite` is statically configured, the CMS **Theme** dropdown value is ignored, and only a statically configured `context.theme` (or a theme picked through the Theme Switcher) takes effect. Changing the Backoffice dropdown has no visible effect in this case.

#### With `applyBaseSiteThemeFromCms: true`

The storefront's active theme follows the `theme` field of the active base site, reacting to base site changes at runtime — even when `context.baseSite` is statically configured (unless a static `context.theme` is set, which always wins; see the precedence below). Enable it in your feature toggles:

```ts
// app.module.ts (or wherever you provide the Spartacus config)
provideConfig({
  featureToggles: {
    applyBaseSiteThemeFromCms: true,
  },
});
```

The active theme is resolved with the following precedence:

1. A statically configured `context.theme` — explicit developer intent, never overridden.
1. A theme the user picks through the Theme Switcher (from `siteTheme.optionalThemes`, such as high-contrast) — preserved.
1. Otherwise, the `BaseSite.theme` value from the CMS is applied.

### Providing the Theme Styles

Resolving a theme name only adds a CSS class to the root element; it does not provide any styling. To actually change the storefront's appearance, define a CSS class matching the theme name that overrides the theme's CSS custom properties.

In your application, create a CSS file (for example, `cms-themes.scss`) and import it in your `styles.scss` **after** the main Spartacus styles import so that the custom properties override the defaults:

```scss
// styles.scss
@import '@spartacus/styles';

// CMS-driven base-site theme rules (must come after Spartacus styles)
@import 'cms-themes';
```

The `cms-themes.scss` file defines the theme colors using CSS custom properties scoped to the theme class:

```scss
// cms-themes.scss
.santorini {
  --cx-color-primary: #055f9f;
  --cx-color-secondary: #556b82;
  // ... other color tokens
}
```

**Note:** The theme name is applied as a CSS class regardless of whether matching styles exist. If a theme name becomes active but no corresponding CSS class is defined, the class is present on the root element but overrides nothing, so the storefront falls back to the default theme values defined on `:root`. No error occurs — this simply looks like the default theme.

## Configuring

No special configuration is needed.

## Extending

No special extensibility is available for this feature.

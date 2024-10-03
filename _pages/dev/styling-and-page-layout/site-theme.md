---
title: Site Theming and Site Theme Switcher
feature:
  - name: site Theme
    spa_version: 2211.29
    cx_version: 2211.29
---

Starting with Spartacus version 2211.29, a new theming mechanism and site theme switcher UI component have been added to enhance site theming flexibility. Previously, site themes could be configured either statically or through CMS using the `config.context.theme` property. It is now possible to define optional themes, which provides more customization options for site theming.

Spartacus now provides two high-contrast themes (High Contrast Light and High Contrast Dark), which improve accessibility for users with visual impairments. These themes dynamically alter global CSS properties to ensure seamless adaptation for UI components.

The theme switcher allows users to select and switch between themes in real-time, with the selected theme persisting across sessions through local storage. The following sections describe how to enable these features, configure them, and ensure custom components remain compatible with the theming system in Spartacus, including high-contrast modes.

Before Spartacus version 2211.29, the site theme could be configured with the `config.context.theme` object. This object could be statically defined in the configuration file, and could be populated from the CMS using the automatic site-context configuration feature. This allowed you to define a default theme for the entire site.

Starting with version 2211.29, a new configuration system allows you to define a list of optional themes using the `config.siteTheme.optionalThemes` property. The old `config.context.theme` object remains important because it defines the default theme, either through static configuration or CMS. If the `config.context.theme` is not set, the default theme will be an empty string ('').

The key configuration options are the following:

- The `config.context.theme` still controls the default theme. You can configure the default theme either through static configuration (using the `config.context.theme` object), or through CMS by using automatic site-context configuration.
- The `config.siteTheme.optionalThemes` config allows you to define a list of optional themes that users can select from the theme switcher UI.

## Site Theme Switcher UI Component

The site theme switcher is a dropdown UI component that allows users to select and apply different themes in real-time. The selected theme is saved to the user’s local storage, so user choices are persisted across page refreshes and future visits.

This improves the user experience by allowing instant visual feedback when switching themes, without requiring a full page reload.

## High Contrast Themes for Accessibility

To enhance accessibility, two optional high-contrast themes have been introduced:

- High Contrast Light
- High Contrast Dark

These themes modify global CSS variables, such as `--cx-color-background`, and automatically update the appearance of all components that rely on these variables.

### Custom Style Rules for High Contrast

For components that do not inherently use these variables, additional style rules enforce the use of global CSS variables when a high contrast theme is active. These rules apply based on CSS classes, such as `.cx-theme-high-contrast-dark` for dark mode.

The following is an example:

```scss
@include cx-highContrastTheme-dark {
  background-color: var(--cx-color-background);
}
```

To ensure your custom components work correctly with the high-contrast themes in Spartacus, keep the following guidelines in mind:

- **Use global CSS variables:** Custom components should use global CSS custom properties in Spartacus, such as `--cx-color-background`. This ensures automatic adjustments when a high-contrast theme is activated.
- **Use theme-specific styles:** If custom components need specific styles for high-contrast modes, use the provided Spartacus mixins.

The following is an example that targets both high-contrast themes:

```scss
@include cx-highContrastTheme {
  // Custom high-contrast styles
}
```

The following is an example that specifically targets the dark high-contrast theme:

```scss
@include cx-highContrastTheme-dark {
  // Custom dark high-contrast styles
}
```

And the following is an example that targets the light high-contrast theme:

```scss
@include cx-highContrastTheme-light {
  // Custom light high-contrast styles
}
```

## Enabling the Theme Switcher and Optional Themes

The following sections describe how to enable the theme switcher and optional themes.

1. Set the `useSiteThemeService` feature toggle to `true` in your configuration.

   For more information, see [Activating the Use Site Theme Service](link-to-activating-page-in-help-portal).
1. If it has not been included yet, add the `SiteThemeSwitcherComponent` CMS component to your site, either through Backoffice or by using ImpEx.

   For more information, see [Adding the Theme Switcher Component in Backoffice](#adding-the-theme-switcher-component-in-backoffice) or [Adding the Theme Switcher Component Through ImpEx](#adding-the-theme-switcher-component-through-impex).

### Adding the Theme Switcher Component in Backoffice

1. In Backoffice, navigate to **WCMS → Component**.
1. Add a new **CMS Flex Component** by entering a **Catalog Version**, such as `SPA Electronics Content Catalog: Online`, and enter an **ID**, such as `SiteThemeSwitcherComponent`.
1. Select the **Administration** tab and enter `SiteThemeSwitcherComponent` as the value for the **Flex Type**.
1. Select the **Content Slots** tab and then select **Content Slots → Site Context Slot** with the following ID: `SiteContextSlot, Catalog Version: SPA Electronics Content Catalog: Online`.

### Adding the Theme Switcher Component Through ImpEx

Use the following ImpEx to add the `SiteThemeSwitcherComponent` to your site. This example is for the electronics online catalog.

```text
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]
$siteResource=jar:de.hybris.platform.spartacussampledata.constants.SpartacussampledataConstants&/spartacussampledata/import/contentCatalogs/electronicsContentCatalog

INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef
;;SiteThemeSwitcherComponent;Site Theme Switcher Component;SiteThemeSwitcherComponent;SiteThemeSwitcherComponent

UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(uid,$contentCV)
;;SiteContextSlot;Site Context Slot;true;LanguageComponent,CurrencyComponent,SiteThemeSwitcherComponent
```

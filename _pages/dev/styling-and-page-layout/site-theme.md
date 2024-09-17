---
title: Site Theming and Site Theme Switcher Feature
feature:
  - name: site Theme
    spa_version: 2211.29
    cx_version: 2211.29
---

The new **theming mechanism** and **Site** **Theme Switcher** UI component have been added to Spartacus, enhancing site theming flexibility. Previously, site themes could be configured either statically or via CMS using the "config.context.theme" property. The update allows for defining **optional themes**, providing more customization options for site theming.

Additionally, this update introduces two new **high-contrast themes** (High Contrast Light and High Contrast Dark), improving accessibility for users with visual impairments. These themes dynamically alter global CSS properties to ensure a seamless adaptation of UI components.

The **Theme Switcher** enables users to select and switch between themes in real-time, with the selected theme persisting across sessions via local storage. This guide explains how to enable these features, configure them, and ensure custom components remain compatible with Spartacus’s theming system, including high-contrast modes.

## Previous Behavior: Configuring Site Themes

Previously, the site theme could be configured using the "config.context.theme" object in Spartacus, which could:

- Be **statically defined** in the configuration file.
- Be **populated from the CMS** using the feature of automatic site-context configuration.

This allowed for defining a default theme for the entire site.

## New Mechanism: Optional Themes

A new configuration system allows for defining a list of **optional themes** using the "_config.siteTheme.optionalThemes"_ property. The old "_config.context.theme"_ remains important as it defines the **Default theme**, either through static configuration or CMS. If the "_config.context.theme"_ is not set, the default theme will be an empty string ('').

### Key Points:

- The "config.context.theme" still controls the Default theme.
- The "config.siteTheme.optionalThemes" config enables defining a list of **alternative themes** that users can select from the Theme Switcher UI.

## Site Theme Switcher UI Component

The **Site** **Theme Switcher** is a new UI component, a dropdown that allows users to select and apply different themes in real-time. The selected theme is saved to the user’s **local storage**, meaning the choice persists across page refreshes and future visits.

This improves the user experience by allowing instant visual feedback when switching themes without requiring a full page reload.

## High Contrast Themes for Accessibility

To enhance accessibility, two **optional high-contrast themes** have been introduced:

- **High Contrast Light**
- **High Contrast Dark**

These themes modify global CSS variables like _--cx-color-background_, automatically updating the appearance of all components relying on these variables.

### Custom Style Rules for High Contrast:

For components that don’t inherently use these variables, additional style rules enforce the use of global CSS variables when a high contrast theme is active. These rules apply based on CSS classes such as .cx-theme-high-contrast-dark for dark mode.
Example:

```scss
@include cx-highContrastTheme-dark {
  background-color: var(--cx-color-background);
}
```

To ensure custom components work correctly with Spartacus’s high-contrast themes:

- **Use Global CSS Variables**: Custom components should use Spartacus’s global CSS custom properties (like --cx-color-background). This ensures automatic adjustments when a high-contrast theme is activated.
- **Use Theme-specific Styles**: If custom components need specific styles for high-contrast modes, use the provided Spartacus mixins.

For example:

To target **both** high-contrast themes:

```scss
@include cx-highContrastTheme {
  // Custom high-contrast styles
}
```

To target specific high-contrast themes:

For **High Contrast Dark**

```scss
@include cx-highContrastTheme-dark {
  // Custom dark high-contrast styles
}
```

For **High Contrast Light**:

```scss
@include cx-highContrastTheme-light {
  // Custom light high-contrast styles
}
```

## How to Enable the Theme Switcher and Optional Themes

To enable the **Theme Switcher** and optional themes, follow these steps:

1.  **Enable the feature toggle**: Set the useSiteThemeService toggle to true in your configuration.
2.  **Add the CMS component**: There are several ways to add the SiteThemeSwitcherComponent to your site if it hasn't been included yet. Here are two options:

### Option 1: Adding the Theme Switcher Component via Backoffice

1.  Go to the backoffice.
2.  Navigate to **WCMS** → **Component**.
3.  Add a new **CMS Flex Component**:
    - Enter **Catalog Version** (e.g., "SPA Electronics Content Catalog: Online").
    - Enter **ID**: SiteThemeSwitcherComponent.
4.  Once the component is created:
    - Go to the **Administration** tab and enter the value for **Flex Type** as SiteThemeSwitcherComponent.
    - Go to the **Content Slots** tab and select **Content Slots** → Site Context Slot (ID: SiteContextSlot, Catalog Version: SPA Electronics Content Catalog: Online).

### Option 2: Executing an Impex Script via Console

Alternatively, you can execute the following Impex script via the console to add the SiteThemeSwitcherComponent: example for electronics online catalog

```impex
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]
$siteResource=jar:de.hybris.platform.spartacussampledata.constants.SpartacussampledataConstants&/spartacussampledata/import/contentCatalogs/electronicsContentCatalog

INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef
;;SiteThemeSwitcherComponent;Site Theme Switcher Component;SiteThemeSwitcherComponent;SiteThemeSwitcherComponent

UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(uid,$contentCV)
;;SiteContextSlot;Site Context Slot;true;LanguageComponent,CurrencyComponent,SiteThemeSwitcherComponent
```

### Key Configuration Options:

- **Default Theme**: Configure the default theme either through static configuration (config.context.theme) or via CMS using the automatic site-context feature.
- **Optional Themes**: Define additional optional themes to display in the Theme Switcher using config.siteTheme.optionalThemes

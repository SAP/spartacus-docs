---
title: On Navigate Focus
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The `OnNavigateService` contains keyboard focus features that are triggered when a navigation event is triggered (ie. navigating to another page).

## Configuration

On-navigation focus features can be enabled by passing a `KeyboardFocusConfig` to the `KeyboardFocus Module`. Boolean or breakpoint values can be passed to the config flags to be enabled, enabled at specified breakpoints only or disabled.

Example:

```
export const exampleKeyboardFocusConfig: KeyboardFocusConfig = {
  keyboardFocus: {
    enableResetFocusOnNavigate: [BREAKPOINT.xs, BREAKPOINT.sm, BREAKPOINT.md],
    enableResetViewOnNavigate: true,
  },
};
```

By default, all on-navigation focus features are enabled.

### Reset Focus On Navigation

Resets focus back to root element `<cx-storefront>` in the DOM tree when a navigation is started. Without this enabled, the focus will not reset to the top element on a navigation change which can contribute to an unexpected user experience.

### Reset View On Navigation

Resets view back to root element `<cx-storefront>` in the DOM tree when a navigation is started.Without this enabled, the view will not reset to the top element on a navigation change which can contribute to an unexpected user experience.

## Extensibility

The on navigate focus logic is driven by the `OnNavigateFocusService`. This service can be customized.

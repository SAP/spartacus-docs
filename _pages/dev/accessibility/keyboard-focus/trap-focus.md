---
title: Trap Focus
---

{% capture version_note %}
{{ site.version_note_part1 }} 2.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The `cxFocus` directive provides functionality to trap the focus of a group of focusable elements. Trap focus (that is, focus-trap) is often required in dialogs, such as modals. As long as the dialog is open, the focus should not leave the dialog when the user keeps tabbing through the focusable elements. Typically, when the focus leaves the last element, the focus should move to the first element. And vice versa, when `SHIFT + TAB` is pressed, when the focus leaves the first element, the last element should be focused.

Trapping is driven by intercepting the keydown event for the `TAB`, `SHIFT + TAB`, arrow `UP`, and arrow `DOWN` keys.

## Configuration

The trap focus is configurable so that trapping works in both directions, or only for the start or the end of the group. The configuration is provided by the `TrapFocusConfig` typing and supports three modes.

### Trap in Both Directions

The default configuration traps the focus in both directions, at the start and at the end of the form. In the following form, the focus moves automatically to the first element if the user presses `TAB` (or `MOUSE DOWN`) on the last element. And vice versa, if the first element is focused, and the user presses `SHIFT + TAB` (or `ARROW UP`), the focus moves to the last element:

```html
<form [cx-focus]="{ trap: true }">
  <input name="first" />
  <input name="second" />
  <input name="last" />
</form>
```

### Trap End

When the trap configuration is set to `end`, the focus is only trapped at the end. This means that if the user presses `SHIFT + TAB` on the first element, the focus is not trapped in the form. The following is an example:

```html
<form [cx-focus]="{ trap: 'end' }">
  <input name="first" />
  <input name="second" />
  <input name="last" />
</form>
```

### Trap Start

When the trap configuration is set to `start`, the focus is only trapped at the start. This means that if the user presses `TAB` on the last element, the focus is not trapped in the form. The following is an example:

```html
<form [cx-focus]="{ trap: 'start' }">
  <input name="first" />
  <input name="second" />
  <input name="last" />
</form>
```

## Extensibility

The trap focus logic is driven by the `TrapFocusService`. This service can be customized.

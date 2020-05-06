---title: Auto Focus---

The `cxFocus` directive provides functionality to trap the focus of a group of focusable elements. Trap focus (AKA focus-trap) is often required in dialogs, such as modals. As long as the dialog is open, the focus should not leave the dialog when the user keeps tabbing through the focusable elements. Typically, when the focus leaves the last element, the focus should move to the first element. And visa versa, when `SHIFT + TAB` is used, when the first element is focused, the last element should be focused.

Trapping is driven by intercepting the keydown event for the `TAB`, `SHIFT + TAB`, arrow `UP` and `DOWN` keys. 

## Confguration
The trap focus is configurable so that trapping works both ways, or only for the start or end of the group. The configuration is provided by the `TrapFocusConfig` typing and supports three modes.

### Trap both ways
The default configuration traps the focus both ways, at the start and end of the form. In the following form, the focus will move automatically the first element if the user uses `TAB` (or `MOUSE DOWN`) on the last element. Visa versa, if the first element is focused, and the user uses `SHIFT + TAB` (or `ARROW UP`), the focus will move to the last element. 

```html
<form [cx-focus]="{ trap: true }">
  <input name="first" />
  <input name="second" />
  <input name="last" />
</form>
```

### Trap end

When the trap configuration is set to `end` the focus is only trapped at the end. It means that if the user uses `SHIFT + TAB` on the first element, the focus is not trapped in the form.

```html
<form [cx-focus]="{ trap: 'end' }">
  <input name="first" />
  <input name="second" />
  <input name="last" />
</form>
```

#### Trap start

When the trap configuration is set to `start` the focus is only trapped at the start. It means that if the user uses `TAB` on the last element, the focus is not trapped in the form.

```html
<form [cx-focus]="{ trap: 'start' }">
  <input name="first" />
  <input name="second" />
  <input name="last" />
</form>
```


### Extensibility
The trap focus logic is driven by the `TrapFocusService`. This service can be customised. 
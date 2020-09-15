---
title: Keyboard Focus
---

The `cxFocus` directive handles keyboard-specific features in Spartacus regarding Focus Management, which is crucial for keyboard-only users.

The keyboard features are used for a host element, and for the focusable elements of the inner DOM of the host element. Focusable elements are HTML elements that receive focus when you use the keyboard. For example, by tabbing through the experience, focusable elements are highlighted and provide access to key features, such as "open product", "add to cart", and so on.

There are many keyboard focus features. While most of these features work in isolation, there is often a correlation between them. This is why all features are handled by a single `cxFocus` directive. The directive ensures that the features do not conflict, and that they work well together.

The various features of the `cxFocus` directive are documented separately, as follows:

| Feature | Description |
| --- | --- |
| [Visible focus]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/visible-focus.md %}) | Limits the visible focus to keyboard users only. |
| [Persist focus]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/persist-focus.md %}) | Refocuses an element based on its last focus state. |
| [Escape focus]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/escape-focus.md %}) | Traps the focus of an element when the user presses the `ESC` key. |
| [Auto focus]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/auto-focus.md %}) | Provides auto focus in a single-page experience. |
| [Trap focus]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/trap-focus.md %}) | Traps the focus of a group of focusable elements, so that focus returns to the first element after leaving the last element. |
| [Lock focus]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/lock-focus.md %}) | Locks and unlocks the focus of the focusable child elements of the host element. |

All features have separate configuration typings, but all configurations are accessible through the `FocusConfig`.

The various features can be used with a single directive. The following is an example:

```html
<div
  [cxFocus]="{ 
    autofocus: 'input[submit:true]',
    lock: true,
    trap: true }"
></div>
```

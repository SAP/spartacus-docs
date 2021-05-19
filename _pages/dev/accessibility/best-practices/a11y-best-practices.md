---
title: Accessibility Best Practices
---

This is a landing page for grouping together topics about accessibility (a11y) best practices.

Starting with version 2.0, Spartacus features comply with the following success criteria of the [Web Content Accessibility Guidelines (WCAG) 2.1](https://www.w3.org/TR/WCAG21/):

- 2.1.1, Level A, Keyboard
- 2.1.2, Level A, No Keyboard Trap
- 2.4.1, Level A, Bypass Blocks
- 2.4.3, Level A, Focus Order
- 2.4.7, Level AA, Focus Visible
- 3.2.3, Level AA, Consistent Navigation

When combined all together, these criteria provide Spartacus with keyboard accessibility. To continue to comply with each of these criteria, it is recommended that you include the following features and best practices in your implementation when you are developing new features or fixing regressions:

- [Keyboard Accessibility]({{ site.baseurl }}{% link _pages/dev/accessibility/best-practices/keyboard-accessibility.md %})
- [Keyboard Focus]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/keyboard-focus.md %})

If you are a contributor to the Spartacus project, it is also important to ensure you run end-to-end tests for accessibility. For more information, see [Accessibility E2E Tests]({{ site.baseurl }}{% link _pages/contributing/a11y-e2e-tests.md %}).

## Common Keyboard Interactions

The following table lists many of the most common UI components, and the standard keystrokes for interacting with those components.

| Component | Keystrokes |
| --- | --- |
| Any focusable element | • <kbd>Tab</kbd> moves focus to the next focusable element<br>• <kbd>Shift</kbd> + <kbd>Tab</kbd> moves the focus to the previous focusable element (navigates backwards) |
| Link | <kbd>Enter</kbd> activates the link |
| Button | <kbd>Enter</kbd> or <kbd>Spacebar</kbd> activates the button |
| Radio buttons group | • <kbd>Tab</kbd> moves the focus to the first or selected radio button of a group, and throughout groups only<br>• <kbd>&#8593;</kbd> <kbd>&#8595;</kbd> or <kbd>&#8592;</kbd> <kbd>&#8594;</kbd> navigates and selects options within a group. |
| Select menu | • <kbd>Tab</kbd> moves the focus to the `<select>` field<br>• <kbd>Spacebar</kbd> expands<br>• <kbd>&#8593;</kbd> <kbd>&#8595;</kbd> navigates between the menu options |
| Autocomplete | • Type to display options<br>• <kbd>&#8593;</kbd> <kbd>&#8595;</kbd> navigates to an option<br>• <kbd>Enter</kbd> selects an option|
| Dialog | <kbd>Esc</kbd> closes the dialog |
| Slider | • <kbd>&#8593;</kbd> <kbd>&#8595;</kbd> or <kbd>&#8592;</kbd> <kbd>&#8594;</kbd> increases or decreases the slider value<br>• <kbd>Home</kbd> moves to the slider to the first value<br>• <kbd>End</kbd> moves the slider to the last value |
| Tab group | • <kbd>Tab</kbd> moves the focus into the group of tabs, and also moves the focus into the selected tab<br>• <kbd>&#8593;</kbd> <kbd>&#8595;</kbd> or <kbd>&#8592;</kbd> <kbd>&#8594;</kbd> navigates, selects, and activates the previous or next tab<br>• <kbd>Enter</kbd> or <kbd>Spacebar</kbd> activates the tab (this is optional when arrows are only used for navigation) |
| Tree menu | • <kbd>&#8593;</kbd> <kbd>&#8595;</kbd> navigates to the previous or next menu option<br>• <kbd>&#8592;</kbd> <kbd>&#8594;</kbd> expands or collapses the submenu, and moves up or down one level |
| Scroll | • <kbd>&#8593;</kbd> <kbd>&#8595;</kbd>  scrolls vertically<br>• <kbd>&#8592;</kbd> <kbd>&#8594;</kbd> scrolls horizontally<br>• <kbd>Spacebar</kbd> or <kbd>Shift</kbd> + <kbd>Spacebar</kbd> scrolls by page |

**Notes:**

- A focusable element is an element that receives *visible* focus, either natively or through configuration.
- Spartacus follows the [WAI-ARIA Authoring Practices 1.1](https://www.w3.org/TR/wai-aria-practices/#aria_ex). For more component examples, see the WAI-ARIA Authoring Practices documentation, and the "Keyboard Interactions" subsections for each component.

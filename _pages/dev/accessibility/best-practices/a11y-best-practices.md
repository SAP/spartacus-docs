---
title: Accessibility Best Practices
---

This is a landing page for grouping together topics about accessibility (a11y) best practices.

## Accessibility Compliance

Spartacus ensures accessibility by adhering to the success criteria of the [Web Content Accessibility Guidelines (WCAG) 2.1](https://www.w3.org/TR/WCAG21/) in the following categories:

- [Core Theme Accessibility]({{ site.baseurl }}{% link _pages/dev/accessibility/best-practices/a11y-compliance.md %}#core-theme-accessibility)
- [Keyboard Accessibility]({{ site.baseurl }}{% link _pages/dev/accessibility/best-practices/a11y-compliance.md %}#keyboard-accessibility)
- [Screen Reader Accessibility]({{ site.baseurl }}{% link _pages/dev/accessibility/best-practices/a11y-compliance.md %}#screen-reader-accessibility)
- [Media Accessibility]({{ site.baseurl }}{% link _pages/dev/accessibility/best-practices/a11y-compliance.md %}#media-accessibility)
- [Other Accessibility Conformance]({{ site.baseurl }}{% link _pages/dev/accessibility/best-practices/a11y-compliance.md %}#other-accessibility-conformance)

When you are developing new features or fixing regressions, it is recommended that you include the following features and best practices in your implementation to continue to comply with the relevant accessibility criteria:

- [{% assign linkedpage = site.pages | where: "name", "keyboard-accessibility.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/accessibility/best-practices/keyboard-accessibility.md %})
- [{% assign linkedpage = site.pages | where: "name", "keyboard-focus.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/keyboard-focus.md %})

If you are a contributor to the Spartacus project, it is also important to ensure you run end-to-end tests for accessibility. For more information, see [{% assign linkedpage = site.pages | where: "name", "a11y-e2e-tests.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/contributing/a11y-e2e-tests.md %}).

## Common Keyboard Interactions

The following table lists many of the most common UI components, and the standard keystrokes for interacting with those components.

| Component | Keystrokes |
| --- | --- |
| Any focusable element | • <kbd>Tab</kbd> moves focus to the next focusable element<br>• <kbd>Shift</kbd> + <kbd>Tab</kbd> moves the focus to the previous focusable element (navigates backwards) |
| Link | <kbd>Enter</kbd> activates the link |
| Button | <kbd>Enter</kbd> or <kbd>Spacebar</kbd> activates the button |
| Checkbox | <kbd>Spacebar</kbd> checks or unchecks a checkbox |
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

## Web Browser Setup for Keyboard Navigation

On macOS, both the Safari and Firefox web browsers do not have tabbing enabled by default. The following sections describe how to enable tabbing in these browsers.

### Enabling Tabbing in Firefox

The following steps describe how to enable tabbing for Firefox on macOS.

1. In Firefox, select **Preferences** in the **Firefox** menu, or select **Settings** in the **Open Application Menu** in the top right of the browser window, and in the **General** settings section, scroll down to **Browsing**.

1. Uncheck the **Always use the cursor keys to navigate within pages** checkbox.

1. In the Mac System Preferences, open the **Keyboard** preferences, and then select the **Shortcuts** tab.

1. In the bottom of the **Shortcuts** pane, check the **Use keyboard navigation to move focus between controls** checkbox.

### Enabling Tabbing in Safari

The following steps describe how to enable tabbing for Safari on macOS.

1. In Safari, select **Preferences** in the **Safari** menu, then select the **Advanced** tab.

1. In the **Accessibility** section, check the **Press Tab to highlight each item on a webpage** checkbox.

1. In the Mac System Preferences, open the **Keyboard** preferences, and then select the **Shortcuts** tab.

1. In the bottom of the **Shortcuts** pane, check the **Use keyboard navigation to move focus between controls** checkbox.

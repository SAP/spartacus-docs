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

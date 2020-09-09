---
title: Accessibility Best Practices
---

This is a landing page for grouping together topics about accessibility (a11y) best practices.

Up to version 2.0, Spartacus features comply with the 6 following [WCAG 2.1](https://www.w3.org/TR/WCAG21/) success criteria:

- 2.1.1, Level A, Keyboard
- 2.1.2, Level A, No Keyboard Trap
- 2.4.1, Level A, Bypass Blocks
- 2.4.3, Level A, Focus Order
- 2.4.7, Level AA, Focus Visible
- 3.2.3, Level AA, Consistent Navigation

Altogether they provide Spartacus with **Keyboard Accessibility**, and in order to preserve compliance for each criterion, the following technniques are recommended when developing new features and addressing regressions:

- [Keyboard Accessibility]({{ site.baseurl }}{% link _pages/dev/accessibility/best-practices/keyboard-accessibility.md %})
- [Keyboard Focus]({{ site.baseurl }}{% link _pages/dev/accessibility/best-practices/keyboard-focus.md %})
- [Accessibility E2E tests]({{ site.baseurl }}{% link _pages/dev/accessibility/best-practices/a11y-e2e-tests.md %})

More success criteria will be introduced in future versions and will be added to this page. The project aims for a [WCAG 2.1](https://www.w3.org/TR/WCAG21/) AA conformance level.

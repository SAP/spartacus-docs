---
title: Keyboard Focus
feature:
- name: Keyboard Focus
  spa_version: 2.0
  cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 2.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The `cxFocus` directive handles keyboard-specific features in Spartacus related to focus management. These features are essential for keyboard-only users.

The keyboard features are used for a host element, and for the focusable elements of the inner DOM of the host element. Focusable elements are HTML elements that receive focus when you use the keyboard. For example, by tabbing through the experience, focusable elements are highlighted and provide access to key features, such as "open product", "add to cart", and so on.

There are many keyboard focus features. While most of these features work in isolation, there is often a correlation between them. This is why all features are handled by a single `cxFocus` directive. The directive ensures that the features do not conflict, and that they work well together.

The various features of the `cxFocus` directive are documented separately, as follows:

| Feature | Description |
| --- | --- |
| [{% assign linkedpage = site.pages | where: "name", "visible-focus.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/visible-focus.md %}) | Limits the visible focus to keyboard users only. |
| [{% assign linkedpage = site.pages | where: "name", "persist-focus.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/persist-focus.md %}) | Refocuses an element based on its last focus state. |
| [{% assign linkedpage = site.pages | where: "name", "escape-focus.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/escape-focus.md %}) | Traps the focus of an element when the user presses the `ESC` key. |
| [{% assign linkedpage = site.pages | where: "name", "auto-focus.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/auto-focus.md %}) | Provides auto focus in a single-page experience. |
| [{% assign linkedpage = site.pages | where: "name", "trap-focus.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/trap-focus.md %}) | Traps the focus of a group of focusable elements, so that focus returns to the first element after leaving the last element. |
| [{% assign linkedpage = site.pages | where: "name", "lock-focus.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/lock-focus.md %}) | Locks and unlocks the focus of the focusable child elements of the host element. |
| [{% assign linkedpage = site.pages | where: "name", "on-navigate-focus.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/on-navigate-focus.md %}) | ... |

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

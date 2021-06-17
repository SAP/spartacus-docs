---
title: Lock Focus
---

{% capture version_note %}
{{ site.version_note_part1 }} 2.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The `cxFocus` directive provides locking of the focusable elements of a host element. The focusable elements receive a `tabindex` of `-1`, so that the default tabbing in the browser is temporarily disabled.

The locked focus is used for groups of elements that should be skipped by keyboard users. A good example is a child navigation panel, or the facet navigation on the product listing page. Keyboard users can skip larger groups of focusable elements, until they unlock the group by pressing the `ENTER` or `SPACE` key.

Locked elements leverage the auto focus feature, unless the auto focus configuration is explicitly set to false. This results in the first focusable element being selected when the group is unlocked. For more information, see [{% assign linkedpage = site.pages | where: "name", "auto-focus.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/auto-focus.md %}).

An unlocked group can be locked again by pressing the `ESC` key. The locked focus feature uses the escape focus feature, so that the host element is focused again when pressing `ESC`. For more information, see [{% assign linkedpage = site.pages | where: "name", "escape-focus.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/escape-focus.md %}).

---
title: Lock Focus
---

The `cxFocus` directive provides locking of focusable elements of a host element. The focusable elements will receive a `tabindex` of `-1`, so that the default tabbing in the browser is temporarily disabled.

The locked focus is used for groups of elements that should be skipped by keyboard users. A good example is a child navigation panel or the facet navigation on the product listing page. Keyboard users can skip larger groups of focusable elements, until they _unlock_ the group, by using the `ENTER` or `SPACE` key. 

Locked elements will be leveraged the [Auto focus feature]({{ site.baseurl }}{% link _pages/dev/accessibility/auto-focus.md %}), unless the autofocus configuration is explicitely set to false. This results in an effect that the first focusable element is selected when the group is unlocked. 

An unlocked group can be locked again by using the `ESC` key. The locked focus feature will use the [Escape focus]({{ site.baseurl }}{% link _pages/dev/accessibility/escape-focus.md %}) feature, so that the host element is focused again when pressing escape. 


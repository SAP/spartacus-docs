---
title: Keyboard Accessibility
feature:
- name: Keyboard Accessibility
  spa_version: 2.0
  cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 2.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

You can make your storefront website keyboard accessible by following correct HTML semantics and general "best practices" in your code. Good keyboard accessibility means that a user can navigate your website with a keyboard, from top to bottom (and back), from the first interactable element to the last. You can achieve this by implementing consistent navigation, a correct tabbing order, a visual focus indicator that is easily seen, and by avoiding focus traps.

For more information on how HTML semantics can affect accessibility, see [Semantics in HTML](https://developer.mozilla.org/en-US/docs/Glossary/Semantics#Semantics_in_HTML).

## HTML Attributes and Events

To successfully implement keyboard accessibility, you need to use HTML attributes with the correct HTML elements. Also, when implementing an event, such as a click or a keydown, if you try to force a "wrong" element to act like an interactable element, it can lead to problems with your site's keyboard accessibility.

The following are examples of HTML attributes with correct HTML elements:

- `<input disabled />`,
- `<button tabindex="0">`,
- `<button (click)="foo($event)"></button>`

The following are examples of HTML attributes and elements that should be avoided:

- `<div tabindex="0"></div>`,
- `<p (click)="foo($event)"></p>`
- `<li role="checkbox" (keyup)="bar($event)"></li>`

## Focus Management

Proper focus management is essential to providing an uninterrupted and consistent keyboard flow. For more information, see [{% assign linkedpage = site.pages | where: "name", "keyboard-focus.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/keyboard-focus.md %}).

## CSS Styles

There is not a lot in CSS that can break accessibility. However, you should be careful about the following CSS properties:

- **order:** The `order` property changes the visual order of elements, even though the DOM order stays the same. The DOM order is used in keyboarding, so if you change the order using the `order` property, the tabbing order that is seen by the user will not correct.
- **display/opacity:** If an element has a `display: none` property, it is excluded from tabbing. However, elements with an `opacity: 0` property can still be accessed with the keyboard. There are other properties that do not exclude elements from being accessible. For more information, see [Writing CSS with Accessibility in Mind](https://medium.com/@matuzo/writing-css-with-accessibility-in-mind-8514a0007939#81ec).
- **outline:** If you change the `outline` property, it may break accessibility in Spartacus, because the default visual focus indicator in Spartacus depends on the `outline` property. Accordingly, it is important to avoid setting the `outline` property to a value such as `0` or `none`.

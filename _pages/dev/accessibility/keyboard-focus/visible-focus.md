---
title: Visible Focus
---

{% capture version_note %}
{{ site.version_note_part1 }} 2.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

One of the main requirements for accessibility is a clear visual indication of focused elements in the UI. A clear focus indication helps sighted keyboard users with orientation in the storefront.

In Spartacus, focusable elements are styled with a blue outline. This appearance can be further customized in the CSS layer if you prefer to have an alternative effect for certain elements.

## Avoiding Visible Focus

Visible focus might be considered best practice for users who have limited vision, but it is typically not the experience that "mouse users" would expect. When the mouse is used to navigate through the experience, having such a dominant focus effect could be considered awkward, and does not contribute to a nice UI for those who have good vision.

That being said, if the "mouse user" temporarily switches to the keyboard, the visible focus then actually contributes to the experience in a positive way.

The Web industry seems to agree that a strong visible focus should be reserved for users who have limited vision. A keyboard-only focus style feature has been proposed, using the CSS `:focus-visible` pseudo selector, next to the `:focus` selector. The intent is that you can style elements when the focus is driven by the keyboard, rather than the mouse. So far, the `:focus-visible` pseudo selector is only implemented in Firefox. For more information, see [The Focus-Indicated Pseudo-class: ':focus-visible'](https://drafts.csswg.org/selectors-4/#the-focus-visible-pseudo).

Given that `:focus-visible` is not supported by all ever-green browsers, Spartacus provides an implementation to accomplish the same effect. If the user is using the mouse, the visible focus is hidden. If the user switches (temporarily) to the keyboard, the visible focus is enabled.

## Implementation

The appearance of the focus outline is driven by CSS. The usage of this style depends on the occurrence of the `mouse-focus` class. Without this class, the visual focus is not added to focused elements.

The `mouse-focus` class is part of the `cxFocus` directive, and is added by applying the directive to the three root elements in the `cx-storefront` component, as follows:

```html
<header [cxFocus]="{ disableMouseFocus: true }">
  [...]
</header>

<main [cxFocus]="{ disableMouseFocus: true }">
  [...]
</main>

<footer [cxFocus]="{ disableMouseFocus: true }">
  [...]
</footer>
```

If you are not using the `cx-storefront` component, and you still want to leverage this behavior, you can use the `cxFocus` directive in your custom HTML.

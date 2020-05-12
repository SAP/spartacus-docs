---
title: Visible Focus
---

One of the main requirements for accessibility is a clear visual indication of _focused_ elements in the UI. The clear focus indication helps sighted keyboard users with orientation on the storefront. 

In Spartacus, focusable elements are styled with a blue outline. This appearance can be further customised in the CSS layer if you like to have an alternative effect for certain elements. 

## Avoid visible focus

While the visible focus might be best practices for users who have limited vision, it is surely not the experience that "mouse-users" would expect. When the mouse is used to navigate through the experience, having such a dominant focus effect would be considered awkward and doesn't contribute to a nice UI for those who have good vision.

That being said, if the "mouse user" would temporarily swich to the keyboard, the visible focus would actually contribute to the experience in a positive way. 

The web industry seem to agree that the strong visible focus should be reserved for users who have limited vision. A keyboard-only [focus style feature](https://drafts.csswg.org/selectors-4/#the-focus-visible-pseudo) has been proposed, using the CSS `:focus-visible` pseudo selector, next to the `:focus` selector. The intent is that you can style elements when the focus was driven by the keyboard rather than the mouse. So far, the `:focus-visible` pseudo selector is only implemented in Firefox. 

Given that the `:focus-visible` is not supported by all ever-green browsers, Spartacus provides an implementation to accomplish the same effect. If the user is using the mouse, the visible focus will be hidden. If the user switches (temporarily) to the keyboard, the visible focus is on. 

### Implementation
The appearance of the _focus outline_ is driven by CSS. The usage of this style is depending on the occurance of the `mouse-focus` class. Without this class, the visual focus is not added to focused elements. 

The `mouse-focus` class is part of the `cxFocus` directive and is added by applying the directive to the three root elements in the `cx-storefront` component:
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

In case you're not using the `cx-storefront` component, and you still want to leverage this behaviour, you can use `cxFocus` directive in your custom html. 

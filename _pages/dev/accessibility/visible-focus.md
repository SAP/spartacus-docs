---
title: Visible Focus
---

One of the main requirements for accessibility is to come up with a clear visual indication of _focused_ element in the UI. In Spartacus, focusale elements are styled with a blue outline. This appearance can be further customised in the CSS layer if you like to have an alternative effect for a certain element.

While the visible focus might be best practices for users who have limited vision, it is surely not the experience that "mouse-users" would expect. When the mouse is used to navigate through the experience, having such a dominant focus outline would be considered awkward and doens't necessarly contribute to a nice UI for those who have good vision. That being said, if the "mouse user" would temporarily swich to the keyboard, the visible focus would contribute to the expereince in a positive way. 

The web industry seem to agree that the strong visible focus should be reserved for users who have limited vision. A keyboard-only focus style feature has been proposed, using the CSS `:focus-visible` pseudo selector, next to the `:focus` selector. The intent is that you can style elements when the focus was driven by the keyboard rather than the mouse. 

So far, the `:focus-visible` pseudo selector has only been implemented by Firefox. This is why Spartacus provides a implementation to accomplish the same effect. If users is using the mouse, the visible focus will be hidden. 

## Implementation

The appearance of the _focus outline_ is driven by CSS. The usage of this style is depending on the occurance of the `mouse-focus` class. Without this class, the visual focus is not added to focused elements. 

The `mouse-focus` class is part of the `cxFocus` directive and is added by applying the directive to the three root elements in the `cx-storefront` component:

```html
<header [cxFocus]="{ disableMouseFocus: true }">[...]
</header>

<main [cxFocus]="{ disableMouseFocus: true }">
  [...]
</main>

<footer [cxFocus]="{ disableMouseFocus: true }">
  [...]
</footer>
```

In case you're not using the `cx-storefront` component, and you still want to leverage this behaviour, you could add the `[cxFocus]="{ disableMouseFocus: true }"` to any of the root elements to benefit form this behaviour. 
---
title: Escape focus
---

The `cxFocus` directive provides a feature to focus the host element when the `ESC` key is captured. This is useful for dialogs as well as larger parts of the UI that should _trap_ the focus. 

When the `ESC` key is captured while the element is already focused, the event is let go, and will _bubble_ up to the anchestor tree (this is how browsers treat certain UI events). 

Spartacus uses the escape focus for the so-called "skip links", dialogs (i.e. modal) and element groups that must be unlocked initially (i.e. a facet).

Whenever the escape focus is handled, an output (`esc`) is emitted, so that additional logic can be applied if needed. 

### Configuration
The escape focus will only happen if it's configured: 
```html
<div [cxFocus]="{ focusOnEscape: true }"></div>
```

The `focusOnDoubleEscape` property can be used to force an autofocus in case of a re-occuring escape key. 

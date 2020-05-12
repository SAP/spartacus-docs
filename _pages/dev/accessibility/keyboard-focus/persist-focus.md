---
title: Persist Focus
---

The `cxFocus` directive provides persistence of the focused state. This is useful when a group of focusable elements got refocused or even recreated. That happens often when the DOM is constructed with an `*ngIf` or `*ngFor`. Whenever the data is changed, the focus is naturally lost. To overcome this issue, the persisted focus is introduced. 

The focus state is based on a configured _key_. The key is used to store the focus state. The focus state can be part of an optional focus _group_, so that the state is shared and remember for the given group. 

To detect the persistence for a given element, the persistence key is stored in a data attribute (`data-cx-focus`) on the element:

```html
  <button data-cx-focus="myKey"></button>
```

Other keyboard focus directives can read and query this key to understand whether the element should retrieve focus.

The peristed focus is used when an element is created, and explicitely usd by the autofocus feature. 

### Extensibility
The persisted focus logic is driven by the `PersistFocusService`. This service can be customised. 

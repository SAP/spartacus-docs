---
title: Auto Focus
---

The `cxFocus` directive provides Auto Focus capabilities for a single page experience. The default htmnl5 `autofocus` attribute falls short in a Single Page Application experience, since this attribute is only applied when a page is loaded. In a Single Page Application this behavior is not replicated automatically. Moreover, there are more scenario's where you'd like to focus an element, for example when a dialog is opened or a group of element is "unlocked".

The auto focus feauture of the `cxFocus` directive focus an element when the host element is focused. The element of choice that will be focused is driven by configuration. Moreover, the previous focused element can be persistd, so that it will be re-focused during the user session. 


## Default behaviour
The default configuration (`autofocus: true`) select the first focusable element of the inner DOM of the host element. In the below example, this is the close button. 

```html
<div [cx-focus]="{ autofocus: true }">
    <button class="close"></button>
    <input  class="value" />
</div>
```

There are however two exeptions to the default behaviour: 

### Perist focus
If an element has been focused before, and a focus _key_ is available, the element is _re-focused_. The focusable element with a focus key is peristed and will be re-focused when the host element is selected. 

```html
<div [cx-focus]="{ autofocus: true }">
    <button class="close"></button>
    <input  class="value" cxFocus="key-1" />
    <input  class="value" [cxFocus]="{ key: key-1 }" />
</div>
```
A configurable group of persisted focusable elements can be used to distinquish the focus for certains part of the UI. This allows you to maintain the focus for a dialog. 

```html
<div [cx-focus]="{ autofocus: true, group: 'address-book-dialog' }">
    <button class="close"></button>
    <input  class="value" cxFocus="key-1" />
    <input  class="value" [cxFocus]="{ key: key-1 }" />
</div>
```

### Native `autofocus` attribute
If the inner DOM contains an element with the html5 `autofocus` attribute, this element is focused by default:

```html
<div [cx-focus]="{ autofocus: true }">
    <button class="close"></button>
    <input  class="value" autofocus />
</div>
```

## Autofocus by CSS selector
The configuration also allows for a CSS selector, so that the focusable element is selected from the child elements. In the following example, this is will be the close button. 

```html
<div [cx-focus]="{ autofocus: 'input.firstname' }">
    <button class="close"></button>
    <input  class="firstname" />
    <input  class="lasttname" />
</div>
```

Similar to the css selector on the autofocus element, the `:host` selector will not select any of the focusable child elements, but instead focus the host itself. 


> skipFocus ???


### Extensibility
The auto is driven by configuration, the logic is mainly implemented in the `AutoFocusService`. You can further customise this service.
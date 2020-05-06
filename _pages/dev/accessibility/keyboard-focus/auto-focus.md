---title: Auto Focus---

The `cxFocus` directive provides Auto Focus capabilities for a _single page_ experience. The native htmnl5 `autofocus` attribute falls short in a Single Page Application experience, since this attribute is only applied when a page is loaded in the browser. In a Single Page Application pages are dynamically being build, and elements with an autofocus attribute are not focused automatically. Moreover, there are scenario's where the focus of an element should be driven dyncamilly. For example when a dialog is opened or a group of element is "unlocked".

The auto focus feauture of the `cxFocus` directive focus an element when the host element is focused. The element of choice that will be focused is driven by configuration. Moreover, the previous focused element can be persisted, so that it will be re-focused during the user session. 


## Default behaviour
The default configuration (`autofocus: true`) select the first _focusable element_ of the inner DOM of the host element. Focusable elements are elements that get a focus when you tab through the DOM. The focus is primairly driven by the semantic nature of the element, but can also be forced by using the `tabindex` attribute. In the below example, the first focusable element is the close button. 

```html
<div [cx-focus]="{ autofocus: true }"> 
  <button class="close"></button>
  <input class="value" />
</div>
```

There are three exeptions to the default behaviour:
- persisted focus
- focus by native html5 `autofocus` attribute
- selected focus 

### Autofocus by peristed key

If an element has been focused before, and a focus _key_ is available, the element is _re-focused_. The focusable element with a focus key is peristed and will be re-focused when the host element is selected. 

```html
<div [cx-focus]="{ autofocus: true }">
  <button class="close"></button>
  <input class="value" cxFocus="key-1" />
  <input class="value" [cxFocus]="{ key: key-1 }" />
</div>
```

A configurable group of persisted focusable elements can be used to distinquish the focus for certains part of the UI. This allows you to maintain the focus for a dialog. 

```html
<div [cx-focus]="{ autofocus: true, group: 'address-book-dialog' }">
  <button class="close"></button>
  <input class="value" cxFocus="key-1" />
  <input class="value" [cxFocus]="{ key: key-1 }" />
</div>
```

### Autofocus by html5 `autofocus` attribute
If the inner DOM contains an element with the html5 `autofocus` attribute, this element is focused by default:

```html
<div [cx-focus]="{ autofocus: true }">
  <button class="close"></button>
  <input class="value" autofocus />
</div>
```

### Autofocus by CSS selector
The autofocus configuration also allows for specific CSS selector, so that the focusable element is precisely selected from the inner DOM of the host element. In the following example, the first name input is selected. 

```html
<div [cx-focus]="{ autofocus: '.section input.firstname' }">
  <button class="close"></button>
  <div class="section">
    <input class="firstname" />
    <input class="lasttname" />
  </div>
</div>
```

A special case is made for the host element itself, using the `:host` selector. This selector will not select from the inner DOM, but will instead select and focus the host itself. 

> skipFocus ???

### Extensibility
The auto is driven by configuration, the logic is mainly implemented in the `AutoFocusService`. You can further customise this service.
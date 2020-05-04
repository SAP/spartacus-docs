# `cxFocus` Directive 

The `cxFocus` directive is added in Spartacus to provide accessibility features for _focusable_ elements. Focusable elements are html elements that receive a focus when you use the keyboard. I.e. by tabbing through the experience, focusable elements will be highlighted and provide access to key features, such as "open product", "add to cart", etc. 

The base functionality around focusable elements is driven by the `tabindex` attribute, and handled by the browser. There are more advanced requirements that require custom implementations, such as (un)locking a group of focusable elments, trapping the focus in a dialog, autofocus a certain element, etc. The `cxFocus` direcitve supports all these features and provides a configuration to control this conveniently. 

The different features of the cxFocus are listed below: 

| Feature | Description | Configuration  |
|---|---|---|---|---|
| Autofocus | Provides auto focus of any of the nested focusable elements.   | `AutoFocusConfig` | 
| Persist |  Re-focus an element based on it's last focus state. |  `PersistFocusConfig`  | 
| Trap Focus |  Traps the focus of the first of last element when the user tabs through them  | `TrapFocusConfig`  | 
| Escape focus | Traps the focus of an element when the user hits escape.  | `EscapeFocusConfig` |

While all features have separate configuration typings, the configurations are accesible through the `FocusConfig`. 

## Auto Focus
The `AutoFocus` configuration allows for selecting a focusable element when the host element get's focused. This can be useful in case of opening a dialog (i.e. a modal), or if a group of elements get _unlocked_. 

Spartacus introduced auto focus for the facet configuration and various dialogs (i.e. modals). 

### Persist Focus
The focus of an element can be persisted. This means that whenever a group of elements is re-focused, the autofocus last focused element will 


The autofocus configuration allows to apply the focus in different scenario's. The following configuration list the various options: 

### Configuration

The auto focus behaviour is configurable by the `AutoFocusConfig`. The configuration includes: 
- auto focus by the first focusable element of the child elements
- specific focus by CSS selector


> skipFocus ???

#### `{ autofocus: true }`
The default configuration (autofocus: true) will select the first focusable element of the DOM. In the below  example, this is will be the close button. 

```html
<div [cx-focus]="{ autofocus: true }">
    <button class="close"></button>
    <input  class="value" />
</div>
```

There are however 2 excpetions to the autofocus: 
- select last focused element; This is driven by the persisted focus
- select first focusable element with an html5 `autofocus` attribute

#### `{autofocus: '.selector' }`
The configuration also allows for a CSS selector, so that the focusable element is selected from the child elements. In the following example, this is will be the close button. 

```html
<div [cx-focus]="{ autofocus: 'input.firstname' }">
    <button class="close"></button>
    <input  class="firstname" />
    <input  class="lasttname" />
</div>
```

Similar to the css selector on the autofocus element, the `:host` selector will not select any of the focusable child elements, but instead focus the host itself. 

### Extensibility
The auto focus logic is driven by the `AutoFocusService`. 

## Trap Focus

_Trapping focus_ is a behaviour that is required in dialogs, such as modals. As long as the dialog is open, the focus should not leave the dialog when the user keeps tabbing through the focusable elements. 

Trapping is driven by intercepting the keydown event for the (shift)tab key and arrow up/down keys. The trap focus is configurable so that trapping works both ways, or only for the start or end of the form. 

### Configuration

The auto focus behaviour is configurable by the `TrapFocusConfig`.

#### `{ trap: true }`
The default configuration traps the focus both ways, at the start and end of the form. In the following form, the focus will move automatically the first element if the user uses `TAB` (or `MOUSE DOWN`) on the last element. Visa versa, if the first element is focused, and the user uses `SHIFT + TAB` (or `ARROW UP`), the focus will move to the last element. 

```html
<form [cx-focus]="{ trap: true }">
    <input name="first" />
    <input name="second" />
    <input name="last" />
</form>
```

#### `{ trap: 'start' }`
When the trap configuration is set to `start` the focus is only trapped at the start. It means that if the user uses `TAB` on the last element, the focus is not trapped in the form.

```html
<form [cx-focus]="{ trap: 'start' }">
    <input name="first" />
    <input name="second" />
    <input name="last" />
</form>
```


#### `{ trap: 'end' }`
When the trap configuration is set to `end` the focus is only trapped at the end. It means that if the user uses `SHIFT + TAB` on the first element, the focus is not trapped in the form.

```html
<form [cx-focus]="{ trap: 'end' }">
    <input name="first" />
    <input name="second" />
    <input name="last" />
</form>
```

### Extensibility

The trap focus logic is driven by the `TrapFocusService`



## Escape focus
The Escape focus will focus an element when the `ESC` key is captured on the host element. This is useful for dialogs as well as larger parts of the UI that should _trap_ the focus. When the `ESC` key is captured while the element is already focused, the event is let go, and will _bubble_ up to the anchestor (this is how browsers treat certain UI events). 

Spartacus uses the escape focus for the so-called "skip links" as well as for dialogs as well as for element groups that must be unlocked (i.e. a facet).

The Escape focus is also emitted to the  `esc` output, so that additional logic can be applied if needed. 

### Configuration
The escape focus will only happen if it's configured: 

```html
<div [cxFocus]="{ focusOnEscape: true }"></div>
```

The `focusOnDoubleEscape` property can be used to force an autofocus in case of a reoccuring escape key. 
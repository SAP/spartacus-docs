---title: Keyboard Focus---

The `cxFocus` directive is added in Spartacus to handle keyboard specific features in Spartacus. These features are mainly put in place for sigthed users,but are actually valueable for any keyboard users. 

The keyboard features are used for a host element and the focusable elements of the inner DOM of the host element. Focusable elements are html elements that receive focus when you use the keyboard. I.e. by tabbing through the experience, focusable elements will be highlighted and provide access to key features, such as "open product", "add to cart", etc. 

There are many keyboard focus features. While most of these features work in isolation, there is often a correlation between them. This is why all features are handled by a single directive, `cxFocus`. The directive ensures that the features will not conflict and work together in a nice way. 

The different features of the `cxFocus` are documented separately: 

| Feature | Description |
|---|---|
| [Visible focus]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/visible-focus.md %}) | Limits the visible focus to keyboard users only.  |
| [Persist focus]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/persist-focus.md %}) | Re-focus an element based on it's last focus state. |
| [Escape focus]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/escape-focus.md %}) | Traps the focus of an element when the user hits escape. |
| [Auto focus]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/auto-focus.md %}) |  Provides auto focus in a Single Page Experience. |
| [Tab focus]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/tab-focus.md %}) | Provides tabbing through a list of elements.  |
| [Trap focus]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/trap-focus.md %}) | Traps the focus of the first of last element when the user tabs through them. |
| [Lock focus]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/lock-focus.md %}) | Locks and unlocks the focus of focusable child element of the host element. |


While all features have separate configuration typings, all configurations are accesible through the `FocusConfig`. 

The different features can be used with a single directive:

```html
<div [cxFocus]="{ 
    autofocus: 'input[submit:true]', 
    lock: true,
    trap: true }"
></div>
```
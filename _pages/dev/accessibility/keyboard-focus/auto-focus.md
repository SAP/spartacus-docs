---
title: Auto Focus
---

{% capture version_note %}
{{ site.version_note_part1 }} 2.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The `cxFocus` directive provides auto focus capabilities for a single-page experience. The native HTML5 `autofocus` attribute falls short in a single-page application experience, since this attribute is only applied when a page is loaded in the browser. In a single-page application, pages are built dynamically, and elements with an `autofocus` attribute are not focused automatically. Moreover, there are scenarios where the focus of an element should be driven dynamically. For example, when a dialog is opened, or a group of elements is "unlocked".

The auto focus feature of the `cxFocus` directive focuses an element when the host element is focused. The element of choice that is focused is driven by configuration. Moreover, the previously focused element can be persisted, so that it will be refocused during the user session.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Default Behavior

The default configuration (`autofocus: true`) selects the first focusable element of the inner DOM of the host element. Focusable elements are elements that receive focus when you tab through the DOM. The focus is primarily driven by the semantic nature of the element, but can also be forced by using the `tabindex` attribute. In the below example, the first focusable element is the close button:

```html
<div [cx-focus]="{ autofocus: true }"> 
  <button class="close"></button>
  <input class="value" />
</div>
```

The following are exceptions to the default behavior:

- persisted focus
- focus by the native HTML5 `autofocus` attribute
- selected focus

### Auto Focus by Persisted Key

If an element has been focused before, and a focus key is available, the element is refocused. The focusable element with a focus key is persisted, and is refocused when the host element is selected. The following is an example:

```html
<div [cx-focus]="{ autofocus: true }">
  <button class="close"></button>
  <input class="value" cxFocus="key-1" />
  <input class="value" [cxFocus]="{ key: key-1 }" />
</div>
```

A configurable group of persisted, focusable elements can be used to distinguish the focus for certain parts of the UI. This allows you to maintain the focus for a dialog. The following is an example:

```html
<div [cx-focus]="{ autofocus: true, group: 'address-book-dialog' }">
  <button class="close"></button>
  <input class="value" cxFocus="key-1" />
  <input class="value" [cxFocus]="{ key: key-1 }" />
</div>
```

### Auto Focus by the HTML5 autofocus Attribute

If the inner DOM contains an element with the HTML5 `autofocus` attribute, this element is focused by default. The following is an example:

```html
<div [cx-focus]="{ autofocus: true }">
  <button class="close"></button>
  <input class="value" autofocus />
</div>
```

### Auto Focus by CSS Selector

The auto focus configuration also allows for a specific CSS selector, so that the focusable element is precisely selected from the inner DOM of the host element. In the following example, the first name input is selected:

```html
<div [cx-focus]="{ autofocus: '.section input.firstname' }">
  <button class="close"></button>
  <div class="section">
    <input class="firstname" />
    <input class="lasttname" />
  </div>
</div>
```

A special case is made for the host element itself, using the `:host` selector. This selector does not select from the inner DOM, but instead selects and focuses the host itself.

### Extensibility

The auto focus is driven by configuration, and the logic is mainly implemented in the `AutoFocusService`. You can further customize this service.

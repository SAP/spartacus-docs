---
title: Popover Component
feature:
  - name: Popover Component
    spa_version: 3.2
    cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The popover component allows you to display a transient view that contains additional content, such as a note, whenever a user clicks on a control element.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Adding a Popover to a UI Element

The popover component can be used by any UI element that needs to display some additional content near the element. The following steps describe how to add a popover to a UI element.

1. Import the `PopoverModule` into the relevant component module, as shown in the following example:

    ```ts
    @NgModule({
      imports: [PopoverModule]
    })
    ```

1. Bind the popover to the UI element.

    In the following example, the popover is bound to a button that displays a string after it is clicked:

    ```html
    <button [cxPopover]="'Welcome popover!'">
      Example Button
    </button>
    ```

    It is also possible to pass an `<ng-template>` reference into a popover instead of a string. The following example shows how to make template content render inside the popover:

    {% raw %}

    ```html
    <ng-template #myTemplate>
      <h1>Welcome {{ name }}!</h1>
    </ng-template>

    <button [cxPopover]="myTemplate">
      Example Button
    </button>
    ```

{% endraw %}

## Configuration

You can use the `cxPopoverOptions` configuration object to modify the appearance and behavior of the popover component.

The following example creates a customized popover that appears at the bottom of the button it is bound to:

```html
<button
  [cxPopover]="'Welcome Popover!'"
  [cxPopoverOptions]="{
    placement: 'bottom'
  }"
>
  Example Button
</button>
```

You can configure the popover component with the following options:

- `placement` is of type `PopoverPosition` and indicates the preferred placement of the popover. You can see all of the possible `placement` values in `popover.model.ts`. The default is `'top'`.
- `autoPositioning` is a boolean that indicates if the popover should try to find a better placement if there is not enough space in the viewport for the preferred position. This value is ignored if `placement` is set to `'auto'`. The default value is `true`.
- `disable` is a boolean that prevents the popover open function from running. The default is `false`.
- `class` is a string for a custom class name that is passed to the popover component. This is useful for custom CSS styling. The default is `'cx-popover'`.
- `displayCloseButton` is a boolean that indicates if a "close" button is displayed in the popover. The default is `false`.
- `appendToBody` is a boolean that indicates if the popover component is appended to the DOM just before the closing `'body'` tag. The default is `false`.
- `positionOnScroll` is a boolean that indicates if the popover should be repositioned on a scroll event. The default is `false`.

## Events

The following is a description of the events the popover component can emit:

- `openPopover` is emitted after the popover open method is triggered.
- `closePopover` is emitted after the popover close method is triggered.

Any function can be passed with these events. The following is an example:

```html
<button
  [cxPopover]="'Welcome Popover!'"
  (openPopover)="exampleMethod()"
  (closePopover)="exampleMethod()"
>
  Example Button
</button>
```

## Auto Positioning

By default, the popover component uses the `PositioningService` for placement adjustments.

For example, if the `placement` option is set to `'left'`, it means the preferred popover position is on the left of the UI element, and if there is not enough space in the viewport on the left side to render the popover properly, the service changes the position automatically and renders the popover in the best available position.

You can turn this behavior off by setting `autoPositioning` to `false`.

## Accessibility

The popover component is fully keyboard accessible. A popover can be opened when the `Enter` key is pressed, and closed when the `Escape` key is pressed.

If a popover is appended to the DOM using the `appendToBody` configuration option, autofocus is set on the popover area when the popover is opened. The user is "trapped" inside the popover area and can navigate all of the focusable elements within the popover, until it is closed.

After the popover is closed, focus returns to the UI element that triggered the opening of the popover.

## Known Limitations

Popovers cannot currently be triggered on mouse hover. Also, it is only possible to display one popover at a time. If you open a popover, any previously opened popover will close.

---
title: Popover Component
feature:
  - name: Popover Component
    spa_version: 3.2
    cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

The Popover component is UI feature similar to tooltip. It is a transient view  that appears when the user clicks on the control element and can contain much more content.

## Requirements

Popover component requires `PopoverModule` to be imported inside the component module:

```ts
@NgModule({
  imports: [PopoverModule]
})
```

## Component Usage

The popover component can be used by any UI that needs to display near some  content.

The following code snippet shows a simple example of popover binded to button which displays string after click:

```html
<button [cxPopover]="'Welcome popover!'">
  Example Button
</button>
```

For some advanced usage there is also possibility to pass `<ng-template>` reference into popover instead of string. This solution will make template content rendered inside popover area:

```html
<ng-template #myTemplate>
  <h1>Welcome {{ name }}!</h1>
</ng-template>

<button [cxPopover]="myTemplate">
  Example Button
</button>
```

## Configuration

Popover component can be customized in few areas. There is configuration object called `cxPopoverOptions` which setups popover apperance and behaviour based on passed properties.

To add customized popover please see following snippet:

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
It will add popover binded to button, but after trigger open action popover will be rendered from the bottom of such button.

Placement is one of examples, here is full list of popover options:

| option | description | type | default |
| ---------------------- | ------- | ------ | ------ |
| `placement` | The preferred placement of the popover.<br/><br/> Allowed popover placements: `'auto'`, `'top'`, `'bottom'`, `'left'`, `'right'`, `'top-left'`, `'top-right'`, `'bottom-left'`, `'bottom-right'`, `'left-top'`, `'left-bottom'`, `'right-top'`, `'right-bottom'`. | `PopoverPosition` | `'top'`
| `autoPositioning` | Flag used to define if popover should look for the best placement in case if there is not enough space in viewport for preferred position.<br/><br/> Value of this flag is omitted if preferred placement is set to `auto`. | `boolean` | `true`
| `disable` | Flag used to prevent firing popover open function. | `boolean` | `false`
| `class` | Custom class name passed to popover component. Mostly helpful for some custom CSS styling. | `string` | `'cx-popover'`
| `displayCloseButton` | Flag used to display close button in popover component. | `boolean` | `false`
| `appendToBody` | Appends popover component in DOM right before closing `'body'` tag. | `boolean` | `false`
| `positionOnScroll` | Flag indicates if popover should be re-positioned on scroll event. | `boolean` | `false`

## Events

The popover emits two types of events:
| event | description |
| ---------------------- | ------- |
`openPopover` | Fired after popover open method was triggered.
`closePopover` | Fired after popover close method was triggered.

Any function can be passed for such events. Here is an example how it can be done:
```html
<button
  [cxPopover]="'Welcome Popover!'"
  (openPopover)="exampleMethod()"
  (closePopover)="exampleMethod()"
>
  Example Button
</button>
```

## Auto positioning

Popover by default is using `PositioningService` for placement adjustments. 

For example if `placement` option is specified to the `left` which means that preffered popover position should be left and is not enough space in viewport on left side to render popover properly service will change position automatically and render it in the best fitted placement.

This option can be turned off by setting `autoPositioning` to `false`.

## Accessibility

Popover component is fully keyboard accessible. It can be opened on 'Enter' keydown and closed using 'Escape' key.

If popover is appended to body (see configuration section) there is autofocus set on popover area when open was triggered. Customer is 'trapped' inside area and can navigate all focusable elements till popover is closed.

After close focus back to element on which popover was triggered.

## Known limitations

Current version of popover cannot be triggerd on mouse hover. Also there is only possibile to display one popover instance per time. Triggering open another popover will close previous.


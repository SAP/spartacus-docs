## Table of contents

- [LaunchDialogService](#launchdialogservice)
  - [Service Usage](#service-usage)
    - [Importing the Service](#importing-the-service)
    - [Accessing Data via Observables](#accessing-data-via-observables)
    - [Opening a Dialog](#opening-a-dialog)
    - [Opening a Dialog and Subscribing](#opening-a-dialog-and-subscribing)
    - [Closing a Dialog](#closing-a-dialog)
  - [Service Methods](#service-methods)
  - [Service Properties](#service-properties)
  - [Customization](#customization)
  - [Logging](#logging)
- [Modal Styles Documentation](#modal-styles-documentation)
  - [CSS Variables](#css-variables)
    - [Modal Content Border Radius](#modal-content-border-radius)
    - [Modal Dialog Margin (Small Screens)](#modal-dialog-margin-small-screens)
    - [Modal Max Width](#modal-max-width)
    - [Modal Min Width](#modal-min-width)
  - [CSS Classes](#css-classes)
    - [.modal](#modal)
    - [.modal-header](#modal-header)
    - [.modal-body](#modal-body)
    - [.modal-content](#modal-content)
    - [.close](#close)
    - [\&\[aria-hidden='false'\]](#aria-hiddenfalse)
    - [.cx-modal-container](#cx-modal-container)
    - [.cx-modal-header](#cx-modal-header)
    - [.cx-modal-content](#cx-modal-content)
    - [.cx-modal-footer](#cx-modal-footer)
  - [Conclusion](#conclusion)

# LaunchDialogService

The `LaunchDialogService` is designed to facilitate the opening and rendering of dialog components within your application. It provides methods for launching dialogs, managing dialog lifecycle, and passing data to the rendered components. This documentation outlines the key features and usage guidelines for the `LaunchDialogService`.

## Service Usage

### Importing the Service

Before using the `LaunchDialogService`, you need to import it into your component or service.

```typescript
import { Injectable } from '@angular/core';
import { LaunchDialogService } from '@spartacus/storefront';

@Injectable()
export class YourService {
  constructor(protected launchDialogService: LaunchDialogService) {
    // ...
  }
}
```

### Accessing Data via Observables

The `LaunchDialogService` provides access to data using Observables. You can subscribe to these Observables to receive data updates when dialogs are opened or closed.

```typescript
// Accessing data updates
this.launchDialogService.data$.subscribe((data) => {
  // Handle data updates here
});
```

### Opening a Dialog

To open a dialog using the `LaunchDialogService`, use the `openDialog` method. This method takes parameters such as the caller, the button's element reference (optional), the view container reference (optional), and data to pass to the dialog component.

```typescript
this.launchDialogService.openDialog(
  caller: LAUNCH_CALLER,
  openElement?: ElementRef,
  vcr?: ViewContainerRef,
  data?: any
): Observable<any> | undefined;
```

- `caller`: A unique identifier for the dialog.
- `openElement`: (Optional) The button's element reference that triggers the dialog.
- `vcr`: (Optional) The view container reference for inline rendering.
- `data`: (Optional) Data to pass to the dialog component.

Example:

```typescript
import '@spartacus/storefront';

declare module '@spartacus/storefront' {
  const enum LAUNCH_CALLER {
    CUSTOM_ERROR = 'CUSTOM_ERROR',
  }
}

this.launchDialogService.openDialog(LAUNCH_CALLER.CUSTOM_ERROR, buttonElementRef, viewContainerRef, dialogData)
  ?.pipe(take(1))
  .subscribe((result) => {
    // Handle dialog result
  });
```

### Opening a Dialog and Subscribing

The `openDialogAndSubscribe` method opens a dialog and subscribes to it in the service. This method is useful when the trigger component might get destroyed while the dialog is open.

```typescript
this.launchDialogService.openDialogAndSubscribe(
  caller: LAUNCH_CALLER,
  openElement?: ElementRef,
  data?: any
): void;
```

Example:

```typescript
this.launchDialogService.openDialogAndSubscribe(LAUNCH_CALLER.CUSTOM_ERROR, buttonElementRef, dialogData);
```

### Closing a Dialog

To close a dialog programmatically, you can use the `closeDialog` method, which accepts a reason for closing the dialog.

```typescript
this.launchDialogService.closeDialog(reason: any): void;
```

Example:

```typescript
this.launchDialogService.closeDialog('userClickedCloseButton');
```

If you need to react somehow depends on closing reason, you can subscribe to dialogClose

Example: 

```typescript
this.launchDialogService.dialogClose.subscribe((value: any) => {
  if (value === 'userClickedCloseButton') {
    // Do something
  }
});
```

## Service Methods

The `LaunchDialogService` provides the following methods:

- `openDialog`: Opens a dialog and returns an Observable to track dialog events.
- `openDialogAndSubscribe`: Opens a dialog and subscribes to it in the service.
- `closeDialog`: Closes the currently open dialog.
- `clear`: Removes an element from the list of rendered elements.
- `findConfiguration`: Returns the configuration for a given caller.
- `getStrategy`: Returns the render strategy based on the configuration.

## Service Properties

The `LaunchDialogService` exposes the following properties:

- `data$`: An Observable that provides access to data updates.
- `dialogClose`: An Observable that provides access to dialog close events.

## Customization

You can customize the behavior of the `LaunchDialogService` by implementing your own render strategies and configuration. The service is designed to be extensible and adaptable to the specific needs of your application.

## Logging

The service includes a built-in logger that can be accessed through the `logger` property for debugging and logging purposes.

```typescript
const logger = this.launchDialogService.logger;
logger.warn('This is a warning message.');
```

# Modal Styles Documentation

This documentation provides an overview of the key CSS variables and classes used for styling modal components. 

## CSS Variables

### Modal Content Border Radius
- **Variable:** `$modal-content-border-radius`
- **Description:** Sets the border radius for the modal content container, giving it rounded corners.
- **Default:** `0`

### Modal Dialog Margin (Small Screens)
- **Variable:** `$modal-dialog-margin-sm`
- **Description:** Sets the margin for the modal dialog container on small screens. The `!important` flag is used to ensure this value is applied.
- **Default:** `0`

### Modal Max Width
- **Variables:** `$modal-max-width`, `$modal-max-width-md`, `$modal-max-width-sm`
- **Description:** Sets the maximum width of the modal dialog on various screen sizes. The `!important` flag is used to ensure these values are applied.
- **Defaults:** 
  - `$modal-max-width`: `768px`
  - `$modal-max-width-md`: `768px`
  - `$modal-max-width-sm`: `100%`

### Modal Min Width
- **Variables:** `$modal-min-width`, `$modal-min-width-md`, `$modal-min-width-sm`
- **Description:** Sets the minimum width of the modal dialog on various screen sizes. The `!important` flag is used to ensure these values are applied.
- **Defaults:** 
  - `$modal-min-width`: `768px`
  - `$modal-min-width-md`: `768px`
  - `$modal-min-width-sm`: `100%`

## CSS Classes

### .modal
- **Description:** The base class for styling modals. It provides a semi-transparent background overlay.
- **Styles:** 
  - `background-color: rgba(0, 0, 0, 0.5);`

### .modal-header
- **Description:** Styles the header section of the modal.
- **Styles:** 
  - `padding: $modal-header-padding;`

### .modal-body
- **Description:** Styles the body content of the modal.
- **Styles:** 
  - `padding: 16px 30px 30px;`

### .modal-content
- **Description:** Styles the content container of the modal, which typically holds the header, body, and footer.
- **Styles:** 
  - `border-radius: $modal-content-border-radius;`
  - `border: none;`

### .close
- **Description:** Styles the close button within the modal.
- **Styles:** 
  - `font-size: 38px;`
  - `font-weight: 100;`
  - `bottom: 5px;`
  - `position: relative;`
  - `margin-inline-start: 0;`
  - `margin-inline-end: 0;`
  - `align-self: flex-end;`

### &[aria-hidden='false']
- **Description:** Selector for showing the modal when `aria-hidden` is `false`.
- **Styles:** 
  - `display: block;`

### .cx-modal-container
- **Description:** Styles the modal container, ensuring it is centered vertically and horizontally.
- **Styles:** 
  - `display: flex;`
  - `align-items: center;`
  - `margin: auto;`
  - `height: 100%;`
  - `overflow-y: auto;`
  - `max-width: $modal-max-width;`
  - `min-width: $modal-min-width;`
  - Responsive Styles (for Small Screens):
    - `margin: $modal-dialog-margin-sm;`
    - `min-width: $modal-max-width-sm;`
    - `max-width: $modal-min-width-sm;`

### .cx-modal-header
- **Description:** Styles the header section of the modal.
- **Styles:** 
  - `display: flex;`
  - `justify-content: space-between;`
  - `padding-top: 2rem;`
  - `padding-inline-end: 1.875rem;`
  - `padding-bottom: 0;`
  - `padding-inline-start: 1.875rem;`

### .cx-modal-content
- **Description:** Styles the content section of the modal, which typically holds the main content.
- **Styles:** 
  - `background-color: var(--cx-color-inverse);`
  - `width: 100%;`

### .cx-modal-footer
- **Description:** Styles the footer section of the modal.
- **Styles:** 
  - `padding: 0px 27px 30px;`


These CSS variables and classes provide a foundation for styling modal components. You can customize their values to achieve the desired visual appearance for your modals within your application.

## Conclusion

The `LaunchDialogService` simplifies the process of opening and managing dialogs in your Angular application. By following the guidelines and examples provided in this documentation, you can efficiently integrate and customize dialog components to enhance user interactions and experiences in your application.
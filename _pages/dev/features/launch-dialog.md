---
title: Launch Dialog Service
---

The `LaunchDialogService` facilitates the opening and rendering of dialog components within your storefront application. It provides methods for launching dialogs, managing the dialog lifecycle, and passing data to the rendered components.

Before using the `LaunchDialogService`, you need to import it into your component or service, as shown in the following example:

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

## Launch Dialog Service Properties

The `LaunchDialogService` exposes the following properties:

- `data$`, which is an Observable that provides access to data updates.
- `dialogClose`, which is an Observable that provides access to dialog close events.

You can subscribe to these Observables to receive data updates when dialogs are opened or closed, as shown in the following example:

```typescript
// Accessing data updates
this.launchDialogService.data$.subscribe((data) => {
  // Handle data updates here
});
```

## Launch Dialog Service Methods

All of the `LaunchDialogService` methods are defined in `launch-dialog-service.ts`.

The following sections describe some of these methods in more detail.

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

The following is description of the `openDialog` parameters:

- `caller` is a unique identifier for the dialog.
- `openElement` is the button's element reference that triggers the dialog. This parameter is optional.
- `vcr` is the view container reference for inline rendering. This parameter is optional.
- `data` is the data to pass to the dialog component. This parameter is optional.

The following is an example of using the `openDialog` method:

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

The `openDialogAndSubscribe` method opens a dialog and subscribes to the dialog in the service. This method is useful when the trigger component might get destroyed while the dialog is open.

The following is an example of using the `openDialogAndSubscribe` method:

```typescript
this.launchDialogService.openDialogAndSubscribe(LAUNCH_CALLER.CUSTOM_ERROR, buttonElementRef, dialogData);
```

### Closing a Dialog

To close a dialog programmatically, you can use the `closeDialog` method, which accepts a reason for closing the dialog.

The following is an example:

```typescript
this.launchDialogService.closeDialog('userClickedCloseButton');
```

If you need your dialog to react in a way that depends on the reason for closing, you can subscribe to `dialogClose`. The following is an example:

```typescript
this.launchDialogService.dialogClose.subscribe((value: any) => {
  if (value === 'userClickedCloseButton') {
    // Do something
  }
});
```

## Customization

You can customize the behavior of the `LaunchDialogService` by implementing your own render strategies and configuration. The service is designed to be extensible and adaptable to the specific needs of your application.

## Logging

To help with debugging and logging, the service includes a built-in logger that can be accessed through the `logger` property, as shown in the following example:

```typescript
const logger = this.launchDialogService.logger;
logger.warn('This is a warning message.');
```

## CSS Variables and Classes for Styling Modal Components

The CSS variable and classes that are used for styling modal components are defined in `modal.scss`. The variables and classes provide a foundation for styling modal components, but you can customize their values to achieve your own visual appearance for the modals within your storefront application.

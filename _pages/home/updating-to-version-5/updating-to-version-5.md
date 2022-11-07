---
title: Updating to Spartacus Version 5.0
---

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Upgrading Your Angular Libraries

Before upgrading Spartacus to version 5.0, you first need to make sure your Angular libraries are up to date. Spartacus 5.0 requires Angular 14.

You can upgrade your application to Angular 14 as follows:

- Start by upgrading Angular to version 13, and verify that all breaking changes have been addressed.
- When you have updated to Angular 13, you can then upgrade to Angular 14.

You might have to append the `--force` flag if you encounter a mismatch between peer dependencies during the migration. The following is an example command that upgrades Angular to version 13.

```bash
ng update @angular/cli@13 --force
```

Afterwards, you need to upgrade third party dependencies to the version that is compatible with Angular 14, such as `@ng-bootstrap/ng-bootstrap`, `@ng-select/ng-select` or `@ngrx/store`.

For more information, see the official [Angular Update Guide](https://update.angular.io/).

## Downloading Spartacus Libraries from the Repository Based Shipment Channel

To upgrade Spartacus to version 5.0, you need to download the Spartacus 5.0 libraries from the Repository Based Shipment Channel (RBSC), as described in the following procedure.

1. Create an S-user for RBSC that has the appropriate licenses to download the Spartacus libraries.
1. Log into your S-user account at the following web address: `https://ui.repositories.cloud.sap/www/webapp/users/`
1. If you have not already done so, click on **Add User** and create a technical user.
1. In the root of your Spartacus project, create an `.npmrc` file with the following content:

   ```text
   @spartacus:registry=https://<repositorynumber>.npmsrv.base.repositories.cloud.sap/
   //<repositorynumber>.npmsrv.base.repositories.cloud.sap/:_auth=<npmcredentialsfromrbsc>
   always-auth=true
   ```

   **Note:** The two slashes (`//`) at the start of the second line are required.

1. Replace the two instances of `<repositorynumber>` with the repository number for the release, which is provided by SAP.
1. In the **User Management** tab of the [RBSC website](https://ui.repositories.cloud.sap/www/webapp/users/), select the technical user and copy the generated `NPM Base64 Credentials`.
1. In the `.npmrc` file, replace `<npmcredentialsfromrbsc>` with the `NPM Base64 Credentials` you copied from the RBSC website.

You can now proceed to [Upgrading Spartacus to 5.0](#upgrading-spartacus-to-50).

## Upgrading Spartacus to 5.0

Spartacus 5.0 includes many new features and fixes. Since this update is a major release, some of the updates may also be breaking changes for your application. In this case, additional work on your side may be required to fix issues that result from upgrading from 4.x to 5.0.

To update to version 5.0 of Spartacus, run the following command in the workspace of your Angular application:

```bash
ng update @spartacus/schematics@5.0.0
```

When the update has finished running, inspect your code for comments that begin with `// TODO:Spartacus`. For detailed information about each added comment, see [{% assign linkedpage = site.pages | where: "name", "5-0-typescript-breaking-changes.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/home/updating-to-version-5/5-0-typescript-breaking-changes.md %}).

The process might also downgrade some dependencies (namely RxJS), because Spartacus does not yet support the newer version.

## Using Spartacus with SAP Commerce Cloud in the Public Cloud

With the release of Spartacus 5.0, the hosting service of SAP Commerce Cloud cannot be used for building your Spartacus application. As a workaround, you can build your Spartacus app locally, and upload the compiled application, as follows:

1. In your Spartacus project, run `yarn build`.

   A new `dist` folder is created in the root directory of your project.

2. Commit the `dist` folder to your code repository for SAP Commerce Cloud.

   For more information, see [Adding Applications for JavaScript Storefronts](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/b2f400d4c0414461a4bb7e115dccd779/63577f67a67347bf9f4765a5385ead33.html).

## Removal of NG Bootstrap

NG Bootstrap has been removed from Spartacus 5.0 and is no longer a dependency. You can continue to use NG Bootstrap in your Spartacus application, but this may require upgrading additional third party dependencies. For more information, see the list of [NG Bootstrap dependencies](https://www.npmjs.com/package/@ng-bootstrap/ng-bootstrap).

If you no longer need NG Bootstrap in your Spartacus application, you can run the command `yarn remove @ng-bootstrap/ng-bootstrap`.

## Removal of ModalService and Related Code

The `ModalService`, `ModalDirective`, `ModalDirectiveOptions`, `ModalDirectiveService`, `ModalOptions` and `ModalRef` have all been removed from Spartacus 5.0. If you are using the `ModalService` and related code in your Spartacus application, you can replace it with the `LaunchDialogService`, which can be imported from `@spartacus/storefront`.

To open a modal, use the `openDialog` or `openDialogAndSubscribe` methods. The following is an example:

```ts
const dialog = this.launchDialogService.openDialog(
    LAUNCH_CALLER.CLOSE_ACCOUNT,
    this.element,
    this.vcr
  );

dialog?.pipe(take(1)).subscribe();
```

The `LaunchDialogService` uses `LAUNCH_CALLER` to open a modal, so you need to augment `LAUNCH_CALLER` with a specific key for the component that you want to open in the modal. The following is an example:

```ts
import '@spartacus/storefront';

declare module '@spartacus/storefront' {
    const enum LAUNCH_CALLER {
       CLOSE_ACCOUNT = 'CLOSE_ACCOUNT',
    }
}
```

Once you have a key for your component, you need to provide a configuration to the component module that is specified for your modal. The following is an example:

```ts
import { DIALOG_TYPE, LayoutConfig } from '@spartacus/storefront';
import { CloseAccountModalComponent } from './close-account-modal.component';

export const defaultCloseDialogModalLayoutConfig: LayoutConfig = {
    launch: {
       CLOSE_ACCOUNT: {
          inline: true, // OR inlineRoot: true
          component: CloseAccountModalComponent,
          dialogType: DIALOG_TYPE.DIALOG,
       },
    },
};
```

```ts
provideDefaultConfig(defaultCloseDialogModalLayoutConfig),
```

You can use the following dialog rendering strategies in your configuration:

- `inline` renders a component inline, next to the trigger. This strategy requires `ElementRef` to be provided to the `openDialog` or `openDialogAndSubscribe` methods.
- `inlineRoot` renders a component directly inside `cx-storefront` (that is, the storefront selector).

More configuration options can be found in the `LaunchOptions` interface.

To close the modal, use the `closeDialog` method, as shown in the following example:

```ts
dismissModal(reason?: any): void {
  this.launchDialogService.closeDialog(reason);
}
```

To handle closing of the dialog when click events occur outside of the dialog, use `@HostListener` and `ElementRef`, as shown in the following example:

```ts
@HostListener('click', ['$event'])
handleClick(event: UIEvent): void {
  if ((event.target as any).tagName === this.el.nativeElement.tagName) {
    this.dismissModal('Cross click');
  }
}
```
  
To pass data to the modal, call the data as a parameter of the function, as shown in the following example:
  
```ts
const dialog = this.launchDialogService.openDialog(
    LAUNCH_CALLER.COUPON,
    this.element,
    this.vcr,
    { coupon: this.coupon }
  );
```

## Additional Information

In addition to breaking changes, the following details are important to be aware of when upgrading to Spartacus 5.0:

- New entry points have been introduced for the `@spartacus/cart` library. For more information, see [{% assign linkedpage = site.pages | where: "name", "cart-library-release-notes.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/home/updating-to-version-5/cart-library-release-notes.md %}).
- New entry points have been introduced for the `@spartacus/checkout` library. For more information, see [{% assign linkedpage = site.pages | where: "name", "checkout-libraries-release-notes.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/home/updating-to-version-5/checkout-libraries-release-notes.md %}).
- Spartacus provides a `webApplicationInjector.js` file that is required for working with SmartEdit. In Spartacus 5.0, the `webApplicationInjector.js` file has been updated to work with SAP Commerce Cloud 2211. If you are using an older version of SAP Commerce Cloud, you need to replace the `webApplicationInjector.js` file in your Spartacus application with the `webApplicationInjector.js` file that is shipped with your version of SAP Commerce Cloud. For more information, see [Web Application Injector](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/e1391e5265574bfbb56ca4c0573ba1dc/e9340d1d3d3249849ff154731277069a.html).

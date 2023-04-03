---
title: Updating to Spartacus Version 6.0
---

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Upgrading Your Angular Libraries

Before upgrading Spartacus to version 6.0, you first need to make sure your Angular libraries are up to date. Spartacus 6.0 requires Angular 15.

You can upgrade your application to Angular 15 as follows:

- Start by upgrading Angular to version 14, and verify that all breaking changes have been addressed.
- When you have updated to Angular 14, you can then upgrade to Angular 15.

You might have to append the `--force` flag if you encounter a mismatch between peer dependencies during the migration. The following is an example command that upgrades Angular to version 14.

```bash
ng update @angular/cli@14 --force
```

Afterwards, you need to upgrade third party dependencies to the version that is compatible with Angular 15, such as `ngx-infinite-scroll`, `@ng-select/ng-select` or `@ngrx/store`.

For more information, see the official [Angular Update Guide](https://update.angular.io/).

## Downloading Spartacus Libraries from the Repository Based Shipment Channel

To upgrade Spartacus to version 6.0, you need to download the Spartacus 6.0 libraries from the Repository Based Shipment Channel (RBSC), as described in the following procedure.

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

You can now proceed to [Upgrading Spartacus to 6.0](#upgrading-spartacus-to-60).

## Upgrading Spartacus to 6.0

Spartacus 6.0 includes many new features and fixes. Since this update is a major release, some of the updates may also be breaking changes for your application. In this case, additional work on your side may be required to fix issues that result from upgrading from 5.x to 6.0.

To update to version 6.0 of Spartacus, run the following command in the workspace of your Angular application:

```bash
ng update @spartacus/schematics@6.0.0
```

When the update has finished running, inspect your code for comments that begin with `// TODO:Spartacus`. For detailed information about each added comment, see [6.0 Typescript Breaking Changes](TODO:MATT - link to the typescript breaking change file that Patrick generates).

The process might also downgrade some dependencies (namely RxJS), because Spartacus does not yet support the newer version.

## Using Spartacus with SAP Commerce Cloud in the Public Cloud

With the release of Spartacus 6.0, the hosting service of SAP Commerce Cloud cannot be used for building your Spartacus application. As a workaround, you can build your Spartacus app locally, and upload the compiled application, as follows:

1. In your Spartacus project, run `npm run build`.

   A new `dist` folder is created in the root directory of your project.

2. Commit the `dist` folder to your code repository for SAP Commerce Cloud.

   For more information, see [Adding Applications for JavaScript Storefronts](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/b2f400d4c0414461a4bb7e115dccd779/63577f67a67347bf9f4765a5385ead33.html).

---
title: Assisted Service Module (DRAFT)
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.3 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

Assisted Service Module (ASM) enables customer service personnel to provide real-time customer sales and service support using the storefront. For more information, refer to the [ASM section on SAP Help Portal](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/8b571515866910148fc18b9e59d3e084.html)

Spartacus now supports the ASM functionality that allows customer emulation by sales support agents through the Spartacus storefront.

## Requirements

For more information on to setup and configure ASM on your SAP Commerce Cloud, refer to the [ASM section on SAP Help Portal](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/8b571515866910148fc18b9e59d3e084.html).

Here are a few setup steps that are important and/or specific to get ASM working with Spartacus:

### ASM Back End Requirements

ASM in Spartacus requires SAP Commerce Cloud version 1905.5 or higher. The minimum version of 1905.5 is required to enable CORS in `assistedservicewebservices` endpoints.

The ASM feature in Spartacus requires the following extensions:

- assistedservicewebservices Extension
- assistedservicestorefront AddOn

### Granting asagentgroup CMS Permissions

The user group `asagentgroup` needs specific rights to read CMS data from OCC.

#### Option 1: Initialize from scratch with 1905.5 or higher

If you start from scratch and initialize your SAP Commerce Cloud system with version 1905.5 or higher, `asagentgroup` will get the required permissions to use cms data via Spartacus and OCC. There is no additional step to do.

#### Option 2: Manual import in impex console.

If you upgrade from an earlier version than 1905.5, you need to grant the `asagentgroup` permissions by importing this impex data via the impex console:

```
# Access rights for asagentgroup
# - These are needed for rendering (cmsoccaddon).

$START_USERRIGHTS;;;;;;;;;
Type;UID;MemberOfGroups;Password;Target;read;change;create;remove;change_perm
UserGroup;asagentgroup;;;;;;;;

# general
;;;;Item;+;;;;;
;;;;Type;+;;;;;

# access rights for Products, Store, Site and Catalogs
;;;;Product;+;;;;;
;;;;Category;+;;;;;
;;;;VariantType;+;;;;;
;;;;BaseSite;+;;;;;
;;;;BaseStore;+;;;;;
;;;;Catalog;+;;;;;
;;;;CatalogVersion;+;;;;;
;;;;ContentCatalog;+;;;;;
;;;;MediaContainer;+;-;-;-;-;
;;;;MediaContext;+;-;-;-;-;
;;;;MediaFormat;+;-;-;-;-;
;;;;MediaFormatMapping;+;-;-;-;-;

# cms2 items
;;;;CMSItem;+;-;-;-;-;

$END_USERRIGHTS;;;;;
```

### CORS Configuration

The `assistedservicewebservices` extension requires CORS configuration, which is possible since SAP Commerce Cloud version 1905.5. In your `local.properties` file, you need to customize the "allowed origins" property for `assistedservicewebservices`, which is shown here with its default value:

```
corsfilter.assistedservicewebservices.allowedOrigins=http://localhost:4200 https://localhost:4200
```

For development purposes, the value can be a wildcard:

```
corsfilter.assistedservicewebservices.allowedOrigins=*
```

Bear in mind this wildcard configuration is flexible for development environments but it is unsecured. A more restrictive configuration is required for production use.

## Invoke the ASM UI in the storefront

To invoke the ASM UI in the storefront, add the `?asm=true` suffix to the url.
For example, with the sample store, you can invoke the ASM UI on the home page with this url

```
https://{hostname}/electronics-spa/en/USD/?asm=true
```

## Spartacus ASM aware development guidelines

Before ASM was released, the occ userId used for an authenticated user was the special occ user "current", represented by the constant `OCC_USER_ID_CURRENT`, like in this example:

```typescript
  load(): void {
    this.store.dispatch(new UserActions.LoadUserDetails(OCC_USER_ID_CURRENT));
  }
```

Now that Spartacus supports ASM, the correct way to determine the occ userId is to call AuthService.getOccUserId(). If we fix the previous example, it becomes:

```typescript

  load(): void {
    this.authService
      .getOccUserId()
      .pipe(take(1))
      .subscribe(occUserId =>
        this.store.dispatch(new UserActions.LoadUserDetails(occUserId))
      );
  }

```

The rule of thumb is, if `OCC_USER_ID_CURRENT` is used directly in a service, it should likely be replaced by a call to `getOccUserId()`.

In order to support ASM, and potentially other features in the future, the facade services can't simply use the "current" special userId when calling various actions. There needs to be some logic applied to determine the correct OCC userId to pass down to actions that will trigger a backend call.

Therefore, the logic to determine the correct OCC userid given the context is centralized in the `AuthService` function `getOccUserId()`.

## Configuring

No special configuration is required for this feature.

## Extending

No special extensibility is available for this feature.

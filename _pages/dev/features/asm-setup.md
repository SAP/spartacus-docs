---
title: ASM
---

# ASM backend requirment

ASM in spartacus requires SAP Commerce Cloud 1905.5. This patch version is required to enable cors in `assistedservicewebservices` endpoints.

## Extensions required for ASM:

```
    assistedservicewebservices
    assistedservicestorefront
```

`assistedservicestorefront` is an addon and needs to be installed on the traditional accelerator storefront.

# Grant asagentgroup cms premissions

`asagentgroup` needs specific rights to read cms data from OCC.

## Option 1: Initialize from scratch with 1905.5

If you start from scratch and initiaslize your system with 1905.5, `asagentgroup` will get the required permissions to use cms data via Spartacus and OCC.

## Option 2: Manual import in impex console.

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

# Required CMS Data

The ASM angular component is layed out by the CMS and requires a corresponding CMS entry to be displayed in spartacus.

## Option 1: Initialize with the latest Spartacus sample data

The most straignforward way obtain the ASM CMS component is if you initialize your store with the latest spartacus sample data extension: [spartacussampledataaddon](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/assets/other/spartacussampledataaddon.zip)

## Option 2: Manual import in impex console.

If you are not starting from scratch with the latest sample data, you can import this impex to create the AssistedServiceComponent in the CMS and link it to the TopHeaderSlot (change the name of content catalog if needed):

```
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]

INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef
;;AssistedServiceComponent;Assisted Service Component;AssistedServiceComponent;AssistedServiceComponent

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];active;cmsComponents(&componentRef)[mode=append]
;;TopHeaderSlot;true;AssistedServiceComponent

```

# Configure CORS

The `assistedservicewebservices` extension requires CORS configuration, which is possible since SAP Commerce Cloud version 1905.5. In your local.properties file, you need to customize the "allowed origins" for `assistedservicewebservices` property which is shown here with its default valus:

```
corsfilter.assistedservicewebservices.allowedOrigins=http://localhost:4200 https://localhost:4200
```

For development purposes, the config can be

```
corsfilter.assistedservicewebservices.allowedOrigins=*
```

Bear in mind this wildcard configuration is unsecure and a more restrictive configuration is required for production use.

# Invoke the Asm UI in the storefront.

To invoke the ASM UI in the storefront add the `?asm=true` suffix to the url.
For example, with the sample store you can invoke the ASM UI on the home page with this url

```
https://{hostname}/electronics-spa/en/USD/?asm=true
```

# Enable/Disable the ASM UI in Spartacus

The `visibility` attribute of AssistedServiceComponent in the CMS dictates wether the ASM UI is supported or not in the storefront. When AssistedServiceComponent is not visible, it will be completely omitted in the page data returned by OCC to be rendered by Spartacus.

# Spartacus ASM aware development guidelines

In order to support ASM, and potentially other features in the future, the facade services can't simply use the "current" special userId when calling various actions. There needs to be some logic applied to determine the correct OCC userId to pass down to actions that will trigger a backend call.

The logic is required for ASM support, but there are also other rules considered to determine the occ userId (like if there is an authenticated user or not), so ASM is not the only reason why facade services should rely on the new logic to determine which userId to use.

Therefore, the logig to determine the correct OCC userid givent the context is centralized in the `AuthService` function `getOccUserId()`.

Before this function ans ASM were available, one of the mos common way the occ userId was determined is by using the special occ user "current", represented by the constant `OCC_USER_ID_CURRENT`, like in this example:

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
      )
      .unsubscribe();
  }

```

Bottom line, if `OCC_USER_ID_CURRENT` is used directly in a service, it should likely be replaced by a call to `getOccUserId()`.

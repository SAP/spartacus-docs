---
title: Assisted Service Module (DRAFT)
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.3 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

Assisted Service Module (ASM) enables customer service personnel to provide real-time customer sales and service support using the storefront. For more information, refer to the [ASM section on SAP Help Portal](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b571515866910148fc18b9e59d3e084.html)

Spartacus now supports the ASM functionality that allows customer emulation by sales support agents through the Spartacus storefront.

## Requirements

For more information on to setup and configure ASM on your SAP Commerce Cloud, refer to the [ASM section on SAP Help Portal](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b571515866910148fc18b9e59d3e084.html).

Here are a few setup steps that are important and/or specific to get ASM working with Spartacus:

### ASM Back End Requirements

ASM in Spartacus requires SAP Commerce Cloud version 1905.5 or newer. The minimum version of 1905.5 is required to enable CORS in the `assistedservicewebservices` endpoints.

The ASM feature in Spartacus requires the following extensions:

- assistedservicewebservices Extension
- assistedservicestorefront AddOn

### Granting asagentgroup CMS Permissions

The user group `asagentgroup` needs specific rights to read CMS data from OCC.

#### Option 1: Initialize from scratch with 1905.5

If you start from scratch and initialize your SAP Commerce Cloud system with version 1905.5 or newer, `asagentgroup` will get the required permissions to use cms data via Spartacus and OCC. There is no additional step to do.

#### Option 2: Manual import in impex console

If you upgrade from an earlier version than 1905.5, you need to grant the `asagentgroup` permissions by importing this impex data via the impex console:

```impex
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

The `assistedservicewebservices` extension requires CORS configuration, which is possible since SAP Commerce Cloud version 1905.5.  
The cors configurations for `assistedservicewebservices` have default values specified in the `project.properties` file of the `assistedservicewebservices`. At the time of writing these lines, the default values are:

```cors
corsfilter.assistedservicewebservices.allowedOrigins=http://localhost:4200 https://localhost:4200
corsfilter.assistedservicewebservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.assistedservicewebservices.allowedHeaders=origin content-type accept authorization
```

#### Customizing CORS Configuration

CORS configurations are customized by overriding the default configuration via your `local.properties` file.

Since configurations are _overridden_ in local.properties, if you want to add a configuration element without losing the default value, you need to add all the defaults in addition to the new element. For example, to add 'my-new-header' in the allowed header list in addition to the default ones, you need to add this in local.properties:

```cors
corsfilter.assistedservicewebservices.allowedHeaders=origin content-type accept authorization my-new-header.
```

To customize `allowedMethods` and `allowedHeaders` you should add to the default values.
To customize `allowedOrigins`, you will need to override the value with one that is relevant for your environment.

#### allowedOrigins

You need to customize the `allowedOrigins` property for `assistedservicewebservices` with host names that are relevant to your environment. As mentioned above, this is done by adding the propery yout `local.properties` with a new value:

```cors
corsfilter.assistedservicewebservices.allowedOrigins=https://my-new-host:4200
```

For development purposes only, the value can be a wildcard:

```cors
corsfilter.assistedservicewebservices.allowedOrigins=*
```

Bear in mind this wildcard configuration is flexible for development environments but it is unsecured. A more restrictive configuration is required for production use.

## Invoke the ASM UI in the storefront

To invoke the ASM UI in the storefront, add the `?asm=true` suffix to the url.
For example, with the sample store, you can invoke the ASM UI on the home page with this url.

```url
https://{hostname}/electronics-spa/en/USD/?asm=true
```

## Update custom services to support ASM.

If you use a custom service that extends one of these classes:

- UserService
- UserAddressService
- UserConsentService
- UserOrderService
- UserPaymentService

You need to update their constructor in order to support ASM in your storefront.

If during customer emulation the storefront displays the error message: `Cannot find user with propertyValue 'current'`, it is very likely that you use custom services that need to be updated to support ASM.

The update consists of adding a dependency to AuthService in the constructor and pass it down to super(). The constructors that don't have AuthService are now deprecated.

Beyond the constructor update, you may need to update your custom functions to support ASM as well. See the section called `How to write ASM compatible code` for details.

### Update UserService Subclasses

#### Custom service

```typescript
export class CustomUserService extends UserService {
  constructor(store: Store<StateWithUser | StateWithProcess<void>>) {
    super(store);
  }
}
```

#### Custom service updated to support ASM.

```typescript
export class CustomUserService extends UserService {
  constructor(
    store: Store<StateWithUser | StateWithProcess<void>>,
    authService: AuthService
  ) {
    super(store, authService);
  }
}
```

### Update UserAddressService Subclasses

#### Custom service

```typescript
export class CustomUserAddressService extends UserAddressService {
  constructor(protected store: Store<StateWithUser | StateWithProcess<void>>) {
    super(store);
  }
}
```

#### Custom service updated to support ASM.

```typescript
export class CustomUserAddressService extends UserAddressService {
  constructor(
    protected store: Store<StateWithUser | StateWithProcess<void>>,
    protected authService: AuthService
  ) {
    super(store, authService);
  }
}
```

### Update UserConsentService Subclasses

#### Custom service

```typescript
export class CustomUserConsentService extends UserConsentService {
  constructor(protected store: Store<StateWithUser | StateWithProcess<void>>) {
    super(store);
  }
}
```

#### Custom service updated to support ASM.

```typescript
export class CustomUserConsentService extends UserConsentService {
  constructor(
    protected store: Store<StateWithUser | StateWithProcess<void>>,
    protected authService: AuthService
  ) {
    super(store, authService);
  }
}
```

### Update UserOrderService Subclasses

#### Custom service

```typescript
export class CustomUserOrderService extends UserOrderService {
  constructor(protected store: Store<StateWithUser | StateWithProcess<void>>) {
    super(store);
  }
}
```

#### Custom service updated to support ASM.

```typescript
export class CustomUserOrderService extends UserOrderService {
  constructor(
    protected store: Store<StateWithUser | StateWithProcess<void>>,
    protected authService: AuthService
  ) {
    super(store, authService);
  }
}
```

### Update UserPaymentService Subclasses

#### Custom service

```typescript
export class CustomUserPaymentService extends UserPaymentService {
  constructor(protected store: Store<StateWithUser | StateWithProcess<void>>) {
    super(store);
  }
}
```

#### Custom service updated to support ASM.

```typescript
export class CustomUserPaymentService extends UserPaymentService {
  constructor(
    protected store: Store<StateWithUser | StateWithProcess<void>>,
    protected authService: AuthService
  ) {
    super(store, authService);
  }
}
```

## How to write ASM compatible code.

Writing ASM compatible code is all about using the function `getOccUserId()` from the `AuthService` to determine the userId used in occ calls. This is typically done in a service that dispatches and action containing the userId in the payload.

Before ASM was released, the occ userId in requests on the behalf of an authenticated user was the special occ user "current", represented by the constant `OCC_USER_ID_CURRENT`, like in this example:

```typescript
  load(): void {
    this.store.dispatch(new UserActions.LoadUserDetails(OCC_USER_ID_CURRENT));
  }
```

Now that Spartacus supports ASM, the correct way to determine the occ userId is to call AuthService.getOccUserId(). When we update the previous example, we get:

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

Therefore, the logic to determine the correct OCC userId given the context is centralized in the `AuthService` function `getOccUserId()`.

## Configuring

Some ASM behaviors can be configures through Spartacus.

### asm.agentSessionTimer.startingDelayInSeconds

The start time for the customer support agent session timer has a default value of 600 seconds (10 minutes). This can be configured. Specify the number of seconds for the timer staring delay via the property `asm.agentSessionTimer.startingDelayInSeconds` like so ( using the `B2cStorefrontModule` as an example ):

```ts
B2cStorefrontModule.withConfig({
  asm: {
    agentSessionTimer: {
      startingDelayInSeconds: 600
    }
  }
});
```

### asm.customeSearch.maxResults

The number of results in the asm customer search can be customized in spartacus via the property `asm.customeSearch.maxResults`. You define it like this ( using the `B2cStorefrontModule` as an example ):

```ts
B2cStorefrontModule.withConfig({
  asm: {
    customeSearch: {
      maxResults: 20
    }
  }
});
```

## Extending

No special extensibility is available for this feature.

---
title: Assisted Service Module
feature:
- name: Assisted Service Module
  spa_version: 1.3
  cx_version: 1905
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.3 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The Assisted Service Module (ASM) enables customer service personnel to provide real-time customer sales and service support using the Spartacus storefront. For more information, see [Assisted Service Module](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b571515866910148fc18b9e59d3e084.html) on the SAP Help Portal.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Requirements

The Assisted Service Module feature in Spartacus requires SAP Commerce Cloud version 1905.5 or newer. The minimum version of 1905.5 is required to enable CORS in the `assistedservicewebservices` endpoints.

ASM in Spartacus requires the following SAP Commerce Cloud extensions:

- `assistedservicewebservices` extension
- `assistedservicestorefront` AddOn

## Enabling ASM in Spartacus

To enable ASM in Spartacus, you need to carry out the steps in the following sections:

- [Granting CMS Permissions](#granting-cms-permissions)
- [Configuring CORS](#configuring-cors)

### Granting CMS Permissions

The `asagentgroup` user group needs specific rights to read CMS data from OCC.

If you start from scratch and initialize your SAP Commerce Cloud system with version 1905.5 or newer, the `asagentgroup` gets the required permissions to use CMS data through Spartacus and OCC. There is no further action to take.

However, if you upgrade SAP Commerce Cloud from a version that is older than 1905.5, you need to grant the `asagentgroup` permissions by importing the following ImpEx data through the ImpEx console:

```text
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

### Configuring CORS

The `assistedservicewebservices` extension requires CORS configuration, which is possible with SAP Commerce Cloud version 1905.5 or newer. The CORS configurations for `assistedservicewebservices` have default values that are specified in the `project.properties` file of the `assistedservicewebservices`. The default values are the following:

```text
corsfilter.assistedservicewebservices.allowedOrigins=http://localhost:4200 https://localhost:4200
corsfilter.assistedservicewebservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.assistedservicewebservices.allowedHeaders=origin content-type accept authorization
```

#### Customizing the CORS Configuration

CORS configurations are customized by overriding the default configuration through your `local.properties` file.

Since configurations are _overridden_ in `local.properties`, if you want to add a configuration element without losing the default values, you need to add all the defaults in addition to any new elements. For example, to add `my-new-header` in the `allowedHeaders` list, in addition to the default headers, you need to add the following to your `local.properties` file:

```text
corsfilter.assistedservicewebservices.allowedHeaders=origin content-type accept authorization my-new-header.
```

To customize `allowedMethods` or `allowedHeaders`, you should add to the default values.

To customize the `allowedOrigins` property of `assistedservicewebservices`, you need to override (that is, replace) the default value in your `local.properties` file with a host name that is relevant to your environment. The following is an example:

```text
corsfilter.assistedservicewebservices.allowedOrigins=https://my-new-host:4200
```

For development purposes only, you can set the value to a wildcard (`*`), as shown in the following example:

```text
corsfilter.assistedservicewebservices.allowedOrigins=*
```

**Note:** This wildcard configuration is flexible for development environments, but it is not secure. A more restrictive configuration is required for production use.

## Updating Custom Services to Support ASM

If you use a custom service that extends one of the following classes, you need to update the relevant constructor to support ASM in your storefront:

- `UserService`
- `UserAddressService`
- `UserConsentService`
- `UserOrderService`
- `UserPaymentService`

During customer emulation, the storefront may display the following error message: `Cannot find user with propertyValue 'current'`. If you see this message, it is very likely that you have a custom service that needs to be updated to support ASM.

You can update your custom service by adding a dependency to the `AuthService` in the constructor, and passing it down to `super()`. Constructors that do not have `AuthService` are now deprecated.

In addition to updating the constructor, you may need to update your custom functions to support ASM as well. For more information, see [Writing ASM-Compatible Code](#writing-asm-compatible-code).

### Updating Subclasses

If you use a custom service that extends the `UserService` class, your custom service may look like the following example:

```typescript
export class CustomUserService extends UserService {
  constructor(store: Store<StateWithUser | StateWithProcess<void>>) {
    super(store);
  }
}
```

You can update this custom service to support ASM as follows:

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

If you use a custom service that extends the `UserAddressService` class, your custom service may look like the following example:

```typescript
export class CustomUserAddressService extends UserAddressService {
  constructor(protected store: Store<StateWithUser | StateWithProcess<void>>) {
    super(store);
  }
}
```

You can update this custom service to support ASM as follows:

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

For custom services that extend the `UserConsentService`, `UserOrderService`, or `UserPaymentService` classes, the pattern for updating the custom service to support ASM is identical to the example shown for the `UserAddressService` class. The following is another example.

If you use a custom service that extends the `UserConsentService` class, your custom service may look like the following example:

```typescript
export class CustomUserConsentService extends UserConsentService {
  constructor(protected store: Store<StateWithUser | StateWithProcess<void>>) {
    super(store);
  }
}
```

You can update this custom service to support ASM as follows:

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

## Writing ASM-Compatible Code

To write ASM-compatible code, you need to use the `getOccUserId()` function from the `AuthService` to determine the `userId` that is used in OCC calls. This is typically done in a service that dispatches an action that contains the `userId` in the payload.

Prior to official ASM support in Spartacus, in requests sent on behalf of an authenticated user, the OCC `userId` was the special "current" OCC user, which was represented by the `OCC_USER_ID_CURRENT` constant. This can be seen in the following example:

```typescript
  load(): void {
    this.store.dispatch(new UserActions.LoadUserDetails(OCC_USER_ID_CURRENT));
  }
```

With official ASM support in Spartacus, the correct way to determine the OCC `userId` is to call `AuthService.getOccUserId()`. Using the previous example as the starting point, Spartacus now determines the OCC `userId` as follows:

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

**Note:** If `OCC_USER_ID_CURRENT` is used directly in a service, it should likely be replaced by a call to `getOccUserId()`.

To support ASM in Spartacus, and potentially other features in the future, the facade services cannot simply use the "current" special `userId` when calling various actions. There needs to be some logic that is applied to determine the correct OCC `userId` to pass down to actions that trigger back end calls. As a result, the logic to determine the correct OCC `userId` is centralized in the `getOccUserId()` function of the `AuthService`.

## Configuring the Starting Timer Delay

The start time for the customer support agent session timer has a default value of 600 seconds (10 minutes). You can configure this by specifying the number of seconds for the timer starting delay, as shown in the following example:

```ts
provideConfig({
  asm: {
    agentSessionTimer: {
      startingDelayInSeconds: 600,
    },
  },
});
```

## Configuring the Number of Search Results

The number of results in the ASM customer search can be customized, as shown in the following example:

```ts
provideConfig({
  asm: {
    customerSearch: {
      maxResults: 20,
    },
  },
});
```

## Invoking the ASM UI in the Storefront

To invoke the ASM UI in the Spartacus storefront, add the `?asm=true` suffix to the URL. For example, with the electronics sample store, you can invoke the ASM UI on the home page with the following URL:

```text
https://{hostname}/electronics-spa/en/USD/?asm=true
```

## Extending

No special extensibility is available for this feature.

## Limitations

ASM customer emulation does not work with CMS content rules and restrictions in Spartacus. If there are content rules or restrictions that are normally applied based on a customer's ID, or the customer's group ID, these rules and restrictions are not applied during an ASM customer emulation. The CMS endpoints instead provide content based on what the customer support agent is permitted to see.

To display CMS content, Spartacus relies on the CMS endpoints from OCC. When requests are sent, the CMS endpoints do not accept a `userId` parameter that could define the emulated user (that is, the customer). The CMS endpoints only recognize the authenticated user as the sender of requests, and in ASM customer emulation sessions, the authenticated user is the customer support agent.

The following OCC CMS endpoints work only for the authenticated user:

- `/{baseSiteId}/cms/components`
- `/{baseSiteId}/cms/components/{componentId}`
- `/{baseSiteId}/cms/pages`
- `/{baseSiteId}/cms/pages/{pageId}`
- `/{baseSiteId}/cms/sitepages`

OCC CMS endpoints do not accept a `userId` parameter, so it is not possible for an emulated customer to trigger CMS rules and restrictions during an ASM emulation session.

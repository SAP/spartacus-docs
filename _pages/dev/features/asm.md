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

## Granting CMS Permissions

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

## Configuring CORS

The `assistedservicewebservices` extension requires CORS configuration. The CORS configurations for `assistedservicewebservices` have default values that are specified, for example, in the `project.properties` file of the `assistedservicewebservices`. The default values are the following:

```text
corsfilter.assistedservicewebservices.allowedOrigins=http://localhost:4200 https://localhost:4200
corsfilter.assistedservicewebservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.assistedservicewebservices.allowedHeaders=origin content-type accept authorization
```

The various CORS configurations for ASM that are required by the back end can be installed in the following ways:

- using configuration properties to install them during a deployment
- using the Commerce Cloud manifest file to install them during a deployment
- using an ImpEx script to install them at runtime
- using Backoffice to configure them manually at runtime

The following sections describe how to update the CORS configurations for ASM through the `local.properties` file, the SAP Commerce Cloud manifest file, and through ImpEx.

### Local Properties File

If you install the CORS filter configuration for ASM by properties, the following properties must be added to the `corsfilter.assistedservicewebservices` settings of your `local.properties` file:

```plaintext
corsfilter.assistedservicewebservices.allowedOriginPatterns=*
corsfilter.assistedservicewebservices.allowedMethods=GET HEAD OPTIONS PATCH PUT POST DELETE
corsfilter.assistedservicewebservices.allowedHeaders=origin content-type accept authorization cache-control if-none-match x-anonymous-consents x-profile-tag-debug x-consent-reference occ-personalization-id occ-personalization-time
corsfilter.assistedservicewebservices.exposedHeaders=x-anonymous-consents occ-personalization-id occ-personalization-time
corsfilter.assistedservicewebservices.allowCredentials=true
```

**Note:** The wildcard configuration for `allowedOriginPatterns` is flexible for development environments, but it is not secure. A more restrictive configuration is required for production use.

### Commerce Cloud Manifest Configuration

If you install the CORS filter configuration for ASM using the Commerce Cloud manifest file, add the following key-value pairs to the `corsfilter.assistedservicewebservices` settings of the manifest file:

```json
{
	"key": "corsfilter.assistedservicewebservices.allowedOriginPatterns",
	"value": "*"
},
{
	"key": "corsfilter.assistedservicewebservices.allowedMethods",
	"value": "GET HEAD OPTIONS PATCH PUT POST DELETE"
},
{
	"key": "corsfilter.assistedservicewebservices.allowedHeaders",
	"value": "origin content-type accept authorization cache-control if-none-match x-anonymous-consents x-profile-tag-debug x-consent-reference occ-personalization-id occ-personalization-time"
},
{
	"key": "corsfilter.assistedservicewebservices.exposedHeaders",
	"value": "x-anonymous-consents occ-personalization-id occ-personalization-time"
}
{
	"key": "corsfilter.assistedservicewebservices.allowCredentials",
	"value": "true"
}
```

**Note:** The wildcard configuration for `allowedOriginPatterns` is flexible for development environments, but it is not secure. A more restrictive configuration is required for production use.

### ImpEx

You can use the following ImpEx script if you want to install the CORS filter configuration for ASM during initialization, during an update, or manually with the Hybris Admin Console.

```plaintext
INSERT_UPDATE CorsConfigurationProperty;key[unique=true];value;context[default=assistedservicewebservices,unique=true]
;allowedOriginPatterns;*
;allowedMethods;GET HEAD OPTIONS PATCH PUT POST DELETE
;allowedHeaders;origin content-type accept authorization cache-control if-none-match x-anonymous-consents x-profile-tag-debug x-consent-reference occ-personalization-id occ-personalization-time
;allowCredentials;true
;exposedHeaders;x-anonymous-consents occ-personalization-id occ-personalization-time
```

**Note:** The wildcard configuration for `allowedOriginPatterns` is flexible for development environments, but it is not secure. A more restrictive configuration is required for production use.

## Customizing the CORS Configuration

CORS configurations are customized by overriding the default configuration through your `local.properties` file.

Since configurations are *overridden* in `local.properties`, if you want to add a configuration element without losing the default values, you need to add all of the default elements in addition to any new elements. For example, to add `my-new-header` to the `allowedHeaders` list, you need to provide all of the default headers as well as any custom headers in the `allowedHeaders` list.

The following is an example that adds `my-new-header` to the default `allowedHeaders` list in the `local.properties` file:

```text
corsfilter.assistedservicewebservices.allowedHeaders=origin content-type accept authorization my-new-header.
```

To customize `allowedMethods` or `allowedHeaders`, you should include to the default values along with your custom values.

To customize the `allowedOrigins` property of `assistedservicewebservices`, you need to override (that is, replace) the default value in your `local.properties` file with a host name that is relevant to your environment. The following is an example:

```text
corsfilter.assistedservicewebservices.allowedOrigins=https://my-new-host:4200
```

For development purposes only, you can use `allowedOriginPatterns` and set the value to a wildcard (`*`), as shown in the following example:

```text
corsfilter.assistedservicewebservices.allowedOriginPatterns=*
```

**Note:** This wildcard configuration is flexible for development environments, but it is not secure. A more restrictive configuration is required for production use.

## Additional CORS Configuration for Customer Emulation

To enable customer emulation, you must add the `sap-commerce-cloud-user-id` header to the `corsfilter.commercewebservices.allowedHeaders` list. As described in previous sections, you can update the configuration in the `local.properties` file, in the SAP Commerce Cloud manifest file, or through ImpEx. The following is an example of the updated `corsfilter.commercewebservices.allowedHeaders` list in the `local.properties` file:

```text
corsfilter.commercewebservices.allowedHeaders=origin content-type accept authorization cache-control if-none-match x-anonymous-consents x-profile-tag-debug x-consent-reference occ-personalization-id occ-personalization-time sap-commerce-cloud-user-id
```

Additionally, in an `AsmConfig` provider, add a `userIdHttpHeader.enable` key with the value set to `true`. The following is an example:

```ts
provideConfig(<AsmConfig>{
  asm: {
    userIdHttpHeader: {
      enable: true,
    },
  },
}),
```

Now when requests are sent, the `sap-commerce-cloud-user-id` header has its value set to the emulated user's ID. This prevents ambiguity errors when making requests to OCC.

## Writing ASM-Compatible Code

To write ASM-compatible code, you need to use the `takeUserId()` function from the `UserIdService` to determine the `userId` that is used in OCC calls. This is typically done in a service that dispatches an action that contains the `userId` in the payload.

Prior to official ASM support in Spartacus, in requests sent on behalf of an authenticated user, the OCC `userId` was the special "current" OCC user, which was represented by the `OCC_USER_ID_CURRENT` constant. This can be seen in the following example:

```typescript
  /**
   * Retrieves user's addresses
   */
  loadAddresses(): void {
    this.store.dispatch(new UserActions.LoadUserAddresses(OCC_USER_ID_CURRENT));
  }
```

With official ASM support in Spartacus, the correct way to determine the OCC `userId` is to call `UserIdService.takeUserId()`. Using the previous example as the starting point, Spartacus now determines the OCC `userId` as follows:

```typescript

  /**
   * Retrieves user's addresses
   */
  loadAddresses(): void {
    this.userIdService.takeUserId().subscribe((userId) => {
      this.store.dispatch(new UserActions.LoadUserAddresses(userId));
    });
  }

```

**Note:** If `OCC_USER_ID_CURRENT` is used directly in a service, it should likely be replaced by a call to `takeUserId()`.

To support ASM in Spartacus, and potentially other features in the future, the facade services cannot simply use the "current" special `userId` when calling various actions. There needs to be some logic that is applied to determine the correct OCC `userId` to pass down to actions that trigger back end calls. As a result, the logic to determine the correct OCC `userId` is centralized in the `takeUserId()` function of the `UserIdService`.

## Configuring the Session Timer Duration

When a customer support agent signs in, a **Session Timeout** timer appears in the ASM UI. The default value is 600 seconds (10 minutes), but you can change the session timeout duration, as shown in the following example:

```ts
provideConfig({
  asm: {
    agentSessionTimer: {
      startingDelayInSeconds: 720,
    },
  },
});
```

In this example, the duration of the session timer has been set to 720 seconds (12 minutes).

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

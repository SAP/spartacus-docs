---
title: Auth Config Initializer
feature:
- name: Auth Config Initializer
  spa_version: 221121.15.0
  cx_version: 2211-jdk21.1
---

The `AuthConfigInitializer` is a `ConfigInitializer` that allows you to adjust the runtime configuration of the Spartacus auth configuration. The default implementation handles the following two runtime adjustments to the static auth configuration:

- Changes the default redirect URL to include the base site URL context parameter
- Adds the base site as a suffix to the configured client ID

These behaviors can be independently controlled through the `AuthConfig.authentication.initializerOptions` object. They may be explicitly enabled or disabled using a boolean value, or set to `auto` to make the initializer only apply changes when relevant.

The following is an example of the default configuration:

```ts
    provideConfig(<AuthConfig>{
      authentication: {
        initializerOptions: {
          addBaseSiteToRedirectUri: 'auto',
          baseSiteSuffix: 'auto',
        },
      },
    })
```

Relevance is determined by the presence of the base site in the URL context parameters. For more information about URL context parameters, see [Static Multi-Site Configuration](context/static-context-configuration.md) and [Automatic Multi-Site Configuration](context/automatic-context-configuration.md).

The purpose of initializing the redirect URL and client ID is to handle base site resolution during the Authorization Code Flow. When the base site is in the URL context parameter list, Spartacus assumes that multiple sites are being hosted on the same domain (for example, `https://example.com/electronics-spa` and `https://example.com/powertools-spa`). In this case, the Authorization Code Flow process needs to be configured with a return URI that includes the base site. Otherwise, when returning from the authorization server, Spartacus is not able to identify which base site the user originated from. This same problem also applies for the Custom Login URI that is set in the SAP Commerce Cloud `OAuthClientDetails`. Since that field is not dynamic enough to read the return URI path, it must be hard-coded with the base site in the path. This means that a client ID will only work for a single base site. With the `AuthConfigInitializer` adjusting the client ID at runtime to have the base site added as a suffix, it creates a unique, predictable client ID that can be pre-configured in SAP Commerce Cloud with the appropriate Custom Login Page URI for each base site.

For example, if the client ID in Spartacus is set to `mobile_android_public`, the client ID assignments appear as follows:

- For the site `https://example.com/electronics-spa`, the base site is `electronics-spa`, and the client ID is set at runtime to `mobile_android_public_electronics-spa`
- For the site `https://example.com/powertools-spa`, the base site is `powertools-spa`, and the client ID is set at runtime to `mobile_android_public_powertools-spa`

## Enabling the Auth Config Initializer

The auth config initializer requires Spartacus 221121.15 or newer, and SAP Commerce Cloud 2211-jdk21.1 or newer.

If you have installed a new Spartacus app that is version 221121.15 or newer, the auth config initializer is already enabled.

If you are upgrading your Spartacus app to version 221121.15, you must enable the `asyncAuthConfigInitializer` feature toggle to be able to use the auth config initializer. For more information, see [Activating Async Auth Config Initializer](link-to-doc-in-portal).

## Configuring the Auth Config Initializer

The `AuthConfigInitializer` interfaces with the `OAuthClientDetails` that is configured in Backoffice. The configuration requirements depend on your hosting setup for the storefronts.

In general, there are two ways to host multiple storefronts: you can use different domain names for each site, or you can provide the base site in the URL path.

The following is an example of the domain-based approach:

- https://electronics-spa.example.com/en/USD
- https://powertools-spa.example.com/en/USD

The following is an example of the path-based approach:

- https://example.com/electronics-spa/en/USD
- https://example.com/powertools-spa/en/USD

The following sections describe the required configurations for these two types of hosting setups.

### Multiple Domains

If you are using a different domain for each storefront, you can use a single `OAuthClientDetails`. In this case, the `AuthConfigInitializer` can be set to `auto` (the default), or it can be explicitly disabled. Each storefront origin can be set in **OAuth registered redirect URI** in Backoffice, and the **Custom Login Page URI** can use the hostname placeholder to dynamically build the appropriate login page for the authorize request.

The following is an example of ImpEx that configures `OAuthClientDetails` for multiple domains:

```text
INSERT_UPDATE OAuthClientDetails; clientId[unique=true] ;public ;authorities ;scope ;authorizedGrantTypes             ;registeredRedirectUri                                                   ;loginPageUri
                                ; mobile_android_public ;true   ;ROLE_CLIENT ;basic ;authorization_code,refresh_token ;https://electronics-spa.example.com,https://powertools-spa.example.com  ;https://{redirectUriHost}/login
```

The following is an example of the corresponding configuration in `spartacus-configuration.module.ts`:

```ts
    provideConfig(<AuthConfig>{
      authentication: {
        initializerOptions: {
          addBaseSiteToRedirectUri: false, // or 'auto'
          baseSiteSuffix: false, // or 'auto'
        },
      },
    })
```

**Note:** `auto` is the default config value and does not need to be explicitly defined.

### Single-Domain with the Base Site in the Path

If your hosting approach is to define the base site in the path of the URL, you need to set `AuthConfigInitializer` to `auto`, or else have it explicitly enabled (set to `true`). In this case, both the redirect URI and the custom login page URI need to have the base site in the path. Although it is possible to set multiple redirect URIs, you can only set one custom login page URI, and it does not have an appropriate placeholder for the path. As a result, you need one client ID for each base site. The `AuthConfigInitializer` sets the client ID with a pattern of `<client_id>_<base_site>`, so you can create the corresponding set of `OAuthClientDetails` in SAP Commerce Cloud, each with the **OAuth registered redirect URI** and **Custom Login Page URI** set to the appropriate hostname and path.

The following is an example of ImpEx that configures `OAuthClientDetails` for base sites provided in the URL path:

```text
INSERT_UPDATE OAuthClientDetails; clientId[unique=true]                 ;public ;authorities ;scope ;authorizedGrantTypes             ;registeredRedirectUri              ;loginPageUri
                                ; mobile_android_public_electronics-spa ;true   ;ROLE_CLIENT ;basic ;authorization_code,refresh_token ;http://example.com/electronics-spa ;http://example.com/electronics-spa/login
                                ; mobile_android_public_powertools-spa  ;true   ;ROLE_CLIENT ;basic ;authorization_code,refresh_token ;http://example.com/powertools-spa  ;http://example.com/powertools-spa/login
                                ; mobile_android_public_apparel-uk-spa  ;true   ;ROLE_CLIENT ;basic ;authorization_code,refresh_token ;http://example.com/apparel-uk-spa  ;http://example.com/apparel-uk-spa/login
```

The following is an example of the corresponding configuration in `spartacus-configuration.module.ts`:

```ts
    provideConfig(<AuthConfig>{
      authentication: {
        initializerOptions: {
          addBaseSiteToRedirectUri: true, // or 'auto'
          baseSiteSuffix: true, // or 'auto'
        },
      },
    })
```

**Note:** `auto` is the default config value and does not need to be explicitly defined.

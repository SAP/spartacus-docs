---
title: Auth Config Initializer
feature:
- name: Auth Config Initializer
  spa_version: 221121.15.0
  cx_version: 2211-jdk21.0
---

## Auth Config Initializer

The `AuthConfigInitializer` is a `ConfigInitializer` that allows for runtime configuration of the Spartacus auth configuration.  The default implementation handles 2 runtime adjustments to the static auth configuration: 
1. Change the default redirect URL to include the base site URL context parameter
2. Add the base site as a suffix to the configured client ID.  

These behaviors can be independently controlled through the `AuthConfig.authentication.initializerOptions` object.  They may be explicitly enabled or disabled using a boolean value or set to `"auto"` to make the initializer only apply changes when relevant. 

ex: Default Configuration
```typescript
    provideConfig(<AuthConfig>{
      authentication: {
        initializerOptions: {
          addBaseSiteToRedirectUri: 'auto',
          baseSiteSuffix: 'auto',
        },
      },
    })
```

Relevance is determined by the presence of the base site in the URL context parameters.  For more details on URL context parameters, see [Static Multi-Site Configuration](context/static-context-configuration.md) and [Automatic Multi-Site Configuration](context/automatic-context-configuration.md).

The purpose of initializing the redirect URL and client ID is to handle base site resolution during the Authorization Code flow.  When the base site is in the URL context parameter list, Spartacus will assume that multiple sites are being hosted on the same domain (i.e. https://example.com/electronics-spa and https://example.com/powertools-spa).  In this scenario, the Authorization Code flow process will need to be configured with a return URI that includes the base site.  Otherwise, when returning from the authorization server, Spartacus will not be able to identify from which base site the user had originated.  This same problem also applies for the Custom Login URI set in the SAP Commerce Cloud OAuthClientDetails.  Since that field is not dynamic enough to read the return URI path, it must be hard-coded with the base site in the path.  This means that a client ID will only work for a single base site.  With the AuthConfigInitializer adjusting the client ID at runtime to have the base site added as a suffix, it creates a unique, predictable client ID that can be pre-configured in SAP Commerce Cloud with the appropriate Custom Login Page URI for each base site.

Example Client ID assignment:
```
Spartacus build:
  - Client ID set to "mobile_android_public"

On site https://example.com/electronics-spa:
  - Base site is "electronics-spa"
  - Client ID will be set at runtime to "mobile_android_public_electronics-spa"

On site https://example.com/powertools-spa:
  - Base site is "powertools-spa"
  - Client ID will be set at runtime to "mobile_android_public_powertools-spa"
```


## Configuration

The `AuthConfigInitializer` interfaces with the OAuthClientDetails configured in Backoffice.  What configuration is needed will depend on the hosting setup for the storefronts.

In general there are 2 specific ways to host multiple storefronts.  Using different domain names for each site and using the base site in the URL path.
```
Path-based 
 - https://example.com/electronics-spa/en/USD
 - https://example.com/powertools-spa/en/USD

Domain-based
 - https://powertools-spa.example.com/en/USD
 - https://powertools-spa.example.com/en/USD
```

Which hosting setup is used will determine the needed configurations.

### Multiple Domains
If using a different domain for each storefront, you can use a single OAuthClientDetails.  In this case, the `AuthConfigInitializer` can be left on `"auto"` or explicitly disabled.  Each storefront origin can be set in "OAuth registered redirect URI" and the "Custom Login Page URI" can use the hostname placeholder to dynamically build the appropriate login page for the authorize request.

ex: OAuthClientDetails IMPEX for multiple domains 
```
INSERT_UPDATE OAuthClientDetails; clientId[unique=true] ;public ;authorities ;scope ;authorizedGrantTypes             ;registeredRedirectUri                                                   ;loginPageUri
                                ; mobile_android_public ;true   ;ROLE_CLIENT ;basic ;authorization_code,refresh_token ;https://electronics-spa.example.com,https://powertools-spa.example.com  ;https://{redirectUriHost}/login
```

ex: Composable Commerce configuration in spartacus-configuration.module.ts
```typescript
    provideConfig(<AuthConfig>{
      authentication: {
        initializerOptions: {
          addBaseSiteToRedirectUri: false, // or 'auto'
          baseSiteSuffix: false, // or 'auto'
        },
      },
    })
```
Note: `"auto"` is the default config value and does not need to be explicitly defined.


### Single-domain with Base Site in path
For this hosting arrangement, we will want `AuthConfigInitializer` set to `"auto"` or explicitly enabled.  We need both the redirect URI and custom login page URI to have the base site in the path.  While we can set multiple redirect URIs, we can only set one Custom login page URI and it does not have an appropriate placeholder for the path.  As a result, we will need one client ID for each base site.  The `AuthConfigInitializer` will set the client ID with a pattern of `<client_id>_<base_site>`, so we can create the corresponding set of OAuthClientDetails in Commerce Cloud, each with the "OAuth registered redirect URI" and "Custom Login Page URI" set to the appropriate hostname and path.

ex: OAuthClientDetails IMPEX for path-based base site
```
INSERT_UPDATE OAuthClientDetails; clientId[unique=true]                 ;public ;authorities ;scope ;authorizedGrantTypes             ;registeredRedirectUri              ;loginPageUri
                                ; mobile_android_public_electronics-spa ;true   ;ROLE_CLIENT ;basic ;authorization_code,refresh_token ;http://example.com/electronics-spa ;http://example.com/electronics-spa/login
                                ; mobile_android_public_powertools-spa  ;true   ;ROLE_CLIENT ;basic ;authorization_code,refresh_token ;http://example.com/powertools-spa  ;http://example.com/powertools-spa/login
                                ; mobile_android_public_apparel-uk-spa  ;true   ;ROLE_CLIENT ;basic ;authorization_code,refresh_token ;http://example.com/apparel-uk-spa  ;http://example.com/apparel-uk-spa/login
```

ex: Composable Commerce configuration in spartacus-configuration.module.ts
```typescript
    provideConfig(<AuthConfig>{
      authentication: {
        initializerOptions: {
          addBaseSiteToRedirectUri: true, // or 'auto'
          baseSiteSuffix: true, // or 'auto'
        },
      },
    })
```
Note: `"auto"` is the default config value and does not need to be explicitly defined.

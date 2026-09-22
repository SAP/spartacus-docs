---
title: OAuth Callback Page
feature:
- name: OAuth Callback Page
  spa_version: 221121.19.0
  cx_version: 2211-jdk21.1
---

For Composable Commerce to support a dedicated callback page, set the following feature toggles to `true` in the `spartacus-features.module.ts` file:

- `authorizationCodeFlowByDefault`
- `asyncAuthConfigInitializer`
- `oauthCallbackPage`

Version 221121.19.0 introduces default support for a dedicated OAuth callback page.  This feature provides an improved UX flow for Authorization Code flow.  As part of the Authorization Code flow, when the user credentials are submitted to the Authorization Server, the browser is redirected back to the storefront to the Redirect URI sent in the initial /authorize call.  Composable Commerce used to set a default value of the homepage as the Redirect URI.  With SSR enabled, this results in the user seeing the homepage for a brief moment before Composable Commerce routes back to the page where the user initiated the login flow.  This is undesirable since the homepage could be confusing to see when the user expects a different page, such as checkout or PDP.  Additionally, this slows the storefront down by requesting the homepage media assets that will then be discarded.  A dedicated page allows us to better control the UX when returning from login.  The default implementation simply uses the Spinner Component, so the page that is rendered is lightweight and appears as a loading page.

To better support a dedicated OAuth callback page, AuthConfigInitializer now comprehensively manages initializing the redirect URI.  The OAuth 2.1 spec defines the Redirect URI as an absolute URL.  The auto-configuration now provides more convenience to meet this requirement.  Previously, relative values would be used as-is, which could cause issues with the OAuth2.1 spec.  The new default behavior of AuthConfigInitializer will initialize empty or relative values to include the current page origin. The base site will be added as the first path segment when enabled, and if the statically-configured URI was relative, then it will be appended as the page path.  Absolute values will be considered the desired URL base, and the base site will be added when enabled.

For example, assuming an origin of "https://storefront.com", base site of "electronics-spa", and adding base site to redirect URI is enabled:
- An undefined value will be initialized to "https://storefront.com/electronics-spa/oauth-callback".
- The value "" (empty string) will be initialized to "https://storefront.com/electronics-spa/".  
- The relative value "/my-login-return" will be initialized to "https://storefront.com/electronics-spa/my-login-return".  
- The absolute value "https://storefront.com/shop" will be initialized to "https://storefront.com/shop/electronics-spa"


### Customizing the OAuth Callback Page

#### Custom page path

It is possible to change the default path for the callback page.  It requires adjusting the path for oAuthCallback page in the CMS, then setting the new path in the Composable Commerce config.

The path can be modified in CMS using Backoffice > WCMS > Page.  Select the "oAuthCallback" page and edit the "Page Label" field with the new path.

Here is an example IMPEX to change the path:
```impex
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]

UPDATE ContentPage ;$contentCV[unique=true] ;uid[unique=true] ;label
                   ;                        ;oAuthCallback    ;/my-oauth-callback
```

Set the new path to both the Composable Commerce routing configuration for route "oAuthCallback" and the redirect URI in the `spartacus-configuration.module.ts`.
```typescript
import {
  AuthConfig,
  provideConfig,
  RoutingConfig,
} from '@spartacus/core';

// ...

    provideConfig(<RoutingConfig & AuthConfig>{
      routing: {
        routes: {
          oAuthCallback: {
            paths: ['my-oauth-callback'],
          },
        },
      },
      authentication: {
        OAuthLibConfig: {
          redirectUri: 'my-oauth-callback',
        },
      },
    }),
```


#### Custom component or guards
The default component is minimal and you may wish to customize it.  This can be done with a CMS config to define new components and guards.  

In the Composable Commerce configuration, preferably in an eagerly-loaded module, modify the CmsComponent mapping for "OAuthCallbackComponent" using a config provider.

In this example, we are changing the component and adding an extra guard:
```typescript
import { OAuthCallbackGuard } from '@spartacus/core';

// ... 

    provideConfig(<CmsConfig>{
      cmsComponents: {
        OAuthCallbackComponent: {
          component: MyAuthCallbackComponent,
          guards: [OAuthCallbackGuard, MyExtraGuard],
        },
      },
    }),
```

Note that when providing an array value like guards, the entire array is replaced with the provided value.  If you wish to only add a guard, you will need to re-declare all the other elements in the array, as seen in the above example.



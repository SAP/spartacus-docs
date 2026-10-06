---
title: OAuth Callback Page
feature:
- name: OAuth Callback Page
  spa_version: 221121.19.0
  cx_version: 2211-jdk21.1
---

Version 221121.19.0 introduces default support for a dedicated OAuth callback page.  This feature provides an improved UX flow for Authorization Code flow.  As part of the Authorization Code flow, when the user credentials are submitted to the Authorization Server, the browser is redirected back to the storefront to the Redirect URI sent in the initial /authorize call.  Composable Commerce used to set a default value of the homepage as the Redirect URI.  With SSR enabled, this results in the user seeing the homepage for a brief moment before Composable Commerce routes back to the page where the user initiated the login flow.  This is undesirable since the homepage could be confusing to see when the user expects a different page, such as checkout or PDP.  Additionally, this slows the storefront down by requesting the homepage media assets that will then be discarded.  A dedicated page allows us to better control the UX when returning from login.  The default implementation simply uses the Spinner Component, so the page that is rendered is lightweight and appears as a loading page.

To better support a dedicated OAuth callback page, AuthConfigInitializer now comprehensively manages initializing the redirect URI.  The OAuth 2.1 spec defines the Redirect URI as an absolute URL.  The auto-configuration now provides more convenience to meet this requirement.  Previously, relative values would be used as-is, which could cause issues with the OAuth2.1 spec.  The new default behavior of AuthConfigInitializer will initialize empty or relative values to include the current page origin. The base site will be added as the first path segment when enabled, and if the statically-configured URI was relative, then it will be appended as the page path.  Absolute values will be considered the desired URL base, and the base site will be added when enabled.

For example, assuming an origin of "https://storefront.com", base site of "electronics-spa", and adding base site to redirect URI is enabled:
- An undefined value will be initialized to "https://storefront.com/electronics-spa/oauth-callback".
- The value "" (empty string) will be initialized to "https://storefront.com/electronics-spa/".  
- The relative value "/my-login-return" will be initialized to "https://storefront.com/electronics-spa/my-login-return".  
- The absolute value "https://storefront.com/shop" will be initialized to "https://storefront.com/shop/electronics-spa"

## Enabling OAuth Callback Page

Composable Commerce provides support out-of-the-box for a dedicated callback page.  To enable, set the following feature toggles to `true` in the `spartacus-features.module.ts` file:

- `authorizationCodeFlowByDefault`
- `asyncAuthConfigInitializer`
- `oauthCallbackPage`


**Note:** The `$contentCV` variable that is used throughout the following ImpEx examples, and which stores information about the content catalog, is defined as follows:

```text
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]
```

### Update OAuth Client Credentials

The new path for the oauth callback page needs to be set as an allowed Redirect URI in OAuthClientDetails.  This can be done through Backoffice > System > OAuth > OAuth Clients, and selecting the relevant entry.  Add the new Redirect URI to the multi-value field "OAuth registered redirect URI".  The URL pattern is "https:/<storefront_host>/<base_site>/oauth-callback" and, if you are not using the base site in the URL, you may omit that path segment.

You may also use Impex to update or add the client credentials.  In this example, we are using client IDs with a base site suffix.  We have applied the appropriate Redirect URI according to the base site.
```text
# Public oAuth client credential.
#  - Base site suffixed client IDs are for when URL context parameter is needed to determine base site
INSERT_UPDATE OAuthClientDetails; clientId[unique=true]                     ;public ;authorities ;scope ;authorizedGrantTypes             ;registeredRedirectUri                                ;loginPageUri
                                ; mobile_android_public_electronics-spa     ;true   ;ROLE_CLIENT ;basic ;authorization_code,refresh_token ;http://localhost:4200/electronics-spa/oauth-callback ;http://localhost:4200/electronics-spa/login
                                ; mobile_android_public_powertools-spa      ;true   ;ROLE_CLIENT ;basic ;authorization_code,refresh_token ;http://localhost:4200/powertools-spa/oauth-callback  ;http://localhost:4200/powertools-spa/login
                                ; mobile_android_public_apparel-uk-spa      ;true   ;ROLE_CLIENT ;basic ;authorization_code,refresh_token ;http://localhost:4200/apparel-uk-spa/oauth-callback  ;http://localhost:4200/apparel-uk-spa/login
```

### CMS Page
The oauth callback page is CMS-driven.  It consists of a content page with path `/oauth-callback` containing a single CMS component:
- OAuthCallbackComponent

The path `/oauth-callback` uses the routing guard `OAuthCallbackGuard` which is designed to handle direct visits to the page.  The new component type `OAuthCallbackComponent` has a default mapping to the `SpinnerComponent` in Composable Commerce, but you may remap the component type to a custom component for customizations.

If you are using the Spartacus Sample Data Extension, the OAuth Callback Page is already included. However, if you decide not to use the spartacussampledata extension, you can add the page, slot, and flex component through ImpEx.


### Adding CMS OAuth Callback Page manually

This section describes how to add the page, content slots, and flex components to the CMS using ImpEx.

```text
###### Create OAuth Callback Page ######
# Create page entry
INSERT_UPDATE ContentPage        ;$contentCV[unique=true] ;uid[unique=true]             ;name           ;masterTemplate(uid,$contentCV) ;label           ;defaultPage[default='true'] ;approvalStatus(code)[default='approved'] ;homepage[default='false']
                                 ;                        ;oauthCallback                ;Login Callback ;LoginPageTemplate              ;/oauth-callback

# Create a content slot with component(s)
INSERT_UPDATE ContentSlot        ;$contentCV[unique=true] ;uid[unique=true]               ;name                                     ;active ;cmsComponents(&componentRef)
                                 ;                        ;LeftContentSlot-oauthCallback  ;Left Content Slot for OAuth Callback     ;true   ;OAuthCallbackComponent

# Assign the content slot to the page entry
INSERT_UPDATE ContentSlotForPage ;$contentCV[unique=true] ;uid[unique=true]               ;position[unique=true] ;page(uid,$contentCV)[unique=true] ;contentSlot(uid,$contentCV)[unique=true]
                                 ;                        ;LeftContentSlot-oauthCallback  ;LeftContentSlot       ;oauthCallback                     ;LeftContentSlot-oauthCallback

# Create component
INSERT_UPDATE CMSFlexComponent   ;$contentCV[unique=true] ;uid[unique=true]             ;name                       ;flexType                 ;&componentRef
                                 ;                        ;OAuthCallbackComponent       ;OAuth Callback Component   ;OAuthCallbackComponent   ;OAuthCallbackComponent

# (Optional) Make the page breadcrumb slot empty
INSERT_UPDATE ContentSlot        ;$contentCV[unique=true] ;uid[unique=true]               ;name                                     ;active ;cmsComponents(&componentRef)
                                 ;                        ;BottomHeaderSlot-oauthCallback ;BottomHeaderSlot Slot for OAuth Callback ;true   ;
INSERT_UPDATE ContentSlotForPage ;$contentCV[unique=true] ;uid[unique=true]               ;position[unique=true] ;page(uid,$contentCV)[unique=true] ;contentSlot(uid,$contentCV)[unique=true]
                                 ;                        ;BottomHeaderSlot-oauthCallback ;BottomHeaderSlot      ;oauthCallback                     ;BottomHeaderSlot-oauthCallback
```

## Customizing the OAuth Callback Page

### Custom page path

It is possible to change the default path for the callback page.  It requires adjusting the path for oAuthCallback page in the CMS, then setting the new path in the Composable Commerce config.

The path can be modified in CMS using Backoffice > WCMS > Page.  Select the "oAuthCallback" page and edit the "Page Label" field with the new path.

Here is an example IMPEX to change the path:
```impex
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


### Custom component or guards
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



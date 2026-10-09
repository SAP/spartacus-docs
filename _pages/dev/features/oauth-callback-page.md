---
title: OAuth Callback Page
feature:
- name: OAuth Callback Page
  spa_version: 221121.19.0
  cx_version: 2211-jdk21.1
---

Spartacus 221121.20 introduces default support for a dedicated OAuth callback page. This feature provides an improved UX flow for the Authorization Code Flow. As part of the Authorization Code Flow, when a user's credentials are submitted to the Authorization Server, the browser is redirected back to the storefront, and specifically to the  redirect URI sent in the initial `/authorize` call. Before version 221121.20, Spartacus set the default value for the redirect URI to the Homepage. With server-side rendering (SSR) enabled, this would result in the user seeing the Homepage for a brief moment before being routed back to the page where they started the login flow from. This is undesirable because the Homepage could be confusing to see when the user expects a different page, such as the checkout or a Product Details Page. Additionally, this slows the storefront down by requesting the Homepage media assets that will then be discarded. A dedicated page allows you to better control the experience when a user is returning from the login. The default implementation uses the spinner component, so the page that is rendered is lightweight and appears as a loading page.

To better support a dedicated OAuth callback page, the `AuthConfigInitializer` now comprehensively manages initializing the redirect URI. The OAuth 2.1 spec defines the redirect URI as an absolute URL. The auto-configuration provides more convenience to meet this requirement. Previously, relative values would be used "as-is", which could cause issues with the OAuth2.1 spec. The new default behavior of the `AuthConfigInitializer` initializes empty or relative values to include the current page origin. The base site is added as the first path segment when enabled, and if the statically-configured URI is relative, then it is appended as the page path. Absolute values are considered the desired URL base, and the base site is added when enabled.

For example, assuming an origin of `https://storefront.com`, a base site of `electronics-spa`, and with the `baseSiteSuffix` option enabled, the `redirectUri` is calculated as follows:

- An undefined value is initialized to `https://storefront.com/electronics-spa/oauth-callback`.
- The value `""` (an empty string) is initialized to `https://storefront.com/electronics-spa/`.
- The relative value `/my-login-return` is initialized to `https://storefront.com/electronics-spa/my-login-return`.
- The absolute value `https://storefront.com/shop` is initialized to `https://storefront.com/shop/electronics-spa`

## Enabling the OAuth Callback Page

If you are installing Spartacus 221121.20 or later, support for a dedicated callback page is provided out-of-the-box. If you are upgrading to Spartacus 221121.20 or later, you need to enable the feature by setting the following feature toggles to `true` in the `spartacus-features.module.ts` file:

- `authorizationCodeFlowByDefault`
- `asyncAuthConfigInitializer`
- `oauthCallbackPage`

If you are upgrading to Spartacus 221121.20 or later, or you are installing a new instance of Spartacus 221121.20 or later but you are not using the [Spartacus Sample Data Extension](link), it is also necessary to add the required CMS components and data, as described in the following sections.

**Note:** The `$contentCV` variable that is used throughout the following ImpEx examples, and which stores information about the content catalog, is defined as follows:

```text
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]
```

### Update OAuth Client Credentials

The new path for the OAuth callback page needs to be set as an allowed redirect URI in `OAuthClientDetails`. This can be done through **Backoffice > System > OAuth > OAuth Clients**, and selecting the relevant entry. Add the new redirect URI to the multi-value field **OAuth registered redirect URI**. The URL pattern is `https:/<storefront_host>/<base_site>/oauth-callback`, and if you are not using the base site in the URL, you can omit the path segment.

You can also use ImpEx to update or add the client credentials. The following example uses client IDs with a base site suffix, and the appropriate redirect URI has been applied, according to the base site.

```text
# Public oAuth client credential.
#  - Base site suffixed client IDs are for when URL context parameter is needed to determine base site
INSERT_UPDATE OAuthClientDetails; clientId[unique=true]                     ;public ;authorities ;scope ;authorizedGrantTypes             ;registeredRedirectUri                                ;loginPageUri
                                ; mobile_android_public_electronics-spa     ;true   ;ROLE_CLIENT ;basic ;authorization_code,refresh_token ;http://localhost:4200/electronics-spa/oauth-callback ;http://localhost:4200/electronics-spa/login
                                ; mobile_android_public_powertools-spa      ;true   ;ROLE_CLIENT ;basic ;authorization_code,refresh_token ;http://localhost:4200/powertools-spa/oauth-callback  ;http://localhost:4200/powertools-spa/login
                                ; mobile_android_public_apparel-uk-spa      ;true   ;ROLE_CLIENT ;basic ;authorization_code,refresh_token ;http://localhost:4200/apparel-uk-spa/oauth-callback  ;http://localhost:4200/apparel-uk-spa/login
```

### CMS Page

The OAuth callback page is CMS-driven. It consists of a content page with an `/oauth-callback` path that contains a single `OAuthCallbackComponent` CMS component.

The `/oauth-callback` path uses the `OAuthCallbackGuard` routing guard, which is designed to handle direct visits to the page. The new `OAuthCallbackComponent` component type has a default mapping to the `SpinnerComponent` in Spartacus, but you can remap the component type to a custom component for adding your own customizations.

### Adding the CMS OAuth Callback Page Manually

If you are installing a new instance of Spartacus 221121.20 or later, and you are using the [Spartacus Sample Data Extension](link), the OAuth Callback Page is already included. However, if you decide not to use the spartacussampledata extension, or you are upgrading your storefront app from an earlier version, you can add the page, slot, and flex component through ImpEx.

Import the following ImpEx to add the page, content slots, and flex components of the OAuth callback page to the CMS:

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

### Custom Page Path

To change the default path for the callback page, you adjust the path for the `oAuthCallback` page in the CMS, and set the new path in the Spartacus config.

The path can be modified in CMS using **Backoffice > WCMS > Page**. Select the **oAuthCallback** page and edit the **Page Label**" field with the new path.

You can also use ImpEx to change the path, as shown in the following example:

```text
UPDATE ContentPage ;$contentCV[unique=true] ;uid[unique=true] ;label
                   ;                        ;oAuthCallback    ;/my-oauth-callback
```

In `spartacus-configuration.module.ts`, you must also update the `oAuthCallback` route and the `redirectUri` config with the new path, as shown in the following example:

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

### Custom Component or Guards

The default component is minimal and you may wish to customize it. This can be done with a CMS config to define new components and guards.

In the Spartacus configuration, preferably in an eagerly-loaded module, modify the `cmsComponents` mapping for `OAuthCallbackComponent` using a config provider.

In the following example, the component is changed and an extra guard is added:

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

Note that when you provide a new array value for `guards`, the entire array is replaced with the provided value. If you wish to only add a guard, you need to re-declare all of the other elements in the array, as shown in the example above.

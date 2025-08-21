---
title: Authentication
feature:
- name: Authentication
  spa_version: 2211.44.0
  cx_version: 2211-jdk21.0
---

OAuth 2.0 is the default authorization protocol in SAP Commerce Cloud that allows third-party applications to access user data without exposing login credentials. It enhances security and user experience by enabling seamless integration between different services. Spartacus provides out-of-the-box support for OAuth 2.0 authentication methods that involve redirects to an authorization server, primarily the authorization code grant flow and implicit grant flow (*do these need more context/explanation?). The default authentication configuration is authorization code grant, which is the recommended OAuth flow.

In order for Spartacus to work with the authorization server, set the following feature toggles to `true` in your `spartacus-features.module.ts`:
- `authorizationCodeFlowByDefault`: Sets the default authentication configuration to authorization code grant.
- `incrementProcessesCountForMergeCart`: Enables the merge cart operation to set carts as unstable by incrementing the cart process count.
- `dispatchLoginActionOnlyWhenTokenReceived`: (*Verify) Enables dispatching the login action event only upon receiving the token. Login action events are emitted on app initialization. Spartacus recommends replacing the `ActionsSubject` token with the `LOGIN_EVENTS` token in the application for detecting login events.
- `cdsLoginEventsToken`: Enables the `LOGIN_EVENTS` token to inject an observable that, on subscription, replays any login events recorded during application startup.

The following configuration options in your `spartacus-features.module.ts` allow for more granular control of authentication behavior: 
- `AuthConfig.authentication.sendAuthHeaderOnRevoke`: Enables or disables sending the current token in the "Authorization" header.
- `AuthConfig.authentication.useClientTokens`: Enables or disables the use of client tokens being sent with otherwise public APIs. This was achieved in OCC Adapters by adding a special header using the `USE_CLIENT_TOKEN` constant. An interceptor reads this header value and replaces it with an "Authorization" header with a client token as the value. Note that the `USE_CLIENT_TOKEN` header will still be removed from requests even when `useClientTokens` is set to `false`.

# Feature Toggles

## `authorizationCodeFlowByDefault`

The `authorizationCodeFlowByDefault` feature toggle changes the default authentication configuration to use authorization code grant. It also controls the following behaviors:

- Enables the behavior of the `incrementProcessesCountForMergeCart` feature toggle, which this feature toggle depends on.
- Redirects the user to the homepage, instead of the login page, after they register.
- Changes the internal navigation to `/login` and its child routes from using a static path to using CMS page names. For example, it changes `RoutingService.go(['/login'])` to `RoutingService.go({cxRoute: 'login'})` or `RoutingService.go(['/login/register'])` to `RoutingService.go({cxRoute: 'register'})`. Spartacus recommends using named routes to programmatically initiate a navigation. 
- Sets a flag in `localstorage` to indicate the login page should show/ offer guest checkout.
- Enables the custom login page feature code on Spartacus login components.
- Enables a specific Assisted Service Module (ASM) client ID to override the one specified in your Spartacus configuration (for example, the default `mobile_android_public` client ID). This only occurs when the ASM is activated. 
- Moves the `login` CMS page route from the `/login` static path to `/sign-in`.
- Adds the `loginForm` CMS page route with the static path `/login`. This is required to accommodate the custom login page.

## `incrementProcessesCountForMergeCart`

The `incrementProcessesCountForMergeCart` feature toggle sets the active cart to "unstable" during the merge cart operation. With this feature toggle enabled, consumers using the `getActive()` method do not receive the cart until the active cart has been loaded and the merge operation is complete. This is required for OAuth flows that redirect away from Spartacus because the cart state needs to be re-loaded and merged upon return. Prior to the introduction of this feature toggle, any consumer of active cart would receive an empty cart immediately because the merge operation did not mark the cart as "unstable".

## `dispatchLoginActionOnlyWhenTokenReceived`

(*More context?) The `dispatchLoginActionOnlyWhenTokenReceived` feature toggle enables logic that is needed for OAuth 2.0 flows that redirect. It prevents the `AuthActions.Login` event from being repeated on page refresh.

## `cdsLoginEventsToken`

(*More context?) The `cdsLoginEventsToken` feature toggle enables logic to preserve the login event from application bootstrapping so that late consumers that are created after application bootstrapping is able to respond to the login event. The prior behavior relied on login happening after application bootstrapping, so there was no need to replay the event for consumers.


# Custom Login Page

(*Accurate? Taken from CCV2 docs.) Configure custom login pages for your client applications in the authorization code flow to enable personalized user experiences, enhance security, and boost client satisfaction. For more information, see https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/aa417173fe4a4ba5a473c93eb730a417/ca1176a372b242a6abd75a39fe803eea.html.

To use this feature, you must enable the following feature toggles in your `spartacus-features.module.ts`:
- `authorizationCodeFlowByDefault`
- `incrementProcessesCountForMergeCart`
- `dispatchLoginActionOnlyWhenTokenReceived`
- `cdsLoginEventsToken`

The `authorizationCodeFlowByDefault` toggle applies the default configuration, which includes the configuration object `AuthConfig.authentication.customLoginPage`. To disable this feature and use the authorization server login page, apply the following configuration:
```typescript
provideConfig(<AuthConfig>{
  authentication: {
    customLoginPage: undefined,
  }
})
```

# Authenticating with Legacy SAP Commerce Cloud Versions

(*Accurate? Taken from CCV2 docs:) In the traditional client-server authentication model, the client requests an access-restricted resource (in other words, protected resource) on the server by authenticating with the server using the resource owner's credentials. In order to provide third-party applications access to the restricted resources, the resource owner shares its credentials with the third-party application. Spartacus supports the use of resource owner password credentials that is used by 2211.XX.X versions of SAP Commerce Cloud until that version branch reaches end of life. If you want to enable resource owner password credentials authentication model in Spartacus, set the following feature toggles to `false` in your `spartacus-features.module.ts`:

- `authorizationCodeFlowByDefault`
- `incrementProcessesCountForMergeCart`
- `dispatchLoginActionOnlyWhenTokenReceived`
- `cdsLoginEventsToken`


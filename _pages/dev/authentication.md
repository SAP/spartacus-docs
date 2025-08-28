---
title: Authentication
feature:
- name: Authentication
  spa_version: 221121.1.0
  cx_version: 2211-jdk21.0
---

OAuth 2.0 is the default authorization protocol in SAP Commerce Cloud that allows third-party applications to access user data without exposing login credentials. OAuth 2.0 enhances security and enhances the user experience by enabling seamless integration between different services. Spartacus provides out-of-the-box support for OAuth 2.0 authentication methods that involve redirects to an authorization server, and primarily supports the authorization code grant flow and the implicit grant flow. The default authentication configuration is authorization code grant, which is the recommended OAuth flow.

For Spartacus to work with an authorization server, set the following feature toggles to `true` in the `spartacus-features.module.ts` file:

- `authorizationCodeFlowByDefault`
- `incrementProcessesCountForMergeCart`
- `dispatchLoginActionOnlyWhenTokenReceived`
- `cdsLoginEventsToken`

These toggles are described in more detail in [Authentication Feature Toggles](#authentication-feature-toggles), below.

The following configuration options in `spartacus-features.module.ts` allow for more granular control of authentication behavior:

- `AuthConfig.authentication.sendAuthHeaderOnRevoke`: Enables or disables sending the current token in the "Authorization" header.
- `AuthConfig.authentication.useClientTokens`: Enables or disables the use of client tokens being sent with otherwise public APIs. This was achieved in the OCC adapter layer by adding a special header using the `USE_CLIENT_TOKEN` constant. An interceptor reads this header value and replaces it with an "Authorization" header with a client token as the value. Note that the `USE_CLIENT_TOKEN` header is still removed from requests even when `useClientTokens` is set to `false`.

## Authentication Feature Toggles

The following sections provide details about the feature toggles that need to be enabled for Spartacus to work with an authorization server.

### authorizationCodeFlowByDefault

When enabled, the `authorizationCodeFlowByDefault` feature toggle sets the default authentication configuration to authorization code grant. It also does the following:

- Enables the behavior of the `incrementProcessesCountForMergeCart` feature toggle, which this feature toggle depends on.
- Redirects users to the homepage, instead of the login page, after they register.
- Changes the handling of internal navigation for `/login` and its child routes. The routing is changed from using a static path to using CMS page names instead. For example the `RoutingService.go(['/login'])` route is changed to `RoutingService.go({cxRoute: 'login'})`. Another example is the `RoutingService.go(['/login/register'])` route, which is changed to `RoutingService.go({cxRoute: 'register'})`. It is recommended that you use named routes to programmatically initiate a navigation.
- Sets a flag in `localstorage` to indicate the login page should display the option for guest checkout to users.
- Enables the custom login page feature code in Spartacus login components.
- Enables a specific Assisted Service Module (ASM) client ID to override the one specified in your Spartacus configuration (for example, the default `mobile_android_public` client ID). This only occurs when ASM is activated.
- Moves the `login` CMS page route from the `/login` static path to `/sign-in`.
- Adds the `loginForm` CMS page route with the static path `/login`. This is required to accommodate the custom login page.

### incrementProcessesCountForMergeCart

The `incrementProcessesCountForMergeCart` feature toggle enables the merge cart operation to set the active cart as unstable by incrementing the cart process count. When this feature toggle is enabled, consumers using the `getActive()` method do not receive the cart until the active cart has been loaded and the merge operation is complete. This is required for OAuth flows that redirect away from Spartacus because the cart state needs to be re-loaded and merged upon return. Prior to the introduction of this feature toggle, any consumer of the active cart would receive an empty cart immediately because the merge operation did not mark the cart as "unstable".

### dispatchLoginActionOnlyWhenTokenReceived

When enabled, the `dispatchLoginActionOnlyWhenTokenReceived` feature toggle limits the `AuthActions.Login` action to dispatching only upon receiving the token from the Authorization Server at the beginning of an authenticated session. It does this by enabling logic that is needed for OAuth 2.0 flows that redirect. It prevents the `AuthActions.Login` event from being repeated on page refresh.

### cdsLoginEventsToken

When enabled, the `cdsLoginEventsToken` feature toggle allows the `LOGIN_EVENTS` token to inject an observable that, on subscription, replays any login events recorded during application startup.  Login action events are now emitted during app initialization. This logic preserves the login event from application bootstrapping so that late consumers that are created after application bootstrapping are able to respond to the login event. The prior behavior relied on login happening after application bootstrapping, so there was no need to replay the event for consumers.

It is recommended that you replace the `ActionsSubject` token with the `LOGIN_EVENTS` token in the application for detecting login events.

## Custom Login Page

To provide a personalized user experience that boosts client satisfaction while also enhancing security, you can use Spartacus to provide the custom login page during the authorization code flow.

**Note:** This feature requires SAP Commerce Cloud version `2211-jdk21.1` or newer. It is not supported by 2211.XX versions of SAP Commerce Cloud that still supports JDK 17, such as version 2211.44.

To use this feature, set the following feature toggles to `true` in the `spartacus-features.module.ts` file:

- `authorizationCodeFlowByDefault`
- `incrementProcessesCountForMergeCart`
- `dispatchLoginActionOnlyWhenTokenReceived`
- `cdsLoginEventsToken`

The `authorizationCodeFlowByDefault` toggle applies the default configuration, which includes the configuration object `AuthConfig.authentication.customLoginPage`.

To disable this feature and use the login page of the authorization server instead, provide the following configuration:

```typescript
provideConfig(<AuthConfig>{
  authentication: {
    customLoginPage: undefined,
  }
})
```

For more information, see [Custom Login Page](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/aa417173fe4a4ba5a473c93eb730a417/ca1176a372b242a6abd75a39fe803eea.html).

## Authenticating with Legacy SAP Commerce Cloud Versions

In the traditional client-server authentication model, the client requests an access-restricted resource on the server (in other words, a protected resource) by authenticating with the server using the resource owner's credentials. In order to allow third-party applications to access restricted resources, the resource owner shares its credentials with the third-party applications. Spartacus supports the use of resource owner password credentials, which are used by 2211.XX versions of SAP Commerce Cloud (such as 2211.44). This support remains until the 2211.XX version branch reaches end of life, in Q3 2026.

If you are working with a 2211.XX version of SAP Commerce Cloud (as opposed to a 2211-jdk21.x version), and you want to enable the resource owner password credentials authentication model in Spartacus, set the following feature toggles to `false` in the `spartacus-features.module.ts` file:

- `authorizationCodeFlowByDefault`
- `incrementProcessesCountForMergeCart`
- `dispatchLoginActionOnlyWhenTokenReceived`
- `cdsLoginEventsToken`

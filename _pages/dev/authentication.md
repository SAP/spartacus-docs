---
title: Authentication
feature:
- name: Authentication
  spa_version: 2211.44.0
  cx_version: 2211-jdk21.0
---

Spartacus now provides enhanced support out-of-the-box for oAuth 2.0 authentication methods that involve redirects to an authorization server, primarily Authorization Code Grant flow and Implicit Grant flow.  Additionally, we will be changing the default authentication configuration to be set up for the recommended oAuth flow, Authorization Code Grant.

To accommodate the user flow of leaving Spartacus to sign in with the Authorization Server, then returning to Spartacus, there have been a few behavior changes that have been introduced.
- Setting default authentication configuration to Authorization Code Grant
	- see Feature Flag `authorizationCodeFlowByDefault`
- Merge cart now sets carts as unstable by incrementing the cart process count.
	- see Feature Flag `incrementProcessesCountForMergeCart`
- Login action events are now emitted on app initialization, requiring a change in how the rest of the application listens for login events.  
	- It is recommended to replace `ActionsSubject` with the new `LOGIN_EVENTS` token in the application for detecting login events.  The `LOGIN_EVENTS` token will inject an observable that will replay, on subscription, any login events recorded during application startup.
	- see Feature Flag `dispatchLoginActionOnlyWhenTokenReceived`
	- see Feature Flag `cdsLoginEventsToken`

New configuration options have been added to the Authorization configuration.  These allow for more granular control of authentication behavior.

The token revoke endpoint used to be hard-coded to send the current token in the "Authorization" header.  There is now a config option to enable or disable this behavior: `AuthConfig.authentication.sendAuthHeaderOnRevoke`

Some OCC APIs used to require a client token to be sent with otherwise public APIs.  This was achieved in OCC Adapters by adding a special header using the `USE_CLIENT_TOKEN` constant.  An interceptor would read this header value and replace it with an "Authorization" header with a client token as the value.  This behavior can now be enabled or disabled using the configuration value `AuthConfig.authentication.useClientTokens`.  Note that the `USE_CLIENT_TOKEN` header will still be removed from requests even when `useClientTokens` is set to `false`.


***

# Feature Flags

## authorizationCodeFlowByDefault

The authorizationCodeFlowByDefault flag controls several behaviors:

- Primarily, it changes the default authentication configuration to use Authorization Code Grant.
- It will enable the behavior of incrementProcessesCountForMergeCart, which this flag depends on.
- After a user registers, Spartacus will redirect the user to the homepage, instead of the login page.
- Change internal navigation to "/login" and its child routes from using a static path to now use CMS page names
	- i.e. `RoutingService.go(['/login'])` to `RoutingService.go({cxRoute: 'login'})`
	- i.e. `RoutingService.go(['/login/register'])` to `RoutingService.go({cxRoute: 'register'})`
	- Named routes are the recommended way to programmatically initiate a navigation, the string static path were legacy artifacts
- Set a flag in localstorage to indicate login should show guest checkout
- Enables Custom Login Page feature code on spartacus login components
- Enables ASM client ID when ASM mode is on
- Moves CMS Page Route "login" from the static path "/login" to "/sign-in"
- Adds new CMS Page Route "loginForm" with static path "/login"
	- This change is required to accommodate Custom Login Page


## incrementProcessesCountForMergeCart

This flag will set the active cart as "unstable" during the merge operation.  With this flag enabled, consumers of active cart will not receive the cart until the active cart has been loaded and the merged operation is complete.  This is required for oAuth flows that redirect away from Spartacus because the cart state needs to be re-loaded and merged upon return.  Prior to this flag, any consumer of active cart would receive an empty cart immediately because the merge operation did not mark the cart as "unstable".


## dispatchLoginActionOnlyWhenTokenReceived

This flag enables logic that is needed for oAuth 2.0 flows that redirect.  It prevents the AuthActions.Login event from being repeated on page refresh.

## cdsLoginEventsToken

This flag enables logic to preserve the login event from application bootstrapping so that late consumers that are created after application bootstrapping will be able to respond to the login event.  The prior behavior relied on login happening after application bootstrapping, so there was no need to replay the event for consumers.


***

# Custom Login

A new feature of the CCv2 2211-JDK21.X Authorization server is Custom Login Page.  This feature will allow using Spartacus to render the login form during the oAuth 2.0 Authorization Code Grant login flow.  

To use this feature the following feature flags must be enabled:
- authorizationCodeFlowByDefault
- incrementProcessesCountForMergeCart
- dispatchLoginActionOnlyWhenTokenReceived
- cdsLoginEventsToken

The authorizationCodeFlowByDefault flag will apply the new default configuration, which includes the new configuration object `AuthConfig.authentication.customLoginPage`.



To disable this feature and use the Authorization Server login page, apply the following configuration:
```typescript
provideConfig(<AuthConfig>{
  authentication: {
    customLoginPage: undefined,
  }
})
```

***


# Authenticating with legacy CCv2 versions

We will continue to support the Resource Owner Password Credentials Grant flow that is used by 2211.XX.X versions of Commerce Cloud until that version branch reaches EoL.  The recommended configuration to enable Resource Owner Password Credentials flow is to set the following feature flags to `false`.

- authorizationCodeFlowByDefault
- incrementProcessesCountForMergeCart
- dispatchLoginActionOnlyWhenTokenReceived
- cdsLoginEventsToken


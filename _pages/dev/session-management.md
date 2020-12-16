---
title: Session Management
feature:
- name: Session Management
  spa_version: 3.0
  cx_version: 1905
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Spartacus 3.0 introduces a new way to manage user sessions, handle tokens, and perform authorizations. The following sections are intended to help you understand how session management works under the hood, how can you extend the underlying mechanism, and how you can interact with the auth module from outside of Spartacus.

## Client Authentication and User Authentication

From the beginning, Spartacus has included both client authentication and user authentication. Although this is not typical for web applications, it is necessary for Spartacus to work with the OCC API.

There are a number of endpoints that work on behalf of logged-out users, such as registering, resetting a password, placing an order as a guest, and verifying an address. These endpoints require an access token to be sent with the request, and this access token needs to be retrieved by following the Client Credentials Flow that is defined by the OAuth specification. This is the client authentication.

Meanwhile, user authentication is used for requests that are sent on behalf of specific user resources. For example, if you want to update your profile, you need to be logged in. When you log in, the server confirms your credentials and returns an application access token. This token is then used for all requests on your account, such as updating your profile, making cart modifications, and checking out.

Prior to Spartacus 3.0, the code for both client authentication and user authentication was in the `AuthModule`, which included interceptors, services, and methods for facades all mixed together. In Spartacus 3.0, the `AuthModule` still contains client and user authentication, but this is now the result of importing two modules, the `UserAuthModule` and the `ClientAuthModule`. Each module is responsible for one type of authentication.

This change is important because Spartacus is built to support OCC by default, but Spartacus is not limited to using OCC. The OCC API requires client credentials for some of the requests it receives, but this is not common for other APIs, and accordingly, the client and user authentication has been separated to make it easier to work with other APIs. For example, if you are using a different API that does not need client authentication, instead of using the `AuthModule`, you can import only the `UserAuthModule` and reduce the size of your final bundle by not including the `ClientAuthModule`.

## User Authentication

This section takes a detailed look at the `UserAuthModule`, where most of the changes to session management were made.

The following diagram shows how the `UserAuthModule` works under the hood:

![UserAuthModule]({{ site.baseurl }}/assets/images/session-management/all.svg)

The `UserAuthModule` module is responsible for the following:

- performing authentication flow
- storing tokens and user identifiers
- adding access tokens for user calls
- recovering from API auth errors (for example, refreshing tokens when access tokens expire)
- persisting the tokens in browser storage

Each of these steps is described in more detail in the following sections.

### Authentication Flow

Authenticating users is the main responsibility of this module. Previous versions of Spartacus used custom code to provide support for the Resource Owner Password Flow, but OAuth specifies additional flows that can be used in web applications. To support these additional flows, Spartacus 3.0 no longer uses its custom code for the Resource Owner Password Flow, and instead relies on the third party `angular-oauth2-oidc` library that is built for this purpose, and is also well-tested and certified.

The services that are involved in authenticating users are highlighted in the following diagram:

![Authentication flow]({{ site.baseurl }}/assets/images/session-management/auth.svg)

Authentication starts from the `AuthService` facade, where you initialize the process by calling one of the following login methods:

- `loginWithCredentials` for the Resource Owner Password Flow
- `loginWithRedirect` for the Implicit Flow or the Authorization Code Flow

The login method then interacts with the `angular-oauth2-oidc` library. However, this interaction always goes through the `OAuthLibWrapperService`, which is a layer for isolating external libraries from Spartacus code.

**Note:** If you want to access methods from a library that Spartacus does not expose, you should extend the `OAuthLibWrapperService` class.

The `OAuthLibWrapperService` class is also responsible for configuring the library. It uses the `AuthConfigService` to access the `AuthConfig` configuration provided in the application.

It is recommended that you always use the `AuthConfigService` if you need to read anything from the `AuthConfig`. This service is able to provide sensible defaults when some parts of the configuration are missing, and it gives you a few utilities out of the box, including one that detects OAuth flow based on your configuration.

The `OAuthLibWrapperService` is a relatively thin layer that provides a lot of flexibility with the library, and also provides the `authentication.OAuthLibConfig` configuration option, which allows you to pass any configuration option to the library. Client and endpoint configurations are available in the top-level `authentication` configuration.

You can learn more about advanced configuration of the authentication flow by looking at the `angular-oauth2-oidc` library source code, as well as the [angular-oauth2-oidc documentation](https://github.com/manfredsteyer/angular-oauth2-oidc).

### Storing Tokens and User Identifiers

After authentication, the tokens received from the library methods need to be stored somewhere. Previously, these tokens were kept in NgRx Store, but in Spartacus 3.0, there are dedicated services to keep the data. The library requires a storage mechanism with an API similar to `localStorage` or `sessionStorage`, and that was the main reason to switch from NgRx to services with a stream for keeping the data.

![Storing auth data]({{ site.baseurl }}/assets/images/session-management/store.svg)

For authentication, it is normally sufficient to store only tokens and their metadata (such as expiration time and scope). However, with OCC, there is also the tightly-coupled user ID that needs to be set after login or logout, as well as being required for user emulation when working with the Assisted Service Module (ASM). Prior to Spartacus 3.0, the user ID was kept in the same place as the tokens in NgRx, and because of that previous association, the user ID remains in the `UserAuthModule`. However, the tokens have now been separated from this module. Tokens and their metadata are now stored with the `AuthStorageService`, while user IDs have their own, dedicated `UserIdService`.

The usual sequence for the authentication data flow is the following:

- a user invokes login
- the authentication library perform the OAuth flow and receives tokens
- the authentication library directly sets the tokens in the `AuthStorageService` through the `setItem` and `removeItem` methods
- the `AuthService` is informed about the successful login
- the `AuthService` sets the user ID in the `UserIdService` for the logged-in user

The `UserIdService` is part of a facade, because almost all services that interact with the OCC API require it. Previously, the user ID was exposed in the `AuthService.getOccUserId`. As a result, in Spartacus 3.0 it has been kept in the same facade, but in a different service and in a different method.

### Access Tokens in API Calls and Error Recovery

After logging in a user, and storing their access token and user ID, it is then possible to request some of the user's resources. To do so, it is necessary to pass an access token as a header in the request. In Spartacus, this is achieved with HTTP interceptors, as shown in the following diagram:

![Auth interceptors]({{ site.baseurl }}/assets/images/session-management/interceptors.svg)

To enrich a request with an access token, you do not need to mark the request in any way. The `AuthInterceptor` recognizes the request to the API based on the URL. If the request does not have the `Authorization` header, and does not match the API path, the interceptor adds the header to the request. To make it easier to extend the interceptor, Spartacus has its own `AuthHttpHeaderService` helper service. In most cases, extending this one service should be enough.

Apart from injecting the token, this interceptor is also responsible for handling errors that are related to authorization. In such cases, it tries to recover first and retry the request, and if that is not possible, it completes the logout process and redirects the user to the login page. When a request fails because the access token has expired, the interceptor uses the refresh token (if it exists) to request a new access token, and then retries the failed request with the new token.

A second `TokenRevocationInterceptor` interceptor has a very specific role. For calls to revoke tokens on user logout, this interceptor adds an `Authorization` header. With a different OAuth server, you might not need to provide this header, and you can drop this interceptor from your own `UserAuthModule`.

### Persisting Authentication Data in the Browser Storage

After you log in, and your token has been stored and used for API calls, you refresh the page and suddenly you are no longer logged in. To avoid this problem, the `AuthStatePersistenceService` synchronizes the authentication data (such as tokens and user ID) in the browser storage, as shown in the following diagram.

![Storing auth data in browser]({{ site.baseurl }}/assets/images/session-management/storage.svg)

The `AuthStatePersistenceService` uses the `StatePersistenceService` to synchronize data to and from the browser storage. The user ID from the `UserIdService`, the tokens from the `AuthStorageService`, and the redirect URL from the `AuthRedirectStorageService` are all synchronized to the `localStorage`. Every time data changes, it is saved in the browser storage, and when the application starts, it is read from the storage into services.

## Assisted Service Module

Since Spartacus version 1.3 we supported feature called ASM, which allows customer support agents to emulate users and help them accomplish their goals. This feature is tightly coupled with `AuthModule` as agents needs to log in with OAuth flow similarly to normal user and manipulate user id. In previous versions some parts of the implementation of this feature was placed in `AuthModule` logic.

One of the goals of session management refactor was to make `AuthModule` not aware of ASM at all. Removing ASM from your application should be as simple as just not including `AsmModule`. No code should be left in different modules. With the new `AuthModule` structure we were able to make ASM feature isolated.

![Asm integration with UserAuthModule]({{ site.baseurl }}/assets/images/session-management/asm.svg)

To integrate ASM with `UserAuthModule` we mainly used the mechanism to provide your own services in place of the default along with inheritance.

We extended `AuthService`, `AuthHttpHeaderService` and `AuthStorageService` and provided them in `AsmModule`.

```ts
{
  provide: AuthStorageService,
  useExisting: AsmAuthStorageService,
},
{
  provide: AuthService,
  useExisting: AsmAuthService,
},
{
  provide: AuthHttpHeaderService,
  useExisting: AsmAuthHttpHeaderService,
},
```

Along with this services we created `CSAgentAuthService` which is responsible for CS agent login/logout process. `AsmAuthStorageService` stores a bit more information than the original `AuthStorageService`. And those information must be persisted in browser as well so we created `AsmStatePersistenceService` to work alongside the `AuthStatePersistenceService`. So part of the data in `AsmAuthStorageService` is initialized by `AuthStatePersistenceService` and the rest by `AsmStatePersistenceService`.

We also had to override `AuthHttpHeaderService`, because we don't only need to add the token to OCC calls, but also for ASM calls (eg. listing users available for emulation). The error handling for auth errors also had to be improved, because we have to handle for agent requests differently than to normal user (eg. logout agent instead of normal user).

`AsmModule` from `@spartacus/core` is a great example of how new `UserAuthModule` can be modified and extended from outside. Most of the patterns use there are the same patterns you should use when extending it on your own (eg. providing services, inheritance, building new services be assembling few existing services).

## Complementary components to `AuthModule`

We focused mainly on the `AuthModule` from the `@spartacus/core` library, but there are few complementary components across the codebase to make auth working as you would expect in web application.

We still rely on `AuthGuard` and `NotAuthGuard` to protect pages that should be only available to logged in users (`AuthGuard`) and to pages only for anonymous users (`NotAuthGuard`). Using them consistently for all pages enables correct redirects after successful login.
`AuthRedirectService` is called from those guards with information about accessed page. Thanks to this once you login, you are redirected to the page you were on (or tried to access) before logging in.

Another established pattern by us is the use of `logout` route as the main mechanism to initialize logout process for the user. `AuthService` exposes method to logout user (`coreLogout`), but the process of logout have some gotchas (especially if you use feature called protected routes). Instead we recommend redirecting to `logout` page every time you want to logout. This flow have you covered with the gotchas (those are mostly redirect issues and staying on page for auth user as not authorized user) and you don't need to worry about them.

## Configuring OpenId

Refactor of `AuthModule` made `KymaModule` broken and impossible to fix, so we removed it. The functionality however can be replicated, by providing proper `authentication` configuration. `KymaModule` was responsible for one thing: fetching JWT token alongside the tokens on user login. It was accomplished by using separate OAuth client and calling login endpoint 2 times with different clients.

This can be done in one login call, by using the OpenID capable client and setting proper response type and scope. Below is the example configuration to get both access token and `id_token` with Resource Owner Password Flow.

```ts
authentication: {
  client_id: 'client4kyma',
  client_secret: 'secret',
  OAuthLibConfig: {
    responseType: 'id_token',
    scope: 'openid',
    customTokenParameters: ['id_token'],
  },
},
```

Then once you complete login you can access id token with `OAuthLibWrapperService.getIdToken` method.

## Configuring Authorization Code Flow or Implicit Flow

Using `angular-oauth2-oidc` library made support of Authorization Code Flow and Implicit Flow possible in Spartacus. These flows are drastically different that Resource Owner Password Flow, because the authentication part happens not in Spartacus, but on OAuth server login page. Spartacus redirects you to this page, you provide login and password there and if the credentials match you are redirected back to Spartacus application with the token (Implicit Flow) or code (Authorization Code Flow) as part of url. Then spartacus grabs the data from url and continue the login process (ask for token in case of Authorization Code flow, set user id, dispatch `Login` action and redirects to previously visited page).

Here is how you can configure it:

```ts
authentication: {
  OAuthLibConfig: {
    responseType: 'token', // 'code` for Authorization code flow
  },
},
```

Apart from this config you might need to update few things for your OAuth client in backoffice (allow implicit flow or authorization code flow, set redirect url of the application).

Once you have it setup then spartacus out of the box will use defined flow. Login route is configured in the way that detects OAuth flow by config (`LoginGuard` and `LoginRouteModule`). When it detects different flow than Resource Owner Password Flow it will save the previous url (to redirect to it after login) and redirect you to OAuth server login page.

Spartacus runs `AuthService.checkOAuthParamsInUrl` with `APP_INITIALIZER` on any route, so you can redirect to any spartacus page from the OAuth server. It doesn't have to be callback page as it's usually done.

**Warning** Default OAuth server provided with Cloud commerce do not have great support for these flows (no way to logout user from external applications, no way to customize login page), so for now we still expect everyone using this OAuth server to continue with Resource Owner Password Flow. However if you use different OAuth server (eg. `Auth0`) you can switch to these flows.

**Warning** ASM login is prepared to only with Resource Owner Password Flow for customer support agents.

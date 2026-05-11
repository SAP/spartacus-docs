---
title: Federated Login
feature:
- name: Federated Login
  spa_version: 221121.11.0
  cx_version: 2211-jdk21.11
---

Federated login is an enhancement to the [custom login page](../authentication.md#enabling-a-custom-login-page-in-spartacus) in Spartacus. Federated login allows you to use a single Spartacus app to provide the login page functionality for multiple different domains.

## Overview

One of the restrictions in using the custom login page feature of SAP Commerce Cloud is that the storefront and authorization server must be on the same domain or site.

The following is an example of incompatible hosting for the custom login page:

| Storefront | OCC API |
| --- | --- |
| brand1.com | api.backend.com |
| brand1.jp | " |
| brand2.com | " |
| brand2.jp | " |

The recommended way to create a valid hosting arrangement is to host the OCC API on the same domain, either through reverse-proxying requests from a path, such as `/api/**`, or from a sub-domain, such as `api.*`. This is required for each storefront domain that is different from the API's domain.

The following is an example of valid hosting for the custom login page:

| Storefront | OCC API (host option) | OCC API (path option) |
| --- | --- | --- |
| brand1.com | api.brand1.com | brand1.com/api/ |
| brand1.jp | api.brand1.jp | brand1.jp/api/ |
| brand2.com | api.brand2.com | brand2.com/api/ |
| brand2.jp | api.brand2.jp | brand2.jp/api/ |

If the recommended approach is not feasible, the federated login feature provides an alternative. Instead of making the API accessible at each individual domain, federated login allows you to use a single new storefront as the login page provider for all of the other storefront domains. This "login storefront" is the only instance that is required to be on the same domain as the authorization server, which reduces the hosting complexity.

The following is an example of valid hosting using federated login:

| Storefront | OCC API |
| --- | --- |
| brand1.com | api.backend.com |
| brand1.jp | " |
| brand2.com | " |
| brand2.jp | " |
| login.backend.com | api.backend.com |

When federated login is implemented, the complete login process is the following:

1. A customer on `brand1.com` clicks the login button.
2. The `brand1.com` site navigates to the authorization server, as required by the OAuth 2.0 Authorization Code grant flow. The storefront adds extra context to the request for use on the "login storefront".
3. The authorization server uses the custom login page setting to redirect the browser to the "login storefront" (for example,  `login.backend.com`), and passes through the context from the initial request.
4. The "login storefront" reads that context and uses it to load the base site and language of the originating site, `brand1.com`. It then displays the login page according to the CMS data from `brand1.com`.
5. The customer enters their user credentials and submits the form.
6. The "login storefront" posts the login form to the authorization server, which validates the credentials and issues a redirect to the `return_uri` specified in the initial request, which is `brand1.com`.
7. The customer is returned to the `brand1.com` storefront, where the storefront requests an access token, and the customer is now authenticated.

## Requirements and Restrictions

The federated login feature has the following requirements and restrictions:

- You must set up a new "login storefront" domain that is on the same domain or site as the OCC APIs.
- A single CMS base site is required for each domain.
- You need to redesign the login page CMS.
  - Link data should only use absolute links. Relative links that appear within the text of a paragraph component, for example will not have the correct base URL.
  - Remove the mini-cart from page structure. Cart data is not transferred  in the context to the login domain.
- You need a list of origins embedded in the Spartacus data.

## Configuring Federated Login in Spartacus

To configure the federated login feature in Spartacus, add a new configuration provider to `src/app/spartacus/spartacus-configuration.module.ts`, as shown in the following example:

```typescript
import { type FederatedLoginConfig } from '@spartacus/core';

// ...

    provideConfig(<FederatedLoginConfig>{
      federatedLogin: {
        enabled: true,
        loginHosts: ['login.backend.com'],
        originMap: {
          sf1: 'https://brand1.com',
          sf2: 'https://brand1.jp',
          sf3: 'https://brand2.com',
          sf4: 'https://brand2.jp',
        },
      },
    }),
```

The `loginHosts` array lists the hosts where Spartacus should act as a dedicated login portal. This should be configured with the host(s) of the "login storefront".

The `originsMap` is a map of key and origin pairs that correspond to the storefronts for which the "login storefront" acts as a login page. The keys can be any URL-safe ASCII string, and are used in the context parameter value when building the authorize URL. The values are origins, which means they require protocol and port when using non-standard port numbers.

## Configuring Federated Login in SAP Commerce Cloud

The following procedure describes how to configure SAP Commerce Cloud to use federated login.

1. Add the context parameter to the list of allowed parameters in the authorize request.

   The value of the `authserver.authorizationCode.allowed.params` property needs to be extended with the context parameter name that is configured in Spartacus. The default value is `ctx`.

   The following is an example of the default value of the allowed parameters, with `ctx` added:

   ```text
   authserver.authorizationCode.allowed.params=client_id,client_secret,response_type,redirect_uri,scope,state,code_challenge,code_challenge_method,nonce,continue,_csrf,ctx
   ```

2. Add the host of the login page(s) to the list of allowed custom login page hosts.

   This is required for later configuration of the `OAuthClientDetails`.

   The allowed custom login page hosts are defined in the `authserver.oauthclientdetails.loginpageuri.allowed.hosts` property.

3. Add the origin for both the "login storefront" and all the other storefronts to `corsfilter.authorizationserver.allowedOrigins`.

   The following is an example:

   ```text
   corsfilter.authorizationserver.allowedOrigins=https://login.backend.com https://brand1.com https://brand1.jp https://brand2.com https://brand2.jp
   ```

4. In Backoffice, or by using ImpEx, update the `OAuthClientDetails` for the storefronts that you want to use with federated login. Set the custom login page to the login host with the path `/login?ctx={ctx}`. For example, if your host is `login.backend.com`, the full value becomes `https://login.backend.com/login?ctx={ctx}`.

For more details about placeholder configuration and behavior, see [Extensible Placeholder Mechanism for Login Page URIs](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/aa417173fe4a4ba5a473c93eb730a417/ca1176a372b242a6abd75a39fe803eea.html?state=DRAFT&q=loio89c86d4e1116457486db2b78fe539db9#extensible-placeholder-mechanism-for-login-page-uris).

## Recommendations

### Login Page Design

It is recommended that you simplify the CMS structure for the login page as much as possible. The main reasons for doing so are that relative links do not contain the correct base URL, and also lack cart data. By reducing the login page to only the necessary components and links, you can reduce the challenges with CMS configuration when using the federated login feature.

For example, it could be confusing to the customer to suddenly see an incorrect cart counter on the login page, so removing cart counters and mini-carts is recommended.  

As for relative links, if these are not tied to the Angular router (such as anchor tags in the text of a paragraph component, for example), the links are not guaranteed to resolve properly to the originating domain. As a result, relative links should be replaced with absolute links, where possible.

### Isolating Testing Values

It is recommended that you use Angular's environments feature to isolate development, staging, and production origin maps. This helps prevent you from including development configurations and publicizing staging origins. The downside of this approach is that you need to make separate builds for staging and production.

The following is an example of how to implement the environments feature in `spartacus-configuration.module.ts`:

```typescript
import { type FederatedLoginConfig } from '@spartacus/core';
import { environment } from '../../environments/environment';

// ...

    provideConfig(<FederatedLoginConfig>{
      federatedLogin: {
        enabled: true,
        loginHosts: environment.loginHosts,
        originMap: environment.originMap,
      },
    }),
```

For more information, see [Configuring application environments](https://angular.dev/tools/cli/environments) in the official Angular documentation.

### Asymmetric Configuration

If your build process supports multiple builds, with unique configurations for each storefront, you can further minimize the origin data embedded in the storefront scripts.

The "login storefront" requires the login hosts array and the entire origin map for every storefront being served. This amounts to the complete configuration. Any other storefront in a federated login setup only requires the key-value pair for itself in the origin map. It does not require any entries in the login hosts array.

The following is an example of the `spartacus-configuration.module.ts` file with asymmetric configuration for the build of `brand1.com`:

```typescript
    provideConfig(<FederatedLoginConfig>{
      federatedLogin: {
        enabled: true,
        originMap: {'sf1': 'https://brand1.com'},
      },
    }),
```

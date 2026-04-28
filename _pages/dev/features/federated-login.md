---
title: Federated Login
feature:
- name: Federated Login
  spa_version: 221121.11.0
  cx_version: 2211-jdk21.11
---

Federated Login is an enhancement to the Custom Login Page support in Spartacus that allows using a single Spartacus instance to serve as the login page for multiple different domains.

# When to use this feature
One of the restrictions in using the Custom Login Page feature of CCv2 is that the storefront and authorization server must be on the same domain or Site.

i.e.  Incompatible hosting for Custom Login Page
```
Storefront  |  OCC API        
------------|---------------- 
brand1.com  | api.backend.com 
brand1.jp   |        "        
brand2.com  |        "        
brand2.jp   |        "        
```

The recommended way to create a valid hosting arrangement is to host the OCC API to the same domain through either reverse-proxying requests from a path like `/api/**` or from a sub-domain like `api.*`.  This would need to be done for each storefront domain that is different than the APIs domain.

i.e.  Valid hosting for Custom Login Page
```
Storefront  | OCC API (host option)  | OCC API (path option)
------------|------------------------|----------------------
brand1.com  | api.brand1.com         | brand1.com/api/  
brand1.jp   | api.brand1.jp          | brand1.jp/api/   
brand2.com  | api.brand2.com         | brand2.com/api/  
brand2.jp   | api.brand2.jp          | brand2.jp/api/   
```

If the recommended approach is not feasible, the Federated Login feature provides an alternative.  Instead of making the API accessible at each individual domain, we use a single new storefront as the login page provider for all the other storefront domains.  This "login storefront" will be the only instance required to be on the same domain, reducing the hosting complexity.

i.e.  Valid hosting using federated login
```
Storefront        | OCC API
------------------|-----------------
brand1.com        | api.backend.com
brand1.jp         |        "       
brand2.com        |        "       
brand2.jp         |        "       
login.backend.com | api.backend.com
```

With Federated login implemented, the complete login process is:
1. Customer on brand1.com clicks the login button.
2. The brand1.com site navigates to the authorization server per the oAuth 2.0 Authorization Code grant flow.  The storefront will add extra context to the request for use on the login storefront.
3. The authorization server will use the Custom Login Page setting to redirect the browser to the login storefront, login.backend.com, and pass through the context from the initial request.
4. The login storefront will read that context and use it to load the base site and language of the originating site, brand1.com.  It will display the login page according the the CMS data from brand1.com.
5. The customer enters their user credentials and submits the form.
6. The login storefront posts the login form to the authorization server, which validates the credentials and issues a redirect to the return_uri specified in the initial request, which is brand1.com.
7. The Customer is back on the brand1.com storefront, where the storefront will request an access token, and the customer is now authenticated.


## Requirements and Restrictions

- A new login storefront domain that is on the same domain/Site as the OCC APIs
- CMS base site for each domain
- Redesigned login page CMS data to use only absolute links
- List of origins embedded in spartacus data


## How to configure

### Spartacus
Add a new configuration provider to the spartacus configuration module at `src/app/spartacus/spartacus-configuration.module.ts`
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
The `loginHosts` array lists the hosts where spartacus should act as a dedicated login portal.  This should be configured with the host(s) of the "login storefront".

The `originsMap` is a map of key and origin pairs that correspond to the storefronts that the "login storefront" acts as a login page for.  The keys can be any url-safe, ASCII string and are used in the context parameter value when building the authorize URL.  The values are origins, which means they require protocol and port, when using non-standard port numbers.

### Commerce Cloud

#### 1. Authorize parameters
Add the context parameter to the list of allow parameters on the authorize request.
The value of property `authserver.authorizationCode.allowed.params` needs to be extended with the context parameter name configured in Spartacus.  The default value is "context".

#### 2. Allowed hosts
Add the host of the login page(es) to the list of allowed Custom Login Page hosts.  This is required for later configuration of the OAuthClientDetails.
Property `authserver.oauthclientdetails.loginpageuri.allowed.hosts`.

#### 3. CORS filters
Add the appropriate values to `corsfilter.authorizationserver.allowedOrigins`.

#### 2. OAuthClientDetails 
In Backoffice or via Impex, update the OAuthClientDetails for the storefronts that we want to use federated login with.  Set the Custom Login Page to the login host with the path `/login?ctx={ctx}`.  For example, with a host of "login.backend.com", the full value would be "https://login.backend.com/login?ctx={ctx}".

See Custom Login Placeholders --LINK TBD-- for more details on modifying the placeholder names or behaviors.



## Recommendations

### Origin map values
It is recommended to use Angular's [Environments](https://angular.dev/tools/cli/environments) feature to isolate development, staging, and production origin maps.  This prevents including development configurations and publicizing staging origins.  The downside of this is that separate builds will need to be made for staging and production.

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

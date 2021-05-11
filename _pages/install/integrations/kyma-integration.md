---
title: Kyma Integration
---

The following steps describe how to integrate [Kyma](https://kyma-project.io) into your Spartacus storefront.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Prerequisites

If your Spartacus application is running on Commerce Cloud, the following configs should already be in place:

`local.properties`:

```properties
oauth2.client4kyma.kid=test1
oauth2.client4kyma.keystore.location=/security/keystore.jks
oauth2.client4kyma.keystore.password=nimda123
oauth2.algorithm=RS256
```

Add a new OAuth client using the following impex:

```text
### Kyma OAuth client
INSERT_UPDATE OpenIDClientDetails;clientId[unique=true] ;resourceIds   ;scope    ;autoApprove  ;authorizedGrantTypes         ;authorities  ;clientSecret   ;registeredRedirectUri      ;externalScopeClaimName ;issuer
                                 ;client4kyma           ;hybris        ;openid   ;openid       ;password,client_credentials  ;ROLE_CLIENT  ;secret         ;http://MY_APPLICATION/     ;scope                  ;ec
```

**NOTE**: these values are for the testing environment. Do not use them in production.

## Spartacus Configuration

You can integrate Kyma functionality in Spartacus by providing an appropriate `authentication` configuration, as described in [Configuring OpenID]({{ site.baseurl }}/session-management/#configuring-openid).

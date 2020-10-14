---
title: Kyma Integration (DRAFT)
---

## Prerequisites

If your Spartacus application is running on Commerce Cloud, these configs should already be in place:

`local.properties`:

```properties
oauth2.client4kyma.kid=test1
oauth2.client4kyma.keystore.location=/security/keystore.jks
oauth2.client4kyma.keystore.password=nimda123
oauth2.algorithm=RS256
```

Add a new OAuth client using the following impex:

```impex
### Kyma OAuth client
INSERT_UPDATE OpenIDClientDetails;clientId[unique=true] ;resourceIds   ;scope    ;autoApprove  ;authorizedGrantTypes         ;authorities  ;clientSecret   ;registeredRedirectUri      ;externalScopeClaimName ;issuer
                                 ;client4kyma           ;hybris        ;openid   ;openid       ;password,client_credentials  ;ROLE_CLIENT  ;secret         ;http://MY_APPLICATION/     ;scope                  ;ec
```

**NOTE**: these values are for the testing environment. Do not use them in production.

## Spartacus Configuration

The Kyma integration is turned off by default. To enable it, import `KymaModule` from `@spartacus/core` and enable `kyma_enabled: true` flag in `authentication` configuration:

```ts
import { KymaModule } from '@spartacus/core';
...
@NgModule({
  imports: [
    ...
    B2cStorefrontModule.withConfig({
      ...
      authentication: {
        kyma_enabled: true,
        kyma_client_id: 'client4kyma',
        kyma_client_secret: 'secret',
      },
      ...
    }),
    KymaModule,
  ],
  ...
})
export class AppModule {}
```

Note that `kyma_client_id` and `kyma_client_secret` values have to match the back end configuration mentioned [above](#prerequisites).

## Getting the Open ID Token

After configuring the Kyma integration, you can obtain the open ID token (that's being used for communicating with kyma) by calling `getOpenIdToken()` method from `KymaService` facade. Note that this token will be available only after a successful authentication (i.e. a user logs in or registers).

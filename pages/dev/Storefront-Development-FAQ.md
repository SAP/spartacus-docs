---
title: Storefront Development FAQ
---

This document compiles frequently-asked or interesting questions we've received regarding developing with Spartacus libraries. Some information may apply to source code but the intent of this page is for people developing with the libraries only.

----
### Integrating with external identity provider

Q: What's the best method to integrate Spartacus with an external Identity Provider such as OpenID Connect?

A: The guards `AuthGuard` (and `NotAuthGuard`) should work in this situation. They are responsible for:
- preventing navigation to the url which is available only for authorized (or relevantly for non-authorized users)
- remembering the redirect url, where you should be redirected after authorization

It should suffice to just extend the AuthService:
```
import { AuthService} from '@spartacus/core`;
...
@Injectable()
class MyAuthService extends AuthService {
   // here you extend specific methods...
}
```
and in your app.module provide your implementation to the DI:
```
providers: [
   { provide: AuthService, useClass: MyAuthService }
]
```

This is a proposed solution and has not been tested.

(last updated June 3, 2019)
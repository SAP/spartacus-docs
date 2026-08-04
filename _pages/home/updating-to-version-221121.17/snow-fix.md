---
title: Validating Trusted Origins in SSR
---

Spartacus provides an optional Server-Side Rendering (SSR) middleware, `getOriginValidationMiddleware`, that protects your storefront against Host Header Injection and cache poisoning. It checks the origin of each incoming request against a list of origins that you trust, and before the page is rendered or cached, it rejects any request that does not match.

## Overview

During SSR, your storefront determines the request's origin from headers such as `Host` and `X-Forwarded-Host` (the latter is typically set by your reverse proxy
or CDN). This origin can influence rendered output and how pages are cached.

If a request arrives with a forged host, it can lead to the following outcomes:

- Host Header Injection: The forged host is reflected into the rendered page or generated links.
- Cache poisoning: A page that is rendered for a forged host is stored in the cache and later served to legitimate users.

Although Angular offers host validation through the `NG_ALLOWED_HOSTS` environment variable, Spartacus does its rendering using Angular's `CommonEngine`, and on this path, only the raw `Host` header is validated. In other words, the `X-Forwarded-Host` header is not checked against `NG_ALLOWED_HOSTS`, which can lead to vulnerabilities, as illustrated in the following table:

| Forged header | Blocked by `NG_ALLOWED_HOSTS` |
| --- | --- |
| `Host` | Yes |
| `X-Forwarded-Host` | No |

Since `X-Forwarded-Host` is the header that your reverse proxy or CDN sets, this is the more relevant attack vector, and it is left unprotected if you only use
`NG_ALLOWED_HOSTS` on its own. The `getOriginValidationMiddleware` closes that gap by validating the resolved origin, which takes `X-Forwarded-Host` into account.

To provide a more robust defense, it is recommended that you configure both `NG_ALLOWED_HOSTS` and the `getOriginValidationMiddleware`.

**Note:** The `getOriginValidationMiddleware` is an additional safeguard, not a replacement for correctly configuring your reverse proxy and Express `trust proxy` settings.

**Note:** The origin from `X-Forwarded-Host` is only trusted when your Express `trust proxy` configuration trusts the proxy that forwarded the request.

## Configuring the Trusted Origins Validation Middleware

Using the `getOriginValidationMiddleware` is optional, and it only takes effect once you provide a list of allowed origins. If no list is configured (or the list is empty), the middleware does nothing, and your storefront behaves exactly as before. In other words, the protection offered by the middleware is inactive until you configure it. For this reason, it is strongly recommended that you enable it in production.

The middleware is available from the `@spartacus/setup/ssr` package, and to enable it you need to start by registering it in your project's `server.ts` file, as shown in the following example:

```ts
import { getOriginValidationMiddleware } from '@spartacus/setup/ssr';

server.use(
  getOriginValidationMiddleware({
    allowedOrigins: process.env['SSR_ALLOWED_ORIGINS'],
  })
);
```

The recommended approach is to then provide the allowed origins through the `SSR_ALLOWED_ORIGINS` environment variable as a comma-separated list, so you can
use different values for each environment without changing any code. The following is an example:

```text
SSR_ALLOWED_ORIGINS="https://my-shop.com,https://*.my-shop.com"
```

For deployment environments where setting custom environment variables is not an option, you can hardcode the list of allowed origins directly in `server.ts` instead. The following is an example:

```ts
server.use(
  getOriginValidationMiddleware({
    allowedOrigins: ['https://my-shop.com', 'https://*.my-shop.com'],
  })
);
```

When defining allowed origins, the following rules apply:

- Each entry must be a full origin (that is, protocol and host), with no trailing slash. For example, `https://my-shop.com`
- Matching is case-insensitive
- The protocol is part of the match. For example, `http://my-shop.com` and `https://my-shop.com` are treated as different origins. Accordingly, list each one that you need to allow.

If you wish to use wildcards for subdomains, the `*` wildcard will match exactly one subdomain label. It does not span dots and does not match the base (apex) domain.

For example, using a wildcard such as `https://*.my-shop.com` produces the following results:

| Request origin | Allowed |
| --- | --- |
| `https://shop.my-shop.com` | ✅ |
| `https://my-shop.com` | ❌ |
| `https://a.b.my-shop.com` | ❌ |

To allow the base domain as well, add it as its own entry, as shown in the following example:

```text
SSR_ALLOWED_ORIGINS="https://my-shop.com,https://*.my-shop.com"
```

If a request is rejected because the request's origin is not in your allowlist, the following occurs:

- The request receives a `400 Bad Request` response.
- The response includes `Cache-Control: no-store` so it is not cached.
- The page is not rendered.

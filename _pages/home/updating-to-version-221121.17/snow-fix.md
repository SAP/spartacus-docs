---
title: SNOW Fix for 221121.17
---
# Validating Trusted Origins in SSR

## What this does

Spartacus provides an optional Server-Side Rendering (SSR) middleware,
`getOriginValidationMiddleware`, that protects your storefront against
**Host header injection** and **cache poisoning**. It checks the origin of each
incoming request against a list of origins you trust, and rejects any request
that doesn't match before the page is rendered or cached.

The middleware is available from `@spartacus/setup/ssr`.

## Why you should configure it

During SSR, your storefront determines the request's origin from headers such as
`Host` and `X-Forwarded-Host` (the latter is typically set by your reverse proxy
or CDN). This origin can influence rendered output and how pages are cached.

If a request arrives with a forged host, it can lead to:

- **Host header injection** — the forged host is reflected into the rendered
  page or generated links.
- **Cache poisoning** — a page rendered for a forged host is stored in the cache
  and later served to legitimate users.

### Why Angular's `NG_ALLOWED_HOSTS` is not enough

Angular offers host validation through the `NG_ALLOWED_HOSTS` environment
variable. However, Spartacus renders using Angular's `CommonEngine`, and on this
path only the raw `Host` header is validated — the `X-Forwarded-Host` header is
**not** checked against `NG_ALLOWED_HOSTS`:

| Forged header      | Blocked by `NG_ALLOWED_HOSTS`? |
| ------------------ | :----------------------------: |
| `Host`             |              Yes               |
| `X-Forwarded-Host` |             **No**             |

Since `X-Forwarded-Host` is the header your reverse proxy or CDN sets, this is
the more relevant attack vector — and it is left unprotected by
`NG_ALLOWED_HOSTS` alone. This middleware closes that gap by validating the
resolved origin, which accounts for `X-Forwarded-Host`.

For defense in depth, configure both `NG_ALLOWED_HOSTS` and this middleware.

## This feature is opt-in

The middleware only takes effect once you provide a list of allowed origins. If
no list is configured (or the list is empty), it does nothing and your storefront
behaves exactly as before.

Because only you know the valid domains for your deployment, **this protection is
inactive until you configure it.** We strongly recommend enabling it in
production.

## How to configure it

The middleware is registered in your storefront's `server.ts`:

```ts
import { getOriginValidationMiddleware } from '@spartacus/setup/ssr';

server.use(
  getOriginValidationMiddleware({
    allowedOrigins: process.env['SSR_ALLOWED_ORIGINS'],
  })
);
```

The recommended approach is to provide the allowed origins through the
`SSR_ALLOWED_ORIGINS` environment variable as a comma-separated list, so you can
use different values per environment without changing code:

```
SSR_ALLOWED_ORIGINS="https://my-shop.com,https://*.my-shop.com"
```

For deployment environments where setting custom environment variables is not an
option, hardcode the list of allowed origins directly in `server.ts` instead:

```ts
server.use(
  getOriginValidationMiddleware({
    allowedOrigins: ['https://my-shop.com', 'https://*.my-shop.com'],
  })
);
```

## Rules for allowed origins

- Each entry must be a **full origin** — protocol and host — with **no trailing
  slash**. For example: `https://my-shop.com`.
- Matching is **case-insensitive**.
- The protocol is part of the match. `http://my-shop.com` and
  `https://my-shop.com` are treated as **different** origins; list each one you
  need to allow.

### Using wildcards for subdomains

A `*` wildcard matches **exactly one subdomain label**. It does not span dots and
does not match the base (apex) domain.

For example, `https://*.my-shop.com`:

| Request origin             | Allowed? |
| -------------------------- | :------: |
| `https://shop.my-shop.com` |    ✅    |
| `https://my-shop.com`      |    ❌    |
| `https://a.b.my-shop.com`  |    ❌    |

To allow the base domain as well, add it as its own entry:

```
SSR_ALLOWED_ORIGINS="https://my-shop.com,https://*.my-shop.com"
```

## What happens to rejected requests

When a request's origin is not in your allowlist:

- The request receives a **`400 Bad Request`** response.
- The response includes **`Cache-Control: no-store`** so it is not cached.
- The page is **not rendered**.

## Important notes

- This middleware is an **additional safeguard**, not a replacement for correctly
  configuring your reverse proxy and Express `trust proxy` settings.
- The origin from `X-Forwarded-Host` is only trusted when your Express
  `trust proxy` configuration trusts the proxy that forwarded the request.

---
title: Token Revocation (DRAFT)
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

When a user signs out of the storefront, Spartacus requests the revocation of the user authentication token so the OCC session is terminated. This is a security improvement.

Here is what to expect:

- When a customer signs out of the storefront, a token revocation request is sent.
- When an ASM customer support agent signs out, a token revocation request is sent.
- When a customer emulated with ASM signs out, a token revocation is _not_ sent. The customer support agent's token is used in emulation sessions and we only want to revoke it when the agent himself signs out.

If the token revocation request fails, Spartacus will fail silently since there is no action it can make to recover. For example requesting the revocation of an already expired token will result in a http 401 response. Even if the server sends an error response, Spartacus will fail silently.

## Requirements

### Spartacus

You need Spartacus v1.4.0

### Backend

Token revocation is available on backends with version 1905.6 and above.

Spartacus 1.4.0+ can still be used with backends with a version lower than 1905.6. In Spartacus, token revocation will fail silently if the backend does not support it.

Under the hood, a backend that does not support token revocation will return an http 302 redirect response on a token revocation request. The backend's behaviour on a request to a non-existing authorization-related endpoint is to return a 302 redirect code pointing to the `login.jsp` page.

## Enabling Token Revocation

Token revocation in Spartacus is always enabled in v1.4.0+.

## Configuring

No extra configuration is required.

## Extending

No special extensibility is available for this feature.

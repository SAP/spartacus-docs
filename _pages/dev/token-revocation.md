---
title: Token Revocation
feature:
- name: Token Revocation
  spa_version: 1.4
  cx_version: 1905.6
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

When a user signs out of the storefront, Spartacus requests the revocation of the user authentication token so that the OCC session is terminated. This is a security improvement.

Token revocation works as follows:

- When a customer signs out of the storefront, a token revocation request is sent.
- When an ASM customer support agent signs out, a token revocation request is sent.
- When a customer who is emulated with ASM signs out, a token revocation is _not_ sent. The customer support agent's token is used in emulation sessions, so Spartacus only revokes the token when the agent signs out.

If the token revocation request fails, Spartacus fails silently, because there is no action it can make to recover. For example, requesting the revocation of an already-expired token results in an HTTP 401 response. Even if the server sends an error response, Spartacus will fail silently.

## Requirements

For the front end, you need version 1.4 or newer of the Spartacus libraries.

For the back end, token revocation is available with version 1905.6 or newer of SAP Commerce Cloud.

Spartacus 1.4 can still be used with a SAP Commerce Cloud back end that is older than 1905.6, but in the front end, token revocation will fail silently if the back end does not support it.

Under the hood, a back end that does not support token revocation returns an HTTP 302 redirect response if it receives a token revocation request. If a request is sent to an authorization-related endpoint that does not exist, the back end returns a 302 redirect code that points to the `login.jsp` page.

## Enabling Token Revocation

Token revocation is automatically enabled in Spartacus version 1.4 or newer. It cannot be disabled.

## Configuring

No additional configuration is required.

## Extending

No special extensibility is available for this feature.

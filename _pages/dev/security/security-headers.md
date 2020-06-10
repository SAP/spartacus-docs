**TODO**: WIP, first headers added, more to come.

---

HTTP security headers are a important part of website security. They protect your storefront against potential attacks, such as XSS, code injection, clickjacking, etc.

This document describes various security headers that are in place or should be added by customers when they deploy a Spartacus based Storefront in production.

[Owasp](https://owasp.org/www-project-secure-headers/) gives a good overview of the various headers that can be applied.

## Prevent clickjacking

To prevent third-party application to host the Spartacus storefront in an iframe, it is important add a header to instruct the browser to not render a web page response in case it's being loaded in an iframe. This could result in _clickjacking_, which is a known security vulnerability.

To mitigate the risk against _clickjacking_, it is recommended to use the `Content-Security-Policy` instead, specifically using the `frame-ancestors` directive. This directive allows to specify a configuration for the domains that you would allow to host the storefront in an iframe. (see also the section on CSP).

Alternatively, the well known `X-Frame-Options` header would be used to mitigate clickjacking. However, this header can only be configured with `DENY` or `SAMEORIGIN`. This is too limited for Spartacus as a default strategy, since the Spartacus storefront runs in an iframe in SmartEdit. SmartEdit loads Spartacus in an iframe and actually uses _Clickjacking_ technique deliberately to support inline content managing.

**Note**: The `Content-Security-Policy: frame-ancestors` is not supported in older browsers such as IE11. If you need to support IE11, it is recommended to plan for an alternative security strategy.

## MIME sniffing vulnerabilities

To prevent users from uploading a malicious file to the backend API, the `X-Content-Type-Options` header can be added to mitigate this behavior. This header is not related to the Spartacus implementation and is therefor not part of the implementation, nor the related deployments. Moreover, there are currently no APIs in use that allow for uploading files.

If you do leverage an API that allows to upload files, it is recommended to add the `X-Content-Type-Options`. This will prevent users to upload a file with a malicious mime type.

**TODO**:

- ensure that OCC API doesn't have any upload APIs.

## Content Security Policy (CSP)

CSP prevents a wide range of attacks, including cross-site scripting and other cross-site injections. The policy can specified in great detail with several _directives_.

The policy should include the following directives:

- The `frame-ancestors` directive is used to allow the storefront to be loaded in SmartEdit.
- the `script-src` directive can be used to prevent scripts being loaded from unknown locations. This does not only include spartacus static resources, but also third-party JS files for integrations such as SmartEdit, Qualtrics, etc.

The policy must be applied to both SSR rendered pages as well as the static `index.html`. The policy can be added in the `index.html` source file in the application. This is the most flexible way, as the Cloud Portal does not allow for configurable http headers.

**TODO**:

- Discuss: consider using `OCC_BACKEND_BASE_URL_VALUE` to dynamically add the backend API base URL in the policy
- Consider a default policy or example

```html
<meta
  http-equiv="Content-Security-Policy"
  content="default-src 'self'; img-src https://*; child-src 'none';"
/>
```

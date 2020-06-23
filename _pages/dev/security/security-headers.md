**TODO**: WIP, discussion with security team and ccv2 ongoing.

HTTP security headers are a important part of website security. They protect your storefront against potential attacks, such as XSS, code injection, clickjacking, etc.

This document describes various security headers that are in place or should be added by customers when they deploy a Spartacus based Storefront in production.

[Owasp](https://owasp.org/www-project-secure-headers/) gives a good overview of the various headers that can be applied. We've used the headers outlined by Owasp and reflect the recommended headers for Spartacus.

## HTTP Strict-Transport-Security

The HSTS security header forces the web browser to access the storefront by https only. This contributes to protocol downgrading and cookie hijacking.

This is a pretty basic header that should be applied by default to Spartacus applications.

The following snippets shows an example header config:

```
Strict-Transport-Security: max-age=31536000 ; includeSubDomains
```

**TODO**

- @Michael Verify if this is added in ccv2 by default (likely already on ingress controller)

## HTTP Public Key Pinning (HPKP)

`HPKP` is a (deprecated) mechanism that can be added through http headers. The mechanism would forces the same headers cross various layers, including APIs.

CCv2 doesn't support this header deliberately. It adds too much pressure on syncing certificates cross multiple (changing) layers in the hosting setup. Moreover, HPKP is deprecated and not implemented in a stable manner cross browsers for HPKP.

Spartacus does not insist on the usage of HPKP.

## X-Frame-Options

The `X-Frame-Options` header is a well-known header that can be used to mitigate clickjacking. This header can only be 2 values, `DENY` or `SAMEORIGIN`. This is too limited for Spartacus as a default strategy to prevent clickjacking, since the Spartacus storefront runs in an iframe in SmartEdit. SmartEdit loads Spartacus in an iframe and actually uses _Clickjacking_ technique deliberately to support inline content managing.

The `Content-Security-Policy: frame-ancestors` offers more sophisticated approach to tackle clickjacking, so that SmartEdit can be used while still being able to protect from clickjacking. The CSP is detailed further below.

The `Content-Security-Policy: frame-ancestors` is not supported in older browsers such as IE11. Customers who need to support IE11, the `X-Frame-Options` could be used as an alternative policy to evaluate. (Keep in mind however that this will block SmartEdit on the same deployed environment).

Since audits will likely report the lack of `X-Frame-Options` even if the more modern CSP is in place, it is recommended to add this header regardless.

**TODO**

- Add `X-Frame-Options` header as a backup for the `frame-ancestors`. Must be added by ccv2 for both ssr and static index.html

## X-XSS-Protection

It's generally recommended to not use the `X-XSS-Protection` security header, as it can "introduce additional security issues on the client side" (https://owasp.org/).

```
X-XSS-Protection: 0
```

**TODO**

- Validate if the `X-XSS-Protection` header is turned off for Spartacus
- Consider doing this globally.

## X-Content-Type-Options

To prevent users from uploading a malicious file to the backend API (AKA _MIME sniffing vulnerabilities_), the `X-Content-Type-Options` header can be added. This header is not relevant to Spartacus application resources, but could be a risk for backend APIs if they allow to upload files.

There are currently no public APIs in use that allow for uploading files. This could however change (i.e. b2b basket upload).

Since audits likely report the lack of `X-Content-Type-Options`, it is recommended to add this header regardless.

Example:

```
X-Content-Type-Options: nosniff
```

**TODO**:

- add `X-Content-Type-Options` for compliance reasons and avoid noisy audits

## Content Security Policy (CSP)

CSP prevents a wide range of attacks, including cross-site scripting and other cross-site injections. The policy can specified in great detail with several _directives_.

The policy should include the following directives:

- the `frame-ancestors` directive to allow the storefront to be loaded in SmartEdit frame.
- the `script-src` directive to prevent scripts being loaded from unknown locations. This does not only include spartacus static resources, but also third-party JS files for integrations such as SmartEdit, Qualtrics, etc.
  - The `script-src` directive should not have `unsafe-inline` or `unsafe-eval` to prevent XSS.
    **Note**: some areas in Spartacus (or 3rd parties) might not work after applying this one.
- (optional) the `object-src` directive to avoid any insecure execution (i.e. flash, java, etc.).
- (optional) the `default-src` to limit to use https only

Further restrictions regarding images, fonts or other static resources are not added by default. Customers can extend the policy to meet there security requirements.

The policy must be applied to both SSR rendered pages as well as the static `index.html`.

While most of the policy can be added with a meta tag in the `index.html`, the `frame-ancestors` directive must be ignored when contained in a policy declared via a meta element.

**TODO**:

- Discuss adding CSP in security headers
  - allow for flexibility
  - allow for injection of environment URLs
  - consider using `OCC_BACKEND_BASE_URL_VALUE` to dynamically add the backend API base URL in the policy
  - distinguish dev, qa and prod
- Consider a default (templated) policy  
  Consider a template per environment
- Consider combining html meta tag driven policy vs headers

Meta tag example

```html
<meta
  http-equiv="Content-Security-Policy"
  content="script-src 'myshop.com'; img-src https://*; child-src 'none';"
/>
```

## X-Permitted-Cross-Domain-Policies

The `X-Permitted-Cross-Domain-Policies` is used to grant permissions to handle data cross domains by rich clients such as Adobe Flash or Acrobat.

This is not relevant to the standard Spartacus application, and is therefor not enabled.

## Referrer-Policy

The `Referrer-Policy` HTTP header can be used to avoid any confidential information in the referrer URL.

Spartacus does not add any confidential in public storefront URLs. Having rich referrers is recommended for a public storefront in general. This is why the `Referrer-Policy` is not enabled for Spartacus.

## Expect-CT

**TODO**

- @Michael Rieder – investigate if we need this.

## Feature-Policy

The Feature-Policy header allows developers to selectively enable and disable use of various browser features and APIs.

Spartacus encourage the use of modern browser APIs and doesn't want to limit the application. This header is therefor not added.

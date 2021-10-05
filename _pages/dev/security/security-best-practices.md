---
title: Security Best Practices
---

When you are developing your Spartacus storefront, you can improve the security of your storefront application by implementing the security best practices described here and in the following pages:

- [{% assign linkedpage = site.pages | where: "name", "content-security-policy.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/security/content-security-policy.md %})
- [{% assign linkedpage = site.pages | where: "name", "dos-protection.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/security/dos-protection.md %})
- [{% assign linkedpage = site.pages | where: "name", "token-revocation.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/security/token-revocation.md %})

## Secure Authentication

A fundamental element of running a secure storefront with Spartacus is to deploy to a web server that provides and enforces encrypted communication through HTTPS. Spartacus does not enforce HTTPS through any kind of internal logic. This is a feature the web server must provide. User security can be vulnerable to threats if you deploy a Spartacus storefront on a server that allows Spartacus to communicate using the unencrypted HTTP protocol.

HTTPS encryption is especially important for user authentication and registration processes. Without the use of HTTPS, attackers may be able to exploit the transmission of user credentials.

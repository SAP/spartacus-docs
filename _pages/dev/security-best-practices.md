---
title: Security Best Practices (DRAFT)
---

When you are developing your Project "Spartacus" storefront, you can improve the security of your storefront application by implementing the following security best practices.

## Secure Authentication

A fundamental element of running a secure storefront with Spartacus is to deploy to a web server that provides and enforces encrypted communication via HTTPS. Spartacus does not enforce HTTPS via internal logic, it is a feature the web server must provide. The users security can be threatened if the operating party deploys the Spartacus storefront on a server that allows the Spartacus storefront communicate via un-encrypted HTTP.

HTTPS encryption is especially important for the user authentication and registration processes. Attackers could exploit the transmission of user credentials without the usage of HTTPS.

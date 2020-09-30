---
title: Web Browser Support
---

Spartacus libraries are designed to take advantage of the latest web platform standards, while also allowing you to run your Spartacus storefront on as many different web browsers as possible. However, some older browsers do not support the latest standards, and as a result, these browsers are not supported by Spartacus. Officially, Spartacus only supports evergreen browsers.

However, there are ways to get Spartacus to work with older browsers, including IE11 (even though it is not an evergreen browser). The following are some of the steps you can take to get older browsers to work with Spartacus:

- You can transpile TypeScript into other version of JavaScript
- You can use polyfills to provide some of the standard web features that are missing in some older browsers
- You can use PostCSS to automatically add vendor prefix style rules.

## Working with IE11

If your Spartacus storefront needs to support IE11, you must do the following:

- Use JavaScript polyfills to add missing browser capabilities
- Customize the Spartacus styles, or bring in a custom style layer.

### Known Issues with Supporting IE11

In terms of Spartacus supporting IE11, the following are known issues at the time of writing:

- [GH-7220](https://github.com/SAP/spartacus/issues/7220) has been resolved, but the fix requires version 2.0 or newer of the Spartacus libraries
- [GH-8925](https://github.com/SAP/spartacus/issues/8925) is being addressed, but is currently not resolved.

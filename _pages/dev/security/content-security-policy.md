---
title: Content Security Policy
---

Content Security Policy is a tool that allows you to specify which locations and which types of resources are allowed to be loaded when your storefront is accessed through a web browser. You can use Content Security Policy to lock down your storefront app and mitigate the risk of content injection vulnerabilities, such as cross-site scripting (XSS), code injection, and clickjacking attacks, as well as reducing the privilege with which your storefront app executes.

It is highly recommended that you follow the Content Security Policy best practices described here, as well as in [Backoffice Framework Security](https://help.sap.com/viewer/5c9ea0c629214e42b727bf08800d8dfa/latest/en-US/f7bc40281c2c43479fcd1562b02e63e5.html?q=CSP#loiod0774212b4ae4b8bb3dcf39908ab5832) on the SAP Help Portal.

For more information about the W3C specification, see [Content Security Policy](https://owasp.org/www-community/controls/Content_Security_Policy) on the Open Web Application Security Project documentation site.

## Target Policy

In the `Content-Security-Policy` security header, you can specify directives that define loading behaviors for target resource types. The following are recommended directives and corresponding targets:

```html
default-src 'self'; style-src 'self' 'unsafe-inline'; img-src 'self'
```

**Note:** Additional directives may be needed to ensure app functionality, such as adding source lists for `script-src`.

## Working with Scripts

Scripts loaded from an allow-listed source using the `<script>` tag are still allowed. The following is an example:

```html
<script src = "foo.js" type = "text/javascript" > </script >
```

## Using the onClick Method

To handle events, you can set the event handler attributes of elements, or you can call `element.addEventListener()` from a script that has been loaded from an allow-listed site. The following is an example:

```js
element.onclick = someFunction; element. addEventListener( "click" , someFunction, false ) ;
```

## Using the setInterval Method

The following is an example of the recommended way to use the `setInterval()` method:

```js
window.setInterval( myFunc, 10000 ) ;
```

## Using the setTimeout Method

The following is an example of the recommended way to use the `setTimeout()` method:

```js
self.timers.invite2xxTimer = window.setTimeout(function() {invite2xxRetransmission(retransmissions)}, timeout);
```

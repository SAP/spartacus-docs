---
title: Content Security Policy
---

The usage of [Content Security Policies](https://owasp.org/www-community/controls/Content_Security_Policy) is recommended for the Commerce Suite backend used with Spartacus.
This will help in the prevention of XSS, code injection and clickjacking attacks, among others. 


Please follow recommendations for Commerce Suite backoffice as detailed [here](https://help.sap.com/viewer/5c9ea0c629214e42b727bf08800d8dfa/2105/en-US/f7bc40281c2c43479fcd1562b02e63e5.html?q=CSP#loiod0774212b4ae4b8bb3dcf39908ab5832)

SAP's security standard 269 recommends the following best practices of Content Security Policy usage:

```
Target policy

It is advisable to target the following policy (certainly adjustments might be needed to ensure functionality, e.g. adding source lists for script-src):

Content-Security-Policy: default-src 'self'; style-src 'self' 'unsafe-inline'; img-src 'self'

Proper usage of <script>:

Scripts loaded from a white-listed source using the <script> tag is still allowed:

<script src = "foo.js" type = "text/javascript" > </script >

   

Proper usage of onClick()

To handle events, you can set the event handler attributes of elements, or call element.addEventListener(), from script that has been loaded from a white-listed site:

element.onclick = someFunction; element. addEventListener( "click" , someFunction, false ) ;

 
Proper usage of setInterval():

window. setInterval( myFunc, 10000 ) ;

   

Proper usage of setTimeout():

self.timers.invite2xxTimer = window.setTimeout(function() {invite2xxRetransmission(retransmissions)}, timeout);
```
---
title: Clickjacking Prevention
---

Certain modifications are required in order to block Spartacus libraries from [Clickjacking](https://owasp.org/www-community/attacks/Clickjacking) attacks. 

The options listed in this page may block SmartEdit from working with Spartacus. Please consult with technical team before implementing. 

Option 1. Set X-Frame-Option http header field to 'DENY' or 'SAMEORIGIN' in Commerce Suite used by Spartacus as backend. 
Modify property xss.filter.header.X-Frame-Options accordingly. Follow detailed instructions [here](https://help.sap.com/viewer/9433604f14ac4ed98908c6d4e7d8c1cc/2105/en-US/c8145542c2564bb29f6cf2fb6fe67b90.html)

Option 2. SAP's security standards recommend as one of its possible solutions: "Frame Buster Javascript (Embedded site only) for single domain solution.
Inclusion of javascript code in HTML pages can actively block pages to be embedded in a frame"
Example of this is: 
```
<style> html{display : none ; } </style>
<script>
  if( self == top ) {
    document.documentElement.style.display = 'block' ;
  } else {
    top.location = self.location ;
  }
</script>
```

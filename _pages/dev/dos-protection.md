---
title: Protection Against Denial of Service Attacks
---

Spartacus libraries do not offer any protection again Denial of Service (DOS) attacks. It is out of scope.

Third-party libraries that are used by Spartacus are scanned regularly. If vulnerabilities are found, library versions are updated, or their usage goes through an internal security review process.

Steps to prevent DOS attacks should be taken at the infrastructure level as part of deployment planning for SAP Commerce Cloud in a production environment. For more information, see [SAP Commerce Security](https://help.sap.com/viewer/9433604f14ac4ed98908c6d4e7d8c1cc/latest/en-US/420e99cf09244637a220cf5e56b265b1.html) on the SAP Help Portal.

SAP Commerce Cloud also provides mechanisms for preventing brute force attacks on passwords. For more information, see [User Account](https://help.sap.com/viewer/d0224eca81e249cb821f2cdf45a82ace/latest/en-US/28cfbf93784640d09929ee4e9b97ba1e.html) on the SAP Help Portal.

Maximum login attempts can also be set for the authentication service. For more information, see [Oauth2](https://help.sap.com/viewer/d0224eca81e249cb821f2cdf45a82ace/latest/en-US/3d3ea6a4d5fa486aa324ce278fa2afc3.html) on the SAP Help Portal.

For more information about DOS attacks, see [Denial of Service](https://owasp.org/www-community/attacks/Denial_of_Service) in the Open Web Application Security Project documentation.

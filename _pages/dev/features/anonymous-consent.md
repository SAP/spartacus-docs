---
title: Anonymous Consent
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.3 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

Anonymous Consent Management gives anonymous users control over the tracking of their data. Anonymous users can grant or decline their consent for applications that collect and process personal data. For more, refer to the [Anonymous Consent Management on SAP Help Portal](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/a9f387f70d484c19971aca001dc71bc5.html?q=anonymous%20consent)

## Requirements

### Back End Requirements

Anonymous consent uses an `x-anonymous-consents` custom header, which needs to be configured in the back end by adding it to certain properties. If you are using SAP Commerce Cloud 2005 or newer, add the `x-anonymous-consents` header to the following properties:

- `corsfilter.commercewebservices.allowedHeaders`
- `corsfilter.commercewebservices.exposedHeaders`
- `corsfilter.assistedservicewebservices.allowedHeaders` - if ASM is being used
- `corsfilter.assistedservicewebservices.exposedHeaders` - if ASM is being used

If you are using SAP Commerce Cloud 1905 or older, add the `x-anonymous-consents` header to the following properties:

- `corsfilter.ycommercewebservices.allowedHeaders`
- `corsfilter.ycommercewebservices.exposedHeaders`
- `corsfilter.assistedservicewebservices.allowedHeaders` - if ASM is being used
- `corsfilter.assistedservicewebservices.exposedHeaders` - if ASM is being used

**Note:** If you are using Spartacus 2.0 with SAP Commerce Cloud 1905, you may experience some caching issues on the consent management page. The fix has been back-ported to Spartacus version 1905.15.

#### Consent Data

Besides having consent defined on the back end, they need to be marked as _exposed_, which can be done by executing an impex file similar to this:

```sql
$siteUid=electronics-spa

INSERT_UPDATE ConsentTemplate;id[unique=true];name;description;version[unique=true];baseSite(uid)[unique=true,default=$siteUid];exposed
;PERSONALIZATION;"I approve to this sample PERSONALIZATION consent";"This is a sample personalization consent description that will need to be updated or replaced.";0;;true
;MARKETING_NEWSLETTER;"I approve to this sample MARKETING consent";"This is a sample marketing consent description that will need to be updated or replaced, based on the valid registration consent required.";0;;true
;STORE_USER_INFORMATION;"I approve to this sample STORE USER INFORMATION consent";"This is a sample store user information consent description that will need to be updated or replaced.";0;;true
```

Notice that the last column named _exposed_ is set to _true_ for the consents that should be exposed to the anonymous users.

### CMS Components

The anonymous consent banner, and the link in the footer that opens the anonymous consent dialog, are driven by CMS. To have these CMS components, an ImpEx similar to this can be used:

```sql
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]

INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef;restrictions(uid,$contentCV)
;;AnonymousConsentManagementBannerComponent;Anonymous Consent Management Banner Component;AnonymousConsentManagementBannerComponent;AnonymousConsentManagementBannerComponent;anonymousUserRestriction
;;AnonymousConsentOpenDialogComponent;Anonymous Consent Open Dialog Component;AnonymousConsentOpenDialogComponent;AnonymousConsentOpenDialogComponent;anonymousUserRestriction
```

### Footer notice

Previously, the `footer-navigation.component.html` was tightly coupled with the footer notice message, which is now a `CMSParagraphComponent` that should also be added like this:

```sql
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]

INSERT_UPDATE CMSParagraphComponent;$contentCV[unique=true];uid[unique=true];name;&componentRef;
;;NoticeTextParagraph;Notice Text Paragraph;NoticeTextParagraph;

UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)
;;FooterSlot;FooterNavigationComponent,AnonymousConsentOpenDialogComponent,NoticeTextParagraph,AnonymousConsentManagementBannerComponent
```

Along with the `NoticeTextParagraph` CMS component you should also update the localized properties files with a sample text such as this example:

```properties
CMSParagraphComponent.NoticeTextParagraph.content="<div class=""cx-notice"">Copyright © 2020 SAP SE or an SAP affiliate company. All rights reserved.</div>"
```

After changing the `*.properties` files, don't forget to run `ant build` and the `ant initialize` commands.

## Configuring Anonymous Consent

Spartacus offers some configuration options that are encapsulated in `anonymousConsents` configuration object. The following options are available:

- `registerConsent` - specify a consent template ID that should be rendered on the registration page. By default, `MARKETING_NEWSLETTER` is being rendered.
- `showLegalDescriptionInDialog` - set to _false_ if the legal description shouldn't be visible on the anonymous consents dialog. By default, this has _true_ value.
- `requiredConsents` - specify an array of consent template IDs that are going to be required for the end users. These consents are given by default, and users can't toggle them. By default, this array is empty.
- `consentManagementPage.showAnonymousConsents` - specify whether to show anonymous consents on the registered consent management page. By default, this is set to `true`, and setting it to `false` will hide all consents from consents management page that have `exposed` property set to `true`. In case you don't want to hide all anonymous consents from the consents management page, refer to `consentManagementPage.hideConsents` below.
- `consentManagementPage.hideConsents` - an array of consent template IDs that should be hidden on the consents management page. By default, this array is empty, and adding consent template IDs to it will hide them from the consents management page.

### Changing UI Labels

In order to customize any UI message on the banner or in the dialog, you can refer to [our i18n guide](_pages/dev/i18n.md) on how to override the existing translation keys.

## Extending Anonymous Consent

No special extensibility is available for this feature.

## Known Limitations

Any user who registers is considered a new user. A user who logs in during the same session will have their anonymous consents transferred to registered consents. To no longer be considered a new user, the user then needs to refresh the page or close the page to end the current session.

More information on the progress of this limitation can be found in our [Spartacus GitHub Issues](https://github.com/SAP/spartacus/issues/6467).

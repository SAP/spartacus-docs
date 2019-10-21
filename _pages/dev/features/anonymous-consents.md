# Anonymous Consents

## Overview

Anonymous Consent Management gives anonymous users control over the tracking of their data. Anonymous users can grant or decline their consent for applications that collect and process personal data. For more, refer to the [Anonymous Consent Management on SAP Help Portal](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/1905/en-US/a9f387f70d484c19971aca001dc71bc5.html?q=anonymous%20consent)

## Requirements

### Back End Requirements

As anonymous consents use a custom header `x-anonymous-consents`, this needs to be configured on the back end by adding it to the following properties:

- `corsfilter.ycommercewebservices.allowedHeaders`
- `corsfilter.ycommercewebservices.exposedHeaders`
- `corsfilter.assistedservicewebservices.allowedHeaders` - if ASM is being used
- `corsfilter.assistedservicewebservices.exposedHeaders` - if ASM is being used

#### Consent data

Besides having consents defined on the back end, they need to be marked as _exposed_, which can be done by just executing an impex file similar to this:

```impex
$siteUid=electronics-spa

INSERT_UPDATE ConsentTemplate;id[unique=true];name;description;version[unique=true];baseSite(uid)[unique=true,default=$siteUid];exposed
;PERSONALIZATION;"I approve to this sample PERSONALIZATION consent";"This is a sample personalization consent description that will need to be updated or replaced.";0;;true
;MARKETING_NEWSLETTER;"I approve to this sample MARKETING consent";"This is a sample marketing consent description that will need to be updated or replaced, based on the valid registration consent required.";0;;true
;STORE_USER_INFORMATION;"I approve to this sample STORE USER INFORMATION consent";"This is a sample store user information consent description that will need to be updated or replaced.";0;;true
```

Notice that the last column named _exposed_ is set to _true_ for the consents that shold be exposed to the anonymous users.

### CMS components

At this moment, only the anonymous consents banner is being driven by CMS. To have this CMS component, an impex similar to this can be used:

```impex
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]

INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef
;;AnonymousConsentManagementBannerComponent;Anonymous Consent Management Banner Component;AnonymousConsentManagementBannerComponent;AnonymousConsentManagementBannerComponent

UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)
;;FooterSlot;FooterNavigationComponent,AnonymousConsentManagementBannerComponent
```

Having this CMS component alone doesn't enable the anonymous consents feature. Please see [Spartacus configuration](#Spartacus-configuration) section.

### Spartacus configuration

To enable anonymous consents in Spartacus, you need to enable the `anonymousConsents` feature in your `app.module.ts`, i.e.:

```typescript
B2cStorefrontModule.withConfig({
...
features: {
  level: '1.3',
  anonymousConsents: true,
},
...
}
```

_Note_ that feature level _1.3_ is _not_ required for anonymous consents. However, using _1.3_ version of Spartacus enables the new UI for the consents managment page, that uses accordions and toggles instead of checkboxes.

## Configuration options

Spartacus offers some configuration options that are encapsulated in `anonymousConsents` configuration object. The following options are available:

- `footerLink` - set to _false_ if the footer link shouldn't be rendered. By default it's set to _true_
- `registerConsent` - specify a consent template ID that should be rendered on the registration page. By default, `MARKETING_NEWSLETTER` is being rendered.
- `showLegalDescriptionInDialog` - set to _false_ if the legal description shouldn't be visible on the anonymous consents dialog. By default, this has _true_ value.
- `requiredConsents` - specify an array of consent template IDs that are going to be required for the end users. These consents are given by default, and users can't toggle them. By default, this array is empty.
- `consentManagementPage.showAnonymousConsents` - specify whether to show anonymous consents on the registered consent management page. By default, this is set to `true`, and setting it to `false` will hide all consents from consents management page that have `exposed` property set to `true`. In case you don't want to hide all anonymous consents from the consents management page, refer to `consentManagementPage.hideConsents` below.
- `consentManagementPage.hideConsents` - an array of consent template IDs that should be hidden on the consents management page. By default, this array is empty, and adding consent template IDs to it will hide them from the consents management page.

### Change UI labels

In order to customize any UI message on the banner or in the dialog, you can refer to [our i18n guide](_pages/dev/i18n.md) on how to override the existing translation keys.

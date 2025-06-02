---
title: PunchOut
---

SAP Commerce B2B Composable Storefront supports PunchOut functionality, which allows a buyer to shop a supplier's online catalog and save the cart as a requisition in the buyer's procurement system for approval.

## Schematics

To add punchOut lib via schematics:

```bash
ng add @spartacus/punchout
```

## CMS Sample Data

### Adding the CMS Components Manually Using ImpEx

To add all of the necessary CMS components and related data for Punchout, import the following ImpEx:

```text
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]
$siteResource=jar:de.hybris.platform.spartacussampledata.constants.SpartacussampledataConstants&/spartacussampledata/import/contentCatalogs/powertoolsContentCatalog

# Components
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;PunchoutSessionComponent;PunchoutSessionComponent;PunchoutSessionComponent
;;PunchoutButtonsComponent;PunchoutButtonsComponent;PunchoutButtonsComponent
;;PunchoutRequisitionComponent;PunchoutRequisitionComponent;PunchoutRequisitionComponent
;;PunchoutInspectCartComponent;PunchoutInspectCartComponent;PunchoutInspectCartComponent
;;PunchoutCloseSessionComponent;PunchoutCloseSessionComponent;PunchoutCloseSessionComponent
;;PunchoutErrorComponent;PunchoutErrorComponent;PunchoutErrorComponent
;;LoginComponent;LoginComponent;LoginComponent

# Disable onlyOneRestrictionMustApply for components to be hidden
UPDATE CMSLinkComponent;$contentCV[unique=true];uid[unique=true];onlyOneRestrictionMustApply
;;LoginLink;false
;;OrdersLink;false

UPDATE NavigationComponent;$contentCV[unique=true];uid[unique=true];onlyOneRestrictionMustApply
;;MyAccountComponent;false

# Add page template: required for CMS page even inactivated
INSERT_UPDATE PageTemplate;$contentCV[unique=true];uid[unique=true];name;active[default=true]
;;PunchoutTemplate;Punchout Template;false

# Add Punchout Content Pages
INSERT_UPDATE ContentPage;$contentCV[unique=true];uid[unique=true];name;masterTemplate(uid,$contentCV);label;defaultPage[default='true'];approvalStatus(code)[default='approved'];homepage[default='false']
;;PunchoutSessionPage;Punchout Session Page;PunchoutTemplate;/punchout/cxml/session;true;check;false
;;PunchoutRequisitionPage;Punchout Requisition Page;PunchoutTemplate;/punchout/cxml/requisition;true;check;false
;;PunchoutInspectCartPage;Punchout Inspect Cart Page;PunchoutTemplate;/punchout/cxml/inspect;true;check;false
;;PunchoutErrorPage;Punchout Error Page;ContentPage1Template;/punchout/cxml/error;true;check;false

# Add Content Slots
INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid,$contentCV)[mode=append]
;;CenterRightContentSlot-cartPage;Center Right Content Slot for Cart Page;PunchoutButtonsComponent
;;SiteLinksSlot;Slot contains some links;PunchoutCloseSessionComponent
;;SiteLoginPunchoutInspectCartSlot;Site Login Punchout Inspect cart;LoginComponent
;;BodyContentPunchoutInspectCartSlot;Body Content for Punchout Inspect Cart Page;PunchoutInspectCartComponent
;;BodyContentPunchoutSessionSlot;Body Content for Punchout Session Page;PunchoutSessionComponent
;;BodyContentPunchoutRequisitionSlot;Body Content for Punchout Requisition Page;PunchoutRequisitionComponent
;;Section2APunchoutErrorSlot;Section 2A for Punchout Error Page;PunchoutErrorComponent
;;PreheaderPunchoutEmptySlot;Preheader Punchout Empty Slot
;;SiteLoginPunchoutEmptySlot;Site Login Punchout Empty Slot

# Add Punchout Pages and ContentSlot relations
INSERT_UPDATE ContentSlotForPage;$contentCV[unique=true];uid[unique=true];position[unique=true];page(uid,$contentCV)[unique=true];contentSlot(uid,$contentCV)[unique=true]
;;SiteLogin-PunchoutSessionPage;SiteLogin;PunchoutSessionPage;SiteLoginPunchoutEmptySlot
;;SiteLogin-PunchoutRequisitionPage;SiteLogin;PunchoutRequisitionPage;SiteLoginPunchoutEmptySlot
;;SiteLogin-PunchoutInspectCartPage;SiteLogin;PunchoutInspectCartPage;SiteLoginPunchoutInspectCartSlot
;;SiteContext-PunchoutInspectCartPage;SiteContext;PunchoutInspectCartPage;SiteContextSlot
;;BodyContent-PunchoutInspectCartPage;BodyContent;PunchoutInspectCartPage;BodyContentPunchoutInspectCartSlot
;;BodyContent-PunchoutSessionPage;BodyContent;PunchoutSessionPage;BodyContentPunchoutSessionSlot
;;BodyContent-PunchoutRequisitionPage;BodyContent;PunchoutRequisitionPage;BodyContentPunchoutRequisitionSlot
;;Section2A-PunchoutErrorPage;Section2A;PunchoutErrorPage;Section2APunchoutErrorSlot
;;PreHeader-PunchoutInspectCartPage;PreHeader;PunchoutInspectCartPage;PreheaderPunchoutEmptySlot
;;PreHeader-PunchoutSessionPage;PreHeader;PunchoutSessionPage;PreheaderPunchoutEmptySlot
;;PreHeader-PunchoutRequisitionPage;PreHeader;PunchoutRequisitionPage;PreheaderPunchoutEmptySlot

# *** RESTRICTIONS ***

# PunchOut CMS User Group Restrictions, so only punchout users can see PunchOut specific components
INSERT_UPDATE CMSUserGroupRestriction;$contentCV[unique=true];uid[unique=true];&userGroupRestriction;name;userGroups(uid);includeSubgroups;components(uid, $contentCV)
;;PunchOutGroupRestriction;PunchOutGroupRestriction;PunchOut Group Restriction;PunchOut Organization;true;PunchoutButtonsComponent,PunchoutRequisitionComponent,PunchoutCloseSessionComponent

# CMS Inverse Restriction: components being hidden for punchout users
INSERT_UPDATE CMSInverseRestriction;$contentCV[unique=true];uid[unique=true];name;originalRestriction(&userGroupRestriction)[allownull=true];components(uid, $contentCV)
;;PunchOutGroupInverseRestriction;PunchOutGroupInverseRestriction;PunchOutGroupRestriction;FooterNavigationComponent,OrdersLink,StoreFinderLink,ContactUsLink,HelpLink,MyAccountComponent,CartProceedToCheckoutComponent,CheckoutComponent,SiteLogoComponent,LoginLink,AddToSavedCartsComponent,CartApplyCouponComponent,QuoteRequestComponent,ClearCartComponent
```

## Configuring CCV2 Server Side

### CORS Addition

'punchoutsid' key needs to be added in CORS allow list.

### Required System Variables (Requirements?)

The punchout launch page consists of Spartacus b2b url followed with punchout session path.
eg: https://spartacus/punchout/cxml/session
Below are details to set those 2 paths:

#### Spartacus b2b url:

It is defined on Hybris Configuration Properties, on key:
'website.powertools-spa.https'

#### Spartacus Punchout Session path

url is setup on Hybris Configuration Properties, on field 'b2bpunchoutaddon.mapping.punchout.session.request'
This url needs to match the CMS Punchout Session page link, on sample data it is set as '/punchout/cxml/session'.
This url also need to be setup on Spartacus side, see chapter 'Modify PunchOut Pages Link'.
Make sure the 3 paths are identical.

### OCC API Endpoint Whitelist

To prevent user accessing info out of punchout user scope (eg: checkout on supplier shop, view order details), an allow list of api endpoints has been established, see details on:
https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/7e47d40a176d48ba914b50957d003804/e43d443fae45491aae1be387507e7ddb.html?state=DRAFT#allowed-list-of-endpoints-for-punchout-customers

## Spartacus Optional Configuration

### Modify Allowed Page List

### Modify PunchOut Pages Link

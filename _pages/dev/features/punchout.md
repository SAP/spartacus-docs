---
title: B2B PunchOut Integration
---

B2B PunchOut allows a buyer to shop a supplier's online catalog and save the items that have been selected for purchase as a requisition in the buyer's procurement system.

The following sections describe how to enable, configure and customize B2B PunchOut.

For information on how to use B2B PunchOut in the storefront, see [B2B PunchOut]([link](https://help.sap.com/docs/SAP_COMMERCE_COMPOSABLE_STOREFRONT/d1ca9a1517f847a5b57b4e08400807c1/5313a1c045424e5497a98067b38059f2.html?locale=en-US&state=DRAFT)).

For more general information about the B2B PunchOut feature, see [B2B PunchOut Module](https://help.sap.com/docs/SAP_COMMERCE/4c33bf189ab9409e84e589295c36d96e/60fbb8dccb7a45949c570b6b1c272f10.html?version=2205).

## Enabling B2B PunchOut

You enable B2B PunchOut by installing the `@spartacus/punchout` integration library, as follows:

```bash
ng add @spartacus/punchout
```

For more information, see [Installing Additional Composable Storefront Libraries](https://help.sap.com/docs/SAP_COMMERCE_COMPOSABLE_STOREFRONT/eaef8c61b6d9477daf75bff9ac1b7eb4/e38d45609de04412920a7fc9c13d41e3.html?locale=en-US&version=2211#loioaa76b408d0324aea889aeeaed899144a).

B2B PunchOut is CMS-driven. If you are using the [Spartacus Sample Data Extension](https://help.sap.com/docs/SAP_COMMERCE_COMPOSABLE_STOREFRONT/eaef8c61b6d9477daf75bff9ac1b7eb4/edc7f3a95ac4424b9cc5077d86a62e36.html?locale=en-US&version=2211#loioedc7f3a95ac4424b9cc5077d86a62e36), the B2B PunchOut CMS data are already enabled. However, if you are not using the `spartacussampledata` extension, you can enable the necessary CMS data manually through ImpEx.

### Adding B2B PunchOut CMS Data Manually

To add all of the necessary CMS components and data for B2B PunchOut, import the following ImpEx:

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

## Configuring B2B PunchOut in SAP Commerce Cloud

The following sections describe how to configure CORS for B2B PunchOut, how to set a system variable for the PunchOut launch page, and how to set which OCC API endpoints are allowed. These configurations are done in SAP Commerce Cloud.

### Configuring CORS

B2B PunchOut requires that you configure CORS by adding `punchoutsid` to `corsfilter.commercewebservices.allowedHeaders` and `corsfilter.commercewebservices.exposedHeaders`.

If you are working with a `local.properties` file, update your `corsfilter` properties as shown in the following example:

```text
corsfilter.commercewebservices.allowedHeaders=origin content-type accept authorization cache-control x-anonymous-consents x-profile-tag-debug x-consent-reference if-none-match occ-personalization-id occ-personalization-time punchoutsid
corsfilter.commercewebservices.exposedHeaders=x-anonymous-consents occ-personalization-id occ-personalization-time punchoutsid
```

If you are working with a `manifest.json` file, update the values of your `corsfilter` keys as shown in the following example:

```json
{
  "key": "corsfilter.commercewebservices.allowedHeaders",
  "value": "origin content-type accept authorization cache-control x-anonymous-consents x-profile-tag-debug x-consent-reference if-none-match occ-personalization-id occ-personalization-time punchoutsid"
},
{
  "key": "corsfilter.commercewebservices.exposedHeaders",
  "value": "x-anonymous-consents occ-personalization-id occ-personalization-time punchoutsid"
},
```

### Setting the B2B PunchOut Session Path

The B2B PunchOut launch page consists of the B2B storefront URL, followed by the PunchOut session path. The following is an example:

```text
https://<URL of your B2B storefront>/punchout/cxml/session
```

You use `website.powertools-spa.https` to define your B2B storefront URL, and `b2bpunchout.mapping.punchout.session.request` to define the PunchOut session path.

If you are working with a `local.properties` file, update your properties as shown in the following example:

```text
website.powertools-spa.https=https://composable-storefront-demo.eastus.cloudapp.azure.com/powertools-spa
b2bpunchout.mapping.punchout.session.request=/punchout/cxml/session
```

If you are working with a `manifest.json` file, update your keys as shown in the following example:

```json
{
  "key": "website.powertools-spa.http",
  "value": "https://composable-storefront-demo.eastus.cloudapp.azure.com/powertools-spa"
},
{
  "key": "b2bpunchout.mapping.punchout.session.request",
  "value": "/punchout/cxml/session"
},
```

In the examples above, the B2B storefront URL provided in the examples above is the URL to an SAP demo storefront site. Replace this value with the URL to your B2B storefront.

Also, the value provided for `b2bpunchout.mapping.punchout.session.request` must match the CMS PunchOut Session page link. In the ImpEx data provided above, this value is set to `/punchout/cxml/session`. This value must also match the definition provided for B2B PunchOut page routes. For more information, see [Configuring Routes for B2B PunchOut Pages](#configuring-routes-for-b2b-punchout-pages).

### OCC API Endpoint Allow List

To prevent users from accessing pages that are outside of the scope of the PunchOut experience, such as the supplier's checkout or order details, you can define the allowed list of OCC API endpoints that users can access. For more information, see [Allowed List of Endpoints for PunchOut Customers](https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/7e47d40a176d48ba914b50957d003804/e43d443fae45491aae1be387507e7ddb.html?state=DRAFT#allowed-list-of-endpoints-for-punchout-customers).

## Configuring B2B PunchOut in Spartacus

### Updating the Product Route for B2B PunchOut

Spartacus does not have access to the product name parameter during navigation. To ensure stability, you need to configure the routing to allow the storefront to access the product details page using only the `productCode`.

Define or modify your existing routing configuration for `product` by adding a route matcher that uses `productCode` only. The following is an example:

```ts
provideConfig(<RoutingConfig>{
  routing: {
    routes: {
      product: {
        paths: [/* ... */, 'product/:productCode'],
      },
    },
  },
}),
```

### Configuring Navigation

B2B PunchOut provides a navigation guard configuration that controls which pages and routes a user can access during different PunchOut operations. This configuration helps ensure that users only navigate to allowed pages based on their current PunchOut operation, which improves security and the user experience.

The navigation guard is configured using the `PunchoutNavigationGuardConfig` abstract class, which defines allowed URLs and CX routes for each PunchOut operation, along with a redirect page if the user attempts to access a page outside of the allowed list. The following is an example of the PunchOut navigation guard configuration:

```ts
export abstract class PunchoutNavigationGuardConfig {
  punchoutNavigation?: {
    [PunchOutOperation.EDIT]: {
      allowedUrls?: string[];
      allowedCxRoutes?: string[];
      redirectPage: string | LaunchRoute;
    };
    [PunchOutOperation.CREATE]: {
      allowedUrls?: string[];
      allowedCxRoutes?: string[];
      redirectPage: string | LaunchRoute;
    };
    [PunchOutOperation.INSPECT]: {
      allowedUrls?: string[];
      allowedCxRoutes?: string[];
      redirectPage: string | LaunchRoute;
    };
  };
}
```

The configuration properties are described as follows:

- `allowedUrls` is an optional array of URL strings that are permitted for the given PunchOut operation. The value `/` represents the home page. URLs are considered allowed if they are contained within the current browser relative path.
- `allowedCxRoutes` is an optional array of CX route names that are permitted for the given PunchOut operation. For more information on CX routes, see [Working with Angular Routes](https://help.sap.com/docs/SAP_COMMERCE_COMPOSABLE_STOREFRONT/eaef8c61b6d9477daf75bff9ac1b7eb4/1406702864a24c55ae0daa50c5b590e7.html?q=cxRoute&version=2211#working-with-angular-routes).
- `redirectPage` is the page `LaunchRoute` or the path to redirect to if a user tries to access a page outside the allowed list.

The configuration uses the `PunchOutOperation` enum to specify the operation context, as shown in the following example:

```ts
export enum PunchOutOperation {
  CREATE = 'CREATE',
  EDIT = 'EDIT',
  INSPECT = 'INSPECT',
}
```

These operations are defined as follows in the default navigation guard configuration:

```ts
export const defaultPunchoutNavigationGuardConfig: PunchoutNavigationGuardConfig =
  {
    punchoutNavigation: {
      [PunchOutOperation.INSPECT]: {
        allowedCxRoutes: [
          'punchoutSession',
          'punchoutRequisition',
          'punchoutInspect',
        ],
        redirectPage: { cxRoute: 'punchoutInspect' },
      },
      [PunchOutOperation.EDIT]: {
        allowedUrls: ['/'],
        allowedCxRoutes: [
          'punchoutSession',
          'punchoutRequisition',
          'category',
          'brand',
          'quickOrder',
          'product',
          'cart',
          'search',
          'punchoutError',
        ],
        redirectPage: { cxRoute: 'home' },
      },
      [PunchOutOperation.CREATE]: {
        allowedUrls: ['/'],
        allowedCxRoutes: [
          'punchoutSession',
          'punchoutRequisition',
          'category',
          'brand',
          'quickOrder',
          'product',
          'cart',
          'search',
          'punchoutError',
        ],
        redirectPage: { cxRoute: 'home' },
      },
    },
  };
```

In the above example, the `INSPECT` operation allows navigation only to PunchOut-specific routes, such as the session, requisition, and inspect pages. Unauthorized access redirects the user to the `punchoutInspect` page. The `EDIT` and `CREATE` operations allow a broader set of routes, including product browsing, cart, and search pages, with unauthorized access redirecting to the home page.

You can customize the allowed pages and redirect behavior by extending or overriding the `PunchoutNavigationGuardConfig` in your storefront configuration. This allows you to adjust the security restrictions and tailor the user experience to your specific PunchOut use case. The following configuration is an example of how to add a new allowed route for the `EDIT` operation:

```ts
provideConfig({
  punchoutNavigation: {
    [PunchOutOperation.EDIT]: {
       allowedUrls: ['/'],
       allowedCxRoutes: [
         'punchoutSession',
         'punchoutRequisition',
         'category',
         'brand',
         'quickOrder',
         'product',
         'cart',
         'search',
         'punchoutError',
         'customRoute', // added custom route
        ],
        redirectPage: {cxRoute: 'home'},
    },
    // other operations...
      }
}),
```

### Configuring Routes for B2B PunchOut Pages

B2B PunchOut in Spartacus defines specific routes for handling PunchOut-related pages. These routes correspond to key steps in the PunchOut process, such as session initiation, requisition handling, cart inspection, and error display.

You can customize these routes by modifying the routing configuration, which allows you to change the URL paths or adjust the route protection and authentication behavior to fit your storefront requirements.

The default routing configuration for PunchOut pages is defined as follows:

```ts
export const defaultPunchoutRoutingConfig: RoutingConfig = {
  routing: {
    routes: {
      punchoutSession: {
        paths: ['punchout/cxml/session'],
        protected: false,
        authFlow: true,
      },
      punchoutRequisition: {
        paths: ['punchout/cxml/requisition'],
      },
      punchoutInspect: {
        paths: ['punchout/cxml/inspect'],
      },
      punchoutError: {
        paths: ['punchout/cxml/error'],
        protected: false,
        authFlow: true,
      },
    },
  },
};
```

You can customize the paths, protection, and authentication flow flags by overriding the configuration in your routing setup, as shown in the following example:

```ts
provideConfig({
  routing: {
    routes: {
        punchoutSession: {
            paths: ['punchout/session'],
            protected: false,
            authFlow: true,
        },
        punchoutRequisition: {
            paths: ['punchout/requisition'],
        },
        punchoutInspect: {
            paths: ['punchout/inspect'],
        },
        punchoutError: {
            paths: ['punchout/error'],
            protected: false,
            authFlow: true,
        },
    },
  },
}),
```

In this example, `cxml` is removed from the `paths` definitions.

**Note:** If you make a change to the `paths` in the routing configuration, you also need to make a corresponding update to the configuration of the CMS data. Furthermore, if you update the `paths` definition for `punchoutSession`, be sure to also update the value for `b2bpunchout.mapping.punchout.session.request`, as described in [Setting the B2B PunchOut Session Path](#setting-the-b2b-punchout-session-path).

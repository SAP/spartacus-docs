---
title: PunchOut
---

The B2B PunchOut functionality allows a buyer to shop a supplier's online catalog and save the cart as a requisition in the buyer's procurement system for approval.

## Schematics / (Enabling B2B PunchOut in Composable Storefront?)

To enable B2B PunchOut, you can install the PunchOut library using the following schematics:

```bash
ng add @spartacus/punchout
```

## CMS Components

(Verify)
The PunchOut feature is CMS-driven. If you are using the Spartacus Sample Data Extension, the PunchOut CMS components are already enabled. However, if you decide not to use the `spartacussampledata` extension, you can enable the PunchOut CMS components manually through ImpEx.

### Adding the CMS Components Manually Using ImpEx

To add all of the necessary CMS components and related data for PunchOut, import the following ImpEx:

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

## Configuring Commerce Server Side

### CORS Addition (section necessary?)

You must add the 'punchoutsid' key to the CORS allow list.

### Required System Variables

The PunchOut launch page consists of the Spartacus B2B URL followed by the PunchOut session path, for example, https://spartacus/punchout/cxml/session.

#### Spartacus B2B URL (section necessary?)

You define the Spartacus B2B URL on Hybris Configuration Properties (*what does "on" mean here? should it be "in"?), on key: 'website.powertools-spa.https'.

#### The Spartacus PunchOut Session Path (section necessary?)

You set up the URL on Hybris Configuration Properties, on the 'b2bpunchout.mapping.punchout.session.request' field. This URL must match the CMS PunchOut Session page link. In the sample data, it is set as '/punchout/cxml/session'. The URL must also be set up on the Spartacus side. For more information, see Modify PunchOut Pages Link. 

You must ensure the 3 paths are identical.

### OCC API Endpoint Allow List

## Spartacus required configuration

### Routing configuration
Since we do not have access to the product name parameter during navigation, to ensure stability the routing configuration requires that it is possible to access the product details page using the `productCode` only.
Please define or modify your own routing configuration provided for the `product`, by adding a route matcher which uses `productCode` only, for example, as follows:

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

To ensure users have a secure experience tailored to their needs, only certain OCC API endpoints are allowed. This prevents users from accessing endpoints they don't need, such as checkout in the supplier shop or view order details (*verify wording). For more information, see (insert loio)
https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/7e47d40a176d48ba914b50957d003804/e43d443fae45491aae1be387507e7ddb.html?state=DRAFT#allowed-list-of-endpoints-for-punchout-customers.

## Optional Spartacus Configuration

### Modifying the Allowed Page List / (Configuring the Navigation Guard?)

The PunchOut feature includes a navigation guard configuration that controls which pages and routes a user can access during different PunchOut operations. This configuration helps ensure that users only navigate to allowed pages based on their current PunchOut operation, improving security and user experience.

The navigation guard is configured using the `PunchoutNavigationGuardConfig` abstract class, which defines allowed URLs and CX routes for each PunchOut operation, along with a redirect page if the user attempts to access a disallowed page. The following configuration is an example: 

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

- `allowedUrls` is an optional array of URL strings that are permitted for the given PunchOut operation. The value '/' represents the home page. URLs are considered allowed if they are contained within the current browser relative path.
- `allowedCxRoutes` is an optional array of CX route names that are permitted.
- `redirectPage` is the page LaunchRoute or path to redirect to if a user tries to access a page outside the allowed list.

The configuration uses the `PunchOutOperation` enum to specify the operation context, as shown in the following example:

```ts
export enum PunchOutOperation {
  CREATE = 'CREATE',
  EDIT = 'EDIT',
  INSPECT = 'INSPECT',
}
```

The default navigation guard configuration provides the following defaults for each operation:

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

The INSPECT operation allows navigation only to PunchOut-specific routes such as session, requisition, and inspect pages. Unauthorized access redirects the user to the `punchoutInspect` page. The EDIT and CREATE operations allow a broader set of routes, including product browsing, cart, and search pages, with unauthorized access redirecting to the home page.

#### Customizing Allowed Pages

You can customize the allowed pages and redirect behavior by extending or overriding the `PunchoutNavigationGuardConfig` in your Spartacus storefront configuration. This allows tailoring the user experience and security restrictions to your specific PunchOut use case. The following configuration is an example of how to add a new allowed route for the EDIT operation:

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

### Modifying the PunchOut Pages Link

The PunchOut feature in Composable Storefront defines specific routes for handling PunchOut-related pages. These routes correspond to key steps in the PunchOut process, such as session initiation, requisition handling, cart inspection, and error display.
You can customize these routes by modifying the routing configuration, allowing you to change the URL paths or adjust route protection and authentication behavior to fit your storefront requirements.

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

#### Customization

You can customize the paths, protection, and authentication flow flags by overriding the following configuration in your routing setup:

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

In this example, the extra cxml is removed, which you also must configure on the CMS side.

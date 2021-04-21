---
title: Release Information for All Versions of Spartacus Libraries
---

**Latest news: 3.2.0 final published April 15, 2021**

*Last updated April 15, 2021 by Bill Marcotte, Senior Product Manager, Spartacus*

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Introduction

This document describes what is included in all Spartacus libraries since the initial 1.0 release, up to 3.2.

- For information on specific code changes for a particular release, see the [Development Release Notes](https://github.com/SAP/spartacus/releases).
- For information about features published in pre-release libraries, see [Pre-Release Information]({{ site.baseurl }}{% link _pages/home/pre-release-information.md %}).
- For information about upgrading, see [Upgrading Spartacus Libraries to a New Minor Version](#upgrading-spartacus-libraries-to-a-new-minor-version).
- For information about which versions of the Spartacus libraries and SAP Commerce Cloud are required for a specific feature, see [Feature Compatibility]({{ site.baseurl }}{% link _pages/home/feature-release-versions.md %}).
- If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ). Feedback welcome!

**Disclaimer - Forward-Looking Statements**

*This document contains or may contain forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality. This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence.*

*The various documentation links provided point to SAP Commerce Cloud or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented in Spartacus.*
  
## Release 3.2

*Release 3.2 libraries published April 15, 2021*

- The default behavior for schematics has been changed and Spartacus is now installed with a new app structure. For more information, see [Reference App Structure]({{ site.baseurl }}{% link _pages/install/reference-app-structure.md %})
- Tag Manager framework with support for Google and Adobe tag systems, and Google Analytics [(documentation)]({{ site.baseurl }}{% link _pages/dev/features/tag-management-system.md %})
- New events for Event Service: Search suggestion clicked, facet changed in search/category results, context change (language/currency) [(documentation)]({{ site.baseurl }}{% link _pages/dev/features/event-service.md %})
- B2B Bulk Pricing [(documentation)]({{ site.baseurl }}{% link _pages/dev/features/bulk-pricing.md %})
- Saved Carts [(documentation)]({{ site.baseurl }}{% link _pages/dev/features/saved-cart.md %})
- New popover text component [(documentation)]({{ site.baseurl }}{% link _pages/dev/components/shared-components/popover-component.md %})
- HTML tags [(documentation)]({{ site.baseurl }}{% link _pages/dev/seo/html-tags.md %})
- General improvements to B2B Commerce Organization user experience
- Code splitting continues with new libraries for SmartEdit, Events, Tag Management, and saved carts - see schematics for installation [(documentation)]({{ site.baseurl }}{% link _pages/install/schematics.md %})
- New module initialization functionality for lazy-loaded features [(documentation)]({{ site.baseurl }}/lazy-loading-guide/#initializing-lazy-loaded-modules)
- An official release of the SAP Customer Data Cloud integration library is now available [(documentation)]({{ site.baseurl }}{% link _pages/install/integrations/cdc-integration.md %})
- Dynamic configuration with support for site themes
- Bug fixes

Updates to documentation have been published for all topics, with additional updates to:

- [Structured Data]({{ site.baseurl }}{% link _pages/dev/seo/structured-data.md %})
- [SEO Capabilities]({{ site.baseurl }}{% link _pages/dev/seo/seo-capabilities.md %})
- [SmartEdit Setup Instructions for Spartacus]({{ site.baseurl }}{% link _pages/install/smartEdit-setup-instructions-for-spartacus.md %})
  
## Release 3.1

*Release 3.1 libraries published February 25, 2021*

- SAP Variant Configuration and Pricing
- Qualtrics Embedded Feedback
- New Events
- Performance Improvements with Code Splitting
 
### SAP Variant Configuration and Pricing

We're happy to announce that the Spartacus library for SAP Variant Configuration and Pricing has been released. This library provides the following features:

- Single-level and multilevel configurable products in your Spartacus storefront, where the product model resides in SAP ERP or SAP S/4HANA
- A configuration page with the most commonly used characteristic types, such as radio buttons, checkboxes, drop-down listboxes, and images for characteristic values
- A price summary at the bottom of the configuration page with the base price, the price of the selected options, and the total price of the configured product
- An overview page with all user selections accessible at any time during configuration
- Basic conflict handling
- Inclusion of configurable products as part of storefront processes, such as catalog browsing, product detail page, add to cart, checkout, and order history

The SAP Variant Configuration and Pricing add-on for Commerce provides the user interface (UI) with which configurable products can be configured and sold using SAP Variant Configuration and Pricing.

**Note:** The SAP Variant Configuration and Pricing add-on for Commerce is not included with the Spartacus libraries.

For more information, see [Configurable Products Integration]({{ site.baseurl }}{% link _pages/install/integrations/configurable-products-integration.md %}) in the Spartacus documentation, and [Product Configuration with SAP Variant Configuration and Pricing](https://help.sap.com/viewer/80c3212d1d4646c5b91db43b84e9db47/latest/en-US) on the SAP Help Portal.

### Qualtrics Embedded Feedback

We're happy to also announce support for the Qualtrics Embedded Feedback feature. For more information, see [Spartacus Support for Qualtrics Embedded Feedback]({{ site.baseurl }}/qualtrics-integration#spartacus-support-for-qualtrics-embedded-feedback).

**Note:** Starting with Spartacus 3.1, you must install the Qualtrics feature library to be able to use Qualtrics features. You can install the Qualtrics library by running the following command:

```shell
 ng add @spartacus/qualtrics
 ```

### New Events

Events now triggered when a customer logs in or logs out. For more information, see [Event Service]({{ site.baseurl }}{% link _pages/dev/features/event-service.md %}).

### Performance Improvements with Code Splitting / Lazy Loading

The Spartacus code-based is being separated out into modules for better performance. The 3.1 release includes new libraries for Qualtrics and Variant Configuration. More modules will be split out in future releases. For more information, see [Lazy-Loaded CMS Components]({{ site.baseurl }}/customizing-cms-components/#lazy-loaded-cms-components-code-splitting).
  
  
## Release 3.0

*Release 3.0 libraries published December 17, 2020*

- **Uses Angular 10**
- **B2B Powertools Store support** (for more information, see [Powertools Extension](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ae789ad86691014afcccba59ba613e9.html) in the SAP Help Portal)
- **B2B Commerce Organization** (Spartacus-specific documentation to come - for information on the overall feature as provided by SAP Commerce Cloud, see [Commerce Organization](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac27d4d86691014a47588e9126fdf21.html) in the SAP Help Portal)
- **B2B Checkout** ([documentation]({{ site.baseurl }}/extending-checkout/#b2b-checkout)). For information on the overall feature as provided by SAP Commerce Cloud, see [B2B Checkout](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac2500f8669101493e69e1392b970fd.html) in the SAP Help Portal.
- **B2B Scheduled Replenishment** ([documentation]({{ site.baseurl }}{% link _pages/dev/features/scheduled-replenishment.md %}))
- **Session Management** ([documentation]({{ site.baseurl }}{% link _pages/dev/session-management.md %}))
- **Release 3.0 Documentation** published (v2 and v1 archived)

As always, feedback appreciated! Contact us through Slack or submit an [issue](https://github.com/SAP/spartacus/issues/new/choose).

### Notes about this Release

- Make sure to use the latest sample data, which includes updates to CMS data for the out-of-the-box Powertools store. The latest sample data is published with the [Storefront library](https://github.com/SAP/spartacus/releases/tag/storefront-3.0.0), in the Assets section.
- Spartacus 3.0 and later use the new Spartacus sample data extension (not the addon). For now we provide both for download. However, the sample data extension will be the only one updated in the future. 
- The same backend can be used for hosting both B2C and B2B stores. However, Spartacus requires two different apps, with two different configurations, one for B2C stores, and one for B2B stores. (The ability to use one app for both B2C and B2B will be added in a future Spartacus release.) For more information, see [Building the Spartacus Storefront from Libraries]({{ site.baseurl }}{% link _pages/install/building-the-spartacus-storefront-from-libraries.md %}).
- Setting up a B2B Spartacus store follows the same process as for a B2C store, with one extra step for adding B2B Commerce Organization features using schematics (`ng add @spartacus/organization`). For more information, see [Building the Spartacus Storefront from Libraries]({{ site.baseurl }}{% link _pages/install/building-the-spartacus-storefront-from-libraries.md %}).
- Do not use a B2B Spartacus for a B2C base store. OCC API calls are different, and many aspects of the store will not work. For example, if you point a B2B store to Electronics base store, adding to cart does not work as the call is different.
- B2B Commerce Organization allows you to configure units, users, budgets, cost centers, and spending limits, for the purposes of spend tracking and requiring approvals. For more information on how this feature works in SAP Commerce Cloud, see [Commerce Organization](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac27d4d86691014a47588e9126fdf21.html) on the SAP Help Portal.
- SAP Commerce Cloud ships with all users disabled and no passwords defined. When exploring how to use Spartacus and SAP Commerce Cloud, one of the steps is to import sample users and passwords (see [this help topic](https://help.sap.com/viewer/9433604f14ac4ed98908c6d4e7d8c1cc/latest/en-US/c5d463ec2fbb45b2a7aef664df42d2dc.html)). After that is done, you can use the default B2B users as defined in the [Powertools Extension](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ae789ad86691014afcccba59ba613e9.html) in help.sap.com. For example, you can log in as linda.wolf@rustic-hw.com, who is an administrator for the Rustic Hardware set of units.

## Release 2.1

*Release 2.1.0 libraries published August 27, 2020*

- **Directionality**: Provides support for bidirectional text and layout. You can configure Spartacus to use a left-to-right (LTR) orientation, or a right-to-left (RTL) orientation. The 2.1 feature is for core functionality; that Spartacus updates to CSS will be completed in the 3.0. For more information, see the [documentation]({{ site.baseurl }}{% link _pages/dev/styling-and-page-layout/directionality.md %}).
- **Style Library Versioning**: Allows the core Spartacus development team to introduce gradual changes in the style layer while maintaining backwards compatibility. New or adjusted style rules are added for a specific version, but these changes are not added in the style build process unless you explicitly opt in to receive these changes. For more information, see the [documentation]({{ site.baseurl }}{% link _pages/dev/styling-and-page-layout/css-architecture.md %}).

## Release 2.0

*Release 2.0.0 libraries published June 3, 2020*

As Release 2.0 is a new major version, it contains breaking changes. To migrate to 2.0 from 1.x, see the following documentation:

- [Updating to Version 2.0]({{ site.baseurl }}{% link _pages/home/updating-to-version-2/updating-to-version-2.md %}) (automated update using schematics)
- [Technical Changes in Spartacus 2.0]({{ site.baseurl }}{% link _pages/home/updating-to-version-2/technical-changes-version-2.md %})
- [Changes to Styles in 2.0]({{ site.baseurl }}{% link _pages/home/updating-to-version-2/css-changes-in-version-2.md %})

The following is a summary of the major changes introduced in 2.0:

- Framework updated to Angular 9, including related dependencies such as ngrx 9
- [Schematics updated]({{ site.baseurl }}{% link _pages/install/schematics.md %})
- [Accessibility Keyboarding features]({{ site.baseurl }}{% link _pages/dev/accessibility/keyboard-focus/keyboard-focus.md %})
- [Lazy loading of CMS components]({{ site.baseurl }}/customizing-cms-components/#lazy-loaded-cms-components-code-splitting)
- [Event Service]({{ site.baseurl }}{% link _pages/dev/features/event-service.md %}), with Add to Cart event
- [State Persistence]({{ site.baseurl }}{% link _pages/dev/state_management/state-persistence.md %})
- [Custom Angular URL Matching]({{ site.baseurl }}/adding-and-customizing-routes/#avoiding-static-url-segments-in-the-product-page-url-advanced)
- Many components refactored
- New facet navigation makes extending facets easier
- Deprecated code removed

### Notes for deployment of Spartacus 2.0 storefronts via SAP Commerce cloud hosting service

Spartacus 2.0 uses Angular 9, which changes certain file locations. As of this writing (July 2020), to use Spartacus 2.0 with SAP Commerce Cloud in the Public Cloud hosting services, you must make the following changes to your Angular application for it to build properly. (For more information, see https://github.com/SAP/spartacus/issues/7993.) This will be fixed in a future release of SAP Commerce Cloud in the Public Cloud.

Changes in `angular.json`:

- `"outputPath": "dist/app-name/browser"` to
  `"outputPath": "dist/app-name"`
- `"outputPath": "dist/app-name/server"` to
  `"outputPath": "dist/app-name-server"`

Change in `server.ts`:

- `const distFolder = join(process.cwd(), 'dist/app-name/browser');` to
  `const distFolder = join(process.cwd(), 'dist/app-name');`

### For more information on changes

For a detailed list of all changes for 2.0 and previous 'next' releases of the Spartacus libraries, see the [Spartacus project release page](https://github.com/SAP/spartacus/releases) on GitHub.

## Release 1.5
  
*Release 1.5 libraries published February 26, 2020*

- [Context Driven Services]({{ site.baseurl }}{% link _pages/install/integrations/cds-integration.md %})  
Context-Driven Services provides real-time customer experience personalization for SAP Commerce Cloud, now with support for Spartacus! Integration includes the Profile Tag and the Merchandising Carousel features. For more information on the Context-Driven Services feature itself, see the [Context-Driven Services documentation in the SAP Help Portal](https://help.sap.com/viewer/product/CONTEXT-DRIVEN_SERVICES).

- [Customer Coupons]({{ site.baseurl }}{% link _pages/dev/features/customer-coupons.md %})  
Increase conversion and customer loyalty with Customer Coupons. This feature provides a range of functionality for promotion campaigns, such as allowing customers to claim a coupon using the coupon’s campaign URL, turning on status notifications for a coupon, allowing users to view their coupons in the My Coupons section, and applying usable coupons during checkout.

- [Selective Cart]({{ site.baseurl }}{% link _pages/dev/features/selective-cart.md %})  
Increase conversion and buyer convenience with Selective Cart. Also known as "Save for Later", Selective Cart allows customers to select which items in the cart they wish to purchase, and to leave other items in the cart for future consideration. This improves the shopping experience and increases the conversion rate.

- [Variants]({{ site.baseurl }}{% link _pages/dev/features/variants.md %}) (as seen in the Apparel store)  
Organize and logically display product variants like color and size, making it easier for customers to discover the particular style they want.

- Applied Promotions  
Promotions now appear in all required locations (in the **Added-to-Cart** modal for example), not just in the cart. Per-product promotions now also appear in the product entry. This work also includes refactoring to accommodate future support for potential promotions.

- [Skip Links]({{ site.baseurl }}{% link _pages/dev/features/skip-links.md %})  
The Skip Links features allows users to quickly navigate to important areas of a page using the keyboard. This feature is the first of several Accessibility feature improvements planned for Spartacus.

- Bug fixes as described in the [development release notes](https://github.com/SAP/spartacus/releases)

## Release 1.4

*Release 1.4 libraries published January 27, 2020*
  
What's new?

- [Wish List]({{ site.baseurl }}{% link _pages/dev/features/wish-list.md %})
- [Back-in-Stock Notification]({{ site.baseurl }}{% link _pages/dev/features/stock-notification.md %})  
  - [Notification Preferences]({{ site.baseurl }}{% link _pages/dev/features/notification-preferences.md %})
  - [Customer Interests]({{ site.baseurl }}{% link _pages/dev/features/customer-interests.md %})
- [Token Revocation]({{ site.baseurl }}{% link _pages/dev/features/token-revocation.md %}) (supports back end improvement added to 1905.6)
- [Stacked Outlets]({{ site.baseurl }}/outlets/#stacked-outlets)
- [Product data performance improvements with loading scopes]({{ site.baseurl }}{% link _pages/dev/backend_communication/loading-scopes.md %}). You can also see [GitHub Issue 3666](https://github.com/SAP/spartacus/issues/3666) for more information.
- [Deferred Loading]({{ site.baseurl }}{% link _pages/dev/performance/deferred-loading.md %})
- [Above-the-Fold Loading]({{ site.baseurl }}{% link _pages/dev/performance/above-the-fold.md %})
- CMS component data loading optimization. For more information, see [GitHub Issue 5845](https://github.com/SAP/spartacus/issues/5845)
- Updates to cart handling to support future features. For more information, see [GitHub Issue 4432](https://github.com/SAP/spartacus/issues/4432)

**Note:** The Cancellations and Returns feature is also part of 1.4. However, this feature requires updates to OCC REST APIs that are not yet released. The updated APIs are scheduled to be part of the May 2020 release (Release 2005) of SAP Commerce Cloud. Please see official SAP Commerce Cloud release announcements for more information.

## Release 1.3

*Release 1.3 libraries published November 18, 2019*

What's new?

### Architecture and Development Features

- Storefront Self-Configuration (detection of languages, currencies, and other site settings through base site API)  
  [Spartacus Documentation]({{ site.baseurl }}{% link _pages/dev/context/context-configuration.md %})

- Structured Data (provides a data structure for the web that makes the web content more understandable for web crawlers)  
[Spartacus Documentation]({{ site.baseurl }}{% link _pages/dev/seo/structured-data.md %})

- Qualtrics intercept integration and example  
[Spartacus Documentation]({{ site.baseurl }}{% link _pages/install/integrations/qualtrics-integration.md %})

### Core/B2C Storefront Features

- Assisted Service Module (ASM) customer emulation (requires October patch release of SAP Commerce Cloud 1905)  
  [Spartacus Documentation]({{ site.baseurl }}{% link _pages/dev/features/asm.md %}) [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b571515866910148fc18b9e59d3e084.html)

- Anonymous consent  
  [Spartacus Documentation]({{ site.baseurl }}{% link _pages/dev/features/anonymous-consent.md %}) [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/a9f387f70d484c19971aca001dc71bc5.html)
  
- Coupons (requires October patch release of SAP Commerce Cloud 1905)  
  [Spartacus Documentation]({{ site.baseurl }}{% link _pages/dev/features/coupons.md %}) [SAP Commerce Cloud Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/02a8521eb67b4866a632a1a5e79037e3.html?q=coupons)

### B2B Storefront Features

Powertools sample data modified to work with Spartacus (requires latest spartacussampledata).  

**Note:** B2B Spartacus not yet available (B2B My Company and Checkout planned for Q1 2020). Powertools out-of-the-box sample data itself is now “Spartacus-ified” so that it displays properly when you point Spartacus to it. It’s what we’re using to do our development. However My Company and Checkout not yet supported; you’ll see a few errors related to API calls that we are part of the updated b2boccaddon API release in Q1.
  
## Release 1.2

*Release 1.2 libraries published September 30, 2019*

What's new?

- [Store Locator]({{ site.baseurl }}{% link _pages/dev/features/store-locator.md %})
- [Guest Checkout]({{ site.baseurl }}{% link _pages/dev/features/guest-checkout.md %})
- [Express Checkout]({{ site.baseurl }}{% link _pages/dev/features/express-checkout.md %})
- [Infinite Scroll]({{ site.baseurl }}{% link _pages/dev/features/infinite-scroll.md %})
- Routing Migration
- [Early Login]({{ site.baseurl }}{% link _pages/dev/routes/early-login.md %})
- [Consignment Tracking]({{ site.baseurl }}{% link _pages/dev/features/consignment-tracking.md %})
- Angular updated to 8.2.5; NgRx to 8.3.0; other dependency updates

To update to 1.2.0, you must change your libraries in `package.json` and and dependencies inside `app.module.ts`. See [Building the Spartacus Storefront from Libraries]({{ site.baseurl }}{% link _pages/install/building-the-spartacus-storefront-from-libraries.md %}) for more information.

- To use 1.2 features, add these to `B2cStorefrontModule.withConfig({`
    ```
    features: {
        level: '1.2',
        consignmentTracking: true,
      },
    ```
  
- To enable guest or express checkout, add these to `B2cStorefrontModule.withConfig({`
  
    ```ts
    checkout: {
      express: true,
      guest: true
    },
    ```
  
- To use infinite scroll, add these to `B2cStorefrontModule.withConfig({`
  
   ```ts
       view: {
        infiniteScroll: {
          active: true,
          productLimit: 500,
          showMoreButton: false,
         },
       },
  ```
  
- To see ‘early login’ in action, after this line:
  `ConfigModule.withConfigFactory(defaultCmsContentConfig)`
  add
  `ConfigModule.withConfig({routing: { protected: true, } })`
  
- To enable consignment tracking, add this to `features`:

  ```ts
  features: {
     consignmentTracking: true
  }
  ```

## Release 1.1

*Release 1.1 libraries published August 29, 2019*

Release notes: [https://github.com/SAP/spartacus/releases](https://github.com/SAP/spartacus/releases)

- Feature Flags (meant to allow setting feature level of releases for backwards compatibility)  
  - [Documentation for development]({{ site.baseurl }}{% link _pages/contributing/feature-flags-and-code-deprecation.md %})
  - [Documentation for consumption]({{ site.baseurl }}{% link _pages/install/configuring-feature-flags.md %})
- [Configurable Endpoints]({{ site.baseurl }}/connecting-to-other-systems/#endpoint-configuration)
- [Change to registration and login flow: must log in after registering](https://github.com/SAP/spartacus/issues/2799#issuecomment-525679882)
- Also released: a beta of a new library, [Schematics](https://www.npmjs.com/package/@spartacus/schematics). Schematics allow for easy setup of Spartacus libraries with a new Angular project in one command. In the future, schematics will help in upgrading, maintaining, customizing, and building projects with Spartacus libraries (for example: template generators for custom cms components). A detailed description about schematics can be found [here](https://angular.io/guide/schematics).

## Release 1.0

*Release 1.0 libraries published July 4, 2019*

Customer-facing storefront features:

| Page/Area                  | Notes                                                        |
| -------------------------- | ------------------------------------------------------------ |
| Header                     | Displays language and currency selection, shortcut links to help and other sample information pages, logo, search box, cart icon, category bar, and breadcrumbs |
| Footer                     | Displays company links and copyright notice                  |
| Home                       | Driven by CMS page layout and slots                          |
| Search                     | Search box in header displays search and product suggestions; search results include facets provided by backend |
| Categories                 | Category menus in header display up to 2 levels; category results include facets provided by backend |
| Product details            | Displays product title, images, price, quantity selection, add to cart, stock, and summary; supplementary information area includes details, specifications, reviews, and shipping information |
| Added-to-cart modal        | Displays confirmation that a product was added to the cart; can change quantity in the modal |
| Authentication             | Registration, login, and forgot password                     |
| Cart page                  | Displays list of items in the cart and purchase summary; allows change of quantity and removal of items |
| Checkout                   | Typical four-step checkout allowing customer to enter shipping and payment details, choose shipping method, and then review before submitting order; new shipping addresses and payment methods are saved automatically; customers can choose from saved shipping addresses and payment methods; confirmation displayed after successful order submission; can replace entire checkout process or is extendable on a step-by-step basis |
| Order History              | Displays list of orders and details for a specific order; orders are listed by consignment |
| Address Management         | Displays list of saved shipping addresses; customers can add new shipping addresses, edit and delete shipping addresses, and make set a shipping address as the default |
| Payment Method Management | Displays list of saved payment methods; customers can delete payment methods, and make a payment method the default |
| Account Settings           | Displays and allows customers to edit their name, email address, password and consent preferences; also allows the customer to request account closure |
| Add to Home                | Allows the customer to add the storefront web app to their device Home or Launch screen, as if the storefront were a native app (search for "PWA Add to Home" for more information) |

Architectural and foundational features:

| Topic/Area                       | Notes                                                        |
| -------------------------------- | ------------------------------------------------------------ |
| Decoupled                        | Communicates through API's only; uses SAP Commerce Cloud APIs ootb but can connect to microservices or other API-based Internet sources |
| Upgradable libraries             | Semantic versioning used; recommendation is to use the libraries (don't fork the source code) |
| Extendable architecture          | Replace existing components with custom components; add custom components before or after existing components; customize component-specific business logic; re-use public internal services |
| Customizable Styling             | Global variables for ease of branding; precise selectors for fine-tuning styling; also useful for certain simple positioning changes |
| Responsive Design                | Layouts display properly on devices of different sizes; ootb viewports include mobile, tablet, desktop, wide desktop; configurable |
| CMS                              | Driven almost completely by CMS provided by SAP Commerce Cloud back end; can be used for marketing content and also as placeholders for injecting functionality; can use third-party systems |
| SmartEdit                        | SmartEdit supported; same functionality as in Accelerator (requires SAP Commerce Cloud 1905) |
| Routing                          | Allows configuration of all site URLs (e.g. /products/shoes); configurable in Spartacus application but also controlled by CMS routing configuration defined in the backend (thus editable by SmartEdit); includes default configurations so no customization necessary to get Spartacus working |
| SSR                              | SSR (Server-Side Rendering) supported, where HTML page is rendered on the server instead of on the client; required to for SEO / search site indexing; also improves performance of first time-to-view |
| SEO                              | Stateful URLs for every part of the storefront; search engine indexing supported by way of SSR; configurable routing; page meta resolvers including title, description, image (og:image), and robots |
| Cache-first networking           | Caching of shell app, with more to come in subsequent releases |
| Localization                     | All front-end texts localizable (texts that are part of the storefront code only; some texts come from backend CMS components, translated in backend) |
| Builds with CCv2                 | JavaScript appiclications such as Spartacus-based storefronts can be built alongside SAP Commerce Cloud using Commerce Cloud v2 |

## About Spartacus Releases

- Libraries that are "released" are new, official, tested Spartacus libraries available to the public (hosted on npmjs.com)
- We usually publish new libraries every 2 weeks
- A change in minor means we added new features, but they are configured to be off by default, so as not to cause compatibility issues. A new minor also means inclusion of changes or bug fixes that may affect compatibility, but these are also controlled by feature flags. So all significant changes are “opt-in”. See feature flag documentation for more information.
- We will normally publish pre-release libraries labelled 'next' a few weeks before a new minor release. The goal is to provide early access to new features and get feedback from the community.
- If you choose not to use a new feature, you should have no problems upgrading to a new Major.# with features flag set to a previous Major.#. If you do see a problem, please report a bug and we’ll assess and fix it. We encourage you to upgrade to latest libraries frequently during development in order to take advantage of bug fixes and new features.
- To be able to use all functionality in Spartacus 3.\*, release 2005 of SAP Commerce Cloud is required. For example, release 2005 contains the OCC APIs for B2B Commerce Organization. In addition, the latest patch release is required, or at least strongly recommended, because it usually contains bug fixes that affect Spartacus (for example, ASM requires 1905.5, and the Save for Later feature requires 1905.11). Spartacus 3.\*  is also tested with and works with release 1905. Note, however, that Spartacus features that rely on new APIs introduced in 2005 (such as cancellations and returns) are not available if you are using SAP Commerce Cloud 1905. For more information on which version of Spartacus and which version of SAP Commerce Cloud is required for a particular feature, see [Feature Compatibility]({{ site.baseurl }}{% link _pages/home/feature-release-versions.md %}).

## How Spartacus is Versioned

Spartacus is following semantic versioning (Major.Minor.Patch).

- A new patch release (1.2.**3** > 1.2.**4** for example) means we added fixes or improvements but no new features.
- A new minor release (1.**2**.4 > 1.**3**.0 for example) means we added a new feature and possibly fixes and improvements.

For both patch and minor releases, upgrading to the new libraries should not cause any compatibility problems with your storefront app. (If it does, report a bug.) All new features and fixes are implemented in a compatible way. For example, all new features are disabled by default using feature flags. We hope you will upgrade frequently.

- A new major release (**1**.3.2 > **2**.0.0 for example) means that, besides adding new features and improvements, we made changes that will likely cause compatibility issues. Your app likely needs updating when moving to a new major release. These effects, reasons, and benefits will be documented.

We don't plan to introduce a new major release that frequently, unless an issue is found that makes it necessary to move to a major release . For example, a new major release of the Angular framework is one factor in our decision to move to a new major for Spartacus.

## Upgrading Spartacus Libraries to a New Minor Version

You can upgrade your Spartacus libraries to a new minor version, as follows:

1. In `package.json`, set your `@spartacus` libraries to `“~2.#.0"`, where `#` is replaced with the release version number you wish to upgrade to.

   If you are upgrading from 1.x to the latest 1.5 release in order to then upgrade to 2.x, in `package.json`, set your `@spartacus` libraries to `“~1.5.5"`.

1. Delete your `node_modules` folder.
1. Run `yarn install`.

## Future Releases

See the [separate roadmap document]({{ site.baseurl }}{% link _pages/home/spartacus-roadmap.md %}).

---
title: Release Information for Versions 1.0-1.4 of Spartacus Libraries
---

*Last updated January 27, 2020 by Bill Marcotte, Senior Product Manager, Spartacus*

This document describes what is included in the latest releases of Spartacus libraries.

If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU). Feedback welcome!
  
### *Disclaimer - Forward-Looking Statements*

*This document contains forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality.  This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence.*

*The various documentation links provided point to SAP Commerce Cloud platform or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented in Spartacus.*
   
   
    
### Overview

- Libraries that are "released" are new, official, tested Spartacus libraries available to the public (hosted on npmjs.com)
- We usually release new libraries every 2 weeks 
- A change in minor means we added new features, but they are configured to be off by default, so as not to cause compatibility issues. A new minor also means inclusion of changes or bug fixes that may affect compatibility, but these are also controlled by feature flags. So all significant changes are “opt-in”. See feature flag documentation for more information.
- We will normally publish pre-release libraries labelled 'next' a few weeks before a new minor release. The goal is to provide early access to new features and get feedback from the community.
- If you choose not to use a new feature, you should have no problems upgrading to a new 1.# with features flag set to a previous 1.#. If you do see a problem, please report a bug and we’ll assess and fix it. We encourage you to upgrade to latest libraries frequently during development.
- To use the new libraries, set your @spartacus libraries in package.json to “~1.#.0" (replace # with the release number). Then run `yarn upgrade` (although deleting your node_modules and doing yarn install is usually cleaner).
- To be able to use all functionality in Spartacus 1.\*, release 1905 of SAP Commerce Cloud is required. The latest patch release is strongly recommended as it usually contains bug fixes that affect Spartacus (for example, ASM requires 1905.5). 
  
    
  
### Release 1.4 Highlights

*Release 1.4 libraries published January 27, 2020*
  
What's new?

- [Wish List]({{ site.baseurl }}{% link _pages/dev/features/wish-list.md %})
- [Back-in-Stock Notification]({{ site.baseurl }}{% link _pages/dev/features/stock-notification.md %})
  - [Notification Preferences]({{ site.baseurl }}{% link _pages/dev/features/notification-preferences.md %})
  - [Customer Interests]({{ site.baseurl }}{% link _pages/dev/features/customer-interests.md %})
- [Token Revocation]({{ site.baseurl }}{% link _pages/dev/features/token-revocation.md %}) (supports back end improvement added to 1905.6)
- [Stacked Outlets](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/outlets/#stacked-outlets)
- [Product data performance improvements with loading scopes]({{ site.baseurl }}{% link _pages/dev/backend_communication/loading-scopes.md %}). You can also see [GitHub Issue 3666](https://github.com/SAP/cloud-commerce-spartacus-storefront/issues/3666) for more information.
- [Deferred Loading]({{ site.baseurl }}{% link _pages/dev/performance/deferred-loading.md %})
- [Above-the-Fold Loading]({{ site.baseurl }}{% link _pages/dev/performance/above-the-fold.md %})
- CMS component data loading optimization. For more information, see [GitHub Issue 5845](https://github.com/SAP/cloud-commerce-spartacus-storefront/issues/5845)
- Updates to cart handling to support future features. For more information, see [GitHub Issue 4432](https://github.com/SAP/cloud-commerce-spartacus-storefront/issues/4432)

**Note:** The Cancellations and Returns feature is also part of 1.4. However, this feature requires updates to OCC REST APIs that are not yet released. The updated APIs are scheduled to be part of the May 2020 release (Release 2005) of SAP Commerce Cloud. Please see official SAP Commerce Cloud release announcements for more information.
    
  
### Release 1.3 Highlights

*Release 1.3 libraries published November 18, 2019*

What's new?

#### Architecture and Development Features
- Storefront Self-Configuration (detection of languages, currencies, and other site settings through base site API)
  [Draft Spartacus Documentation](https://github.com/SAP/cloud-commerce-spartacus-storefront-docs/blob/901d0521dcf4668e2ddc5982947268becd0e66dd/_pages/dev/context-configuration.md)
- Structured Data (provides a data structure for the web that makes the web content more understandable for web crawlers)
[Spartacus Documentation](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/structured-data)
- Qualtrics intercept integration and example
  [Spartacus Documentation](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/qualtrics-integration)
#### Core/B2C Storefront Features
- Assisted Service Module (ASM) customer emulation (requires October patch release of SAP Commerce 1905)
  [Spartacus Documentation](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/asm) [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/8b571515866910148fc18b9e59d3e084.html)
- Anonymous consent 
  [Spartacus Documentation](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/anonymous-consent) [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/a9f387f70d484c19971aca001dc71bc5.html)
- Coupons (requires October patch release of SAP Commerce 1905)
  [Spartacus Documentation](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/coupons) [SAP Commerce Documentation](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/02a8521eb67b4866a632a1a5e79037e3.html?q=coupons)


#### B2B Storefront Features
- Powertools sample data modified to work with Spartacus (requires latest spartacussampledataaddon). Note: B2B Spartacus not yet available (B2B My Company and Checkout planned for Q1 2020). Powertools out-of-the-box sample data itself is now “Spartacus-ified” so that it displays properly when you point Spartacus to it. It’s what we’re using to do our development. However My Company and Checkout not yet supported; you’ll see a few errors related to API calls that we are part of the updated b2boccaddon API release in Q1.
  
  
  
### Release 1.2 Highlights

**Release 1.2 libraries published September 30, 2019*

What's new?

- [Store Locator](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/store-locator)
- [Guest Checkout](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/guest-checkout)
- [Express Checkout](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/express-checkout)
- [Infinite Scroll](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/infinite-scroll)
- Routing Migration (docs to come)
- [Early Login](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/early-login)
- [Consignment Tracking](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/consignment-tracking)
- Angular updated to 8.2.5; ngrx to 8.3.0; other dependency updates

To update to 1.2.0, you must change your libraries in `package.json` and and dependencies inside `app.module.ts`. See [Building the Spartacus Storefront from Libraries]({{ site.baseurl }}{% link _pages/install/building-the-spartacus-storefront-from-libraries.md %}) for more information.

- To use 1.2 features, add these to `B2cStorefrontModule.withConfig({`
    ```
    features: {
        level: '1.2',
        consignmentTracking: true,
      },
    ```
    
- To enable guest or express checkout, add these to `B2cStorefrontModule.withConfig({`
  
    ```
    checkout: {
      express: true,
      guest: true
    },
    ```
    
- To use infinite scroll, add these to `B2cStorefrontModule.withConfig({`
  
   ```
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
  
- To enable consignment tracking, add this to `features`
  ```
  features: {
     consignmentTracking: true
  }
  ```




### Release 1.1 Highlights

*Release 1.1 libraries published August 29, 2019*

Release notes: https://github.com/SAP/cloud-commerce-spartacus-storefront/releases

- Feature Flags (meant to allow setting feature level of releases for backwards compatibility)
  - [Documentation for development](https://github.com/SAP/cloud-commerce-spartacus-storefront-docs/blob/e2f291d6c8d21d870a68fe1903b8cd1cf568640d/_pages/contributing/feature-flags-and-code-deprecation.md)
  - [Documentation for consumption](https://github.com/SAP/cloud-commerce-spartacus-storefront-docs/blob/e2f291d6c8d21d870a68fe1903b8cd1cf568640d/_pages/install/configuring-feature-flags.md)
- [Configurable Endpoints](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/connecting-to-other-systems/#endpoint-configuration)
- [Change to registration and login flow: must log in after registering](https://github.com/SAP/cloud-commerce-spartacus-storefront/issues/2799#issuecomment-525679882)
- Also released: a beta of a new library, [Schematics](https://www.npmjs.com/package/@spartacus/schematics). Schematics allow for easy setup of Spartacus libraries with a new Angular project in one command. In the future, schematics will help in upgrading, maintaining, customizing, and building projects with Spartacus libraries (for example: template generators for custom cms components). A detailed description about schematics can be found [here](https://angular.io/guide/schematics).



### Release 1.0 Highlights

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
| CMS                              | Driven almost completely by CMS provided by SAP Commerce backend; can be used for marketing content and also as placeholders for injecting functionality; can use third-party systems |
| SmartEdit                        | SmartEdit supported; same functionality as in Accelerator (requires SAP Commerce 1905) |
| Routing                          | Allows configuration of all site URLs (e.g. /products/shoes); configurable in Spartacus application but also controlled by CMS routing configuration defined in the backend (thus editable by SmartEdit); includes default configurations so no customization necessary to get Spartacus working |
| SSR                              | SSR (Server-Side Rendering) supported, where HTML page is rendered on the server instead of on the client; required to for SEO / search site indexing; also improves performance of first time-to-view |
| SEO                              | Stateful URLs for every part of the storefront; search engine indexing supported by way of SSR; configurable routing; page meta resolvers including title, description, image (og:image), and robots |
| Cache-first networking           | Caching of shell app, with more to come in subsequent releases |
| Localization                     | All front-end texts localizable (texts that are part of the storefront code only; some texts come from backend CMS components, translated in backend) |
| Cloud Platform Extension Factory | Connectivity supported                                      |
| Builds with CCv2                 | JavaScript appiclications such as Spartacus-based storefronts can be built alongside SAP Commerce using Commerce Cloud v2 |

### How Spartacus is Versioned

Spartacus is following semantic versioning (Major.Minor.Patch).

- A new patch release (1.2.**3** > 1.2.**4** for example) means we added fixes or improvements but no new features.
- A new minor release (1.**2**.4 > 1.**3**.0 for example)  means we added a new feature and possibly fixes and improvements.

For both patch and minor releases, upgrading to the new libraries should not cause any compatibility problems with your storefront app. (If it does, report a bug.) All new features and fixes are implemented in a compatible way. For example, all new features are disabled by default using feature flags. We hope you will upgrade frequently.

- A new major release (**1**.3.2 > **2**.0.0 for example) means that, besides adding new features and improvements, we made changes that will likely cause compatibility issues. Your app likely needs updating when moving to a new major release. These effects, reasons, and benefits will be documented.

We don't plan to introduce a new major release that frequently, unless an issue is found that makes it necessary to move to a major release . The upcoming Angular "Ivy" (after Angular 8) is one factor in our eventual decision to do so.

### What's Coming

See the [separate roadmap document]({{ site.baseurl }}{% link _pages/home/spartacus-roadmap.md %}).
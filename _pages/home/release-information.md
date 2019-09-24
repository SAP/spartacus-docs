---
title: Release Information for 1.0-1.2
---

*Last updated September 24, 2019 by Bill Marcotte, Senior Product Manager, Spartacus*

This document describes what is included in Release 1.2 of Spartacus libraries.

Note: Release 1.2-next.0 was published September 24, 2019. The releases labelled 'next' are pre-release versions of the next minor release. Release 1.2.0 is expected to be published end of September.

If you have any questions, use the 'help' channel of our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU). Feedback welcome!



### *Disclaimer - Forward-Looking Statements*

*This document contains forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality.  This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence.*



### Overview

- When we say "released", we mean that we make new, official, tested Spartacus libraries available to the public (hosted on npmjs.com)
- We usually release new libraries every 2 weeks 
- A change in minor means we added new features, but they are configured to be off by default, so as not to cause compatibility issues. A new minor also means inclusion of changes or bug fixes that may affect compatibility, but these are also controlled by feature flags. So all significant changes are “opt-in”. See feature flag documentation for more information.
- We will normally publish pre-release libraries labelled 'next' a few weeks before a new minor release. The goal is to provide early access to new features and get feedback from the community.
- It’s important to note that if you choose not to use the new features, you should have no problems upgrading to a new 1.# with features flag set to a previous 1.#. If you do see a problem, please report a bug and we’ll assess and fix it. We encourage you to upgrade to latest libraries frequently during development.
- To use the new libraries, set your @spartacus libraries in package.json to “~1.#.0" (replace # with the release number). Then run `yarn upgrade` (although deleting your node_modules and doing yarn install is usually cleaner).
- To be able to use all functionality in Spartacus 1.\*, release 1905 of SAP Commerce Cloud is required. The latest patch release is strongly recommended as it usually contains bug fixes that affect Spartacus. Most of Spartacus can work with 1811, with no guarantees the farther back you go. Specifically, the following features require 1905:
  - SmartEdit support
  - Any usage of  new CmsFlexComponents or SiteContextComponent (although you can use other components such as JspComponent)
  - Forgot password / reset
  - Various bug fixes to OCC APIs that help Spartacus work better

### Release 1.2-next.0 Highlights (1.2 Pre-Release)

*Released September 24, 2019*

Note: This release is labelled 'next'. It's pre-release, which allows you to try out new features and give us feedback, especially to report bugs. We plan to do the official release of 1.2.0 by end of September.

What's New?
- Storefinder (docs to come)
- [Guest Checkout](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/guest-checkout)
- [Express Checkout](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/express-checkout)
- [Infinite Scroll](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/infinite-scroll)
- Routing Migration (docs to come)
- [Early Login](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/early-login)
- [Consignment Tracking](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/consignment-tracking)
- Angular updated to 8.2.5; ngrx to 8.3.0; other dependency updates

To use 1.20-next.0 (see sample files in our [Slack announcement](https://spartacus-storefront.slack.com/archives/CE72A1YJJ/p1569279517009600)):

- Update your dependencies  (see sample file in our [Slack announcement](https://spartacus-storefront.slack.com/archives/CE72A1YJJ/p1569279517009600)); it is recommended that you delete `node_modules` and start fresh
  
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

*Released August 29, 2019*

Release notes: https://github.com/SAP/cloud-commerce-spartacus-storefront/releases

- Feature Flags (meant to allow setting feature level of releases for backwards compatibility)
  - [Documentation for development](https://github.com/SAP/cloud-commerce-spartacus-storefront-docs/blob/e2f291d6c8d21d870a68fe1903b8cd1cf568640d/_pages/contributing/feature-flags-and-code-deprecation.md)
  - [Documentation for consumption](https://github.com/SAP/cloud-commerce-spartacus-storefront-docs/blob/e2f291d6c8d21d870a68fe1903b8cd1cf568640d/_pages/install/configuring-feature-flags.md)
- [Configurable Endpoints](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/connecting-to-other-systems/#endpoint-configuration)
- [Change to registration and login flow: must log in after registering](https://github.com/SAP/cloud-commerce-spartacus-storefront/issues/2799#issuecomment-525679882)
- Also released: a beta of a new library, [Schematics](https://www.npmjs.com/package/@spartacus/schematics). Schematics allow for easy setup of Spartacus libraries with a new Angular project in one command. In the future, schematics will help in upgrading, maintaining, customizing, and building projects with Spartacus libraries (for example: template generators for custom cms components). A detailed description about schematics can be found [here](https://angular.io/guide/schematics).



### Release 1.0 Highlights

*Released July 4, 2019*

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



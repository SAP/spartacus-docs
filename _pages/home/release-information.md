---
title: Release Information for All Versions of Spartacus Libraries
---

**Latest news: 4.3.0 final published January 21, 2022**

*Last updated January 21, 2022 by Bill Marcotte, Senior Product Manager, Spartacus*

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Introduction

This document describes what is included in all Spartacus libraries since the initial 1.0 release.

- For information on specific code changes for a particular release, see the [Development Release Notes](https://github.com/SAP/spartacus/releases).
- For information about features published in pre-release libraries, see [Pre-Release Information]({{ site.baseurl }}{% link _pages/home/pre-release-information.md %}).
- For information about upgrading, see [Upgrading Spartacus Libraries to a New Minor Version](#upgrading-spartacus-libraries-to-a-new-minor-version).
- For information about which versions of the Spartacus libraries and SAP Commerce Cloud are required for a specific feature, see [{% assign linkedpage = site.pages | where: "name", "feature-release-versions.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/home/feature-release-versions.md %}).
- If you have technical or how-to questions about using Spartacus, try asking on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). 
- If you would like to report an issue for assistance from SAP, please use the [SAP Launchpad reporting tool](https://launchpad.support.sap.com/)

**Disclaimer - Forward-Looking Statements**

*This document contains or may contain forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality. This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence.*

*The various documentation links provided point to SAP Commerce Cloud or Accelerator documentation or third-party external links. These links are included for information purposes only and may not reflect exactly what is implemented in Spartacus.*

## Release 5.0

*Release 5.0 libraries published January ??, 2022*

Highlights include the following:

### Retract User Selections

For configurable products, OCC now supports a retract feature for single-select attributes in Spartacus for VC products.

When users make selections on the configuration page, certain dependencies might hide values in other attributes or might set them to read-only. For the user it is sometimes impossible to tell how to show those other choices that they just saw a minute ago or to find that other option (or combination of options) that made the undesired value read-only.

This kind of modelling has its origin in the fact that VC/AVC automatically generates a "no option selected" value for single-select non-mandatory characteristics, which means that product modelers never had to model such a value into the product model. Up to now, this value was not automatically generated on the Commerce UI. For customers who are using legacy product models, this is sometimes painful because their testers, consultants, and customers get caught in dead ends that they cannot resolve.

If the retract feature is activated, the configuration UI in Commerce automatically generates an additional value called "no option selected" for single-select attributes. This enables users to always undo a selection they have made, thereby saving them from getting caught in a dead end.

If  the retract feature is not activated, a read-only value might get involved in a conflict, where customers cannot change or undo their selection. It is possible now to allow customers to undo the selection they made for the conflicting read-only value. For more information, see [Retract Option for Single-Select Characteristics]({{ site.baseurl }}{% link _pages/install/integrations/configurable-products-integration.md %}#retract-option-for-single-select-characteristics).

### Numeric Attributes with Interval Domain

The attribute type numeric attribute with interval domain is supported in the storefront now. For more information, see [Supported Attribute Types and Display Types]({{ site.baseurl }}{% link _pages/install/integrations/configurable-products-integration.md %}#supported-attribute-types-and-display-types).

## Release 4.3

 *Release 4.3 libraries published January 21, 2022*

 Highlights include the following:

### SAP Enterprise Product Development Visualization Integration

 The SAP Enterprise Product Development Visualization Integration provides support for visual picking of spare parts using 2D or 3D models of the relevant products. For more information, see [{% assign linkedpage = site.pages | where: "name", "epd-visualization-integration.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/integrations/epd-visualization-integration.md %}).

## Release 4.2

*Release 4.2 libraries published November 10, 2021*

Highlights include the following:

### Import Products to Active or Saved Cart

This feature allows customers to use a comma-separated values (CSV) file to quickly import multiple products to the active cart or into a saved cart. The CSV file contains the product SKU and quantity. For more information, see [{% assign linkedpage = site.pages | where: "name", "cart-import-export.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/cart-import-export.md %}).

### Export Products From Active or Saved Cart

This feature allows customers to export an active or saved cart to a CSV file. By default, the exported file contains the product SKU, quantity, name, and price, but this is configurable. For more information, see [{% assign linkedpage = site.pages | where: "name", "cart-import-export.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/cart-import-export.md %}).

### Product Image Zoom

This feature allows customers to magnify product images when viewed from the Product Details page. Clicking a product image enters "zoom mode", at which point the customer can magnify the picture based on mouse location. For more information, see [{% assign linkedpage = site.pages | where: "name", "image-zoom.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/image-zoom.md %}).

### Quick Order Improvement: Search by Product Name

The Quick Order feature was introduced in the 4.1 Spartacus libraries. With this improvement, customers using the form are now able to search by product name, not just SKU. The Quick Order field on the cart page is not affected. For more information, see [{% assign linkedpage = site.pages | where: "name", "quick-order.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/quick-order.md %}).

### Cart Validation

This feature identifies issues with customer cart when opening the Cart page or when proceeding to check out, and is extensible. The typical use case is when a customer adds a product to the cart today, and then tomorrow goes to check out, but there is no more stock. In this example, a message is displayed to the customer about what happened, and the product is removed from the cart. For more information, see [{% assign linkedpage = site.pages | where: "name", "cart-validation.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/cart-validation.md %}).

### Scroll Position Restoration

This improvement maintains the scroll position when moving forward and backward throughout a Spartacus-based site. The user experience is greatly improved when searching or viewing categories, reviewing product information, and going back. For more information, see [{% assign linkedpage = site.pages | where: "name", "scroll-position-restoration.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/scroll-position-restoration.md %}).

### Order History Library

The introduction of a separate library for order history functionality is part of a long-term performance improvement effort. By separating the codebase into smaller libraries, packages are smaller, allowing for better lazy loading and improved performance. For example, with the Order History library, the code is only loaded when customers want to view orders they have already submitted. The existing Order History code is deprecated and will be removed in a future major release. Note that when upgrading, the existing Order History code is used, but when installing from schematics, the new library is used. For more information, see the [{% assign linkedpage = site.pages | where: "name", "order-library-release-notes.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/home/release-notes/order-library-release-notes.md %}).

### Improvements Related to Support for Screen Readers

If you dive into the source code, you may notice improvements in various places related to support for screen readers. This effort is not complete. We are planning to announce support for screen readers in the next major, 5.0, for most core features.

## Release 4.1

*Release 4.1 libraries published September 14, 2021*

Highlights include the following:

### SAP Digital Payments Integration

SAP Digital Payments integration is an out-of-the-box alternative to current custom payment service provider (PSP) integrations. This integration uses SAP Digital Payments with ready-to-use PSP connectivity. For more information, see [{% assign linkedpage = site.pages | where: "name", "digital-payments-integration.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/integrations/digital-payments-integration.md %}).

### Quick Order

The Quick Order feature allows users to quickly add multiple items to their cart. There is also the option to quickly add a single product from the cart page. For more information, see [{% assign linkedpage = site.pages | where: "name", "quick-order.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/quick-order.md %}).

### B2B Inventory Display

The B2B Inventory Display feature allows sellers to control the display of the stock visible for a category of products or for the whole storefront. Spartacus now supports display of actual stock values, so when this feature is enabled in the back end, the page displays "## in stock". When the feature is disabled, customers see “In Stock” or “Out of Stock”, as in previous versions of Spartacus. For more information, see [{% assign linkedpage = site.pages | where: "name", "inventory-display.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/inventory-display.md %}), as well as [B2B Inventory Display](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8ac35e1d866910148876ef95adde0c60.html) on the SAP Help Portal.

### Authentication Improvements

Several improvements were made to authentication that help make authentication expiry during checkout more reliable. These fixes were backported to 3.0 through to 3.4, as well as to 4.0.

### SSR maxRenderTime Option

The `maxRenderTime` setting is the maximum amount of time expected for a render to complete. If the render exceeds this timeout, the concurrency slot is released, which allows the next request to be server-side rendered. For more information, see [Configuring the SSR Optimization Engine]({{ site.baseurl }}/server-side-rendering-optimization/#configuring-the-ssr-optimization-engine).
  
## Release 4.0

*Release 4.0 libraries published July 29, 2021*

As with every new major release, 4.0 contains breaking changes. Make sure to read the [Development Release Notes](https://github.com/SAP/spartacus/releases) and the [{% assign linkedpage = site.pages | where: "name", "technical-changes-version-4.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/home/updating-to-version-4/technical-changes-version-4.md %}) migration guide.

Highlights include the following:

### Angular 12

With every new major, we upgrade Angular in order to be able to use new features and of course take advantage of security improvements and bug fixes. For a quick summary of what's new, see the Angular blog post, [Angular v12 is now available](https://blog.angular.io/angular-v12-is-now-available-32ed51fbfd49).

### CPQ Configurable Products Integration: Display of Prices for Attribute Values

The display of prices for individual options or attribute values is now supported, not only for bundle items (attributes linked to products), but also for simple attribute values (non-bundle items). For more information, see [{% assign linkedpage = site.pages | where: "name", "cpq-configurable-products-integration.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/integrations/cpq-configurable-products-integration.md %}).

### Cleanup and removal of deprecated code

Removal of deprecated code is performed with every major release. Migration information is documented in the [{% assign linkedpage = site.pages | where: "name", "updating-to-version-4.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/home/updating-to-version-4/updating-to-version-4.md %}) migration guide.

### Checkout moved to a library

The move of checkout to its own library continues our process of breaking the big Spartacus core library into smaller libraries, which will allow Spartacus to become smaller in the browser, more modular, and will also allow customers to only import what they need when they need it.

### Cloning option when restoring saved cart

When restoring a saved cart, the option to keep a copy of the cart is now available. For more information, see [{% assign linkedpage = site.pages | where: "name", "saved-cart.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/saved-cart.md %}).

### Additionally...

This release also includes partial but incomplete support for the following (see roadmap for completion dates):

- screen readers
- the new "blue" Santorini storefront theme. For more information, see [{% assign linkedpage = site.pages | where: "name", "storefront-themes.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/styling-and-page-layout/storefront-themes.md %}).
  
## Release 3.4

*Release 3.4 libraries published June 16, 2021*

### Cart API refactoring

The Cart API was refactored to make development easier. For example, many classes were made protected and thus more extensible. (See [here](https://github.com/SAP/spartacus/pull/12389) for more information.) Inline documentation was also improved.

### Code splitting for performance improvement

Code splitting continues with new libraries for more modules, such as Intelligent Selling Services, Store Finder, Account, Profile, and ASM - see schematics for installation [(documentation)]({{ site.baseurl }}{% link _pages/install/schematics.md %})

### Simplified schematics installation

Installation selection when adding features using `ng add @spartacus/schematics@` was simplified. A single list is presented at the start, and dependencies or sub-coponents automatically determined by feature. The list of modules reflects the changes due to the code splitting initative.

### New events

New events were added: Cart Remove Entry Success, Cart Remove Entry Fail, Cart Update Entry Fail (see [GitHub issue 12125](https://github.com/SAP/spartacus/issues/12125)). Event reference documentation is now auto-generated (see [this page]({{ site.baseurl }}/event-service/#list-of-spartacus-events) for an example).

## Release 3.3

*Release 3.3 libraries published May 12, 2021*

### SAP CPQ Integration for Configurable Products

- Bundling and guided-selling scenarios where the bundle in Commerce contains simple (non-configurable) products. The dependencies within this bundle are controlled by the underlying CPQ configurable product
- Single-level configurable products in your Commerce Spartacus storefront where the product model resides in SAP CPQ
- Configuration page with the most commonly used attribute types, especially attributes with values that are linked to a (non-configurable) product. Attribute types with quantity on attribute or attribute value level are supported
- Price summary at the bottom of the configuration page with the base price, the price of the selected options, and the overall total price of the configured product
- Overview page with all user selections accessible at any time during configuration
- Configurable bundles are part of storefront processes such as catalog browsing, product detail page, add to cart, checkout, and order history
- For underlying functionality in detail and for features that are currently not supported, see [CPQ Configurable Products Integration]({{ site.baseurl }}{% link _pages/install/integrations/cpq-configurable-products-integration.md %})

## Release 3.2

*Release 3.2 libraries published April 15, 2021*

### Schematics Behavior Updated

The default behavior for schematics has been changed and Spartacus is now installed with a new app structure. For more information, see [Reference App Structure]({{ site.baseurl }}{% link _pages/install/reference-app-structure.md %})

### Tag Manager framework

[(Documentation)]({{ site.baseurl }}{% link _pages/dev/features/tag-management-system.md %})
New Tag Manager framework with support for Google and Adobe tag systems, and Google Analytics 

### New events for Event Service

[(documentation)]({{ site.baseurl }}{% link _pages/dev/features/event-service.md %})

- Search suggestion clicked
- Facet changed in search/category results
- Context change (language/currency)

### B2B Bulk Pricing

[(Documentation)]({{ site.baseurl }}{% link _pages/dev/features/bulk-pricing.md %})

### Saved Carts

[(Documentation)]({{ site.baseurl }}{% link _pages/dev/features/saved-cart.md %})

### New popover text component

[(Documentation)]({{ site.baseurl }}{% link _pages/dev/components/shared-components/popover-component.md %})

### HTML tags

[(Documentation)]({{ site.baseurl }}{% link _pages/dev/seo/html-tags.md %})

### General improvements to B2B Commerce Organization user experience

### Code splitting for performance improvements

Code splitting continues with new libraries for SmartEdit, Events, Tag Management, and saved carts - see schematics for installation [(documentation)]({{ site.baseurl }}{% link _pages/install/schematics.md %})

### New module initialization functionality for lazy-loaded features

[(Documentation)]({{ site.baseurl }}/lazy-loading-guide/#initializing-lazy-loaded-modules)

### SAP Customer Data Cloud

[(Documentation)]({{ site.baseurl }}{% link _pages/install/integrations/cdc-integration.md %})
Official release of the SAP Customer Data Cloud integration library.

### Dynamic configuration with support for site themes

[(Documentation)]({{ site.baseurl }}/automatic-context-configuration/#theme-configuration)

### Bug fixes

See [Commit Release Notes](https://github.com/SAP/spartacus/releases)

### Updates to documentation

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
- The same backend can be used for hosting both B2C and B2B stores. However, Spartacus requires two different apps, with two different configurations, one for B2C stores, and one for B2B stores. (The ability to use one app for both B2C and B2B will be added in a future Spartacus release.) For more information, see [Building the Spartacus Storefront from Libraries]({{ site.baseurl }}{% link _pages/install/frontend/building-the-spartacus-storefront-from-libraries.md %}).
- Setting up a B2B Spartacus store follows the same process as for a B2C store, with one extra step for adding B2B Commerce Organization features using schematics (`ng add @spartacus/organization`). For more information, see [Building the Spartacus Storefront from Libraries]({{ site.baseurl }}{% link _pages/install/frontend/building-the-spartacus-storefront-from-libraries.md %}).
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

- [Intelligent Selling Services for SAP Commerce Cloud]({{ site.baseurl }}{% link _pages/install/integrations/cds-integration.md %})  
Intelligent Selling Services for SAP Commerce Cloud provides real-time customer experience personalization for SAP Commerce Cloud, now with support for Spartacus! Integration includes the Profile Tag and the Merchandising Carousel features. For more information on the Intelligent Selling Services feature itself, see the [Intelligent Selling Services documentation in the SAP Help Portal](https://help.sap.com/viewer/product/CONTEXT-DRIVEN_SERVICES).

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
- [Token Revocation]({{ site.baseurl }}{% link _pages/dev/security/token-revocation.md %}) (supports back end improvement added to 1905.6)
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

To update to 1.2.0, you must change your libraries in `package.json` and and dependencies inside `app.module.ts`. See [Building the Spartacus Storefront from Libraries]({{ site.baseurl }}{% link _pages/install/frontend/building-the-spartacus-storefront-from-libraries.md %}) for more information.

- To use 1.2 features, add these to `B2cStorefrontModule.withConfig({`

    ```ts
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
- [Configurable Endpoints]({{ site.baseurl }}/connecting-to-other-systems/#configuring-endpoints)
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
| Builds with CCv2                 | JavaScript applications such as Spartacus-based storefronts can be built alongside SAP Commerce Cloud using Commerce Cloud v2 |

## About Spartacus Releases

- Libraries that are "released" are new, official, tested Spartacus libraries available to the public (hosted on npmjs.com)
- We usually publish new libraries every 2 weeks
- A change in minor means we added new features, but they are configured to be off by default, so as not to cause compatibility issues. A new minor also means inclusion of changes or bug fixes that may affect compatibility, but these are also controlled by feature flags. So all significant changes are “opt-in”. See feature flag documentation for more information.
- We will normally publish pre-release libraries labelled 'next' a few weeks before a new minor release. The goal is to provide early access to new features and get feedback from the community.
- If you choose not to use a new feature, you should have no problems upgrading to a new Major.# with features flag set to a previous Major.#. If you do see a problem, please report a bug and we’ll assess and fix it. We encourage you to upgrade to latest libraries frequently during development in order to take advantage of bug fixes and new features.
- To be able to use all functionality in Spartacus 3.\*, release 2005 of SAP Commerce Cloud is required. For example, release 2005 contains the OCC APIs for B2B Commerce Organization. In addition, the latest patch release is required, or at least strongly recommended, because it usually contains bug fixes that affect Spartacus (for example, ASM requires 1905.5, and the Save for Later feature requires 1905.11). Spartacus 3.\*  is also tested with and works with release 1905. Note, however, that Spartacus features that rely on new APIs introduced in 2005 (such as cancellations and returns) are not available if you are using SAP Commerce Cloud 1905. For more information on which version of Spartacus and which version of SAP Commerce Cloud is required for a particular feature, see [{% assign linkedpage = site.pages | where: "name", "feature-release-versions.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/home/feature-release-versions.md %}).

## How Spartacus is Versioned

Spartacus is following semantic versioning (Major.Minor.Patch).

- A new patch release (1.2.**3** > 1.2.**4** for example) means we added fixes or improvements but no new features.
- A new minor release (1.**2**.4 > 1.**3**.0 for example) means we added a new feature and possibly fixes and improvements.

For both patch and minor releases, upgrading to the new libraries should not cause any compatibility problems with your storefront app. (If it does, report a bug.) All new features and fixes are implemented in a compatible way. For example, all new features are disabled by default using feature flags. We hope you will upgrade frequently.

- A new major release (**1**.3.2 > **2**.0.0 for example) means that, besides adding new features and improvements, we made changes that will likely cause compatibility issues. Your app likely needs updating when moving to a new major release. These effects, reasons, and benefits will be documented.

We don't plan to introduce a new major release that frequently, unless an issue is found that makes it necessary to move to a major release . For example, a new major release of the Angular framework is one factor in our decision to move to a new major for Spartacus.

## Upgrading Spartacus Libraries to a New Minor Version

You can upgrade your Spartacus libraries to a new minor version, as follows:

1. In `package.json`, set your `@spartacus` libraries to `“~3.#.0"`, where `#` is replaced with the release version number you wish to upgrade to.

   If you are upgrading from 3.x to the latest 3.4 release in order to then upgrade to 4.x, in `package.json`, set your `@spartacus` libraries to `“~3.4.4"`.

1. Delete your `node_modules` folder.
1. Run `yarn install`.

## Future Releases

See the [separate roadmap document]({{ site.baseurl }}{% link _pages/home/spartacus-roadmap.md %}).

---
title: Compatibility Notes
---

## **NOTE**:

It is very important to use `yarn` instead of `npm` for installations. It will give a warning when using both. Please do not mix and match both package managers as they may cause conflicts.

## March 27, 2019

Libraries: spartacus/

- core 0.1.0-alpha.2
- storefront 0.1.0-alpha.2
- styles 0.1.0-alpha.2

### Reset Password

The reset password feature requires you to run the 1905 version of SAP Commerce Cloud for you back end. A new, required API endpoint was created in 1905 for the reset password feature, and another required endpoint was updated in 1905 for the feature to work as intended.

## February 13, 2019

Libraries: spartacus/

- core 0.1.0-prealpha.7
- storefront 0.1.0-prealpha.9
- styles 0.1.0-prealpha.15

### Top Bar Missing

The top bar is missing, so there are no language and currency menus, and you can't use the store finder.

New CMS components are being used to display the language and currency selectors, the store finder, and other links in the top right bar. The CMS components are pulled from the back end and thus aren't released yet.

Workarounds:

- You can change the language or currency in the URL. For example, when you first load the storefront, you will see `www.domain.com/en/USD/`. You can change `en` to `de` to show German, and `USD` to `JPY` to show Japanese Yen.

- You can display the store finder by adding `store-finder` after the language and currency entities. For example: `www.domain.com/en/USD/en/USD/store-finder`.

### Refresh Issue

Depending on the server configuration, refreshing the page or trying to go directly to a specific page will display the server's 404 error. This is not an issue with Spartacus but with the server URL rewrite rules.

For more information, see https://stackoverflow.com/questions/34619751/tomcat-8-url-rewrite-issues/44847035#44847035.

## January 14, 2019

Libraries: spartacus/

- core 0.1.0-prealpha.6
- storefront 0.1.0-prealpha.13
- styles 0.1.0-prealpha.7

### SmartEdit

Support for SmartEdit has been added in this release. Full functionality of this feature nonetheless requires extensions that will be released in SAP Commerce Cloud 1905.

### Variants & Multi-Dimensional Products

Spartacus does not support product Variants or Multi-Dimensional products yet. There may be some of these products in the sample data, but support for these types of products is not implemented yet in the storefront.

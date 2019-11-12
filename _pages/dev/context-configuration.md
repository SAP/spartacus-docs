---
title: Context Configuration
---

Every site in CMS has it's own so-called *context* including:

- base site ID,
- allowed languages and default language,
- allowed currencies and default currency.
- configuration of persistence of above attributes in the URL

The *context* can be defined statically in the Spartacus configuration at the property `context`. But it's recommended to leave out this property, so Spartacus can self-recognize by the URL, based on the sites' URL patterns defined in the CMS.

## Static context configuration

You can configure your application by defining `context` properties, such as base site, language, and currency. When you append the values of these properties to the storefront URL, the storefront is configured based on these values.

For example, when you access `https://localhost:4200/electronics-spa/en/USD/`, the application loads the `electronics-spa` base site, sets the site language to English (`en`), and sets the currency to US dollars (`USD`).

The `context` properties also set the default values for the language and currency drop-down lists, which you can use to change the context of the storefront dynamically.

### Context Properties

The `context` properties are located in `app.module.ts`.

The `baseSite`, `language`, and `currency` properties are arrays that take the first element in the array as the default value.

For example, the `language` property is defined as follows:

```typescript
 context: {
   language: ['en', 'de', 'ja', 'zh'],
   ...
```

In this case, the first element is `en`, so English is set as the default language for the application. The other elements in the array indicate the potential values that can be used by the application.

The `urlParameters` property takes the values of the other `context` properties to create the structure of the context that is appended to the storefront URL.

For example, if your storefront URL is `https://localhost:4200`, then it becomes `https://localhost:4200/electronics-spa/en/USD/` with the following `context` configuration:

```typescript
  context: {
    baseSite: [
      'electronics-spa', //Selected by default because it is the first element in the list
      'electronics',
    ],
    language: [
      'en'
    ],
    currency: [
      'USD'
    ],
    urlParameters: ['baseSite', 'language', 'currency']
  },
 ...
```

**Note:** You can change the structure of the context in the URL by changing the order of the elements in the `urlParameters` property. For example, if you change the `urlParameters` property to `urlParameters: ['currency', 'language', 'baseSite']`, then the URL becomes `https://localhost:4200/USD/en/electronics-spa/`.

### Enabling Context in the Storefront URL

By default, context does not appear in the Spartacus storefront URL.

You may wish to have context appear in the storefront URL as a way of optimizing SEO, or for maintaining URL compatibility with a previous storefront. For example, you might want search bots to classify different versions of a storefront based on the language and currency in the URL. Or you may be migrating to Spartacus from another storefront that includes context in the storefront URL, and you wish to maintain previously established page rankings.

To include the context in the URL, add the `urlParameters` property to the `context` property in `app.modules.ts`. The following is an example:

```ts
  context: {
    baseSite: ['electronics-spa'],
    urlParameters: ['baseSite', 'language', 'currency']
  },
```

## Automatic context configuration

By leaving out the configuration's property `context.baseSite`, we enable the automatic configuration of context. This means that before the initialization of the application, Spartacus will get the list of base sites from backend, compare the current URL with sites' URL patterns and then recognize the current base site and its languages, currencies and url encoding attributes.

### Mitigation of the blocking backend call

The initial call to backend for base sites is blocking the user experience. To mitigate it, we can cache the context using SSR or PWA.

#### Caching site context with Server side rendering

The site can be self-recognized during the Server side rendering and transferred to the browser with the Angular's `TransferState` mechanism. To avoid making call for base sites on the server side on every page request, the pages can be cached by a reverse proxy.

To enable self-recognizing of the site on the server side, you need to provide the current request URL to Spartacus. The simplest way to achieve it is to use Spartacus' decorator over the `ngExpressEngine` (which under the hood provides the Spartacus' injection token `SERVER_REQUEST_URL`), i.e. in your file `main.server.ts`:

```typescript
import { ngExpressEngine as engine } from '@nguniversal/express-engine';
import { NgExpressEngineDecorator } from '@spartacus/core';

export const ngExpressEngine = NgExpressEngineDecorator.get(engine);
```

#### Caching the backend response with base sites in PWA

When using PWA, the backend response with base sites can be cached by the Angular Service Worker, by adding a config to the array `dataGroups` in your service worker configuration (commonly named `ngsw-config.json`):
```json
{
  // ...
  "dataGroups": [
    // ...
    {
      "name": "basesites",
      "urls": [
        "*/rest/v2/basesites?fields=baseSites\\(uid,defaultLanguage\\(isocode\\),urlEncodingAttributes,urlPatterns,stores\\(currencies\\(isocode\\),defaultCurrency\\(isocode\\),languages\\(isocode\\),defaultLanguage\\(isocode\\)\\)\\)*"
      ],
      "cacheConfig": {
        "maxSize": 1,
        "maxAge": "1d", // 1 day; should be custom
        "strategy": "performance"
      }
    }
  ]
}
```

Notes:

- the `maxAge` of the cache should be custom
- parenthesis need escaping with double backslash `\\`
- if you customize the endpoint url in your application, you also need to reflect it in the `urls` in the above config

For more, see the official docs of the [Angular Service Worker configuration](https://angular.io/guide/service-worker-config#datagroups).

### Important notes

#### Base site encoded in the URL should be called 'storefront'

For the base site encoded in the URL parameters Spartacus uses the name `baseSite`, but in the CMS this parameter is called `storefront`. So in CMS you should still use `storefront`, but Spartacus will implicitly map it from `storefront` to `baseSite`. Other parameters like `language` or `currency` are left as-is.

#### URL patterns should be written in Java language

Due to historical reasons the regular expressions with URL patterns defined in the CMS are written in the Java language. However they are evaluated on the frontend side using JavaScript. So in the CMS you should still use Java regexps, but they will be implicitly converted from Java to Javascript in Spartacus only by replacing modifiers like `(?i)` (for case-insensitivity) to `/i`. 

Not all features of Java regexps are available in JavaScript. However above simple mapping should suffice for most common cases. **But please double check that your URL patterns don't use features of Java regexp that are not available in JavaScript**. Otherwise the base site with wrong URL pattern won't be recognized by Spartacus.

For more, please see:

- [Comparison of regular expression engines (language features) - Wikipedia](https://en.wikipedia.org/wiki/Comparison_of_regular_expression_engines#Language_features)
- the implementation of the Spartacus' service `JavaRegExpConverter`.

#### Empty URL patterns to inactivate a site

The backend endpoint returns the list of all base sites, without any information whether the site is active (regardless the options defined in the CMS: `active`, `activeFrom`, `activeTo`). **So to inactivate a base site, its URL patterns have to be emptied.**

An alternative low-level workaround is setting restrictions for calls to database in backend, to filter only `active` sites.

### Local development

When Spartacus deduces the site from the URL, it's often the case that the url is not simply `localhost:4200` (the default URL for the `ng serve`), but for example `electronics.localhost:4200`. Then you need to remember about a few things:

- the URL patterns defined in the CMS need to take into account that the port `:4200` is also a part of the URL
- your operating system need to know the IP of custom domains, so you need to add to your `hosts` file i.e. `127.0.0.1 electronics.localhost`
- local Webpack dev server need to allow for domains other than `localhost`, so you need to pass one of the flags: `host` or `disable-host-check` to the command `ng serve` (otherwise the Webpack dev server will display  `Invalid Host Header` in the browser). For example `ng serve --host electronics.localhost` or `ng serve --disable-host-check`

---
title: Automatic Context Configuration
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.3 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Every site that is defined in the CMS has its own context, which includes a base site ID, language properties, and currency properties. The context also defines how these attributes are persisted in the URL. You can allow Spartacus to automatically determine the context based on the URL patterns of your sites, as defined in the CMS. You can enable automatic context configuration by simply not defining the `context.baseSite` property in `app.module.ts`.

Before the application is initialized, Spartacus gets a list of the base sites from the back end, compares the current URL with the URL patterns of the sites that are defined in the CMS, and then identifies the current base site, along with its languages, currencies, and URL encoding attributes.

## Mitigation of the Blocking Back End Call

The initial call to backend for base sites is blocking the user experience. To mitigate it, we can cache the context using SSR or PWA.

### Caching site context with Server side rendering

The site can be self-recognized during the Server side rendering and transferred to the browser with the Angular's `TransferState` mechanism. To avoid making call for base sites on the server side on every page request, the pages can be cached by a reverse proxy.

To enable self-recognizing of the site on the server side, you need to provide the current request URL to Spartacus. The simplest way to achieve it is to use Spartacus' decorator over the `ngExpressEngine` (which under the hood provides the Spartacus' injection token `SERVER_REQUEST_URL`), i.e. in your file `main.server.ts`:

```typescript
import { ngExpressEngine as engine } from '@nguniversal/express-engine';
import { NgExpressEngineDecorator } from '@spartacus/core';

export const ngExpressEngine = NgExpressEngineDecorator.get(engine);
```

### Caching the backend response with base sites in PWA

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

## Important notes

### Base site encoded in the URL should be called 'storefront'

For the base site encoded in the URL parameters Spartacus uses the name `baseSite`, but in the CMS this parameter is called `storefront`. So in CMS you should still use `storefront`, but Spartacus will implicitly map it from `storefront` to `baseSite`. Other parameters like `language` or `currency` are left as-is.

### URL patterns should be written in Java language

Due to historical reasons the regular expressions with URL patterns defined in the CMS are written in the Java language. However they are evaluated on the frontend side using JavaScript. So in the CMS you should still use Java regexps, but they will be implicitly converted from Java to Javascript in Spartacus only by replacing modifiers like `(?i)` (for case-insensitivity) to `/i`. 

Not all features of Java regexps are available in JavaScript. However above simple mapping should suffice for most common cases. **But please double check that your URL patterns don't use features of Java regexp that are not available in JavaScript**. Otherwise the base site with wrong URL pattern won't be recognized by Spartacus.

For more, please see:

- [Comparison of regular expression engines (language features) - Wikipedia](https://en.wikipedia.org/wiki/Comparison_of_regular_expression_engines#Language_features)
- the implementation of the Spartacus' service `JavaRegExpConverter`.

### Empty URL patterns to inactivate a site

The backend endpoint returns the list of all base sites, without any information whether the site is active (regardless the options defined in the CMS: `active`, `activeFrom`, `activeTo`). **So to inactivate a base site, its URL patterns have to be emptied.**

An alternative low-level workaround is setting restrictions for calls to database in backend, to filter only `active` sites.

## Local development

When Spartacus deduces the site from the URL, it's often the case that the url is not simply `localhost:4200` (the default URL for the `ng serve`), but for example `electronics.localhost:4200`. Then you need to remember about a few things:

- the URL patterns defined in the CMS need to take into account that the port `:4200` is also a part of the URL
- your operating system need to know the IP of custom domains, so you need to add to your `hosts` file i.e. `127.0.0.1 electronics.localhost`
- local Webpack dev server need to allow for domains other than `localhost`, so you need to pass one of the flags: `host` or `disable-host-check` to the command `ng serve` (otherwise the Webpack dev server will display  `Invalid Host Header` in the browser). For example `ng serve --host electronics.localhost` or `ng serve --disable-host-check`

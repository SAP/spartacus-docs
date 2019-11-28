---
title: Automatic Context Configuration
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.3 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Every site that is defined in the CMS has its own context, which includes a base site ID, language properties, and currency properties. The context also defines how these attributes are persisted in the URL. You can allow Spartacus to automatically determine the context based on the URL patterns of your sites, as defined in the CMS. You can enable automatic context configuration by simply not defining the `context.baseSite` property in `app.module.ts`.

Before the application is initialized, Spartacus gets a list of the base sites from the back end, compares the current URL with the URL patterns of the sites that are defined in the CMS, and then identifies the current base site, along with its languages, currencies, and URL encoding attributes.

## Mitigating the Initial Back End Call

The initial call to the back end for base sites can be slow, which affects the user experience. To address this, you can choose to cache the context using server-side rendering (SSR) or progressive web application (PWA) techniques.

### Caching the Site Context with Server-Side Rendering

The site can be identified during server-side rendering, and the context can be transferred to the browser using the Angular `TransferState` mechanism. To avoid making calls to the server side with every page request, the pages can be cached by reverse proxy.

To allow the site to be identified on the server side, you need to provide the current request URL to Spartacus. You can do this by using the Spartacus decorator over the `ngExpressEngine`. The `ngExpressEngine` provides the `SERVER_REQUEST_URL` injection token to Spartacus under the hood. You can configure this in `main.server.ts`, as follows:

```typescript
import { ngExpressEngine as engine } from '@nguniversal/express-engine';
import { NgExpressEngineDecorator } from '@spartacus/core';

export const ngExpressEngine = NgExpressEngineDecorator.get(engine);
```

### Caching the Back End Response with Base Sites in PWA

When using PWA, the back end response with base sites can be cached by the Angular service worker, by adding a configuration to the `dataGroups` array in your service worker configuration. The following is an example from `ngsw-config.json`:

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
        "maxAge": "1d", // Set to 1 day. Customize this value according to your needs.
        "strategy": "performance"
      }
    }
  ]
}
```

In the example above, the `maxAge` shows a value of one day. Customize this value according to your needs.

Note that you need to escape parentheses with double backslashes `\\`, as seen in the `urls` configuration above. Also note that if you customize the endpoint URL in your application, you need to reflect this in the `urls` configuration.

For more information, see the official [Angular service worker configuration](https://angular.io/guide/service-worker-config#datagroups) documentation.

## Important Notes

### Base Sites and Storefronts

When the base site is encoded in the URL parameters, Spartacus refers to the `baseSite` parameter, while the CMS refers to this parameter as a `storefront`. You should continue to use the `storefront` parameter name in the CMS, because Spartacus implicitly maps `storefront` to `baseSite`. Other parameters, such as `language` and `currency`, are not touched.

### Writing URL Patterns in Java

For historical reasons, regular expressions with URL patterns that are defined in the CMS are written in Java. However, these regular expressions are evaluated on the front end using JavaScript. You should continue to use Java regex in the CMS, and they will be implicitly converted to JavaScript in Spartacus. For example, for case-insensitivity, modifiers such as `(?i)` are mapped to `/i`.

Due to historical reasons the regular expressions with URL patterns defined in the CMS are written in the Java language. However they are evaluated on the frontend side using JavaScript. So in the CMS you should still use Java regexps, but they will be implicitly converted from Java to Javascript in Spartacus only by replacing modifiers like `(?i)` (for case-insensitivity) to `/i`. 

Not all features of Java regexps are available in JavaScript. However above simple mapping should suffice for most common cases. **But please double check that your URL patterns don't use features of Java regexp that are not available in JavaScript**. Otherwise the base site with wrong URL pattern won't be recognized by Spartacus.

For more, please see:

- [Comparison of regular expression engines (language features) - Wikipedia](https://en.wikipedia.org/wiki/Comparison_of_regular_expression_engines#Language_features)
- the implementation of the Spartacus' service `JavaRegExpConverter`.

### Empty URL patterns to disable a site

The backend endpoint returns the list of all base sites, without any information whether the site is active (regardless the options defined in the CMS: `active`, `activeFrom`, `activeTo`). **So to inactivate a base site, its URL patterns have to be emptied.**

An alternative low-level workaround is setting restrictions for calls to database in backend, to filter only `active` sites.

## Local development

When Spartacus deduces the site from the URL, it's often the case that the url is not simply `localhost:4200` (the default URL for the `ng serve`), but for example `electronics.localhost:4200`. Then you need to remember about a few things:

- the URL patterns defined in the CMS need to take into account that the port `:4200` is also a part of the URL
- your operating system need to know the IP of custom domains, so you need to add to your `hosts` file i.e. `127.0.0.1 electronics.localhost`
- local Webpack dev server need to allow for domains other than `localhost`, so you need to pass one of the flags: `host` or `disable-host-check` to the command `ng serve` (otherwise the Webpack dev server will display  `Invalid Host Header` in the browser). For example `ng serve --host electronics.localhost` or `ng serve --disable-host-check`

---
title: Automatic Multi-Site Configuration
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

The site can be identified during server-side rendering, and the context can be transferred to the browser using the Angular `TransferState` mechanism. To avoid making calls for base sites on the server side with every page request, the pages can be cached using a reverse proxy.

To allow the site to be identified on the server side, you need to provide the current request URL to Spartacus. You can do this by using the Spartacus decorator of the `ngExpressEngine`, which provides the `SERVER_REQUEST_URL` injection token under the hood. You can configure this in `main.server.ts`, as follows:

```typescript
import { ngExpressEngine as engine } from '@nguniversal/express-engine';
import { NgExpressEngineDecorator } from '@spartacus/core';

export const ngExpressEngine = NgExpressEngineDecorator.get(engine);
```

### Caching the Back End Response with Base Sites in PWA

When using PWA, the back end response that provides the base sites can be cached by the Angular service worker, by adding a configuration to the `dataGroups` array in your service worker configuration. The following is an example from `ngsw-config.json`:

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

In the example above, the `maxAge` shows a value of one day. You can customize this value according to your needs.

Note that you need to escape any parentheses with double backslashes `\\`, as shown in the `urls` configuration above. Also note that if you customize the endpoint URL in your application, you need to reflect this in the `urls` configuration.

For more information, see the official [Angular service worker configuration](https://angular.io/guide/service-worker-config#datagroups) documentation.

## Important Notes

### Base Sites and Storefronts

When the base site is encoded in the URL parameters, Spartacus refers to the `baseSite` parameter, while the CMS refers to this parameter as a `storefront`. You should continue to use the `storefront` parameter name in the CMS, because Spartacus implicitly maps `storefront` to `baseSite`. Other parameters, such as `language` and `currency`, are not affected.

### Writing URL Patterns in Java

For historical reasons, regular expressions with URL patterns that are defined in the CMS are written in Java. However, these regular expressions are evaluated on the front end using JavaScript. You should continue to use Java regex in the CMS, and they will be implicitly converted to JavaScript in Spartacus. For example, for case-insensitivity, modifiers such as `(?i)` are mapped to `/i`.

**Note** Although the existing mapping between Java regex and JavaScript should suffice for the most common cases, not all Java regex features are available in JavaScript, so it is important to verify that your URL patterns do not use Java regex features that are not available in JavaScript. Otherwise, any base site with the wrong URL pattern will not be recognized by Spartacus.

For more information, see this comparison of regular expression engines in [Wikipedia](https://en.wikipedia.org/wiki/Comparison_of_regular_expression_engines#Language_features), and also look at the implementation of the `JavaRegExpConverter` service in Spartacus.

### Disabling a Base Site

The back end endpoint returns a list of all base sites, without any information about whether the site is active or not, regardless of the options defined in the CMS, such as `active`, `activeFrom`, or `activeTo`. To disable a base site, you must remove the URL patterns for that base site.

As an alternative, low-level workaround, you can set restrictions for calls to the database in the back end to filter only `active` sites.

## Local Development

When Spartacus identifies the site from the URL, it is often the case that the URL is not `localhost:4200` (which is the default URL for `ng serve`), but something more complex, such as `electronics.localhost:4200`. In this case, consider the following:

- the URL patterns defined in the CMS need to take into account that the port `:4200` is also a part of the URL
- your operating system needs to know the IP of the custom domains (such as `127.0.0.1 electronics.localhost`), which you must add to your `hosts` file
- the local Webpack dev server needs to allow for domains other than `localhost`, so you need to pass either the `host` flag or the `disable-host-check` flag to the `ng serve` command. Otherwise the Webpack dev server will display **Invalid Host Header** in the browser. The following are examples:

  - `ng serve --host electronics.localhost`
  - `ng serve --disable-host-check`

## How to add custom context (DRAFT)

The site context persisted in the URL might be something different than a simply an isocode of currency or language. For example it can be a formatted language (using uppercase letters, or with underscores instead of dashes). Then a custom service `SiteContext<T>` can be implemented. It needs to be registered in `ContextServiceMap` and reflected in the config of `context` and `context.urlParameters`.

Here is an example code of a custom site context that is simply the language isocode, but formatted uppercase.

The implementation of custom context service:

```typescript
export function languageToCustom(lang: string): string {
  return lang && lang.toUpperCase();
}

export function custom2Language(country: string): string {
  return country && country.toLowerCase();
}

@Injectable({ providedIn: 'root' })
export class CustomContextService implements SiteContext<string> {
  constructor(protected langService: LanguageService) {}

  getActive(): Observable<string> {
    return this.langService.getActive().pipe(map(languageToCustom));
  }

  setActive(country: string): void {
    this.langService.setActive(custom2Language(country));
  }

  getAll(): Observable<string[]> {
    return this.langService
      .getAll()
      .pipe(
        map(languages => languages.map(lang => languageToCustom(lang.isocode)))
      );
  }
}
```

If you are using automatic site configuration, additionally you need to:

1. Add in CMS (Backoffice) the _URL encoding attribute_ named `custom`.
2. Extend the dynamic Spartacus configuration of `context` to contain the key `custom`:

    ```typescript
    @Injectable()
    export class CustomOccConfigLoaderService extends OccConfigLoaderService {
      protected getConfigChunks(
        externalConfig: OccLoadedConfig
      ): (I18nConfig | SiteContextConfig)[] {
        // calculate config chunks
        const chunks = super.getConfigChunks(externalConfig);

        // take the chunk with SiteContextConfig (which is the first one in the array)
        const contextConfig = (chunks[0] as SiteContextConfig).context;

        // define possible values of custom context deriving from languages' iso codes
        contextConfig.custom = contextConfig[LANGUAGE_CONTEXT_ID].map(
          languageToCustom
        );

        return chunks;
      }
    }
    ```

Finally you need to provide the `ContextServiceMap` containing the custom context service, i.e. in your app module (if you implemented custom `OccConfigLoaderService`, it also needs being provided):

```typescript
export function serviceMapFactory() {
  return {
    [LANGUAGE_CONTEXT_ID]: LanguageService,
    [CURRENCY_CONTEXT_ID]: CurrencyService,
    [BASE_SITE_CONTEXT_ID]: BaseSiteService,
    custom: CustomContextService,
  };
}

@NgModule({
  /* ... */
  providers: [
    {
      provide: ContextServiceMap,
      useFactory: serviceMapFactory,
    },
    {
      provide: OccConfigLoaderService,
      useClass: CustomOccConfigLoaderService,
    },
  ],
/*...*/
```

Then you should be able to see your URL with language uppercase (i.e. `www.site.com/EN`), but use standard languages in your application with lowercase.

Above technique can be applied to implement any custom site context.

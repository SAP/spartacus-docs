---
title: Automatic Multi-Site Configuration
feature:
- name: Automatic Multi-Site Configuration
  spa_version: 1.3
  cx_version: 1905
- name: Automatic Theme Configuration
  spa_version: 3.2
  cx_version: 1905
  anchor: "#automatic-theme-configuration"
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.3 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Every site that is defined in the CMS has its own context, which includes a base site ID, language properties, and currency properties. The context also defines how these attributes are persisted in the URL. You can allow Spartacus to automatically determine the context based on the URL patterns of your sites, as defined in the CMS. You can enable this automatic context configuration by simply not defining the `context.baseSite` property in `app.module.ts`.

Before the application is initialized, Spartacus gets a list of the base sites from the back end, compares the current URL with the URL patterns of the sites that are defined in the CMS, and then identifies the current base site, along with its languages, currencies, and URL encoding attributes.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

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
        "*/rest/v2/basesites?fields=baseSites\\(uid,defaultLanguage\\(isocode\\),urlEncodingAttributes,urlPatterns,stores\\(currencies\\(isocode\\),defaultCurrency\\(isocode\\),languages\\(isocode\\),defaultLanguage\\(isocode\\)\\)*"
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

**Note:** Although the existing mapping between Java regex and JavaScript should suffice for the most common cases, not all Java regex features are available in JavaScript, so it is important to verify that your URL patterns do not use Java regex features that are not available in JavaScript. Otherwise, any base site with the wrong URL pattern will not be recognized by Spartacus.

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

## Adding a Custom Context

The site context that is persisted in the URL might not be just a simple ISO code of the currency or language. For example, it could be a formatted language that uses uppercase letters, or underscores instead of dashes. In this case, a custom `SiteContext<T>` service can be implemented. It needs to be registered in `ContextServiceMap` and reflected in the config of `context` and `context.urlParameters`.

The following sections describe how to implement a custom context service. In the example that follows, the ISO language code is formatted in uppercase, but you can use this technique to implement any custom site context that you wish.

### Creating a Service for a Custom Context

The following is an example of creating a service for a custom context where the ISO language code is formatted in uppercase:

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

### Configuring the Custom Context

You need to fill the Spartacus configuration of `context.custom` with all possible valid values of the custom context. How you do this depends on whether you are using [Automatic Context Configuration](#automatic-context-configuration) or [Static Context Configuration](#static-context-configuration). Each of these scenarios is described in the following sections.

#### Automatic Context Configuration

If you are using automatic site configuration, can set up the Spartacus configuration of `context.custom` as follows:

1. In Backoffice, open the **WCMS > Website** view and select the website that you want to update.
1. In the **Properties** tab, scroll down to **URL Encoding Attributes** and click the plus (`+`) button.
1. In the modal that appears, enter the name `custom` and click **Add**.
1. Save your changes and exit Backoffice.
1. In your Spartacus code, extend the dynamic configuration of `context` to contain the `custom` key, as shown in the following example:

    ```typescript
    @Injectable()
    export class CustomSiteContextConfigInitializer extends SiteContextConfigInitializer {
      protected getConfig(source: BaseSite): SiteContextConfig {
        // get the site context config
        const siteContextConfig = super.getConfig(source);

        // define possible values of custom context deriving from ISO languages codes
        const custom = siteContextConfig.context[LANGUAGE_CONTEXT_ID].map(
            languageToCustom
        );

        const config =  {
            context: {...siteContextConfig.context, custom}
        }
    
        return config;
      }
    }
    ```

## Static Context Configuration

If you are using static context configuration, you need to populate the `context.custom` with all possible valid values of the custom context. The following is an example from `app.module.ts`:

```typescript
providers: [
  provideConfig({
    context: { custom: ['EN', 'DE', 'JA', 'ZH'] }
  })
]
```

## Updating the Context Services Mapping

After configuring your custom context, you need to provide the `ContextServiceMap` that contains the custom context service. You can provide this in your app module, as shown in the following example:

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
    // version >= 3.2
    {
      provide: SiteContextConfigInitializer,
      useClass: CustomSiteContextConfigInitializer,
    },
    // version < 3.2
    {
      provide: OccConfigLoaderService,
      useClass: CustomOccConfigLoaderService,
    },
  ],
/*...*/
```

**Note:** If you have implemented a custom `SiteContextConfigInitializer`, this also needs to be provided, as shown in the example above.

You should now be able to see your URL with an uppercase ISO language code (for example, `www.site.com/EN`), while still being able to use standard lowercase languages in your application.

## Theme Configuration

{% capture version_note %}
{{ site.version_note_part1a }} 3.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

You can add a `theme` to your `SiteContextConfig`, either automatically or statically.

### Automatic Theme Configuration

You can set the `theme` by using the automatic site configuration, as described in the following procedure.

1. In Backoffice, open the **WCMS > Website** view.
1. Select the website that you want to update.
1. In the **Properties** tab, scroll down to **Base Configuration** and select the desired theme from the list.

    The theme value is applied as a CSS class in the root component of the application. For example, if the theme value is `sparta`, you should be able to see it in `<your-app class="... sparta ...">`.

### Static Theme Configuration

You can statically configuring your `theme`, as shown in the following example:

```typescript
providers: [
  provideConfig({
    context: { theme: ['your-theme-value'] }
  })
]
```

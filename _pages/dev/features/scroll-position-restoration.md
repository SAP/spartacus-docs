---
title: Scroll Position Restoration
feature:
- name: Scroll Position Restoration
  spa_version: 4.2
  cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 4.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The Spartacus scroll position restoration feature uses the same mechanism that is used by the `scrollPositionRestoration` configuration option from the `RouterModule` of the `@angular/router`. However, Spartacus provides additional configuration options to make the scroll position restoration functionality more flexible. For example, you can configure scroll position restoration so that users do not have their scroll position set to the top of the page when they visit child routes, or when query strings are appended to the URL.

---

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

---

## Enabling Scroll Position Restoration

You can enable scroll position restoration in one of two ways, as follows:

- The Spartacus scroll position restoration feature is enabled when you import the `AppRoutingModule` from `@spartacus/storefront` in your `AppModule`. The following is an example:

  ```ts
   @NgModule({
        imports: [
          BrowserModule,
          HttpClientModule,
          AppRoutingModule,

          // then the rest of your custom modules...
        ],
        ...
  ```

- You can instead use Angular's built-in scroll position restoration from the `ExtraOptions` of the `RouterModule` by enabling the `scrollPositionRestoration` option. The following is an example:

  ```ts
   @NgModule({
        imports: [
          BrowserModule,
          HttpClientModule,
          RouterModule.forRoot([], {
              anchorScrolling: 'enabled',
              relativeLinkResolution: 'corrected',
              initialNavigation: 'enabled',
              scrollPositionRestoration: 'enabled'
          }),

          // then the rest of your custom modules...
        ],
        ...
  ```

**Note:** You cannot have both options enabled at the same time in the `AppModule`.

## Configuring

The Spartacus scroll position restoration feature is enabled by default if the `AppRoutingModule` from `@spartacus/storefront` is imported to your `AppModule`.

You can configure the feature using `OnNavigateConfig`, which contains the following properties:

```ts
enableResetViewOnNavigate?: {
    active?: boolean;
    ignoreQueryString?: boolean;
    ignoreRoutes?: string[];
  };
```

The properties are configured as follows:

- `active` allows you to disable the custom Spartacus scroll position restoration functionality. If you have enabled the feature by importing the `AppRoutingModule` from `@spartacus/storefront` in your `AppModule`, you do not need to set this value.
- `ignoreQueryString` allows you to avoid resetting the scroll position back to the top of the same page when query strings are appended to the URL, such as `url?query=spartacus`.
- `ignoreRoutes` allows you to specify routes that should not scroll to the top of the page when the user visits a child route.

The following is an example configuration:

```ts
provideConfig(<OnNavigateConfig>{
    enableResetViewOnNavigate: {
        ignoreQueryString: true,
        ignoreRoutes: ['Open-Catalogue', 'product'],
    }
}
```

**Note:** You can set the `active` flag to `false` to disable the custom Spartacus functionality, and instead enable the out-of-the-box mechanism from `@angular/router`. The following is an example:

```ts
provideConfig(<OnNavigateConfig>{
  enableResetViewOnNavigate: {
    active: false,
  },
}),
{
  provide: ROUTER_CONFIGURATION,
  useValue: { scrollPositionRestoration: 'enabled' },
},
```

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

When scroll position restoration is enabled, it uses the same mechanism as done in the `RouterModule` for scrollPositionRestoration configuration in `@angular/router`. However, we have added some other configurations for flexibility as the out of the box mechanism for scroll position restoration may be too agressive for some, where you do not want the users to move to the top of the page for child routes and query strings.

---

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
  {:toc}

---

## Enabling scroll position restoration in Spartacus

To enable scroll position restoration, there are two options:

1. Using the Spartacus custom scroll position restoration

Make sure the `AppRoutingModule` from `@spartacus/storefront` is imported in your `AppModule`.

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

1. Using Angular's built-in scroll position restoration from `RouterModule` ExtraOptions using `scrollPositionRestoration`.

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

**Note** You can not have both options at the same time in the AppModule.

## Configuring the scroll position restoration behavior

Spartacus custom position restoration is `enabled` by default, if the `AppRoutingModule` from `@spartacus/storefront` is imported to the `AppModule`.

### OnNavigateConfig

Represents the scroll position restoration control.

The OnNavigateConfig contains the following properties:

```ts
provideConfig(<OnNavigateConfig>{
    enableResetViewOnNavigate: {
        ignoreQueryString: true,
        ignoreRoutes: ['Open-Catalogue', 'product'],
    }
}
```

```ts
enableResetViewOnNavigate?: {
    active?: boolean;
    ignoreQueryString?: boolean;
    ignoreRoutes?: string[];
  };
```

- active - whether you want to enable Spartacus custom scroll position restoration
- ignoreQueryString - whether you want to ignore back to top on the same page when things get appended to the url such as `url?query=spartacus`.
- ignoreRoutes - define routes that should not scroll to the top of the page when it is on a child route. Example: `ignoreRoutes: ['Open-Catalogue', 'product']`

**Note** You can set the active flag to `false` to not use the custom scroll position restoration from Spartacus and enable the out of the box mechanism from `@angular/router`.

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

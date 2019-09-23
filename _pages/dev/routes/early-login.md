---
title: Early Login (DRAFT)
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

A lot of B2B storefronts need a password-protected store, which you cannot enter without logging in. There will be typically at least **one page (login) public, or a few** (such as register, help, support, etc.). 

## Protect almost all routes

To enable the early login feature in Spartacus, please provide such a config, for example in the `ConfigModule`:

```typescript
ConfigModule.withConfig({
    routing: {
        protected: true,
        /* ... */
    }
})
```

... which will require logged in user to for all CMS-driven routes (with `CmsPageGuard`), but not for:

- login
- register
- forgot password
- reset password

... which are defined in the default Spartacus config to be public.

### Configure public routes

The public pages can be configured individually by setting explicitly `protected: false` for the individual route's config. *Note: values `true` and `undefined` will be ignored for individual routes.*

Example below:

```typescript
ConfigModule.withConfig({
    routing: {
        protected: true,
        /* ... */
        help: {
            paths: ['help'],
            protected: false // make this public
        }
        register: {
            protected: true // make it protected = overwrite default config `protected: false`
        }
    }
})
```

## Protecting only individual routes

The ealry login feature is not recommended for protecting individual routes, because it only allows for whitelisting of public pages. If only a minority of routes needs protection, please use [CMS Guarded Components](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/customizing-cms-components/#guarding-components).

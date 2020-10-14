---
title: Early Login
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

It is common practice for B2B stores to be password-protected, meaning that users need to log in before they can access the site. At the very least, a login page must be publicly accessible, and there can be other public pages as well, such as registration, help, and support pages. Other than these public pages, the rest of the B2B site requires authentication for the user to access it. The Spartacus early login feature allows you to make one or more pages of your site public, and to set the rest of the site as password-protected.

## Protecting Most Routes

You can enable early login by providing a configuration, such as the following:

```typescript
ConfigModule.withConfig({
    routing: {
        protected: true,
        /* ... */
    }
})
```

This configuration requires a user to be logged in to access any CMS-driven route (that is, any route that has a `CmsPageGuard`), with the exception of the following routes, which are defined as public in `default-routing-config.ts`:

- login
- register
- forgot password
- reset password

## Configuring Public Routes

When the global `protected` configuration is set to `true`, you can still override this for individual routes and make them public by explicitly setting `protected: false` for the individual route's configuration. The following is an example:

```typescript
ConfigModule.withConfig({
    routing: {
        protected: true,
        /* ... */
        routes: {
          contact: {
              paths: ['contact'],
              protected: false // make the contact route public
          },
          register: {
              protected: true // make the register route protected by overriding the `protected: false` configuration in `default-routing-config.ts`
          }
        }
      }
})
```

In the above example, the global configuration is set to `protected: true`, so all routes on the site are password-protected, except those routes that are defined by default as public in `default-routing-config.ts` (in other words, the login, register, forgot password and reset password routes). Now that the site is protected, you can still make specific routes public, such as the route for the Contact Us page, which is made public in this example by setting the `contact` route to `protected: false`. As already mentioned, certain routes are defined as public in `default-routing-config.ts`. If you want to make any of these routes password-protected, you can explicitly override the default setting, as shown with the register route in the above example.

**Note:** If the the global `protected` configuration is set to `false`, all values for individual routes are ignored. In other words, you cannot protect individual routes when the global `protected` configuration is set to `false`.

## Protecting Individual Routes

The early login feature is not recommended for protecting individual routes, because it only allows you to whitelist public pages. If you want to protect only a small number of routes, it is better to use CMS guarded components instead. For more information, see [Guarding Components](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/customizing-cms-components/#guarding-components).

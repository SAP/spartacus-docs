---
title: Disabling Standard Routes
---

Standard Angular routes in Spartacus, such as the route for the product details page, can be disabled through configuration. This can be useful, for example, when you want to provide custom routes instead. When you disable a route, the configuration of `paths` is used only to generate router links. For more information, see [{% assign linkedpage = site.pages | where: "name", "configurable-router-links.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/routes/configurable-router-links.md %}).

The following is an example of disabling the route for the product details page:

```typescript
ConfigModule.withConfig({
  routing: {
    routes: {
      product: {
        disabled: true,
        paths: /* ... */
      }
    }
  }
})
```

You can also disable the generation of router links for a specific page by setting `null` for the route's name, or by setting `null` or `[]` for the route's `paths`, as shown in the following example:

```typescript
ConfigModule.withConfig({
    routing: {
        routes: {
            product: null,
            /*
            or
              product: { paths: null }
            or
              product: { paths: [] }
            */
        }
    }
})
```

With this configuration, the standard Spartacus route is not matched, and the resulting configurable router link for this page is a forward slash `/`.

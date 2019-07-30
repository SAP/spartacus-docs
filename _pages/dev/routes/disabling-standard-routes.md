---
title: Disabling Standard Routes (DRAFT)
---

## Disabling Spartacus's Angular Route

Standard Angular routes of Spartacus (for example, the Product Details Page) can be disabled by config, which can be useful, for example, when you want to provide custom routes instead.

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

Then the configuration of `paths` will be used only to [generate router links]({{ site.baseurl }}{% link _pages/dev/routes/configurable-router-links.md %}).

## Disabling Generation of Semantic Router Links

You can also disable by config generating router links for a specific page. For example:

- set `null` for this route's name; or
- set `null` or `[]` for route's paths

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

Then the standard Spartacus' route won't be matched and configurable router links to this page will output `/`.

---
title: Route Configuration
---

Spartacus includes predefined route configurations in `default-routing-config.ts` that allow you to run your storefront app without needing to configure any routes at all. However, all routes in Spartacus can be configured by importing `ConfigModule.withConfig()` with an object containing the `routing` property, and every part of the predefined configurations can be extended or overwritten using `ConfigModule.withConfig()` as well.

The following is an example of extending a predefined configuration:

```typescript
ConfigModule.withConfig({
    routing: {
        routes: {
            product: { paths: [':productCode/custom/product-path'] }
        }
    }
})
```

Predefined configurations are extended and overwritten as follows:

- objects *extend* predefined objects
- values, such as primitives, arrays, and `null`, *overwrite* predefined values

When you extend a predefined configuration, you must always use the route parameters from the predefined configuration, such as the `:productCode` parameter in the `product/:productCode` path. If you omit a route parameter, the storefront's components could break. The following is an example of what you should **not** do:

```typescript
ConfigModule.withConfig({
    routing: {
        routes: {
            product: { paths: ['product/:productName'] } // overwritten without :productCode
        }
    }
})
```

**Note:** The `paths` property takes the form of an array to support route aliases. For more information, see [{% assign linkedpage = site.pages | where: "name", "route-aliases.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/routes/route-aliases.md %}).

## Working with Angular Routes

For `Routes` to be configurable, they need to be named the same in the `data.cxRoute` property and in the route keys in the configuration.

The following example shows the `data.cxRoute` property defining the name of the route as `'product'`:

```typescript
const routes: Routes = [
    {
        data: {
            cxRoute: 'product' // the name of the route
        },
        path: null, // it will be replaced by the path from config
        component: ProductPageComponent
        /* ... */
    }
];
```

And in the following example, `product` is again used as the name for the route:

```typescript
ConfigModule.withConfig({
    routing: {
        routes: {
            product: { // the name of the route
                paths: [/*...*/]
            }
        }
    }
})
```

**Note:** The `path` property cannot be `undefined`. Angular requires a defined `path` at compilation time.

### Child Routes or Nested Routes

An Angular `Route` can contain `children` (also known as nested routes), as shown in the following example:

```typescript
const routes: Routes = [
    {
        data: {
            cxRoute: 'parent' // the name of the route
        },
        children: [
            {
                data: {
                    cxRoute: 'child' // the name of the route
                },
                /* ... */
            }
        ],
        /* ... */
    }
];
```

In this case, you need to configure both the parent and the child routes, as shown in the following example:

```typescript
ConfigModule.withConfig({
    routing: {
        routes: {
            parent: { // the name of the route
                paths: ['parent-path'],
            },
            child: { // the name of the route
                paths: ['child-path']
            },
        }
    }
})
```

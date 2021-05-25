---
title: Configurable Router Links
---

When you configure routes, the links to those routes must be configured accordingly. Configured router links can be automatically generated in HTML templates using the `cxUrl` pipe. This allows you to transform the name of the route and the `params` object into the configured path.

To make use of the `cxUrl` pipe, you need to import `UrlModule` into every module that uses configurable router links.

By default, the output path array is absolute and contains a leading forward slash `'/'`. However, the output path does not contain a leading forward slash `'/'` when the input starts with an element that is not an object with a `route` property, such as the string `'./'`, or `'../'`, or `{ not_route_property: ... }`. Also note, a route that cannot be resolved from the route's name and parameters will return the root URL `['/']`.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Router links

### Transform the name of the route and the params object

```typescript
{ cxRoute: <route> } | cxUrl
```

Example:

```html
<a [routerLink]="{ cxRoute: 'cart' } | cxUrl"></a>
```

when config is:

```typescript
ConfigModule.withConfig({
    routing: {
        routes: {
            cart: { paths: ['custom/cart-path'] }
        }
    }
})
```

result in:

```html
<a [routerLink]="['/', 'custom', 'cart-path']"></a>
```

#### The route with parameters

When the route needs parameters, the object with route's `name` and `params` can be passed instead of just simple string. For example:

```html
<a [routerLink]="{ cxRoute: 'product', params: { productCode: 1234 } } | cxUrl"></a>
```

where config is:

```typescript
ConfigModule.withConfig({
    routing: {
        routes: {
            product: { paths: [':productCode/custom/product-path'] }
        }
    }
})
```

result:

```html
<a [routerLink]="['/', 1234, 'custom', 'product-path']"></a>
```

## Links to nested routes

When Angular's `Routes` contain **arrays** of `children` routes:

```typescript
const routes: Routes = [
    {
        data: { cxRoute: 'parent' }, // route name
        children: [
            {
                data: { cxRoute: 'child' }, // route name
                /* ... */
            },
            {
                data: { cxRoute: 'otherChild' }, // route name
                /* ... */
            }
        ],
        /* ... */
    }
];
```

then config should be:

```typescript
ConfigModule.withConfig({
    routing: {
        routes: {
            parent: { // route name
                paths: ['parent-path/:param1'],
            },
            child: { // route name
                paths: ['child-path/:param2'],
            }
            otherChild: { // route name
                paths: ['other-child-path'],
            }
        }
    }
})
```

In order to generate the path of parent and child route we need to pass them in an array. For example:

```html
<a [routerLink]="[
    { cxRoute: 'parent', params: { param1: 'value1' },
    { cxRoute: 'child',  params: { param2: 'value2' }
] | cxUrl,
)"></a>
```

result:

```html
<a [routerLink]="['/', 'parent-path', 'value1', 'child-path', 'value2']"></a>
```


### Relative links

If you are already in the context of the activated parent route, you may want to only generate a relative link to the child route. Then you need to pass `'./'` string in the beginning of the input array . For example:

```html
<a [routerLink]="[ './', { cxRoute: 'child',  params: { param2: 'value2' } } ] | cxUrl"></a>
```

result:

```html
<a [routerLink]="['./', 'child-path', 'value2']"></a>
```

### Relative links up

If you want to go i.e. one one level up in the routes tree, you need to pass `../` to the array. For example:

```html
<a [routerLink]="[ '../', { cxRoute: 'otherChild' } ] | cxUrl"></a>
```

result:

```html
<a [routerLink]="['../', 'child-path', 'value2']"></a>
```

**NOTE:** *Every element that is **not an object with `route` property** won't be transformed. So for example:*

```html
<a [routerLink]="[
    { cxRoute: 'parent', params: { param1: 'value1' } },
    'SOMETHING'
] | cxUrl,
)"></a>
```

*will result in:*

```html
<a [routerLink]="['/', 'parent-path', 'value1', 'SOMETHING']"></a>
```

**NOTE:** *If the first element in the array is **not an object with `route` property**, the output path array won't have `'/'` element by default. So for example:*


```html
<a [routerLink]="[
    'SOMETHING',
    { cxRoute: 'parent', params: { param1: 'value1' } }
] | cxUrl,
)"></a>
```

*will result in:*

```html
<a [routerLink]="['SOMETHING', 'parent-path', 'value1']"></a>
```

## Parameters mapping

When properties of given `params` object do not match exactly to names of route parameters, they can be mapped using `paramsMapping` option in the configuration. For example:

The `params` object below does not contain necessary property `productCode`, but it has `code`:

```html
<a [routerLink]="{ cxRoute: 'product', params: { code: 1234 } } | cxUrl"></a>
```

Then `paramsMapping` needs to be configured:

```typescript
ConfigModule.withConfig({
    routing: {
        routes: {
            product: {
                /* 'productCode' route parameter will be filled with value of 'code' property of 'params' object  */
                paramsMapping: { productCode: 'code' }
                paths: [':productCode/custom/product-path']
            }
        }
    }
})
```

result:

```html
<a [routerLink]="['/', 1234, 'custom', 'product-path']"></a>
```

### Predefined parameters mapping

The routes of some storefront already have predefined `paramsMapping`. They can be found in `default-routing-config.ts`.

```typescript
// default-routing-config.ts

product: {
    paramsMapping: { productCode: 'code' }
    /* ... */
},
category: {
    paramsMapping: { categoryCode: 'code' }
    /* ... */
},
/* ... */
```

## Programmatic API

### Navigation to the generated path

The `RoutingService.go` method called with `{ cxRoute: <route> }` navigates to the generated path - similar like `routerLink` with `cxUrl` pipe in the HTML template. For example:

When config is:

```typescript
ConfigModule.withConfig({
    routing: {
        routes: {
            product: { paths: ['p/:productCode'] }
        }
    }
})
```

```typescript
routingService.go({ cxRoute: 'product', params: { productCode: 1234 } });

// router navigates to ['/', 'p', 1234]
```

### Simply generation of the path

The `SemanticPathService.transform` method called with `{ cxRoute: <route> }` returns the generated path (just like `cxUrl` pipe in HTML templates). For example:

When config is:

```typescript
ConfigModule.withConfig({
    routing: {
        routes: {
            product: { paths: ['p/:productCode'] }
        }
    }
})
```

```typescript
semanticPathService.transform({ cxRoute: 'product', params: { productCode: 1234 } });

// ['/', 'p', 1234]
```

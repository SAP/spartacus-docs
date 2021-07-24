---
title: Configurable Router Links
---

When you configure routes, the links to those routes must be configured accordingly. Configured router links can be automatically generated in HTML templates using the `cxUrl` pipe. This allows you to transform the name of the route and the `params` object into the configured path.

To make use of the `cxUrl` pipe, you need to import `UrlModule` into every module that uses configurable router links.

By default, the output path array is absolute and contains a leading forward slash `'/'`. However, the output path does not contain a leading forward slash `'/'` when the input starts with an element that is not an object with a `cxRoute` property, such as the string `'./'`, or `'../'`, or `{ not_cxRoute_property: ... }`. Also note, a route that cannot be resolved from the route's name and parameters will return the root URL `['/']`.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Router Links

You can transform the name of the route and the `params` object as follows:

```typescript
{ cxRoute: <route> } | cxUrl
```

The following is an example:

```html
<a [routerLink]="{ cxRoute: 'cart' } | cxUrl"></a>
```

The following is an example of the related route configuration:

```typescript
ConfigModule.withConfig({
    routing: {
        routes: {
            cart: { paths: ['custom/cart-path'] }
        }
    }
})
```

The result is the following configured router link:

```html
<a [routerLink]="['/', 'custom', 'cart-path']"></a>
```

### Configuring Router Links with Parameters

If you need to include parameters in the route, you can pass the route `name` and `params` objects, as shown in the following example:

```html
<a [routerLink]="{ cxRoute: 'product', params: { productCode: 1234 } } | cxUrl"></a>
```

The following is an example of the related route configuration:

```typescript
ConfigModule.withConfig({
    routing: {
        routes: {
            product: { paths: [':productCode/custom/product-path'] }
        }
    }
})
```

The result is the following configured router link:

```html
<a [routerLink]="['/', 1234, 'custom', 'product-path']"></a>
```

### Additional Route Parameters

You can configure additional route parameters to make a URL more specific, which can be useful for SEO.

The following is an example that adds a new `:productName` parameter:

```typescript
ConfigModule.withConfig({
    routing: {
        routes: {
            product: { 
                paths: [
                    // :productCode is an obligatory parameter because it is present in default URL
                    // :productName is a new parameter
                    ':productCode/custom/product-path/:productName'
                ] 
            }
        }
    }
})
```

You also need to include any additional parameters in `{ cxRoute: <route> }`, otherwise the path cannot be generated.

The following is an example that adds the new `productName` parameter to `{ cxRoute: <route> }`:

```html
<a [routerLink]="{ cxRoute: 'product', params: { productName: 'ABC', productCode: 1234 } } | cxUrl"></a>
```

The result is the following configured router link:

```html
<a [routerLink]="['/', 1234, 'custom', 'product-path', 'ABC']"></a>
```

## Linking to Nested Routes

The following is an example of the Angular `Routes` array that contains `children` routes:

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

When the `Routes` array contains child routes, the configuration should be as follows:

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

To generate the path of the parent and child routes, you need to pass them in an array, as shown in the following example:

```html
<a [routerLink]="[
    { cxRoute: 'parent', params: { param1: 'value1' },
    { cxRoute: 'child',  params: { param2: 'value2' }
] | cxUrl,
)"></a>
```

The result is the following configured router link:

```html
<a [routerLink]="['/', 'parent-path', 'value1', 'child-path', 'value2']"></a>
```

### Configuring Relative Links

If you are already in the context of the activated parent route, you may want to only generate a relative link to the child route. In this case, you need to pass `'./'` in the beginning of the input array. The following is an example:

```html
<a [routerLink]="[ './', { cxRoute: 'child',  params: { param2: 'value2' } } ] | cxUrl"></a>
```

The result is the following configured router link:

```html
<a [routerLink]="['./', 'child-path', 'value2']"></a>
```

### Navigating Up the Routes Tree

If you want to go, for example, one one level up in the routes tree, you need to pass `../` to the array. The following is an example:

```html
<a [routerLink]="[ '../', { cxRoute: 'otherChild' } ] | cxUrl"></a>
```

The result is the following configured router link:

```html
<a [routerLink]="['../', 'child-path', 'value2']"></a>
```

### Objects Without the "cxRoute" Property

Any element that is not an object with the `cxRoute` property is not transformed when router links are generated. The following is an example that includes an element that is not an object with the `cxRoute` property:

```html
<a [routerLink]="[
    { cxRoute: 'parent', params: { param1: 'value1' } },
    'SOMETHING'
] | cxUrl,
)"></a>
```

The result is the following router link:

```html
<a [routerLink]="['/', 'parent-path', 'value1', 'SOMETHING']"></a>
```

If the first element in the array is not an object with the `cxRoute` property, the output path array will not have the forward slash `'/'` element by default. The following is an example where the first element in the array is not an object with the `cxRoute` property:


```html
<a [routerLink]="[
    'SOMETHING',
    { cxRoute: 'parent', params: { param1: 'value1' } }
] | cxUrl,
)"></a>
```

The result is the following router link:

```html
<a [routerLink]="['SOMETHING', 'parent-path', 'value1']"></a>
```

## Mapping Parameters

When the properties of a `params` object do not match exactly with the names of the route parameters, you can map them by using the `paramsMapping` option in the configuration.

In the following example, the `params` object does not contain the necessary `productCode` property, but it does have a `code` property:

```html
<a [routerLink]="{ cxRoute: 'product', params: { code: 1234 } } | cxUrl"></a>
```

You can configure the `paramsMapping` as follows:

```typescript
ConfigModule.withConfig({
    routing: {
        routes: {
            product: {
                /* The 'productCode' route parameter will be filled with the value of the 'code' property of the 'params' object  */
                paramsMapping: { productCode: 'code' }
                paths: [':productCode/custom/product-path']
            }
        }
    }
})
```

The result is the following configured router link:

```html
<a [routerLink]="['/', 1234, 'custom', 'product-path']"></a>
```

**Note:** Spartacus includes a number of predefined `paramsMapping` configurations in `default-routing-config.ts`.

## Programmatic API

### Navigation to the Generated Path

The `RoutingService.go` method called with `{ cxRoute: <route> }` navigates to the generated path, similar to the `routerLink` with the `cxUrl` pipe in the HTML template.

The following is an example configuration:

```typescript
ConfigModule.withConfig({
    routing: {
        routes: {
            product: { paths: ['p/:productCode'] }
        }
    }
})
```

You can then call the `RoutingService.go` method as follows:

```typescript
routingService.go({ cxRoute: 'product', params: { productCode: 1234 } });

```

The result is that the router navigates to `['/', 'p', 1234]`.

### Path Generation

The `SemanticPathService.transform` method called with `{ cxRoute: <route> }` returns the generated path, just like the `cxUrl` pipe in the HTML templates.

The following is an example configuration:

```typescript
ConfigModule.withConfig({
    routing: {
        routes: {
            product: { paths: ['p/:productCode'] }
        }
    }
})
```

You can then call the `SemanticPathService.transform` method as follows:

```typescript
semanticPathService.transform({ cxRoute: 'product', params: { productCode: 1234 } });
```

The result is the following generated path:

```ts
['/', 'p', 1234]
```

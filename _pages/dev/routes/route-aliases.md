---
title: Route Aliases
---

Multiple route aliases can be configured in the `paths` array. Spartacus then generates router links using the first configured alias that can satisfy the parameters of the `paths` array with the `params` object. As a result, you need to order aliases from those that require the most specific parameters to those having the least parameters.

In the following example, the configuration has the route aliases in the correct order:

```typescript
ConfigModule.withConfig({
    routing: {
        routes: {
            product: {
                paths: [
                    ':campaignName/p/:productCode', /* this will be used when the `campaignName` parameter is provided */
                    'p/:productCode' /* this will be used otherwise */
                ]
            }
        }
    }
})
```

The following is an example where the `campaignName` parameter is provided:

```html
<a [routerLink]="{ cxRoute: 'product', params: { productCode: 1234, campaignName: 'sale' } } | cxUrl"></a>
```

The result is the following configured router link:

```html
<a [routerLink]="['/', 'sale', 'p', '1234']"></a>
```

The following is an example where the `campaignName` parameter is not provided:

```html
<a [routerLink]="{ cxRoute: 'product', params: { productCode: 1234 } } | cxUrl"></a>
```

The result is the following configured router link:

```html
<a [routerLink]="['/', 'p', '1234']"></a>
```

## Wrong Order of Aliases

When a path with less parameters, such as `/p/:productCode`, is listed in the configuration before a path that has the same number of parameters and more, such as `:campaignName/p/:productCode`, then the first alias will always be used to generate the path, and the second alias will never be used.

In the following example, the configuration has the route aliases in the wrong order:

```typescript
ConfigModule.withConfig({
    routing: {
        routes: {
            product: {
                paths: [
                    /* WRONG: */

                    /* will always be used */
                    'p/:productCode', 

                    /* will never be used, because (among others) it contains the same parameters as above */
                    ':campaignName/p/:productCode'
                ]
            }
        }
    }
})
```

The following is an example where the `campaignName` parameter is provided:

```html
<a [routerLink]="{ cxRoute: 'product', params: { productCode: 1234, campaignName: 'sale' } } | cxUrl"></a>
```

The following is an example where the `campaignName` parameter is not provided:

 ```html
 <a [routerLink]="{ cxRoute: 'product', params: { productCode: 1234 } } | cxUrl"></a>
 ```

In both cases, the resulting configured router link is the same, and the `campaignName` parameter is not included:

```html
<a [routerLink]="['/', 'p', '1234']"></a>
```

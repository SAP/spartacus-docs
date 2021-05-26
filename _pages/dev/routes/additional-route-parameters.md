---
title: Additional Route Parameters
---

Additional route parameters can be configured to make the URL more specific, which can be useful for SEO.

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

Then additional params are also needed in `{ cxRoute: <route> }` (otherwise path cannot be generated). Examples:

`{ cxRoute: <route> }` also needs the new `productName` param:

```html
<a [routerLink]="{ cxRoute: 'product', params: { productName: 'ABC', productCode: 1234 } } | cxUrl"></a>
```

result:

```html
<a [routerLink]="['/', 1234, 'custom', 'product-path', 'ABC']"></a>
```

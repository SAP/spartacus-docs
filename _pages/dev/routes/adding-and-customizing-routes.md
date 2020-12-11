---
title: Adding and Customizing Routes
---

## Page Types and Page Labels

The CMS in SAP Commerce Cloud comes with the concept of three special page types: Product Page, Category Page, Catalog Page (Catalog is not supported for now) and one common type Content Page used for all other pages, i.e. login, order history or faq.

Spartacus reflects that by defining a few Angular `Routes`:

- route with `:productCode` param - for Product Pages
- route with `:categoryCode` param and route with `:brandCode` param - for Category Pages
- wildcard `**` route - for all other, Content Pages

The URLs of product, category and brand pages can be [configured only in Spartacus]({{ site.baseurl }}{% link _pages/dev/routes/route-configuration.md %}). Content Pages have a configurable URL in the CMS, called *page label*.

## Adding a Content Page Route

To add new route, no development is required, it suffices to add in the CMS a new Content Page with *page label* starting with slash i.e. `/contact-us`. The Spartacus' wildcard `**` route with match it out of the box.

## Customizing the Product Page Route

Product Page route can be configured only in Spartacus. It has to contain the `:productCode` param to identify the product. But for SEO you may want to also include more parameters that can be accessed in the product entity, i.e. product name, in `ConfigModule`:

```typescript
routing: {
    routes: {
        product: { paths: ['product/:name/:productCode'] }
    }
}
```

**Note:** The optional `paramsMapping` config can be used for properties that have a different name than the route parameter (i.e. to map from `product.code` to `:productCode`). For more information, see [Configurable Router Links]({{ site.baseurl }}{% link _pages/dev/routes/configurable-router-links.md %}).

## Customizing the Category Page Route

Similar to Product Page.

## Adding a Content Page with Dynamic Parameters

Angular routes can contain dynamic *route parameters* that are consumed in the logic of Angular components. Although The SAP Commerce Cloud CMS doesn't support *page labels* with dynamic params, you can have dynamic params for Content Pages in Spartacus. You need to define your custom Angular `Route` with `path` and explicitly assign the CMS *page label*, for example in your `app.module.ts`:

```typescript
import { PageLayoutComponent, CmsPageGuard } from `@spartacus/storefront`;

/* ... */

imports: [
    RouterModule.forChild([
        {
            // path with dynamic param:
            path: 'order/:orderCode',

            // page label without param, starting with slash:
            data: { pageLabel: '/order' },

            // those are needed to display slots and components from CMS:
            component: PageLayoutComponent,
            canActivate: [CmsPageGuard]
        }
    ]),
]
```

## Adding Angular Child Routes for a Content Page

Angular can display components for child routes inside nested `<router-outlet>`. Although the SAP Commerce Cloud CMS doesn't support child pages, in Spartacus you can have child routes. You need to configure child routes for your CMS component, for example in `ConfigModule`:

```typescript
cmsComponents: {
    CustomComponentName: {
        component: CustomComponent,
        childRoutes: [
            {
                path: 'some/nested/path',
                component: ChildCustomComponent,
            },
        ],
    }
}
```

**Note:** Child routes for the Product and Category Pages are not supported.

## Configuring the Category Name in the Product Page Route (Advanced)

Only the first-level properties of the product entity (i.e. `code` or `name`) can be used to build URL. Unfortunately, product categories is not the case (the field `categories` is an array of objects). So you need to map `categories` array's elements to the first-level properties of the product entity. You can perform such a mapping for example in the `PRODUCT_NORMALIZER`. Here is how to do it:

Provide `PRODUCT_NORMALIZER` i.e. in your app.module:

```typescript
providers: [
    {
      provide: PRODUCT_NORMALIZER,
      useClass: MyProductCategoriesNormalizer,
      multi: true,
    },
]
```

... and add your implementation with mapping ...

```typescript
@Injectable()
export class MyProductCategoriesNormalizer
  implements Converter<Occ.Product, Product> {
  convert(source: Occ.Product, target?: any): any {
    if (source.categories && source.categories.length) {
      target.category = source.categories[0].name; //
    }
    return target;
  }
}
```

... then the `category` field is available in your product entity. So you can configure the Product Page route in `ConfigModule` to contain `:category` param:

```typescript
routing: {
    routes: {
        product: { paths: ['product/:category/:name/:productCode'] }
    }
}
```

**Note:** It is a known issue that product entities returned by the OCC product search endpoint do not contain categories, so you may want to also generate URLs from product entities that do not include categories. Then you also need to configure the second, less-specific route alias. The following is an example:

```typescript
routing: {
    routes: {
        product: {
            paths: ['product/:category/:name/:productCode', 'product/:name/:productCode'] 
        }
    }
}
```

## Backwards Compatibility with Accelerators

The SAP Commerce Cloud Accelerators used routes `**/p/:productCode` and `**/c/:categoryCode` for Product and Category Page. For backwards compatibility, Spartacus also matches those routes, by simply numbering parameters.

So for example URL `/some-catalogue/some-category/p/1234` will be recognized with parameters:

```typescript
{
    productCode: '1234',
    param0: 'some-catalogue',
    param1: 'some-category',
}
```

If you want to have more semantic names of parameters, you can configure a route alias. For example in `ConfigModule`:

```typescript
routing: {
    routes: {
        product: {
            paths: ['product/:name/:productCode', ':catalogue/:category/p/:productCode'] 
        }
    }
}
```

## Avoiding Static URL Segments in the Product Page URL (Advanced)

To watch a video explainer of this topic, see [Custom Angular URL Matchers in the Spartacus Storefront](https://microlearning.opensap.com/media/Custom+Angular+URL+Matchers+in+Spartacus+Storefront+-+SAP+Commerce+Cloud/1_hhjqkiuy/178316081).

Angular, and Spartacus by extension, allows you to configure string patterns to match routes against URLs. An example is `/product/:productCode`, which has two segments. The first segment, `product`, is a static segment that determines the URL is a product page type, and the second segment, `:productCode`, is a dynamic parameter.

However, there may be cases where you need to work with URL segments that contain both static and dynamic parts within a single segment. An example is `/macbook-p`, where `mackbook` is a dynamic product code, and `-p` is a static part that determines the URL is a product page type. In this case, you need to implement a custom Angular `UrlMatcher`. The following is an example:

```typescript
/**
 * Matches pattern `/:productCode-p`
 * @param segments
 */
export function customProductUrlMatcher(
  segments: UrlSegment[]
): UrlMatchResult | null {
  // check if URL ends with `-p`
  if (segments.length === 1 && segments[0].path.endsWith('-p')) {
    // Remove last two characters (which are `-p`), and treat the rest as a product code
    const productCode = segments[0].path.slice(0, -2);
    return {
      consumed: segments,
      posParams: { productCode: new UrlSegment(productCode, {}) },
    };
  }
  return null;
}
```

After setting up your `UrlMatcher`, you need to pass it to the Spartacus configuration of the product route. You can do this in the `app.module`, as follows:

```typescript
ConfigModule.withConfig({
  routing: {
    routes: {
      product: {
        matchers: [customProductUrlMatcher],
        paths: [':customProductCode'],
      },
    },
  },
}),
```

In the above example, `paths` is also configured, with the intention of producing links that have a shape of `:productCode-p`. To do this, the `customProductCode` attribute needs to be added to the product data, which can be done by implementing a custom `PRODUCT_NORMALIZER`. The following is an example:

```typescript
@Injectable()
export class CustomProductNormalizer
  implements Converter<Occ.Product, Product> {
  convert(source: Occ.Product, target?: Product): Product {
    target['customProductCode'] = source.code + '-p';
    return target;
  }
}
```

As you can see in the example above, the `customProductCode` is made by combining the original product code with the string `-p`.

The final step is to provide the `PRODUCT_NORMALIZER`. You can do this in the `app.module`, as follows:

```typescript
providers: [
  {
    provide: PRODUCT_NORMALIZER,
    useClass: CustomProductNormalizer,
    multi: true,
  },
],
```

## Expected CMS page labels of Content Pages

Spartacus expects the page label `homepage` to be configured in the CMS. For B2C Storefront recipe the list of expected CMS page labels by default is longer:

```plaintext
search

/login
/logout
/login/register
/login/forgot-password
/login/reset-password
/terms-and-conditions

/cart
/checkout
/checkout/shipping-address
/checkout/delivery-mode
/checkout/payment-details
/checkout/review-order
/order-confirmation

/my-account/order
/my-account/orders

/not-found
```

### Fixed CMS page labels

For almost all Content Pages, Spartacus treats the URL as the CMS page label. It means that changing the config of route in Spartacus requires also a change of the page label in the CMS. However, there are few exceptions - when the configurable Spartacus' URL is mapped to a fixed CMS page label:

| Spartacus URL (configurable)                                         | Fixed CMS page label |
| -------------------------------------------------------------------- | -------------------- |
| `/search/:query` (configurable cxRoute `search`)                     | `search`             |
| `/my-account/order/:orderCode` (configurable cxRoute `orderDetails`) | `/my-account/order`  |

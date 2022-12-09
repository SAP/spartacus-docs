---
title: Adding and Customizing Routes
---

Spartacus includes default routes for accessing different views within your storefront app, but you can also add or customize any route that you want in Spartacus.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Page Types and Page Labels

The CMS in SAP Commerce Cloud includes the following special page types: Product, Category, and Catalog. There is also a generic Content page type, which is used for all other kinds of pages, such as the login, order history, and FAQ pages.

**Note:** The Catalog page type is currently not supported in Spartacus.

Spartacus defines the following Angular `Routes` by default:

- Routes that contain the `:productCode` parameter are for Product pages
- Routes that contain the `:categoryCode` parameter or the `:brandCode` parameter are for Category pages
- Routes that contain the `**` wildcard are for Content pages (in other words, the wildcard is for all pages that are not Product or Category pages)

Content pages have a configurable URL in the CMS, called a page label. However, the URLs for product, category, and brand pages can only be configured in Spartacus. For more information, see [{% assign linkedpage = site.pages | where: "name", "route-configuration.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/routes/route-configuration.md %}).

## Adding a Content Page Route

To add a new route, you simply add a new Content page in the CMS, and give it a page label that begins with a slash, such as `/contact-us`. The Spartacus wildcard route (`**`) matches it without any configuration.

## Customizing a Product or Category Page Route

You can only configure Product and Category page routes in Spartacus.

Product page routes must contain the `:productCode` parameter to identify the product. Category page routes must contain the `:categoryCode` or `:brandCode` parameter to identify the category.

For SEO, you may want to include more parameters in your route. The following is an example `ConfigModule` that adds a product name to the Product page route:

```typescript
routing: {
    routes: {
        product: { paths: ['product/:name/:productCode'] }
    }
}
```

**Note:** The optional `paramsMapping` configuration can be used for properties that have a different name than the route parameter. For example, you may wish to map from `product.code` to `:productCode`. For more information, see [{% assign linkedpage = site.pages | where: "name", "configurable-router-links.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/routes/configurable-router-links.md %}).

## Adding a Content Page with Dynamic Parameters

Angular routes can contain dynamic route parameters that are consumed by the logic of your Angular components. Although the SAP Commerce CMS does not support page labels with dynamic parameters, you can have dynamic parameters for Content pages in Spartacus.

In `app.module.ts`, you define the URL path for your custom Angular `Route` with the `path` property, and you explicitly assign the CMS page label using the `data` property. The following is an example:

```typescript
import { PageLayoutComponent, CmsPageGuard } from `@spartacus/storefront`;

/* ... */

imports: [
    RouterModule.forChild([
        {
            // path with a dynamic parameter:
            path: 'order/:orderCode',

            // page label without a parameter, starting with slash:
            data: { pageLabel: '/order' },

            // the following are needed to display slots and components from the CMS:
            component: PageLayoutComponent,
            canActivate: [CmsPageGuard]
        }
    ]),
]
```

## Adding Angular Child Routes for a Content Page

Angular can display components for child routes inside a nested `<router-outlet>`. Although the SAP Commerce CMS does not support child pages, in Spartacus you can have child routes.

For example, you can configure child routes for your CMS component in the `ConfigModule`, as follows:

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

**Note:** Child routes for the Product and Category pages are not supported.

## Configuring the Category Name in the Product Page Route (Advanced)

Only the first-level properties of the product entity, such as `code` or `name`, can be used to build a URL. Unfortunately, something like product categories is not a first-level property because the `categories` field is an array of objects. To be able to include product categories in the URL, you need to map the elements of the `categories` array to the first-level properties of the product entity.

The following procedure describes how to create this mapping in the `PRODUCT_NORMALIZER`.

1. Configure the `product` OCC endpoint so that the `list` scope contains the `categories(code,name)` field.

    The following is an example:

    ```typescript
    backend: {
      occ: {
        endpoints: {
          product: {
            list: //                          👇
              'products/${productCode}?fields=categories(code,name),code,name,summary,price(formattedValue),images(DEFAULT, galleryIndex)',
          },
        },
      },
    },
    ```

2. Provide a `PRODUCT_NORMALIZER`.

    You can provide it in your `app.module`, as shown in the following example:

    ```typescript
    providers: [
        {
          provide: PRODUCT_NORMALIZER,
          useClass: MyProductCategoriesNormalizer,
          multi: true,
        },
    ]
    ```

3. Add your implementation with the mapping, as shown in the following example:

    ```typescript
    @Injectable()
    export class MyProductCategoriesNormalizer
      implements Converter<Occ.Product, Product> {
      convert(source: Occ.Product, target?: any): any {
        if (source?.categories?.length) {
          target.category = source.categories[0].name;
        }
        return target;
      }
    }
    ```

    Now the `category` field is available in your product entity.

4. Configure the Product page route in your `ConfigModule` to contain the `:category` parameter, as shown in the following example:

    ```typescript
    routing: {
        routes: {
            product: { paths: ['product/:category/:name/:productCode'] }
        }
    }
    ```

    **Note:** It is a known issue that product entities returned by the OCC product search endpoint do not contain categories, so you may want to also generate URLs from product entities that do not include categories. In this case, you also need to configure the second, less specific route alias. The following is an example:

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

The SAP Commerce Accelerators use `**/p/:productCode` and `**/c/:categoryCode` as routes for the Product and Category pages, respectively. For backwards compatibility, Spartacus also matches these routes by numbering parameters.

For example, the URL `/some-catalogue/some-category/p/1234` is recognized with the following the parameters:

```typescript
{
    productCode: '1234',
    param0: 'some-catalogue',
    param1: 'some-category',
}
```

To give your parameters more semantic names, you can configure a route alias in the `ConfigModule`, as shown in the following example:

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

## Expected CMS Page Labels for Content Pages

Spartacus expects the `homepage` page label to be configured in the CMS. For the B2C storefront recipe, the default list of expected CMS page labels is longer, as shown in the following example:

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
/checkout/delivery-address
/checkout/delivery-mode
/checkout/payment-details
/checkout/review-order
/order-confirmation

/my-account/order
/my-account/orders

/not-found
```

### Fixed CMS Page Labels

For almost all Content Pages, Spartacus treats the URL as the CMS page label. This means that changing the configuration of the route in Spartacus also requires changing the page label in the CMS. However, as shown in the following table, there are a few exceptions, such as when a configurable URL for Spartacus is mapped to a fixed CMS page label.

| Spartacus URL (configurable)                                         | Fixed CMS page label |
| -------------------------------------------------------------------- | -------------------- |
| `/search/:query` (configurable cxRoute `search`)                     | `search`             |
| `/my-account/order/:orderCode` (configurable cxRoute `orderDetails`) | `/my-account/order`  |

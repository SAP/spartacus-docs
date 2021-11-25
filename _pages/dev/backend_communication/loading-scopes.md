---
title: Loading Scopes
feature:
- name: Loading Scopes
  spa_version: 1.4
  cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

When Spartacus requests product data from the back end, the payload that is returned is often very large, and may be required in multiple places, such as in product carousels, the product details page, and so on. However, the complete payload is not necessarily required in all of these places. By breaking the payload into pieces, which we call *scopes*, you can specify which part of the payload is actually needed for each particular case.

Spartacus currently supports scopes for the loading of product data.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Using Default Product Scopes

By default, Spartacus uses a number of predefined scopes. The predefined scopes include, but are not limited to, the following:

```typescript
export enum ProductScope {
  LIST = 'list',
  DETAILS = 'details',
  ATTRIBUTES = 'attributes',
  VARIANTS = 'variants',
}
```

It is recommended that you take advantage of these scopes when retrieving product data. The following is an example:

```typescript
productService.get(code, ProductScope.LIST) // retrieves minimal product data, suitable for listing, carousel items, etc.
productService.get(code, ProductScope.DETAILS) // retrieves detailed product data, suitable for using in the product details page or for generating json-ld schema
```

## Configuring the Payload for Scopes

When you are working with the Spartacus `OccProductAdapter`, you can configure scope payloads by using the `fields` parameter in the endpoint configuration, under the `backend.occ.endpoints.product` key. The following is an example:

```ts
{
  backend: {
    occ: {
      endpoints: {
        product: {
          list: 'products/${productCode}?fields=code,name,summary,price(formattedValue),images(DEFAULT,galleryIndex)',
          // ...
          attributes: 'products/${productCode}?fields=classifications',
        },
      },
    },
  },
}
```

Spartacus  preprocesses these fields to optimize calls to the back end, especially to limit the number of calls if more that one scope is requested at the same time.

Ideally, `fields` descriptions should be as specific as possible, and aliases such as `BASIC`, `DEFAULT` and `FULL` should be avoided, where possible.

## Defining Custom Loading Scopes

You define a custom product scope by adding a new endpoint configuration with the specified `fields` parameter. In the following example, a new `price` scope is defined and made available:

```ts
{
  backend: {
    occ: {
      endpoints: {
        product: {
          price: 'products/${productCode}?fields=price(FULL)',
        },
      },
    },
  },
}
```

With this configuration, you can now use your new scope simply by passing its name. For example, you can get price data for the product as follows:

```typescript
productService.get(code, 'price');
```

Custom scopes work in the same way as default ones, which means they can be merged, included, have a specified `maxAge`, and so on.

## Merging Scopes

In some scenarios, it is beneficial to get data for more than one scope at the same time.

You can do this by passing an array of scopes to the `productService.get` method. The following is an example:

```typescript
productService.get(code, [ProductScope.DETAILS, ProductScope.ATTRIBUTES]) // returns a product payload with merged data for both scopes
```

With this example, you should expect multiple emissions that, in certain cases, could initially contain partial payloads, because the observable instantly delivers data for all scopes that are loaded, and lazy loads the missing ones.

Partial payloads for each scope are merged into one payload according to the order in which the scopes were provided. If scope payloads overlap, then the scope that was specified later in the array can overwrite parts of the payload that were provided earlier. It is always preferable to provide scope definitions that do not overlap with each other, but it is certainly acceptable to provide scope definitions that do overlap, as long as you are aware of the merging order.

## Scope Inclusions

Scope inclusions allow you to optimize the loading of data from multiple scopes. This can be illustrated with the following example:

- you have the `list` scope, which contains only minimal data
- you have the `details` scope, which contains product details, including data that is available in the `list` scope

Scope inclusion allows you to load additional, detailed data if the `list` scope is already loaded. One simple use case is navigating to the product details page after clicking on a carousel item. You already have the basic product data available, which can be displayed instantly, and you only need to make a request for the missing details.

This is handled by removing payload parts from the `details` scope if they are already covered by the `list` scope, and by including the `list` scope in the `details` scope, as shown in the following example:

```ts
{
  backend: {
    loadingScopes: {
      product: {
        details: {
          include: ['list']
        }
      },
    },
  },
}
```

This configuration always results in an optimal call, as follows:

- If only the `list` scope is required, only the `list` scope is loaded.
- If the `details` scope is required, the `list` scope and the `details` scope are both loaded in one network request.
- If the `details` scope is required and the `list` scope is already available, only data from the `details` scope is loaded.

The payload that is defined for the main scope (in this case, the `details` scope) always takes precedence when merging scopes. This means that if one of the included scopes (in this case, the `list` scope) contains the same payload parts as the `details` scope, it will be effectively overwritten by data from the `details` scope.

It is possible to provide more than one scope in the `include` array configuration, and those scopes are merged according to the same rules and order as described in [Merging Scopes](#merging-scopes).

## Keeping Scope Data Up To Date

Working with scopes allows you to load only the part of the data that you need, and to load it efficiently, which usually means only once per session or context change. For data that should be kept fresh and reloaded more often, you can use the `maxAge` parameter to take care of data reloads when the data becomes obsolete.

The `maxAge` is specified in seconds, and can be defined for a scope as shown in the following example:

```ts
{
  backend: {
    loadingScopes: {
      product: {
        list: {
          maxAge: 60
        }
      },
    },
  },
}
```

This configuration results in a `list` scope that reloads as soon as it becomes older than 60 seconds.

A reload only takes place when the scope is "in use", which is to say, when a certain piece of code is subscribed to that data scope. In many cases, this is when the data from the scope is actually being used on a page.

## Reloading Triggers

The `reloadOn` configuration allows you to reload a product when a specific event occurs. The following is an example:

```ts
{
  backend: {
    loadingScopes: {
      product: {
        details: {
          reloadOn: [MyEvent]
        }
      },
    },
  },
}
```

In this example, the `details` scope is reloaded when `MyEvent` is emitted.

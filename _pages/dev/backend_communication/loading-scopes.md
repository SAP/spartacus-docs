---
title: Using Loading Scopes (DRAFT)
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Product data payload is usually huge and required in multiple places, like the Product Detail Page, items in Product Carousels, etc. 
Not all places need complete product payload, breaking product payload into pieces (called scopes), allows to specify which part of the payload is actually needed in a specific case.

Currently, Spartacus supports scopes for loading product data. 

## Using default Product Scopes

By default, Spartacus uses few predefined scopes. The list includes (but is not limited to):

```typescript
export enum ProductScope {
  LIST = 'list',
  DETAILS = 'details',
  ATTRIBUTES = 'attributes',
  VARIANTS = 'variants',
}
```

You can (and should) take advantage of those scopes when getting product data:

```typescript
productService.get(code, ProductScope.DETAILS) // get minimal product data, suitable for listing, carousel items, etc.
productService.get(code, ProductScope.DETAILS) // get detailed product data, suitable for using in product details page or for generating json-ld schema
```

## Configuring Payload for Scopes

When using Occ Products Adapter you can configure scope payloads using `fields` parameter in the endpoint configuration, under `product_scopes` key:

```json
{
  backend: {
    occ: {
      endpoints: {
        product_scopes: {
          list: 'products/${productCode}?fields=code,name,summary,price(formattedValue),images(DEFAULT,galleryIndex)',
          // ...
          attributes: 'products/${productCode}?fields=classifications',
        },
      },
    },
  },
}
```

Spartacus will preprocess those fields to optimize backend calls, especially to limit the number of calls, if more that one scope will be requested at the same time.
To make backend requests as optimal as possible fields description should be as specific as possible, using aliases like `BASIC`, `DEFAULT` or `FULL` should ideally be avoided. 


## Defining Custom Loading Scope

Defining custom product scopes is very simple and straightforward. To add new scope just add new endpoint configuration with specified fields parameter:

```json
{
  backend: {
    occ: {
      endpoints: {
        product_scopes: {
          price: 'products/${productCode}?fields=price(FULL)',
        },
      },
    },
  },
}
```

It will result in a new `price` scope being available. 

With this, you can use your new scope by just passing its name. For example, to get price data for the product using the above configuration just do: 

```typescript
productService.get(code, 'price');
```

Custom scopes work in the same way as default ones, i.e. can be merged, included, can have maxAge specified, etc.


## Merging of Scopes

In some scenarios, it's beneficial to get data for more than one scope at the same time.

You can do it passing an array of scopes to `productService.get` method like below:

```typescript
productService.get(code, [ProductScope.DETAILS, ProductScope.ATTRIBUTES]) // with return product payload with merged data for both scopes
```

Using this you should expect multiple emissions in certain scenarios that could contain partial payloads initially, as observable will instantly deliver data for all scopes that are loaded and will lazy load the missing ones. 
Partial payloads for each scope will be merged into one payload respecting the order in which scopes were provided. This means, that if scopes payloads overlap, then the scope that was specified later can overwrite parts of payload provided earlier. 
It's always more optimal to provide scope definitions that don't overlap with each other but it's perfectly fine to not do as long as you are aware of the merging order. 


## Scope Inclusions

It's possible to define scope inclusions, let's assume that:
1) we have the `list` scope, that contains only minimal data
2) we have the `details` scope that contains product details including data available in list scope

Using inclusion will allow as to load additional detailed data if the list scope was already loaded. One simple use case would be navigating to PDP from clicking on the carousel item. We already have basic product data available which we can display instantly and we only need to request for missing details.

It's possible to make it work by:
1) removing payload parts from details scope if they are covered by list scope
2) including list scope in details scope, like below:

```json
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

With this configuration you will always get an optimal call, for example:

1. if only list scope will be required, only list scope will be loaded
2. if details scope will be required, list and details scope will be loaded in one network request
3. if defails scope will be required and list scope will be already available, only data from details scope will be loaded

Payload defined for master scope (`details` in the above example) will always take precedence when merging scopes, meaning that if one of the included scopes (`list`) contains the same payload parts as `details` it will be effectively overwritten by data from `details`.
It's possible to provide more than one scope in `include` array configuration and those scopes will be merged using the same rules and order as described in __Merging of Scopes__.


## Defining maxAge for the Scope

Using loading scopes allows loading only part of the data that we need and load it efficiently, which usually means only once per session / context change. 
For data that should be kept fresh and reloaded more often, you can use `maxAge` parameter that will take care of data reloads when it becomes obsolete. 

`maxAge` should be specified in seconds and can be defined for a scope like this:

```json
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

This configuration will result in a `list` scope reload as soon as it becomes older than 60 seconds. 

Reload will only take place, when scope will be "in use", more specifically when some code will be subscribed to that data scope, which usually means that the data from the scope is currently used on a page. 

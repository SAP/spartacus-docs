---
title: Export from Cart
feature:
  - name: Export from Cart
    spa_version: 4.1
    cx_version: 2005
---

{% capture version_note %}
{{ site.version_note_part1 }} 4.1 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The export from cart feature allows users to download CSV file containing specified cart product entries. Currently feature supports two places in storefront from which product list can be exported:

- cart details page
- saved cart details page

Export from cart feature is tightly connected with import to cart, because already downloaded CSV file can be re-imported back to the storefront. For more details see import to cart documentation.

Worth to notice is that exported file always should contain product code and quantity columns. Any other additional columns can be defined in configuration [see more](#additional-columns).

---

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
  {:toc}

---

## Enabling Export from cart

Export from cart feature can be enabled by installing the `@spartacus/cart` feature library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

Also the import of following impex script is required to make feature work properly:

```
$contentCatalog=electronics-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]

# Create CMSFlexComponents
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef
;;ExportOrderEntriesComponent;Export Order Entries Component;ExportOrderEntriesComponent;ExportOrderEntriesComponent

# Update slots
UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)
;;TopContent-cartPage;CartComponent,SaveForLaterComponent,ExportOrderEntriesComponent
```

## Configuration

Export feature uses described below configuration model:

```ts
export abstract class ImportExportConfig {
  importExport?: {
    file: {
      separator: string;
    };
    export?: {
      additionalColumns?: ExportColumn[];
    };
  };
}
```

- `separator` - determines which character is used to seperate values. The default separator is comma (",").
- `additionalColumns` - optional array where additional columns to export can be specified. By default exported file contains **name** and **price** values as additional columns. More details about this property can be found [here](#additional-columns).

### Additional columns

`additionalColumns` is an array of `ExportColumn` elements. Allows customer to specify which columns besides code and quantity can be exported to CSV file.

`ExportColumn` model consists of two properties:

```ts
export interface ExportColumn {
  name: Translatable;
  value: string;
}
```

- `name` - is a `Translatable` object used to translate column heading to the language currently set in a storefront. If `key` value was provided it also requires to have a representation in trasnlation file.
- `value` - is a dot notation string which refers to specified `OrderEntry` attribute (check available attributes in `order.model.ts`).

Below can be found an example of default configuration:

```ts
export: {
  additionalColumns: [
    {
      name: {
        key: 'name',
      },
      value: 'product.name',
    },
    {
      name: {
        key: 'price',
      },
      value: 'totalPrice.formattedValue',
    },
  ],
},
```

There are no limits with specyfing number of columns, also it is possible to change columns order by changing order in configuration:

```ts
export: {
  additionalColumns: [
    {
      name: {
        key: 'stockStatus',
      },
      value: 'product.stock.stockLevelStatus',
    },
    {
      name: {
        key: 'name',
      },
      value: 'product.name',
    },
    {
      name: {
        key: 'price',
      },
      value: 'totalPrice.formattedValue',
    },
    {
      name: {
        key: 'thumbnail',
      },
      value: 'product.images.PRIMARY.thumbnail.url',
    },
  ],
},
```

---
title: Cart Import/Export
feature:
  - name: Cart Import/Export
    spa_version: 4.2
    cx_version: 2011
---

{% capture version_note %}
{{ site.version_note_part1 }} 4.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

This feature allows a customer to create saved cart or update active cart, by importing CSV file containing product codes and quantities.

Analogical allows users to download CSV file containing specified cart product entries.

---

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
  {:toc}

---

## Enabling Cart Import/Export

Cart Import/Export feature can be enabled by installing the `@spartacus/cart` feature library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

### CMS Components

Feature is CMS-driven and consists of the one component named as `ImportExportComponent`.

It can be disabled by turning off such component in backoffice or by using ImpEx query.

## Global Configuration

To allow customers adjust this feature to their needs the following configuration model has been implemented:

```ts
export abstract class ImportExportConfig {
  cartImportExport?: {
    file: {
      separator: string;
    };
    import?: ImportConfig;
    export: ExportConfig;
  };
}
```

- `separator` - determines which character is used to seperate values. The default separator is comma (",").
- `import` - specific configuration for import to cart process
- `export` - specific configuration for export from cart process

### ImportConfig

Feature consists of configuration for import which can be modified to specify special file rules and attributes.

```ts
export interface ImportConfig {
  fileValidity?: FileValidity;
  cartNameGeneration?: CartNameGeneration;
}
```

There is possibility to change validation for imported files like allowed type, size and maximum number of entries. To achieve this `fileValidaty` property should be overwritten:

### ExportConfig

Configuration offers setting dedicated for export feature only:

```ts
export interface ExportConfig {
  additionalColumns?: ExportColumn[];
  messageEnabled?: boolean;
  downloadDelay?: number;
  fileOptions: ExportFileOptions;
  maxEntries?: number;
}
```

- `additionalColumns` - is optional array where additional columns to export can be specified. By default exported file contains **name** and **price** values as additional columns. More details about this property can be found [here](#additional-columns).

- `messageEnabled` - flag used to determine if global message informing about download starting proccess should be visible to customer.

- `downloadDelay` - property dedicated to delay download starting process, mainly created to not spam customer by displaying global message and download pop-up same time.

- `fileOptions` - metadata for exported file. For more information please look into `export-file-options.ts` file.

- `maxEntries` - determines entries limit in exported CSV file.

#### Additional columns

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

Here is an example of default configuration:

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

---
title: Export From Cart
feature:
- name: Export From Cart
  spa_version: 4.2
  cx_version: 2005
---

{% capture version_note %}
{{ site.version_note_part1 }} 4.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The Export From Cart feature allows you to download a CSV file that contains a product list of all the items in your cart. You can export this product list from the Cart Details page or the Saved Cart Details page.

The Export From Cart feature works together with the [{% assign linkedpage = site.pages | where: "name", "import-to-cart.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/import-to-cart.md %}) feature, which means you can export a CSV file, make changes to it, and then reimport it back into the storefront.

**Note:** The exported file always contains the product code and quantity columns. You can include additional columns by defining them in the configuration. For more information, see [Additional Columns](#additional-columns).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Enabling Export From Cart

You can enable Export From Cart by installing the `@spartacus/cart` feature library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

The import and export functionality is CMS-driven, and consists of a single component, called the `ImportExportComponent`. You can disable the entire feature by turning off this component in Backoffice, or by turning off the component using an ImpEx query.

## Global Configuration

The cart import and cart export features use a common configuration model. The following is an example:

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

In this model, the `separator` designates which character is used to separate the values in the exported file. The default separator is a comma (`,`).

In addition to the common configuration settings, you can configure settings that are related only to the export feature. The following is an example from `export-entries.model.ts`:

```ts
export interface ExportConfig {
  additionalColumns?: ExportColumn[];
  messageEnabled?: boolean;
  downloadDelay?: number;
  fileOptions: ExportFileOptions;
  maxEntries?: number;
}
```

The following is a description of the settings:

- `additionalColumns` is an optional array that allows you to define additional columns to include in the exported file. By default, the exported file contains additional `name` and `price` columns. For more information, see [Additional Columns](#additional-columns).

- `messageEnabled` is a flag that determines if customers see a global message informing them about the start of the download process.

- `downloadDelay` is a property that is dedicated to delaying the start of the download process. The main purpose of this property is avoid spamming customers by displaying the global message and the download pop-up at the same time.

- `fileOptions` is metadata for the exported file. For more information about the available options, see the `export-file-options.ts` file in the Spartacus source code.

- `maxEntries` determines the maximum number of entries that can be included in the exported CSV file.

### Additional Columns

By default, the exported CSV file contains product code and quantity columns. You can add `ExportColumn` elements to the `additionalColumns` to define which additional columns you want to include in the exported CSV file.

The following is an example of the `ExportColumn` model:

```ts
export interface ExportColumn {
  name: Translatable;
  value: string;
}
```

The following is a description of the properties of the `ExportColumn` model:

- `name` is a `Translatable` object that is used to translate the column heading to the language that is currently set in the storefront. If the `key` value is provided, you must also have a representation of the key in the translation file.
- `value` is a dot notation string that refers to a specific `OrderEntry` attribute. You can see the available attributes in the `order.model.ts` file in the Spartacus source code.

The following is an example of the default configuration for `additionalColumns` in Spartacus:

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

Your exported CSV file can contain as many columns as you would like. It is also possible to change the order of the columns in the exported file by changing the order of the columns in the configuration, as shown in the following example:

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

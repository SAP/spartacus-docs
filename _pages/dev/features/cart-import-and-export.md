---
title: Cart Import and Export
feature:
  - name: Cart Import and Export
    spa_version: 4.2
    cx_version: 2011
---

{% capture version_note %}
{{ site.version_note_part1 }} 4.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

This feature allows a customer to create saved cart or update active cart, by importing CSV file containing product codes and quantities.

And the other way, it allows users to download CSV file containing specified order entries.

---

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
  {:toc}

---

## Enabling Cart Import and Export

Cart Import/Export feature can be enabled by installing the `@spartacus/cart` feature library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

### CMS Components

Feature is CMS-driven and consists of the following components:

`ImportOrderEntriesComponent` - allows rendering button for import order entries.

`ExportOrderEntriesComponent` - allows rendering button for export order entries.

`ImportExportOrderEntriesComponent`- allows to render both buttons in a row (for import and export)

Button rendering can be disabled by turning off such specific component in backoffice or by using ImpEx query.


### Order Entries Context

Import/export feature uses page context provided by routing. In this case, used key is `ORDER_ENTRIES_CONTEXT`.
Provided context should implement one or both of the following interfaces:
- `AddOrderEntriesContext` - An interface for context which determinate import products destination. Implementation must contain `addEntries` method and `type` property.
- `GetOrderEntriesContext` - An interface for context which determinate export products source. Implementation must involve `getEntries` method.
  
If only one of the interfaces is implemented, the other function button will be not displayed as a default.

The export button will be hidden also in case when the order entries list is empty.

### Routing configuration
When one of the above CMS components is registered on the page, you can define your own routing configuration for the feature in the root module, containing the `cxContext` property.

#### Example: ####
```ts
 RouterModule.forChild([
   {
     // @ts-ignore
     path: null,
     canActivate: [AuthGuard, CmsPageGuard],
     component: PageLayoutComponent,
     data: {
       cxRoute: 'savedCartsDetails',
       cxContext: {
         [ORDER_ENTRIES_CONTEXT]: SavedCartOrderEntriesContext,
       },
     },
   },
   //...
```

## Import process

Even if UI was prepared to go through the process smoothly, customer must be aware that products are imported one by one (not all at once), so it is potential risk that import process may be disturbed by no intentional browser tab closure or by losing the internet connection.

### Saved Cart

To use import to Saved Cart log in as customer in Spartacus storefront and go to `Saved Carts` page using user menu. There should be the 'Import products' button available above the saved carts list.

Then form in dialog should be filled: firstly, by selecting valid CSV file with products (it can be the one previously exported using export functionality.

Secondly, by providing cart name and description. For reference see [Saved Cart feature]({{ site.baseurl }}/features/saved-cart) documentation.

### Active Cart

Importing to active cart looks similar to [Saved Cart](#saved-cart) however is not needed to specify cart name and description.

To start import process go to the cart page and if it is empty use 'Import products' link from suggestions. On the other hand if some products were added already into the cart import button will be available below cart entries list.

### Quick Order

The import / export feature supports also quick order functionality. Additional limitation while import is max count of products possible to import in one quick order.

### Others

The configuration has been set up so that the export is also available on the order confirmation and order details pages. There are no contraindications to add it in checkout review order page. It is enough to provide him with the context from the active cart.

### Limitations

Current import logic takes CSV file content and go line by line to detect product code and quantity. Customer is notified in import summary view about import status.

There are following kind of statuses so far:

**success** - product code and quantity are valid, and product is not out of stock.

**warning** - product code is valid, but quantity is higher than amount available in stock. In this case system will import maximum available quantity for such product.

**error** - product code, quantity are invalid or product with following SKU does not exists in database.

## Export process

The Export Order Entries feature allows you to download a CSV file that contains a product list of all the items in your cart. You can export this entries from the Cart Details page or the Saved Cart Details page.

The Export From Cart feature works together with the import feature, which means you can export a CSV file, make changes to it, and then reimport it back into the storefront.

**Note:** The exported file always contains the product code and quantity columns. You can include additional columns by defining them in the configuration. For more information, see [Additional Columns](#additional-columns).

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

In addition to the common configuration settings, you can configure settings that are related only to the import and export feature.

### ImportConfig

Feature consists of configuration for import which can be modified to specify special file rules and attributes.

```ts
export interface ImportConfig {
  fileValidity?: FileValidity;
  cartNameGeneration?: CartNameGeneration;
}
```

There is possibility to change validation for imported files like allowed type, size and maximum number of entries. To achieve this `fileValidaty` property should be overwritten.
By default it looks like following:

```ts
export const defaultImportExportConfig: ImportExportConfig = {
  cartImportExport: {
    import: {
      fileValidity: {
        maxSize: 1,
        maxEntries: {
          [OrderEntriesSource.NEW_SAVED_CART]: 100,
          [OrderEntriesSource.SAVED_CART]: 100,
          [OrderEntriesSource.ACTIVE_CART]: 10,
          [OrderEntriesSource.QUICK_ORDER]: 10,
        },
        allowedTypes: [
          "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
          "application/vnd.ms-excel",
          "text/csv",
          ".csv",
        ],
      },
    },
  },
};
```

- `maxSize` - determines maximum imported file size in megabytes.
- `maxEntries` - determines limit number for imported entries per source specified as key from `OrderEntriesSource`.
- `allowedTypes` - string array with file types/extensions allowed for import.

Another config property is `CartNameGeneration`. By default new saved cart name during import is taken from imported file.

```ts
export const defaultImportExportConfig: ImportExportConfig = {
  cartImportExport: {
    import: {
      cartNameGeneration: {
        source: CartNameSource.FILE_NAME,
      },
    },
  },
};
```

However, this config allows to change a name source. It indicates from which source the new saved cart name should be taken.

```ts
export enum CartNameSource {
  FILE_NAME = "fileName",
  DATE_TIME = "dateTime",
}
```

If `source` has been set as `DATE_TIME`, it means that by default new saved cart name will be set as current date according to `fromDateOptions` property.

```ts
export interface CartNameGeneration {
  fromDateOptions?: {
    prefix?: string;
    suffix?: string;
    mask?: string;
  };
}
```

- `prefix` - adds text before the import date.
- `suffix` - adds text after the import date.
- `mask` - pattern, transforms current date according to specified format.

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

The following is a description of the settings:

- `additionalColumns` is an optional array that allows you to define additional columns to include in the exported file. By default, the exported file contains additional `name` and `price` columns. For more information, see [Additional Columns](#additional-columns).

- `messageEnabled` is a flag that determines if customers see a global message informing them about the start of the download process.

- `downloadDelay` is a property that is dedicated to delaying the start of the download process. The main purpose of this property is avoid spamming customers by displaying the global message and the download pop-up at the same time.

- `fileOptions` is metadata for the exported file. For more information about the available options, see the `export-file-options.ts` file in the Spartacus source code.

- `maxEntries` determines the maximum number of entries that can be included in the exported CSV file.

#### Additional columns

By default, the exported CSV file contains product code and quantity columns. You can add `ExportColumn` elements to the `additionalColumns` to define which additional columns you want to include in the exported CSV file.

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

### Products support

Import and export feature works for general products, but not supporting [CPQ Configurable Products Integration]({{ site.baseurl }}{% link _pages/install/integrations/cpq-configurable-products-integration.md %}).

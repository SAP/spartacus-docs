---
title: Import to Cart
feature:
  - name: Import to Cart
    spa_version: 4.2
    cx_version: 2005
---

{% capture version_note %}
{{ site.version_note_part1 }} 4.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

This feature allows a customer to create saved cart or update active cart, by importing CSV file containing product codes and quantities.

---

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
  {:toc}

---

## Usage

### Saved Cart

To use this feature log in as customer in Spartacus storefront and go to `Saved Carts` page using user menu. There should be the 'Import products' button available above the saved carts list.

Then form in dialog should be filled: firstly, by selecting valid CSV file with products (it can be the one previously exported using [Export from cart feature]({{ site.baseurl }}/features/export-from-cart).

Secondly, by providing cart name and description. For reference see [Saved Cart feature]({{ site.baseurl }}/features/saved-cart) documentation.

### Active Cart

Importing to active cart looks similar to [Saved Cart](#saved-cart) however is not needed to specify cart name and description.

To start import process go to the cart page and if it is empty use 'Import products' link from suggestions. On the other hand if some products were added already into the cart import button will be available below cart entries list.

## Enabling Import to cart

Import to cart feature can be enabled by installing the `@spartacus/cart` feature library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

Also the import of following impex script is required to make feature work properly:

```
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Online])[default=$contentCatalog:Online]

INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef
;;ImportProductsComponent;Import Products Link Component;ImportProductsComponent;ImportProductsComponent

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;BodyContent-saved-carts;Body content for Saved Carts History Slot;ImportProductsComponent,AccountSavedCartHistoryComponent
```

## Global Configuration

Cart import/export features use common configuration model described below:

```ts
export abstract class ImportExportConfig {
  cartImportExport?: {
    file: {
      separator: string;
    };
    export?: ExportConfig;
  };
}
```

- `separator` - determines which character is used to seperate values. The default separator is comma (",").

## CMS Configuration

There is possibility to specify validation for imported files like allowed type and size. This can be set on CMS configuration level. To achieve this `fileValidaty` config needs to be added into `CmsConfig`:

```ts
ConfigModule.withConfig(<CmsConfig>{
  cmsComponents: {
    ImportProductsComponent: {
      component: ImportEntriesComponent,
      data: {
        fileValidity: {
          maxSize: 1,
          allowedExtensions: [
            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
            'application/vnd.ms-excel',
            'text/csv',
            '.csv',
          ],
        },
      },
    },
  },
}),
```

- `maxSize` - determines how many megabytes is customer allowed to import. If a value is `undefined` the validator will do not check it.
- `allowedExtensions` - is an array of allowed file types/mimes. For the configuration this property is not set, the allowed type `*` will be used.

By default import process uses file name for already imported cart name. It can be changed in configuration as well, to do this `cartNameGeneration` should be defined:

```ts
provideConfig(<CmsConfig>{
  cmsComponents: {
    ImportProductsComponent: {
      component: ImportEntriesComponent,
      data: {
        ...
        cartNameGeneration: {
          source: NameSource.DATE_TIME,
          fromDateOptions: {
            mask: 'YYYY_MM_dd',
            prefix: 'Saved_',
            suffix: '_cart',
          },
        },
      },
    },
  },
}),
```

- `source` - is the enum and determines which value should be used as saved cart name by default. `NameSource` model looks like following:

```ts
export enum NameSource {
  FILE_NAME = "fileName",
  DATE_TIME = "dateTime",
}
```

If `NameSource` has been set to `DATE_TIME` it means that by default imported cart name will be set as current date according to `fromDateOptions` config:

- `mask` - transforms current date according to specified format.
- `prefix` - adds text before the import date.
- `suffix` - adds text after the import date.

Otherwise file name of imported file will be used.

## Limitations

Current import logic takes CSV file content and go line by line to detect product code and quantity. Customer is notified in import summary view about import status.

There are following kind of statuses so far:

**success** - product code and qunatity are valid, and product is not out of stock.

**warning** - product code is valid, but quantity is higher than amount available in stock. In this case system will import maximum available quantity for such product.

**error** - product code, quantity are invalid or product with following SKU does not exists in database.

### Import process

Even if UI was prepared to go thourgh the process smoothly, customer must be aware that products are imported one by one (not all at once), so it is potential risk that import process may be disturbed by no intentional browser tab closure or by losing the internet connection.

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

Cart import allows you to create a saved cart, or to update an active cart, by importing a CSV file that contains product codes and product quantities.

Cart export allows you to download a CSV file that contains a list of all the items in your cart. You can export this list from the Cart Details page or from the Saved Cart Details page. Cart export works together with cart import, which means you can export a CSV file, make changes to it, and then reimport it back into the storefront.

**Note:** The exported CSV file always contains the product code and quantity columns. You can include additional columns by defining them in the configuration. For more information, see [Adding Columns in the CSV File](#adding-columns-in-the-csv-file).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Enabling Cart Import and Export

You can enable cart import and export by installing the `@spartacus/cart` feature library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

Cart import and export is CMS-driven and consists of the following components:

- `ImportOrderEntriesComponent`, which allows the link for importing order entries to be rendered.
- `ExportOrderEntriesComponent`, which allows the link for exporting order entries to be rendered.
- `ImportExportOrderEntriesComponent`, which allows both import and export links to be rendered in a row.

If you are using the [{% assign linkedpage = site.pages | where: "name", "spartacussampledata-extension.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/spartacussampledata-extension.md %}), the cart import and export components are already enabled. However, if you decide not to use the `spartacussampledata` extension, you can enable the cart import and export components through ImpEx.

### Adding Cart Import and Export Components Through ImpEx

The following are some ImpEx examples that you can use to add cart import and export components to different pages. After adding a component, you must also define the route and context to enable the relevant functionality.  For more information, see [Defining the Route and Context for Custom Configurations](#defining-the-route-and-context-for-custom-configurations).

**Note:** The `$contentCV` variable that is used throughout the following ImpEx examples, and which stores information about the content catalog, is defined as follows:

```text
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]
```

You can add the `ImportOrderEntriesComponent` to the Saved Carts page with the following ImpEx:

```text
INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;BodyContent-saved-carts;Body content for Saved Carts History Slot;AccountSavedCartHistoryComponent,ImportOrderEntriesComponent
```

You can add the `ImportExportOrderEntriesComponent` to the Saved Cart Details page with the following ImpEx:

```text
INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;BodyContent-savedCartDetailsPage;Body content for Saved Carts Details Slot;SavedCartDetailsOverviewComponent,SavedCartDetailsItemsComponent,ImportExportOrderEntriesComponent,SavedCartDetailsActionComponent
```

You can add the `ImportExportOrderEntriesComponent` to the Cart page with the following ImpEx:

```text
INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;TopContent-cartPage;Top content for Cart Slot;AddToSavedCartsComponent,CartComponent,SaveForLaterComponent,ImportExportOrderEntriesComponent
```

You can add the `ExportOrderEntriesComponent` to the Review Order checkout page with the following ImpEx:

```text
INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;BodyContentSlot-checkoutReviewOrder;Checkout Review Order Slot;CheckoutProgressComponent,CheckoutProgressMobileTopComponent,CheckoutReviewOrderComponent,ExportOrderEntriesComponent,CheckoutProgressMobileBottomComponent
```

## Disabling Cart Import and Export

In Backoffice, you can disable the rendering of the cart import or cart export links by removing the relevant component from the **Content Slot** that contains the component. You can also remove a cart import or cart export component through ImpEx.

The following is an example of how to remove the cart import component from the Saved Cart History page using ImpEx. In this example, the ImpEx query overrides the Saved Cart History content slot and omits `ImportOrderEntriesComponent`, which has the effect of removing the component:

```text
UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;cmsComponents(uid, $contentCV)
;;BodyContent-saved-carts;Body content for Saved Carts History Slot;AccountSavedCartHistoryComponent
```

You can use the same query pattern to disable any cart import or cart export component using ImpEx.

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

In addition to the common configuration settings, you can configure settings that are related only to the import functionality or export functionality of the feature. For more information, see [Configuring Cart Import](#configuring-cart-import) and [Configuring Cart Export](#configuring-cart-export).

## Configuring Cart Import

You can configure settings that are related only to the import functionality, such as special file rules and attributes. The following is an example from `import-entries.config.ts`:

```ts
export interface ImportConfig {
  fileValidity?: FileValidity;
  cartNameGeneration?: CartNameGeneration;
}
```

You can change the validation of imported files by overwriting the settings of the `fileValidaty` property. The following is an example of the default settings for `fileValidaty`:

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

The following is a description of the settings of the `fileValidaty` property:

- `maxSize` determines the maximum size of the imported file in megabytes.
- `maxEntries` sets the limit for the number of imported entries that are allowed for each source that is specified with the `OrderEntriesSource` key.
- `allowedTypes` is a string array that identifies the file types and extensions that are allowed to be imported.

The `ImportConfig` also includes the `CartNameGeneration` property. By default, during import, the new saved cart name is taken from the imported file. This configuration is shown in the following example:

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

However, the `CartNameSource` configuration provides different options for choosing the source of the saved cart name, as shown in the following example:

```ts
export enum CartNameSource {
  FILE_NAME = "fileName",
  DATE_TIME = "dateTime",
}
```

If `source: CartNameSource` is set to `DATE_TIME`, each new saved cart name is generated using the current date. You can use the options of the `fromDateOptions` property to further configure how the cart name is generated, as follows:

```ts
export interface CartNameGeneration {
  fromDateOptions?: {
    prefix?: string;
    suffix?: string;
    mask?: string;
  };
}
```

The following is a description of the settings of the `fromDateOptions` property:

- `prefix` adds text before the import date.
- `suffix` adds text after the import date.
- `mask` is a pattern that transforms the current date according to a specified format.

## Configuring Cart Export

You can configure settings that are related only to the export functionality. The following is an example from `export-entries.model.ts`:

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

- `additionalColumns` is an optional array that allows you to define additional columns to include in the exported file. By default, the exported file contains additional `name` and `price` columns. For more information, see [Adding Columns in the CSV File](#adding-columns-in-the-csv-file).
- `messageEnabled` is a flag that determines if customers see a global message informing them about the start of the download process.
- `downloadDelay` is a property that is dedicated to delaying the start of the download process. The main purpose of this property is avoid spamming customers by displaying the global message and the download pop-up at the same time.
- `fileOptions` is metadata for the exported file. For more information about the available options, see the `export-file-options.ts` file in the Spartacus source code.
- `maxEntries` determines the maximum number of entries that can be included in the exported CSV file.

## Adding Columns in the CSV File

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

## Defining the Route and Context for Custom Configurations

As mentioned in [Enabling Cart Import and Export](#enabling-cart-import-and-export), this feature makes use of the `ImportOrderEntriesComponent`, the `ExportOrderEntriesComponent` and the `ImportExportOrderEntriesComponent`.

If you have one of these CMS components registered on a page, you can use the `cxContext` property to define your own routing configuration for the feature in the root module. You also need the page context that is provided by the routing, which you define with the `ORDER_ENTRIES_CONTEXT` key.

You can use the following values to define the context:

- `NewSavedCartOrderEntriesContext` is used for creating a new saved cart.
- `SavedCartOrderEntriesContext` is used for adding more products to an existing saved cart. It is based on the routing parameters of the `savedCartId`.
- `ActiveCartOrderEntriesContext` is used for importing and export products to and from the active cart. This context can be used on any page where the cart is active. For example, if you wanted to add an export link to the Review Order checkout page, you can simply provide the `ActiveCartOrderEntriesContext` context for the `checkoutReviewOrder` route.
- `QuickOrderOrderEntriesContext` is used to provide the context when using import or export functionality with [{% assign linkedpage = site.pages | where: "name", "quick-order.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/quick-order.md %}).
- `OrderConfirmationOrderEntriesContext` is used for exporting order entries from the order confirmation page.
- `OrderDetailsOrderEntriesContext` is used for exporting products from an existing order on the order details page. It is based on the routing parameters of the `orderCode`.

The following is an example of how Spartacus defines the route and context for the cart import functionality on the Saved Cart Details page:

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

### Implementing Context for a Custom Page

If you are setting up a custom page and want to include cart import or cart export functionality, you need to set the target destination for the import, or the source of the product entries for the export. You can do this by implementing one or both of the following interfaces in your context:

- `AddOrderEntriesContext` is a context interface that determines the destination of the imported products. The implementation must include the `addEntries` method and the `type` property.
- `GetOrderEntriesContext` is a context interface that determines the source of the product entries to be exported. The implementation must include the `getEntries` method.
  
By default, if only one of the interfaces is implemented, the other function link is not displayed. Also note, the *Export to CSV* link is hidden if the order entries list is empty.

## Using Cart Import and Export in the Storefront

The following sections describe how the cart import and export feature works in the storefront.

### Import Status

The import logic processes the content of the CSV file one line at a time. You can see the import status in the **Import Products** status window. The import status can be one of the following:

- `success` indicates the product code and quantity are valid, and that the product is not out of stock.
- `warning` indicates the product code is valid, but that the quantity in the CSV file is higher than the amount that is available in stock. In this case, Spartacus imports the maximum available quantity for this product.
- `error` indicates the product code and quantity are invalid, or that the product with the indicated SKU does not exist in the database.

**Note:** Products are imported one line at a time, so the process can be interrupted if your browser tab is closed before the import has completed, or if your internet connection is lost.

### Importing to a Saved Cart

The following steps require you to be logged in to the Spartacus storefront.

1. In the **My Account** menu, click **Saved Carts**.

   The **Saved Cart** page appears.

1. Below the **Saved Carts** list, click **Import Products**.

   The **Import Products** dialog appears.

1. Click **Select File** and choose the file to upload.

1. Provide a name for the cart in the **Saved Cart Name** field, and an optional description in the **Saved Cart Description** field, then click **Upload**.

   The **Import Products** status window appears and updates the status of the import process as each line from the CSV file is processed.

1. When the process is complete, close the **Import Products** status window.

   You can now see your newly added saved cart in the **Saved Carts** list.

For more information about saved carts, see [{% assign linkedpage = site.pages | where: "name", "saved-cart.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/saved-cart.md %}).

### Importing to an Active Cart

The **Import Products** link appears below the product entries in the cart page, or below the **Suggestions** when the cart is empty.

1. Open the cart page and click **Import Products**.

   The **Import Products** dialog appears.

1. Click **Select File**, choose the file to upload, then click **Upload**.

   The **Import Products** status window appears and updates the status of the import process as each line from the CSV file is processed.

1. When the process is complete, close the **Import Products** status window.

   You can now see the imported items in your cart.

### Importing and Exporting with Quick Order

The quick order feature supports cart import and export. By default, cart import is enabled. The process for importing products with quick order is the same as [importing products to an active cart](#importing-to-an-active-cart).

**Note:** The `quickOrderListLimit` attribute affects the number of items you can add to the **Quick Order** page. If there are more products in the CSV file than are permitted by the limit, any products that exceed the limit are not added. For more information, see [{% assign linkedpage = site.pages | where: "name", "quick-order.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/quick-order.md %}).

### Exporting from the Order Confirmation and Order Details Pages

The `OrderConfirmationOrderEntriesContext` context is provided to allow you to add export functionality to the Order Confirmation page.

The `OrderDetailsOrderEntriesContext` context is provided to allow you to add export functionality to the Order Details page.

For more information, see [Defining the Route and Context for Custom Configurations](#defining-the-route-and-context-for-custom-configurations).

## Limitations

Cart import and export works with most products, but is not supported by the [{% assign linkedpage = site.pages | where: "name", "configurable-products-integration.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/integrations/configurable-products-integration.md %}), nor the [{% assign linkedpage = site.pages | where: "name", "cpq-configurable-products-integration.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/integrations/cpq-configurable-products-integration.md %}).

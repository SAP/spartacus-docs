---
title: Spartacus Sample Data Extension
---

The `spartacussampledata` extension creates new WCMS base sites for Spartacus that share the same product catalog with the default `electronics`, `apparel`, and `powertools` sites, but with content catalogs that have been modified specifically for Spartacus requirements.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Downloading the Spartacussampledata Extension

You can download the Spartacus Sample Data extension from the [Spartacus Releases page](https://github.com/SAP/spartacus/releases).

The Spartacus Sample Data extension is versioned and released with the Spartacus `storefront` library. You can download the latest version by clicking on `spartacussampledata.zip` in the **Assets** section of the most recent release of the `storefront` library.

Of course, previous versions are also available. For example, to download the Spartacus Sample Data extension for the `3.0.0-RC.1` release, you can access the **Assets** section of the `@spartacus/storefront@3.0.0-rc.1` library [here](https://github.com/SAP/spartacus/releases/tag/storefront-3.0.0-rc.1).

For more information about installing the `spartacussampledata` extension, see [{% assign linkedpage = site.pages | where: "name", "installing-sap-commerce-cloud.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/backend/installing-sap-commerce-cloud.md %}).

## Overview

The following diagram demonstrates how the `Electronics-Spa` base site is created. The process is similar for all sample stores.

![spartacussampledata]({{ site.baseurl }}/assets/images/spartacussampledata.png)

**Note:** The ImpEx file paths in the following sections are to a `spartacussampledata` extension that has been installed with SAP Commerce Cloud.

The `spartacussampledata` extension does the following:

- Creates new base sites called `electronics-spa`, `apparel-spa`, and `powertools-spa`, if these sample stores are configured in your `extensions.xml`. See the `site.impex` file for each base site in the `resources/spartacussampledata/import/stores` folder for details.

- Creates a new `ContentCatalog` and its `catalogVersions` (Staged and Online). See the `catalog.impex` file for each base site in the `resources/spartacussampledata/import/contentCatalogs/` folder for details.

- Creates a `CatalogVersionSyncJob` that can sync `[samplestore]ContentCatalog:staged` to `[samplestore]-spaContentCatalog:staged`. See the `sync.impex` file for each base site in the `resources/spartacussampledata/import/contentCatalogs` folder for details.

The `spartacussampledata` extension includes the `SpaSampleAddOnSampleDataImportService`, which extends `DefaultAddonSampleDataImportService`. It overrides the default `importContentCatalog` function, so that during system initialization or system update, the `importContentCatalog` function does the following:

- creates a new catalog
- synchronizes `[samplestore]ContentCatalog:Staged` to `[samplestore]-spaContentCatalog:Staged`
- performs some cleaning
- imports the content catalog from impex
- synchronizes `spaContentCatalog:staged` to `:online`
- gives permission to the `cmsmanager` to do the synchronization
- imports email data

**Note:** To ensure these actions are performed during a system update, you must check the box next to the relevant storefront(s) you wish to update before pressing **Update** in the *hybris administration console*, as shown in the following example:

<img src="{{ site.baseurl }}/assets/images/system-update-button.png" alt="System Update Button" width="400" border="1px" />

## CMS Changes Specific to the Spartacus Project

As `[samplestore]ContentCatalog:Staged` is synchronized to `[samplestore]-spaContentCatalog:Staged`, the initial data is the same in both content catalogs. But, to make Spartacus work better, the `-spa` versions contain different CMS data. Changes are made on the `[samplestore]-spaContentCatalog`, which are described in the following sections.

### Removing Unused Pages, Content Slots and CMS Components

Spartacus does not contain all of the pages that are found in Accelerator. The unused pages, content slots, and CMS components are removed from the `[samplestore]-spaContentCatalog`. You can check the `cleaning.impex` file for each base site in the `resources/spartacussampledata/import/contentCatalogs/electronicsContentCatalog` folder to see what is removed.

### Replacing the JspIncludeComponent with the CMSFlexComponent

The `JspIncludeComponent` allows you to include JSP code when you provide the path of the JSP file that then gets inserted. It does not make sense to have this type of component in the Spartacus Angular-based application. Instead, a new type of component, called `CMSFlexComponent`, was added to SAP Commerce Cloud. This component allows you to get selectors, and also includes code from our libraries in the Content Slot.

**Note:** For backwards compatibility, Spartacus supports the `JspIncludeComponent`.

### Adding Data into the `CmsSiteContext` Enum

The `CmsSiteContext` enum is a dynamic enumeration that contains the available site context. Spartacus has two site contexts: language and currency. The following is an example from `resources/spartacussampledata/import/contentCatalogs/electronicsContentCatalog/catalog.impex`:

```sql
INSERT_UPDATE CmsSiteContext;code[unique=true];name[lang=$language]
;LANGUAGE;"language"
;CURRENCY;"currency"
```

### Replacing the Homepage Preview Image

The Spartacus homepage looks different from the legacy Accelerator storefront, so the preview image has been updated accordingly.

### Adding a SiteContext Slot with New Components to Each Template

A new `SiteContext` slot has been added to the header in every template in Spartacus, and two new components, the `LanguageComponent` and `CurrencyComponent`, have been added into this `SiteContext` slot. The following is an example from `resources/spartacussampledata/import/contentCatalogs/electronicsContentCatalog/cms-responsive-content.impex`:

```sql
INSERT_UPDATE CMSSiteContextComponent;$contentCV[unique=true];uid[unique=true];name;context(code);&componentRef
;;LanguageComponent;Site Languages;LANGUAGE;LanguageComponent
;;CurrencyComponent;Site Currencies;CURRENCY;CurrencyComponent

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(uid,$contentCV)
;;SiteContextSlot;Site Context Slot;true;LanguageComponent,CurrencyComponent
```

### Updating the MiniCartSlot

The `MiniCartSlot` in the `electronicsContentCatalog` contains two components: the `OrderComponent` and the `MiniCart`. In Spartacus, the `OrderComponent` is not used anymore, so it was removed from the `MiniCartSlot`. The following image shows the `MiniCart` component in the `MiniCartSlot`:

![Mini Cart Slot]({{ site.baseurl }}/assets/images/mini-cart-slot.png)

### Adding CMSlink Components to a New SiteLinks Slot

The Spartacus header now contains `HelpLink`, `ContactUsLink` and `SaleLink` CMSlink components, which have been added to a new `SiteLinks` slot. Because this slot has been added in the header, the new `SiteLinks` slot has been added to every template. The following image shows the newly added CMSlink components:

![Site Links Slots]({{ site.baseurl }}/assets/images/site-links-slot.png)

### Creating New CMS Pages

The following new CMS pages have been created with the `spartacussampledata` extension:

- `sale`
- `help`
- `contactUs`
- `forgotPassword`
- `resetPassword`
- `register`

The `spartacussampledata` extension also creates the necessary content slots and CMS components that are contained in these new pages.

### Adding More Content to the "Not Found" Page

Along with a banner image, the "Not Found" page now also includes links and text, as shown in the following image:

!["Not Found" Page]({{ site.baseurl }}/assets/images/page-not-found.png)

### Adding a SignOutLink in My Account

In the default content catalogs, the `MyAccountNavNode` does not have a child node for `SignOut`. To fix this in Spartacus, the `spartacussampledata` extension adds a `SignOutNavNode` as a child of the `MyAccountNavNode`, and adds a `SignOutLink` to the `SignOutNavNode`.

### Updating the Breadcrumb in Spartacus

In the default content catalogs, the `breadcrumbComponent` is located in the `NavigationBarSlot`. The `spartacussampledata` extension moves this component from the `NavigationBarSlot` to the `BottomHeaderSlot`, and the `BottomHeaderSlot` is also added to every template. However, to avoid having a breadcrumb for the `homepage` and `SLRCamerasCategoryPage`, the `BottomHeaderSlot` is removed from the `homepage` and `SLRCamerasCategoryPage` templates.

### Updating Page Labels to Start with a Forward Slash

In Spartacus, page labels are used as the configurable URL for content pages, so these page labels need to start with a `/` forward slash. The following is an example of the update that the `spartacussampledata` extension makes to every content page:

```sql
UPDATE ContentPage;$contentCV[unique=true];uid[unique=true];label
;;login;/login
```

### Adjusting the Searchbox Component Configuration

The `spartacussampledata` extension adjusts the searchbox component configuration as follows:

```sql
INSERT_UPDATE SearchBoxComponent;uid;minCharactersBeforeRequest;maxProducts;maxSuggestions;waitTimeBeforeRequest;$contentCV[unique=true]
;SearchBox;0;5;5;0
```

### Making CMS Changes Related to Checkout

The `spartacussampledata` extension makes a number of CMS changes that are related to checkout. For more information, see [{% assign linkedpage = site.pages | where: "name", "extending-checkout.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/extending-checkout.md %}).

### Making the Product Details Page CMS-Driven

The `spartacussampledata` extension makes the `ProductDetails` template CMS-driven by adding another `ProductSummarySlot` slot, which contains the following CMS components:

- `ProductIntroComponent`
- `ProductImagesComponent`
- `ProductSummaryComponent`
- `VariantSelector`
- `AddToCart`

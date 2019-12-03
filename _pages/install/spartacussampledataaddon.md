---
title: Spartacussampledataaddon AddOn
---

The `spartacussampledataaddon` AddOn creates new WCMS base sites for Spartacus that share the same product catalog with the default `electronics`, `apparel`, and `powertools` sites, but with content catalogs that have been modified specifically for Spartacus requirements.

The following diagram demonstrates how the `Electronics-Spa` base site is created. The process is similar for all sample stores.

![spartacussampledataaddon]({{ site.baseurl }}/assets/images/spartacussampledataaddon.png)

To download and install the `spartacussampledataaddon` AddOn, see [Installing SAP Commerce Cloud for use with Spartacus
]({{ site.baseurl }}/installing-sap-commerce-cloud/#installing-the-spartacus-sample-data-addon). The impex file paths in this document are to the `spartacussampledataaddon` AddOn that has been installed with SAP Commerce Cloud.

The `spartacussampledataaddon` AddOn does the following:

- Creates new base sites called `electronics-spa`, `apparel-spa`, and `powertools-spa`, if these sample stores are configured in your `extensions.xml`. See the `site.impex` file for each base site in the `resources/spartacussampledataaddon/import/stores` folder for details.

- Creates a new `ContentCatalog` and its `catalogVersions` (Staged and Online). See the `catalog.impex` file for each base site in the `resources/spartacussampledataaddon/import/contentCatalogs/` folder for details.

- Creates a `CatalogVersionSyncJob` that can sync `[samplestore]ContentCatalog:staged` to `[samplestore]-spaContentCatalog:staged`. See the `sync.impex` file for each base site in the `resources/spartacussampledataaddon/import/contentCatalogs` folder for details.

The `spartacussampledataaddon` AddOn includes the `SpaSampleAddOnSampleDataImportService`, which extends `DefaultAddonSampleDataImportService`. It overrides the default `importContentCatalog` function, so that during system initialization or system update, the `importContentCatalog` function does the following:

- creates a new catalog
- synchronizes `[samplestore]ContentCatalog:Staged` to `[samplestore]-spaContentCatalog:Staged`
- performs some cleaning
- imports the content catalog from impex
- synchronizes `spaContentCatalog:staged` to `:online`
- gives permission to the `cmsmanager` to do the synchronization
- imports email data

## CMS Changes Specific to the Spartacus Project

As `[samplestore]ContentCatalog:Staged` is synchronized to `[samplestore]-spaContentCatalog:Staged`, the initial data is the same in both content catalogs. But, to make Spartacus work better, the `-spa` versions contain different CMS data. Changes are made on the `[samplestore]-spaContentCatalog`, which are described in the following sections.

### Removing Unused Pages, Content Slots and CMS Components

Spartacus does not contain all of the pages that are found in Accelerator. The unused pages, content slots, and CMS components are removed from the `[samplestore]-spaContentCatalog`. You can check the `cleaning.impex` file for each base site in the `resources/spartacussampledataaddon/import/contentCatalogs/electronicsContentCatalog` folder to see what is removed.

### Replacing the JspIncludeComponent with the CMSFlexComponent

The `JspIncludeComponent` allows you to include JSP code when you provide the path of the JSP file that then gets inserted. It does not make sense to have this type of component in the Spartacus Angular-based application. A new type of component, called `CMSFlexComponent`, was added to SAP Commerce 1905, which allows you to get selectors, and also includes code from our libraries in the Content Slot.

**Note:** For backwards compatibility, Spartacus supports the `JspIncludeComponent`.

### Adding Data into the `CmsSiteContext` Enum

The `CmsSiteContext` enum was created in SAP Commerce 1905. It is a dynamic enumeration that contains the available site context. Spartacus has two site contexts: language and currency. The following is an example from `resources/spartacussampledataaddon/import/contentCatalogs/electronicsContentCatalog/catalog.impex`:

```typescript
INSERT_UPDATE CmsSiteContext;code[unique=true];name[lang=$language]
;LANGUAGE;"language"
;CURRENCY;"currency"
```

### Replacing the Homepage Preview Image

The Spartacus homepage looks different from the legacy Accelerator storefront, so the preview image has been updated accordingly.

### Adding a SiteContext Slot with New Components to Each Template

A new `SiteContext` slot has been added to the header in each template in Spartacus, and two new components, the `LanguageComponent` and `CurrencyComponent`, have been added into this `SiteContext` slot. The following is an example from `resources/spartacussampledataaddon/import/contentCatalogs/electronicsContentCatalog/cms-responsive-content.impex`:

```typescript
INSERT_UPDATE CMSSiteContextComponent;$contentCV[unique=true];uid[unique=true];name;context(code);&componentRef
;;LanguageComponent;Site Languages;LANGUAGE;LanguageComponent
;;CurrencyComponent;Site Currencies;CURRENCY;CurrencyComponent

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(uid,$contentCV)
;;SiteContextSlot;Site Context Slot;true;LanguageComponent,CurrencyComponent
```

**Note:** The `CMSSiteContextComponent` is a new type of component that was created in SAP Commerce 1905.

### Updating the MiniCartSlot

The `MiniCartSlot` in the `electronicsContentCatalog` contains two components: the `OrderComponent` and the `MiniCart`.

![Mini Cart Slot]({{ site.baseurl }}/assets/images/mini-cart-slot.png)

In Spartacus, the `OrderComponent` is not used anymore, so it was removed from the `MiniCartSlot`.

**7. Add `SiteLinks` slot and CMSlink components into it**

In the Spartacus header, we added a new `SiteLinks` slot, which now contains `HelpLink`, `ContactUsLink` and `SaleLink`. Since this slot is added in the header, we need to add it into each template.

  ![Site Links Slots]({{ site.baseurl }}/assets/images/site-links-slot.png)

**8. Some new CMS pages are created**

Spartacus needs some new pages. The following CMS pages are created in this AddOn: `sale`, `help`, `contactUs`, `forgotPassword`, `resetPassword` and `register`. Content Slots and CMS components contained in these pages are also created.

**9. Make "Not Found" page contain more content**

  !["Not Found" Page]({{ site.baseurl }}/assets/images/page-not-found.png)

Now this page not only contains a banner image, it also has some links and text.

**10. Add `SignOutLink` in `My account`**

In the default content catalogs, `MyAccountNavNode` doesn't have the child for `SignOut`. We added `SignOutNavNode` as one child of `MyAccountNavNode`; and added `SignOutLink` into that child node.

**11. Spartacus breadcrumb**

In the default content catalogs, `breadcrumbComponent` is in `NavigationBarSlot`. In Spartacus, we moved this component from `NavigationBarSlot` to `BottomHeaderSlot`. The `BottomHeaderSlot` is a slot added in each template. In Spartacus, we don't want `homepage` and `SLRCamerasCategoryPage` to have a breadcrumb, so we clear the `BottomHeaderSlot` only for `homepage` and `SLRCamerasCategoryPage`.

**12. Update page labels to make them start with '/'**

In Spartacus, we use "page label" as the configurable URL for content pages. So, page labels should start with '/'. For example, we do the following update for each content page:

```typescript
UPDATE ContentPage;$contentCV[unique=true];uid[unique=true];label
;;login;/login
```

**13. Reconfigure searchbox component configuration**

```typescript
INSERT_UPDATE SearchBoxComponent;uid;minCharactersBeforeRequest;maxProducts;maxSuggestions;waitTimeBeforeRequest;$contentCV[unique=true]
;SearchBox;0;5;5;0
```

**14. CMS changes related to checkout**

Please read this document for the [extending checkout](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/extending-checkout/).


**15. To make "product details" page CMS driven, add more Content Slots and CMS components in it**

In the `ProductDetails` template, we added one more `ProductSummarySlot` slot, which contains the following CMS components:

- `ProductIntroComponent`
- `ProductImagesComponent`
- `ProductSummaryComponent`
- `VariantSelector`
- `AddToCart`

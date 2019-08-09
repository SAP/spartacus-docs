---
title: Spartacussampledataaddon AddOn (DRAFT)
---

The `spartacussampledataaddon` AddOn creates a new site that shares the same product catalog with the `electronics` site, but has a new content catalog, as shown in the following diagram:

![spartacussampledataaddon]({{ site.baseurl }}/assets/images/spartacussampledataaddon.png)

To download and install the `spartacussampledataaddon` AddOn, see [Installing SAP Commerce Cloud for use with Spartacus
]({{ site.baseurl }}/installing-sap-commerce-cloud/#installing-the-spartacus-sample-data-addon). The impex file paths in this document are to the `spartacussampledataaddon` AddOn that has been installed with SAP Commerce Cloud.

The `spartacussampledataaddon` AddOn does the following:

- Creates a new `site` called `electronics-spa`. See the `resource/spartacussampledataaddon/import/stores/site.impex` file for details.

- Creates a new `ContentCatalog` and its `catalogVersions` (Staged and Online). See the `resource/spartacussampledataaddon/import/contentCatalogs/electronicsContentCatalog/catalog.impex` file for details.

- Creates a `CatalogVersionSyncJob` that can sync `electronicContentCatalog:staged` to `spaContentCatalog:staged`. See the `resource/spartacussampledataaddon/import/contentCatalogs/electronicsContentCatalog/sync.impex` file for details.

The `spartacussampledataaddon` AddOn includes the `SpaSampleAddOnSampleDataImportService`, which extends `DefaultAddonSampleDataImportService`. It overrides the default `importContentCatalog` function, so during system initialization/update, the `importContentCatalog` function does the following:

- creates new catalog
- synchronizes `electronicsContentCatalog:Staged` to `electronics-spaContentCatalog:Staged`
- performs some cleaning
- imports the content catalog from impex
- synchronizes `spaContentCatalog:staged` to `online`
- gives permission to the cmsmanager to do the synchronization
- imports email data

## CMS changes specific to the Spartacus project

Since we sychronize `electronicsContentCatalog:Staged` to `electronics-spaContentCatalog:Staged`, so the initial data in `electronics-spaContentCatalog` the same as `electronicsContentCatalog`. But, to make Spartacus work better, it has some different CMS data. Changes are made on the `electronics-spaContentCatalog`, which include:

**1. Remove unused Pages, Content Slots and CMS Components**

Unlike our legacy storefront, Spartacus doesn't have some pages, e.g. quickOrderPage. The page and contained Content Slots and CMS Components are removed from the `electronics-spaContentCatalog`. You can check this file `resource/spartacussampledataaddon/import/contentCatalogs/electronicsContentCatalog/cleaning.impex` for the CMS data cleaning.

**2. Replace `JspIncludeComponent` with `CMSFlexComponent`**

`JspIncludeComponent` allows inclusion of JSP code given the path of JSP file which then gets inserted. It does not make sense to have this type of components in our Angular based application. So, we create a new type of component called `CMSFlexComponent` (in SAP Commerce 1905). It allows you to get selector and include code from our libraries into the Content Slot.
**Note:** For backwards compatibility, Spartacus supports both types of CMS components.

**3. Add data into enum `CmsSiteContext`**

Enum `CmsSiteContext` was created in SAP Commerce 1905. It is a dynamic enumeration that contains available site context. For Spartacus, we have 2 site contexts: language and currency.

```typescript
INSERT_UPDATE CmsSiteContext;code[unique=true];name[lang=$language]
;LANGUAGE;"language"
;CURRENCY;"currency"
```

**4. Replace the homepage preview image**

The Spartacus homepage looks different from our legacy storefront. So, it should have a different preview image.

**5. Add `SiteContext` slot to each template, and add `LanguageComponent` and `CurrencyComponent` into this slot**

In Spartacus header, we add a new slot `SiteContext`, which contains 2 new components.

```typescript
INSERT_UPDATE CMSSiteContextComponent;$contentCV[unique=true];uid[unique=true];name;context(code);&componentRef
;;LanguageComponent;Site Languages;LANGUAGE;LanguageComponent
;;CurrencyComponent;Site Currencies;CURRENCY;CurrencyComponent

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(uid,$contentCV)
;;SiteContextSlot;Site Context Slot;true;LanguageComponent,CurrencyComponent
```

`CMSSiteContextComponent` is a new type of components created in in SAP Commerce 1905.

**6. Update `MiniCartSlot`**

`MiniCartSlot` in `electronicsContentCatalog` contains 2 components: `OrderComponent` and `MiniCart`. 
  ![Screen Shot 2019-07-09 at 4 08 24 PM](https://user-images.githubusercontent.com/44440575/60919474-d1fd2100-a263-11e9-8f7a-885df84e2b98.png)

In Spartacus, `OrderComponent` is not used any more, so we remove it from `MiniCartSlot`.

**7. Add `SiteLinks` slot and CMSlink components into it**

In Spartacus header, we add a new Slot `SiteLinks`, which now contains `HelpLink`, `ContactUsLink` and `SaleLink`. Since this slot is added in header, we need add it into each template.

  ![Screen Shot 2019-07-09 at 4 10 56 PM](https://user-images.githubusercontent.com/44440575/60919595-2b655000-a264-11e9-9667-8699220390ae.png)

**8. Some new CMS pages are created**

Spartacus needs some new pages. So, these CMS page are created in this addon: `sale`, `help`, `contactUs`, `forgotPassword`, `resetPassword` and `register`. Content Slots and CMS components contained in these pages are also created.

**9. Make "Not Found" page contain more content**

  ![Screen Shot 2019-07-09 at 4 25 08 PM](https://user-images.githubusercontent.com/44440575/60920445-35884e00-a266-11e9-8ba5-c1f2042d695c.png)

Now, this page not only contains a banner image, it also has some links and text.

**10. Add `SignOutLink` in `My account`**

In `electronicContentCatalog`, `MyAccountNavNode` doesn't have the child for `SignOut`. We add `SignOutNavNode` as one child of `MyAccountNavNode`; and add `SignOutLink` into that child node.

**11. Spartacus breadcrumb**

In `electronicContentCatalog`, `breadcrumbComponent` is in `NavigationBarSlot`. In Spartacus, we move this component from `NavigationBarSlot` to `BottomHeaderSlot`. `BottomHeaderSlot` is a slot added in each template. In Spartacus, we don't want `homepage` and `SLRCamerasCategoryPage` have breadcrumb, so we clear the `BottomHeaderSlot` only for `homepage` and `SLRCamerasCategoryPage`.

**12. Update page labels to make them start with '/'**

In Spartacus, we use "page label" as the configurable URL for content pages. So, page labels should start with '/'. For example, we do the following update for each content page:

```typescript
UPDATE ContentPage;$contentCV[unique=true];uid[unique=true];label
;;login;/login
```

**13. Reconfig searchbox component config**

```typescript
INSERT_UPDATE SearchBoxComponent;uid;minCharactersBeforeRequest;maxProducts;maxSuggestions;waitTimeBeforeRequest;$contentCV[unique=true]
;SearchBox;0;5;5;0
```

**14. CMS changes related to checkout**

Please read this doc for the [extending checkout](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/extending-checkout/).


**15. To make "product details" page CMS driven, add more Content Slots and CMS components in it**

In `ProductDetails` template, we add one more slot `ProductSummarySlot`, which contains CMS components `ProductIntroComponent`, `ProductImagesComponent`, `ProductSummaryComponent`, `VariantSelector`, `AddToCart`.

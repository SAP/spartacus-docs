---
title: What changes spartacussample does
---

Spartacussampledataaddon is ... 
A new site is created in this addon. This new site shares the same product catalog with site `electronics`, but has new content catalog.

![Screen Shot 2019-07-09 at 2 47 17 PM](https://user-images.githubusercontent.com/44440575/60915025-cce6a480-a258-11e9-800d-7e98e2275d48.png)

## It contains the following

- It creates a new `site` called **`electronics-spa`**

Check this impex file `resource/spartacussampledataaddon/import/stores/site.impex` for details.

- It creates a new `ContentCatalog` and its `catalogVersions` (Staged and Online)

Check this impex file `resource/spartacussampledataaddon/import/contentCatalogs/electronicsContentCatalog/catalog.impex` for details.

- It creates `CatalogVersionSyncJob` which can sync `electronicContentCatalog:staged` to `spaContentCatalog:staged`

Check this impex file `resource/spartacussampledataaddon/import/contentCatalogs/electronicsContentCatalog/sync.impex` for details.

This addon has `SpaSampleAddOnSampleDataImportService`, which extends `DefaultAddonSampleDataImportService`. It overrides the default funciton `importContentCatalog`. So, during system initialization/update, function `importContentCatalog` will do the following things:

1. create new catalog
2. sync electronicsContentCatalog:Staged->electronics-spaContentCatalog:Staged
3. perform some cleaning
4. import content catalog from impex
5. synchronize spaContentCatalog:staged->online
6. give permission to cmsmanager to do the sync
7. import email data

## CMS changes specific for Spartacus project

Since we sychronize `electronicsContentCatalog:Staged` to `electronics-spaContentCatalog:Staged`, so the initial data in `electronics-spaContentCatalog` the same as `electronicsContentCatalog`. But, to make Spartacus work better, it has some different CMS data. Changes are made on the `electronics-spaContentCatalog`, which include:

1. Remove unused Pages, Content Slots and CMS Components
Unlike our legacy storefront, Spartacus doesn't have some pages, e.g. quickOrderPage. The page and contained Content Slots and CMS Components are removed from the `electronics-spaContentCatalog`. You can check this file `resource/spartacussampledataaddon/import/contentCatalogs/electronicsContentCatalog/cleaning.impex` for the CMS data cleaning.

2. Replace `JspIncludeComponent` with `CMSFlexComponent`
`JspIncludeComponent` allows inclusion of JSP code given the path of JSP file which then gets inserted. It does not make sense to have this type of components in our Angular based application. So, we create a new type of component called `CMSFlexComponent` (in SAP Commerce 1905). It allows you to get selector and include code from our libraries into the Content Slot.
**Note:** For backwards compatibility, Spartacus supports both types of CMS components.

3. Add data into enum `CmsSiteContext`
Enum `CmsSiteContext` was created in SAP Commerce 1905. It is a dynamic enumeration that contains available site context. For Spartacus, we have 2 site contexts: language and currency.

```typescript
INSERT_UPDATE CmsSiteContext;code[unique=true];name[lang=$language]
;LANGUAGE;"language"
;CURRENCY;"currency"
```

4. Replace the homepage preview image
The Spartacus homepage looks different from our legacy storefront. So, it should have a different preview image.

5. Add `SiteContext` slot to each template, and add `LanguageComponent` and `CurrencyComponent` into this slot
In Spartacus header, we add a new slot `SiteContext`, which contains 2 new components.

```typescript
INSERT_UPDATE CMSSiteContextComponent;$contentCV[unique=true];uid[unique=true];name;context(code);&componentRef
;;LanguageComponent;Site Languages;LANGUAGE;LanguageComponent
;;CurrencyComponent;Site Currencies;CURRENCY;CurrencyComponent

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];name;active;cmsComponents(uid,$contentCV)
;;SiteContextSlot;Site Context Slot;true;LanguageComponent,CurrencyComponent
```

`CMSSiteContextComponent` is a new type of components created in in SAP Commerce 1905.

6. Update `MiniCartSlot`

`MiniCartSlot` in `electronicsContentCatalog` contains 2 components: `OrderComponent` and `MiniCart`. 
![Screen Shot 2019-07-09 at 4 08 24 PM](https://user-images.githubusercontent.com/44440575/60919474-d1fd2100-a263-11e9-8f7a-885df84e2b98.png)

In Spartacus, `OrderComponent` is not used any more, so we remove it from `MiniCartSlot`.

7. Add `SiteLinks` slot and CMSlink components into it
In Spartacus header, we add a new Slot `SiteLinks`, which now contains `HelpLink`, `ContactUsLink` and `SaleLink`. Since this slot is added in header, we need add it into each template.

![Screen Shot 2019-07-09 at 4 10 56 PM](https://user-images.githubusercontent.com/44440575/60919595-2b655000-a264-11e9-9667-8699220390ae.png)

8. Some new CMS pages are created
Spartacus needs some new pages. So, these CMS page are created in this addon: `sale`, `help`, `contactUs`, `forgotPassword`, `resetPassword` and `register`. Content Slots and CMS components contained in these pages are also created.

9. Make "Not Found" page contain more content
![Screen Shot 2019-07-09 at 4 25 08 PM](https://user-images.githubusercontent.com/44440575/60920445-35884e00-a266-11e9-8ba5-c1f2042d695c.png)

Now, this page not only contains a banner image, it also has some links and text.

10.  
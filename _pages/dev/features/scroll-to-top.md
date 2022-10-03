---
title: Scroll to Top
feature:
- name: Scroll to Top
  spa_version: 5.0
  cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 5.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The scroll to top feature provides a button that lets users quickly return to the top of the page they are viewing. Using CMS content slots, you can add the button to any page of your Spartacus storefront.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Enabling Scroll to Top

Scroll to top is CMS-driven and consists of one CMS component, called the `ScrollToTopComponent`.

To enable the scroll to top feature in your storefront, add the `ScrollToTopComponent` to a content slot on each page where you wish to make the scroll to top button available. To add the scroll to top button to every page in your storefront, you can add the `ScrollToTopComponent` to a shared content slot, such as the footer.

If you are using version 5.0 or newer of the `spartacussampledata` extension, the `ScrollToTopComponent` is already enabled. If you wish to enable the scroll to top feature and you are not using the `spartacussampledata` extension, you can create the scroll to top CMS component using ImpEx, as described in the following section.

For more information about the `spartacussampledata` extension, see [{% assign linkedpage = site.pages | where: "name", "spartacussampledata-extension.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/spartacussampledata-extension.md %}).

### Adding the Scroll to Top CMS Component Manually

You can add the `ScrollToTopComponent` CMS component to Spartacus using ImpEx.

**Note:** The `$contentCV` variable that is used in the following ImpEx examples, and which stores information about the content catalog, is defined as follows:

```text
$contentCatalog=powertools-spaContentCatalog
$contentCV=catalogVersion(CatalogVersion.catalog(Catalog.id[default=$contentCatalog]),CatalogVersion.version[default=Staged])[default=$contentCatalog:Staged]
```

1. Create the `ScrollToTopComponent` CMS component with the following ImpEx:

   ```text
   INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType;&componentRef
   ;;ScrollToTopComponent;Scroll To Top Component;ScrollToTopComponent;ScrollToTopComponent
   ```

1. Add the `ScrollToTopComponent` to a content slot on each page where you wish to make the scroll to top button available.

   For example, if you want to add the scroll to top button to every page of your storefront, you can use ImpEx to add the `ScrollToTopComponent` to the footer slot, as shown in the following:

   ```text
   INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid, $contentCV)
   ;;FooterSlot;FooterNavigationComponent,AnonymousConsentOpenDialogComponent,NoticeTextParagraph,AnonymousConsentManagementBannerComponent,ProfileTagComponent,ScrollToTopComponent 
   ```

## Configuring Scroll to Top

You can configure the scroll to top feature using the `scrollBehavior` and `displayThreshold` properties of the `CmsScrollToTopComponent` interface.

### Configuring the Scroll Behavior

You can adjust the experience of the scroll to top feature by setting the scroll behavior to `smooth` or `auto`. When the scroll behavior is set to `smooth`, the page scrolls quickly upward through the contents of the page until it reaches the top. When the scroll behavior is set to `auto`, the page jumps instantly from the current position to the top of the page.

By default, the scrolling behavior is set to `smooth`, but you can change this value to `auto`, as shown in the following example:

```ts
provideConfig(<CmsConfig>{
  cmsComponents: {
    ScrollToTopComponent: {
      data: {
        scrollBehavior: ScrollBehavior.AUTO,
      }
    },
  },
}),
```

In the above example, `ScrollBehavior.AUTO` is part of the `ScrollBehavior` enum that is defined in `cms.model.ts` in the `@spartacus/core` library.

### Configuring the Display Threshold

For pages that have scroll to top enabled, the display threshold property determines how far down the page a user must scroll before the scroll to top button appears. By default, the display threshold is set to half the height of the page, but you can change this display threshold to an absolute number of pixels. For example, if you set the value to 1000, the scroll to top button appears only when the user has scrolled down 1000 pixels from the top of the page.

The following is an example of how to set the `displayThreshold` property to an absolute value of pixels:

```ts
provideConfig(<CmsConfig>{
  cmsComponents: {
    ScrollToTopComponent: {
      data: {
        displayThreshold: 1000,
      }
    },
  },
}),
```

In this example, the scroll to top button appears when the page's `window.scrollY` value reaches `1000`.

**Note:** You can provide values for both the `scrollBehavior` and `displayThreshold` properties in a single configuration. The following is an example:

```ts
provideConfig(<CmsConfig>{
  cmsComponents: {
    ScrollToTopComponent: {
      data: {
        scrollBehavior: ScrollBehavior.AUTO,
        displayThreshold: 1000,
      }
    },
  },
}),
```

## Extending Scroll to Top

The Scroll-to-Top feature in Spartacus is customizable, meaning you can substitute another action for "Scroll to Top". One such common example is replacing "Scroll to Top"-button with displaying a floating Cart icon, as demonstrated below. As a result you can access the Cart by a single click from everywhere.

![floating-cart-button.png]({{ site.baseurl }}/images/floating-cart-button.png)

1. Creating a new component

To substitute the existing component create a new directory inside your angular app: `src/components/scroll-to-top`. You start by copying the existing component source files from the Spartacus-Repository  [spartacus/projects/storefrontlib/cms-components/navigation/scroll-to-top/](https://github.com/SAP/spartacus/tree/develop/projects/storefrontlib/cms-components/navigation/scroll-to-top). This will be the base of the new component. Create a `src/components` and run the clone command:

```bash
git clone \
  --depth 1  \
  --filter=blob:none  \
  https://github.com/SAP/spartacus && \
cp -R spartacus/projects/storefrontlib/cms-components/navigation/scroll-to-top ./ && \
rm -rf spartacus
```

Remove all lines that import relative from paths inside **scroll-to-top.component.ts** and **scroll-to-top.module.ts**. Then add imports from `@spartacus/storefront`:

*scroll-to-top.component.ts*
```javascript
import { CmsComponentData, ICON_TYPE, SelectFocusUtility } from   '@spartacus/storefront';
```

*scroll-to-top.module.ts*
```javascript
import { IconModule } from   '@spartacus/storefront';
```


2. Add Styling

To add the default styling to the new component, you need add a import to the app stylsheet file at `src/app/app.component.scss`:

```scss
@import '@spartacus/styles';
```

Create a new stylesheet in the component folder: `scroll-to-top.component.scss` and add custom styling to it:

*scroll-to-top.component.scss*
```scss
:host {
    width: 82px;

    button > span {
        display: flex;
        justify-content: space-evenly;
        font-size: 20px;
        font-weight: bold;
    }
}
```

Add the stylesheet to the component:

*scroll-to-top.component.ts*
```javascript
@Component({
  [...],
  styleUrls: ["./scroll-to-top.component.scss"]
})
```

3. Add Module Dependencies

For the buttons new behaviour import `RouterModule` and `UrlModule` in `scroll-to-top.module.ts`:

*scroll-to-top.module.ts*
```javascript
import { RouterModule } from '@angular/router';
import { ..., UrlModule } from   '@spartacus/core';
```

Add the new imported modules (`RouterModule`, `UrlModule`) to the modules imports array:

*scroll-to-top.module.ts*
 ```javascript
@NgModule({
  imports: [..., RouterModule, UrlModule],
  [...]
})
```

Next we need to import `Observable` and `MiniCartComponentService` in `scroll-to-top.component.ts`:

*scroll-to-top.component.ts*
```javascript
import { Observable } from 'rxjs';
import { MiniCartComponentService } from '@spartacus/cart/base/components/mini-cart';
```

Add the imported services to the contructor:

*scroll-to-top.component.ts*
```javascript
export class ScrollToTopComponent implements OnInit {
  [...]
  constructor(
    [...],
    protected miniCartComponentService: MiniCartComponentService
  ) {}
  [...]
}
```

Add a computed variable to the component:

*scroll-to-top.component.ts*
```javascript
[...]
export class ScrollToTopComponent implements OnInit {
  [...]
  quantity$: Observable<number> = this.miniCartComponentService.getQuantity();
  [...]
}
[...]
```

4. Change the template

Replace the iconType `iconTypes.CARET_UP` with `iconTypes.CART`, the current action `(click)="scrollToTop()"` with the anticipated action `[routerLink]="{ cxRoute: 'cart' } | cxUrl"` and add the counter markup after the icon:

*scroll-to-top.component.html*
```html
<button
  [attr.aria-label]="'navigation.scrollToTop' | cxTranslate"
  class="cx-scroll-to-top-btn"
  [routerLink]="{ cxRoute: 'cart' } | cxUrl"
>
  <span aria-hidden="true">
    <cx-icon class="caret-up-icon" [type]="iconTypes.CART"></cx-icon>
    <span>
      {{ 'miniCart.count' | cxTranslate: { count: quantity$ | async } }}
    </span>
  </span>
</button>
```

5. Replace the existing component

First remove the original module from the **import** at the top of `src/app/spartacus/spartacus-features.module.ts`:

```javascript
import { [...], ScrollToTopModule, [...] } from   "@spartacus/storefront";
```

Then you need to add a new **import** at the top of the file, that imports the new component:

```javascript
import { ScrollToTopModule } from   '../../components/scroll-to-top/scroll-to-top.module';
```

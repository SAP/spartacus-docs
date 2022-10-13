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

You can customize the scroll to top feature by modifying the action it performs. For example, you can replace the scroll to top button with a floating Cart icon that allows customers to access the cart from anywhere that the scroll to top button would have appeared. This customization is described in the following procedure.

1. Create a new component.
   1. To replace the existing component, create a new `src/components/scroll-to-top` directory inside your Spartacus app.
   1. Copy the existing component source files from `spartacus/projects/storefrontlib/cms-components/navigation/scroll-to-top` to the `src/components/scroll-to-top` directory.
   1. In the `scroll-to-top.component.ts` and `scroll-to-top.module.ts` files, remove all lines that import relative paths.
   1. In `scroll-to-top.component.ts`, add the following import:

      ```ts
      import { CmsComponentData, ICON_TYPE, SelectFocusUtility } from   '@spartacus/storefront';
      ```

   1. In `scroll-to-top.module.ts`, add the following import:

      ```ts
      import { IconModule } from   '@spartacus/storefront';
      ```

1. Add Styling.
   1. To add the default styling to the new component, add the following import to `src/app/app.component.scss`:

      ```scss
      @import '@spartacus/styles';
      ```

   1. In the component folder, create a new `scroll-to-top.component.scss` stylesheet, and add custom styling to it.

      The following is an example:

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

   1. Add the stylesheet to `scroll-to-top.component.ts`, as shown in the following example:

      ```ts
      @Component({
        [...],
        styleUrls: ["./scroll-to-top.component.scss"]
      })
      ```

1. Add the module dependencies.
   1. For the button's new behavior, import `RouterModule` and `UrlModule` in `scroll-to-top.module.ts`, as follows:

      ```ts
      import { RouterModule } from '@angular/router';
      import { ..., UrlModule } from   '@spartacus/core';
      ```

   1. Add the newly imported `RouterModule` and `UrlModule` to the module imports array in `scroll-to-top.module.ts`, as follows:

      ```ts
      @NgModule({
        imports: [..., RouterModule, UrlModule],
        [...]
      })
      ```

   1. Import `Observable` and `MiniCartComponentService` in `scroll-to-top.component.ts`, as follows:

      ```ts
      import { Observable } from 'rxjs';
      import { MiniCartComponentService } from '@spartacus/cart/base/components/mini-cart';
      ```

   1. Add the imported services to the constructor in `scroll-to-top.component.ts`, as follows:

      ```ts
      export class ScrollToTopComponent implements OnInit {
        [...]
        constructor(
          [...],
          protected miniCartComponentService: MiniCartComponentService
        ) {}
        [...]
      }
      ```

   1. Add a computed variable to `scroll-to-top.component.ts`, as follows:

      ```ts
      [...]
      export class ScrollToTopComponent implements OnInit {
        [...]
        quantity$: Observable<number> = this.miniCartComponentService.getQuantity();
        [...]
      }
      [...]
      ```

1. Change the template in `scroll-to-top.component.html`.
   1. Replace the `iconTypes.CARET_UP` iconType with `iconTypes.CART`.
   1. Replace the `(click)="scrollToTop()"` action with the new `[routerLink]="{ cxRoute: 'cart' } | cxUrl"` action.
   1. Add the counter markup after the icon.

      The following example demonstrates these changes to the template in `scroll-to-top.component.html`:

      {% raw %}

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

      {% endraw %}

1. Replace the existing component.
   1. Remove the following import statement from `src/app/spartacus/spartacus-features.module.ts`:

      ```ts
      import { [...], ScrollToTopModule, [...] } from   "@spartacus/storefront";
      ```

   1. In the same file, add the following import statement, which imports the new component:

      ```ts
      import { ScrollToTopModule } from   '../../components/scroll-to-top/scroll-to-top.module';
      ```

You now have a floating Cart icon that allows customers to access the cart from anywhere that the scroll to top button would have appeared.

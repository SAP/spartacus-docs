---
title: Creating New Pages and Components
---

Spartacus is a single-page application, but it still uses the concept of pages to distinguish the different views within the app. Spartacus pages come from the CMS, and are constructed with slots and components. A page contains slots, and slots contain components. To organize common slots and components, Spartacus supports page templates. A page template contains a layout, as well as components that can be used globally, such as header and footer sections.

Spartacus receives each page from the CMS with a list of slots and components, and this list is used to render the appropriate components.

**Note:** For information on replacing an existing component, see [Configuring Custom Components]({{ site.baseurl }}/customizing-cms-components/#configuring-custom-components).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Creating a New Page

To create a new page in Spartacus, first you need to create the relevant page in the CMS. For information on creating pages in the CMS, see [Creating Pages](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/ca0687d2796a44bb99ac59516ca87d20.html) on the SAP Help Portal.

After you have created a new page in the CMS, Spartacus adds it automatically without any configuration. The URL of the page in Spartacus is the same as the CMS label.

## Creating a New Component

To create a new component in Spartacus, first you need to create the relevant component in the CMS. For information on creating components in the CMS, see [Creating Components from Component Types](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/fe7f25cd80ec42e5a197b322dc7aafbc.html) on the SAP Help Portal.

After you have created a new component in the CMS, it needs to be mapped to a new Angular component.

The following example shows how to map a new wish list component. In this case, the wish list component has the following file structure:

```text
wishlist/
  wishlist.component.html
  wishlist.component.scss
  wishlist.component.ts
  wishlist.module.ts
```

You can then map the wish list component in `wishlist.module.ts`, as follows:

```ts
/*...*/
imports: [
  ConfigModule.withConfig({
    cmsComponents: {
      YOUR_NEW_COMPONENT_TYPE: {
        component: WishlistComponent // The class of your Angular component
      }
    }
  })
]
```

This logic injects the `WishlistComponent` wherever it is placed in the CMS. For more details on working with CMS components, see [{% assign linkedpage = site.pages | where: "name", "customizing-cms-components.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/components/customizing-cms-components.md %}).

## Static Pages

You can also create a custom page with custom components by creating a static page.

The following procedure describes how to create a static wish list page with a wish list component.

1. Create a static page and a static route.

   The following example creates a wish list page in `wishlist-page.module.ts`:

   ```ts
   import { RouterModule, Routes } from '@angular/router';
   import { CmsPageGuard } from '@spartacus/storefront';
   /*...*/

   const staticRoutes: Routes = [{
     path: 'wishlist',
     component: WishlistPageComponent // Custom page component,
     canActivate: [CmsPageGuard]
   }];

   /*...*/
   imports: [RouterModule.forChild(staticRoutes)];
   ```

2. Add the component to the page, just as you would for any regular Angular component.

    In the following example, the component is added in `wishlist-page.component.html`:

   ```html
   <!-- Selector of the component to use -->
   <wishlist-component></wishlist-component>
   ```

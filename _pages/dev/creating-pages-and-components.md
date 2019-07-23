---
title: Creating New Pages and Components (DRAFT)
---

The Spartacus storefront is based on Javascript, and accordingly, it is composed of a large number of fine-grained Javascript components. The components have an equivalent in the CMS and there is mapping to the Angular component.

This section will detail how to create a new Page or Component inside Spartacus. Despite Spartacus being a Single Page Application, Spartacus still follows the concept of page. The pages in Spartacus come from the CMS. These pages are constructed with slots and components. A page contains slots, and slots contain components. To organize common slots and components, Spartacus supports page templates. A page template contains layout and components that can be used globally, such as header and footer sections.

Spartacus receives the page with the list of slots and component and can use it to render the appropriate components.

*Note* if you want to replace an existing component please refer to [Configuring Custom Components](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/customizing-cms-components/#configuring-custom-components)

## Creating a New Page

To create a new page in Spartacus it is first necessary to create the appropriate page in the CMS. Please refer to the `Experience Management` section of the `SAP Help Portal` for a more details on how to do this.

Once the page exists in CMS Spartacus will pick it up automatically without any configuration. The url of the page in Spartacus will match the CMS label.

## Creating a New Component

In the case a new component has been created in the backend this new component needs to be mapped to a new Angular component.

Let's take the example of a new component called `wishlist` with the following file structure:

```
wishlist/
  wishlist.component.html
  wishlist.component.scss
  wishlist.component.ts
  wishlist.module.ts
```

In `wishlist.module.ts`:

```ts
/*...*/
imports: [
  ConfigModule.withConfig({
    cmsComponents: {
      YOUR_NEW_COMPONENT_TYPE: {
        component: WishlistComponent //The class of your Angular component
      }
    }
  })
]
```

The following logic will inject use the `WishlistComponent` wherever it is placed in the CMS. For more details on using CMS components see [Customizing CMS Components](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/customizing-cms-components).

## Static Pages

Another way to create a custom page with custom components is to create it statically.

The first step to using a component "statically" is to create a static page and a static route. The following example will create a `Wishlist Page` :

In `wishlist-page.module.ts`
```ts
import { RouterModule, Routes } from '@angular/router';
import { CmsPageGuard } from '@spartacus/storefront';
/*...*/

const staticRoutes: Routes = [{
  path: 'wishlist',
  component: WishlistPageComponent //Custom page component,
  canActivate: [CmsPageGuard]
}];

/*...*/
imports: [RouterModule.forChild(staticRoutes)];
```

Afterwards, you can add the component to the page in a standard Angular maner:

In `wishlist-page.component.html`
```html
  <!-- Selector of the component to use -->
  <wishlist-component></wishlist-component>
```


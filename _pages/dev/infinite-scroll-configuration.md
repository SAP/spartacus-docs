---
title: Infinite Scroll Configuration (DRAFT)
---

`Infinite Scroll` is a toggleable feature applied to the product list page that allows users to automatically retrieve products as they scroll down a page.

The `default configuration` for Infinite Scroll is to have it deactivated. As a result of this, pagination is used in all Spartacus installations unless these settings are overriden.

The default configuration can be overriden in the `app.module.ts` and will look as such:

```typescript
    view: {
      infiniteScroll: {
        active: true,
        productLimit: 500,
        showMoreButton: false,
      },
    },
    ...
```

The `view` container holds all configurations that affect the display of the Spartacus storefront.
The inner `infiniteScroll` is responsible for configuring Infinite Scroll and each property will be explained below.

### active

The `active` property will determine whether Infinite Scroll is used in the application.
Infinite Scroll is only active when this property's value is set to true.

**Note**: If it is empty or set to false, the application will ignore all the settings related to Infinite Scroll and will instead use pagination.

#### productLimit

`productLimit` provides a limit to the number of products a user is able to scroll through before they are prompted to continue the process of scrolling.

**Ex**: If the value for this property is set to 50, then a user will be able to scroll until they reach 50 products. At this point, they will be prompted to continue scrolling by pressing a button labeled "Show More'.

This is to prevent an excessive load on a user's browser that can be caused by displaying very large lists.

**Note**: If this value is empty or set to 0, then the productLimit is disabled.

#### showMoreButton

`showMoreButton` allows for users to experience the scroll effect with more control by having a "Show More" button appear at the end of the current list.

**Ex**: Assume when first navigating to the product list, 10 products are displayed. Once a user has scrolled to the bottom of this list, they will be prompted with a button labeled "Show More'. When this button is pressed, the next 10 products are added to the list. This process will be repeated until there are no more products to display.

**Note**: If this property is set to false, then true Infinite Scroll will be active and no buttons will be displayed. If it is set to true, then productLimit is ignored.

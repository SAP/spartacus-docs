---
title: Pagination
---

(version note: the pagination component is not new, but we've make it more mature and configurable in version 2.0).

The pagination component is a low level component which is used in various components, such in the Product List, Order History, Storefinder and various others. It is used to navigate through page results.

Customers will have different requirements for pagination experience, specifically regarding the precise navigation options being used. The pagination component is highly flexible by using configuration or custom styles.

For the Product List specifically the pagiation can be replaced by [Infinite Scrolling]({{ site.baseurl }}{% link _pages/dev/view_configuration/infinite-scroll.md %}).

## Pagination Structure

The pagination component exists of anchor links. The anchor links can use as actual links (`href`) or action links (`onclick` events). The actual anchor links being rendered depend on the number of total pages as well as the configuration applied. If the full structure is used, the following pagination navigation would be available:

`« ‹ 1 ... 5 (6) 7 ... 11 › »`

This contains the follow navigation links:

-   start (`«`)
-   previous (`‹`)
-   first (`1`)
-   gap (`...`)
-   page range with the current centered whenever possible
-   gap (`...`)
-   last
-   next (`›`)
-   end (`»`)

Spartacus only uses a page range of 3 and a start/end link.

## Pagination Configuration

The pagination component is highly configurable, to allow for maximum reusability of the component in various components.
You can specify partial configurations using the `PaginationConfig`, which contains a typed `pagination` property (using `PaginationOptions`).

Althought the pagiation component is feature rich, the default configuration used in Spartacus is based on a very clean. The configuration is set to have maximum 3 visible pages, surround by an optional `start` and `end` link. The results in the following pagination:

`« 1 2 3 »`

This full blown pagination component is driven by the following options:

-   `addStart`  
    A link to skip to the start of the pages, defaults to false.
-   `addPrevious`  
    A link to the previous page, defaults to false.
-   addFirst
-   `addDots`  
    A gap with dots to indicate hidden pages, defaults to false.
-   `rangeCount`  
    The range of direct accessible pages in the pagination, defaults to 3
-   `addNext`  
    A link to the previous page, defaults to false.
-   `addEnd`  
    A link to skip to the end of the pages, defaults to false.

In addition, the position of the navigation links can be specified, to separate them from the pages. While this can be achieved with pure CSS rules, we care about accessibiliy and lik to provide the actual requried DOM.

The labels used in the navigations are all configurable as well.

## Pagination Styling

The pagination component selector is `cx-pagination` and exists of anchor links.

### Selectors

Each navigation option in the pagination component is rendered as an anchor link with a specfic CSS selector (class):

-   `a.start`
-   `a.previous`
-   `a.first`
-   `a.gap`
-   `a.page`
-   `a.page.current`
-   `a.last`
-   `a.next`
-   `a.end`

### Hide specific navigation

The pagination component is highly configurable as shown in the previous section. Those configuration options are howver globally applied to all instances of the pagination component. If you need to hide navigation options for specific instances, you can apply CSS rules to hide navigation options.

The code snippet below shows a global configuration for the pagination with a first and last page and a gap with dots in between. The CSS snippet below however shows how these options are surpressed for the storefinder search results.

```typescript
ConfigModule.withConfig({
    pagination: {
        addFirst: true,
        addLast: true,
        addDots: true
    }
});
```

```scss
cx-store-finder-search-result {
    cx-pagination {
        a.gap,
        a.first,
        a.last {
            display: none;
        }
    }
}
```

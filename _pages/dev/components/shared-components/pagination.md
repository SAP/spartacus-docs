---
title: Pagination
---

**Note:** Improvements to this feature are introduced with version 2.0 of the Spartacus libraries.

The pagination component is a low-level component that is used to navigate through page results. It is used in various other components, such in the Product List, Order History, and Storefinder components, among others.

Customers have different pagination requirements, especially with regards to the precise navigation options that are used. The pagination component is highly flexible and can be customized either through configuration or by using custom styles.

For the Product List in particular, the pagination component can be replaced by the infinite scroll feature. For more information, see [Infinite Scrolling]({{ site.baseurl }}{% link _pages/dev/view_configuration/infinite-scroll.md %}).

## Pagination Structure

The pagination component is comprised of anchor links. The anchor links can be used as `href` links, or as action links (such as `onclick` events). The type of anchor links that are rendered depends on the number of total pages, as well as the configuration that is applied. If you apply the full structure, the following pagination navigation is available:

`« ‹ 1 ... 5 (6) 7 ... 11 › »`

The example above contains the follow navigation links:

- start: `«`
- previous: `‹`
- first: `1`
- gap: `...`
- page range, with the current page centered whenever possible: `5 (6) 7`
- gap: `...`
- last: `11`
- next: `›`
- end: `»`

Spartacus uses a navigation structure with start and end links, and a page range of three pages.

## Pagination Configuration

You can configure various options for the pagination component, which provides a lot of flexibility, and allows you to reuse it across the application.

Although the pagination component provides numerous configuration options, the default configuration in Spartacus only uses a limited feature set: the page range, surrounded by a start link and an end link. This appears as follows:

`« 1 2 3 »`

The pagination component offers the following options:

- `addStart` adds a link to skip to the start of the pages. The default is set to false.
- `addPrevious` adds a link to the previous page. The default is set to false.
- `addFirst` adds a link to the first page. The default is set to false.
- `addDots` adds a gap with dots to indicate hidden pages. The default is set to false.
- `rangeCount` sets the range of pages that are directly accessible in the pagination. The default is set to `3`.
- `addLast` adds a link to the last page. The default is set to false.
- `addNext` adds a link to the previous page. The default is set to false.
- `addEnd` adds a link to skip to the end of the pages. The default is set to false.

In addition, the position of the navigation links can be specified, which allows you to separate them from the pages. While this can be achieved with pure CSS rules, we care about accessibility and lik to provide the actual required DOM.

The labels used in the navigation are all configurable as well.

## Pagination Styling

The pagination component selector is `cx-pagination`, and is comprised of anchor links.

### Selectors

Each navigation option in the pagination component is rendered as an anchor link with a specific CSS selector (class), as follows:

-   `a.start`
-   `a.previous`
-   `a.first`
-   `a.gap`
-   `a.page`
-   `a.page.current`
-   `a.last`
-   `a.next`
-   `a.end`

### Hiding Navigation in a Specific Instance of the Navigation Component

The pagination component is highly configurable as shown in the previous section. Those configuration options are however globally applied to all instances of the pagination component. If you need to hide navigation options for specific instances, you can apply CSS rules to hide navigation options.

The code snippet below shows a global configuration for the pagination with a first and last page and a gap with dots in between. The CSS snippet below however shows how these options are suppressed for the storefinder search results.

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

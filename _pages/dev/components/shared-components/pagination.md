---
title: Pagination Component
feature:
- name: Pagination Component
  spa_version: 2.0
  cx_version: n/a
---

**Note:** Improvements to this feature are introduced with version 2.0 of the Spartacus libraries.

The pagination component is a low-level component that is used to navigate through page results. It is used in various other components, including the Product List, Order History, and Store Finder components.

Each customer has different pagination requirements, especially with regards to the precise navigation options that you use. The pagination component is very flexible and can be adjusted to meet your needs, either through configuration, or by using custom styles.

For the Product List in particular, the pagination component can be replaced by the infinite scroll feature. For more information, see [{% assign linkedpage = site.pages | where: "name", "infinite-scroll.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/infinite-scroll.md %}).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

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

## Pagination Configuration

You can configure various options for the pagination component, which allows you to reuse the component across the application.

Despite this large number of options, the default configuration in Spartacus uses only a limited feature set: a start link, the page range, and an end link. This appears as follows:

`« 1 2 3 »`

The following list provides a description of each option that is available in the pagination component:

- `addStart` adds a link to skip to the start of the pages. The default is set to true.
- `addPrevious` adds a link to the previous page. The default is set to false.
- `addFirst` adds a link to the first page. The default is set to false.
- `addDots` adds a gap with dots to indicate hidden pages. The default is set to false.
- `rangeCount` sets the range of pages that are directly accessible in the pagination. The default is set to `3`.
- `addLast` adds a link to the last page. The default is set to false.
- `addNext` adds a link to the previous page. The default is set to false.
- `addEnd` adds a link to skip to the end of the pages. The default is set to true.

In addition, the position of the navigation links can be specified, which allows you to separate them from the pages. Although you can achieve this entirely with CSS rules, when considering accessibility, a preferred approach is to provide the actual, required DOM.

All of the labels that are used in the navigation can be configured as well.

## Pagination Styling

The pagination component selector is `cx-pagination`, and is comprised of anchor links.

### Selectors

Each navigation option in the pagination component is rendered as an anchor link with a specific CSS selector (class), as follows:

- a.start
- a.previous
- a.first
- a.gap
- a.page
- a.page.current
- a.last
- a.next
- a.end

### Hiding Navigation in a Specific Instance of the Navigation Component

Although the pagination component is very flexible, the configuration options that have been described so far are applied globally to all instances of the pagination component. If you need to hide navigation options for a specific instance, you can apply CSS rules to hide the navigation options for that instance.

The following example shows a global configuration for the pagination, with a first page, a last page, and a gap with dots in between:

```typescript
ConfigModule.withConfig({
  pagination: {
    addFirst: true,
    addLast: true,
    addDots: true
  }
});
```

You can then use CSS rules to suppress these options for a specific instance, such as the store finder search results. The following is an example:

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

## Component Usage

The pagination component can be used by any UI that needs to navigate a list of things. The pagination component emits an onclick event to the `viewPageEvent` output, which you can use to take further action.

The following code snippet shows a simple example of pagination with action links.

```html
<cx-pagination
  [pagination]="pagination"
  (viewPageEvent)="doPaginationYourself($event)"
></cx-pagination>
```

Alternatively, you can pass in a `pageRoute` and optional `queryParam` to generate specific anchor links. The `queryParam` is often used to generate the pagination parameter. When `defaultPage` is passed in, the `queryParam` is removed when the current page is equal to the default page. This cleans up the URL nicely.

The following code snippet shows a simple example of pagination with anchor links.

```html
<cx-pagination
  [pagination]="model"
  queryParam="currentPage"
  [defaultPage]="0"
></cx-pagination>
```

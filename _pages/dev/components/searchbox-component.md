---
title: Searchbox Component
---

The searchbox component allows you to search the product catalog using typeahead search (also known as autocomplete or autosuggest search).

The searchbox component allows you to search through the product catalog without leaving the page. Search results are fetch-as-you-type, and persist once you navigate to a product details page or a listing page.

The back end returns product items as well as product suggestions.

## Component Mapping

By default, the searchbox component is configured in the CMS as part of a page template. The CMS structure allows you to define the position and behavior of the searchbox with complete flexibility. However, this flexibility is not required for most customers, because in most storefronts, the searchbox is in the header of the page.

The CMS searchbox component is mapped to a JS component as follows:

```typescript
<CmsConfig>{
    cmsComponents: {
        SearchBoxComponent: {
          component: SearchBoxComponent
        }
    }
}
```

You can use the component mapping to configure an alternative searchbox implementation.

## Component Configuration

The CMS component data provides several configuration properties that can be used to influence the behavior of the searchbox. You can use the `CmsSearchBoxComponent` component-typing for type safety. Whenever the searchbox is provided by the CMS structure, the configuration is provided with the CMS component data. However, if the searchbox is used without CMS data, the default values are used, as follows:

| config                 | default |
| ---------------------- | ------- |
| `displayProducts`      | true    |
| `maxProducts`          | 5       |
| `displaySuggestions`   | true    |
| `maxSuggestions`       | 5       |
| `displayProductImages` | true    |

### Component Logic

To keep the component clean, a component-specific `SearchBoxComponentService` is used for the search behavior. This avoids lengthy component logic, but allows for more flexibility when you want to customize the logic.

This service is responsible for executing the search for products and suggestions, unless the search is configured to not search for products and suggestions at all.

The `SearchBoxComponentService` uses the `SearchboxService`, which is a facade on top of the state management layer. 

## Component Styling

The component styles are provided by the `%cx-searchbox` placeholder selector in the styles library. The searchbox style is available in the default sparta theme.

## Known Limitations

- The search configuration in SAP Commerce allows for a redirect configuration. This configuration is not yet implemented in Spartacus.
- The searchbox only searches products and product suggestions. There is no search for categories, pages, or other content types.

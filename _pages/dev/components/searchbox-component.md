---
title: Searchbox Component (DRAFT)
---

The searchbox component is concerned with searching the product catalog using a typeahead search. The end-user can use the searchbox component to search through the product catalog, without leaving the page. Search results are fetch as you type, and persist once you navigate to a product detail page or listing page. 
The backend returns both product items as well as product suggestions. 

## Component mapping
The Searchbox component is by default configured in the CMS, as part of a page template. The CMS structure allows for maximum flexiblity to define the position and and behaviour of the searchbox. While this allows for maximum flexibility, it is not required for most customers as most storefronts will have the searchbox in the header of the page.

The CMS searchbox component is mapped to a JS component using is configured with the following mapping:

```typescript
<CmsConfig>{
    cmsComponents: {
        SearchBoxComponent: {
          component: SearchBoxComponent
        }
    }
}
```

You can use the component mapping to configure an alernative searchbox implementation. 

## Component Configuration
The CMS component data provides several configuration properties that can be used to influence the behaviour of the searchbox. The `CmsSearchBoxComponent` component typing can be used for type safety. Whenever the searchbox is given by the CMS structure, the configuration will be given with the CMS component data. However, if the searchbox is used without CMS data, the default values are used. 

| config                 | default |
| ---------------------- | ------- |
| `displayProducts`      | true    |
| `maxProducts`          | 5       |
| `displaySuggestions`   | true    |
| `maxSuggestions`       | 5       |
| `displayProductImages` | true    |

### Component Logic
In order to keep the component clean, a component specific service (`SearchBoxComponentService`) is used for the search behaviour. This avoids lengthy component logic, but allows for more flexibility when you like to customize the logic. 

This service is responsible for executing the search for products and suggestions, unless the search is configured to not search for products and suggestions at all. 

The `SearchBoxComponentService` uses the `SearchboxService`, which is facade on top of the state management layer. 

## Component styling
The component styles are provided by the `%cx-searchbox` placeholder selector in the styles library. The searchbox style is available in the default sparta theme.

## Known limitations
- The search configuration in SAP Commerce allows for a redict configuration. This configuration is not yet implemented in Spartacus.
- The seachbox only search products and prdouct suggestions. There's no search for categories, pages or other content types. 
  
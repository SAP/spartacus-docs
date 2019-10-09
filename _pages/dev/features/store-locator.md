---
title: Store Locator
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

The Spartacus store locator feature helps customers find brick-and-mortar retail locations. Customers can view a list of all stores, they can search for stores based on their location, or they can search for stores based on a postal code, a town, or an address that the customer provides.

If the customer chooses to **Use My Location** and allows their device to access their location, a list of the nearest stores is displayed, sorted by distance in kilometers. By selecting any store in the list, the customer can view store details, such as address, phone number, opening hours, and features.

If the customer chooses to **View All Stores**, a list of all the countries is displayed, with the number of stores in each country shown in parentheses. When the customer selects a country, a list of all the stores in the selected country is displayed, along with the address for each store location. Customers also have the option to **Get Directions**, which opens Google Maps in a separate browser window with directions from the customer's location to the selected store.



Last option is using search bar, customer needs to put his location (full address, city or zip-code) into search input, next click a "find a store" button. Backend server automatically resolve his coordinates based on text provided and return list of nearest stores.

## Configuration

Store Locator has a following configuration in `default-store-finder-config.ts`

```typescript
  googleMaps: {
    apiUrl: 'https://maps.googleapis.com/maps/api/js',
    apiKey: 'GOOGLE_MAPS_API_KEY',
    scale: 5,
    selectedMarkerScale: 17
}
```

- `apiUrl (string)` - url to Google Maps
- `apiKey (string)` - unique store owner Google Maps API key
- `scale (number)` - initial zoom at which to display the map
- `selectedMarkerScale (number)` - zoom at which to display selected location on a map

## Enabling Store Locator

Store Locator is enabled as default. It can be disabled by turning off "Find a store" header link and Store Locator page in a backend.

To do that the following impex script can be imported:

```
INSERT_UPDATE CMSLinkComponent;$contentCV[unique=true];uid[unique=true];visible
;;StoreFinderLink;false
```

Additionally go to backoffice, select from left sidebar `WCMS` -> `Pages`. Find a page with id: `storeFinderPage` and change page status from `Active` to `Deleted`. That is all, now if customer try to reach directly Store Locator url, the 404 error will appear.

Also there is possibility (but optional) to disable Store Locator feature totally in storefront application.

Just go to `projects\storefrontlib\src\cms-components\cms-lib.module.ts` and remove `StoreFinderModule` from imports.

## More information

For more information we recommend to check following [doc](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8aefbe4086691014bcc4feeef292c19d.html) which describes how to manage POS content in backoffice and other configuration aspects.

---
title: Store Locator
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

The Spartacus store locator feature helps customers find brick-and-mortar retail locations. Customers can view a list of all stores, they can search for stores based on their location, or they can search for stores based on a postal code, a town, or an address that the customer provides.

If the customer chooses to **Use My Location** and allows their device to access their current location, a list of the nearest stores is displayed, sorted by distance in kilometers. By selecting any store in the list, the customer can view store details, such as address, phone number, opening hours, and store features.

If the customer chooses to **View All Stores**, a list of all the countries is displayed, with the number of stores in each country shown in parentheses. When the customer selects a country, a list of all the stores in the selected country is displayed, along with the address for each store location. Customers also have the option to **Get Directions**, which opens Google Maps in a separate browser window with directions from the customer's location to the selected store.

The customer can also search for the nearest stores by entering an address, a town, or a postal code in the search bar. The search results indicate the nearest stores to the location provided by the customer.

## Configuring Store Locator

The store locator feature is configured in `default-store-finder-config.ts`, as follows:

```typescript
  googleMaps: {
    apiUrl: 'https://maps.googleapis.com/maps/api/js',
    apiKey: 'GOOGLE_MAPS_API_KEY',
    scale: 5,
    selectedMarkerScale: 17
}
```

The following is a description of the `googleMaps` parameters:

- `apiUrl` takes the format of a string, and is the URL to Google Maps
- `apiKey` take the format of a string, and is the unique Google Maps API key that belongs to the store owner
- `scale` takes the format of a number, and sets the initial zoom when the map is displayed
- `selectedMarkerScale` takes the format of a number, and sets the zoom on the map when a location is selected

## Enabling Store Locator

The store locator feature is enabled by default.

### Disabling Store Locator

You can disable the store locator by removing the **Find a Store** link in the header, and by deleting the Store Locator page in Backoffice, as described in the following procedure:

1. Import the following impex:

    ```
    INSERT_UPDATE CMSLinkComponent;$contentCV[unique=true];uid[unique=true];visible
    ;;StoreFinderLink;false
    ```

1. Log in to Backoffice as an administrator.

1. In the left sidebar of Backoffice, select **WCMS ––> Page**.

1. In the **Search** field in the center panel of Backoffice, enter the search term `storefinder`.

    A list of pages appears with the `storefinderPage` ID.

1. Select the **StoreFinder Page** that you wish to  

You can also disable the store locator by removing `StoreFinderModule` from the imports in `projects\storefrontlib\src\cms-components\cms-lib.module.ts`.

For more information on impex, see [ImpEx](https://help.sap.com/viewer/d0224eca81e249cb821f2cdf45a82ace/latest/en-US/8bee5297866910149854898187b16c96.html).

For more information on Backoffice, see [Backoffice](https://help.sap.com/viewer/5c9ea0c629214e42b727bf08800d8dfa/1905/en-US/8c17707686691014b72a8fb745de355a.html).


Store Locator is enabled as default. It can be disabled by turning off "Find a store" header link and Store Locator page in a backend.

To do that the following impex script can be imported:

```
INSERT_UPDATE CMSLinkComponent;$contentCV[unique=true];uid[unique=true];visible
;;StoreFinderLink;false
```

Additionally go to backoffice, select from left sidebar `WCMS` -> `Pages`. Find a page with id: `storeFinderPage` and change page status from `Active` to `Deleted`. That is all, now if customer try to reach directly Store Locator url, the 404 error will appear.

Also there is possibility (but optional) to disable Store Locator feature totally in storefront application.

Just go to `projects\storefrontlib\src\cms-components\cms-lib.module.ts` and remove `StoreFinderModule` from imports.

## Further Reading

For more information we recommend to check following [doc](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/1905/en-US/8aefbe4086691014bcc4feeef292c19d.html) which describes how to manage POS content in backoffice and other configuration aspects.

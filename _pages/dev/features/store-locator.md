---
title: Store Locator
feature:
- name: Store Locator
  spa_version: 1.2
  cx_version: 1905
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

The Spartacus store locator feature helps customers find brick-and-mortar retail locations. Customers can view a list of all stores, they can search for stores based on their location, or they can search for stores based on a postal code, a town, or an address that the customer provides.

If the customer chooses to **Use My Location**, and allows their device to access their current location, a list of the nearest stores is displayed, sorted by distance in kilometers. By selecting any store in the list, the customer can view store details, such as address, phone number, opening hours, and store features.

If the customer chooses to **View All Stores**, a list of all stores is displayed, sorted by country, and with the number of stores in each country shown in parentheses. When the customer selects a country, a list of all the stores in the selected country is displayed, along with the address for each store. Customers also have the option to **Get Directions** for a particular store, which opens Google Maps in a separate browser window with directions from the customer's location to the selected store.

The customer can also search for the nearest stores by entering an address, a town, or a postal code in the search bar. The search results indicate the nearest stores, based on the location provided by the customer.

## Configuring the Store Locator

The store locator is configured in `default-store-finder-config.ts`, as follows:

```typescript
  googleMaps: {
    apiUrl: 'https://maps.googleapis.com/maps/api/js',
    apiKey: 'GOOGLE_MAPS_API_KEY',
    scale: 5,
    selectedMarkerScale: 17
}
```

The following is a description of the `googleMaps` parameters:

- `apiUrl` takes the format of a string, and is the URL to Google Maps.
- `apiKey` take the format of a string, and is the unique Google Maps API key that belongs to the store owner.
- `scale` takes the format of a number, and sets the initial zoom when the map is displayed.
- `selectedMarkerScale` takes the format of a number, and sets the zoom on the map when a store location is selected.

## Enabling the Store Locator

You can enable the store locator by installing the `@spartacus/storefinder` feature library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

### Disabling the Store Locator

You can disable the store locator by removing the **Find a Store** link in the header, and by deleting the **StoreFinder Page** in Backoffice, as described in the following procedure:

1. Log in to Backoffice as an administrator.

1. In the left sidebar of Backoffice, select **WCMS ––> Component**.

1. Use the advanced search to find component with ID: `StoreFinderLink`

1. Select the one in the appropriate catalog and set its visibility to: false.

   This removes the **Find a Store** link from the header.

1. In the left sidebar of Backoffice, select **WCMS ––> Page**.

1. Use the search bar to search for `storefinder`.

1. Select the **StoreFinder Page** that you wish to disable.

1. In the **StoreFinder Page** panel, click the **Page Status** dropdown list and select **Deleted**.

1. Click **Save**.

   You have now disabled the store locator.

   After you have disabled the store locator, if a customer tries to directly access the store locator URL, Spartacus returns a 404 error.

## Further Reading

Consult the SAP Help Portal for more information on the following topics:

- [ImpEx](https://help.sap.com/viewer/d0224eca81e249cb821f2cdf45a82ace/latest/en-US/8bee5297866910149854898187b16c96.html)
- [Backoffice](https://help.sap.com/viewer/5c9ea0c629214e42b727bf08800d8dfa/latest/en-US/8c17707686691014b72a8fb745de355a.html)
- [Store Locator Configuration in Backoffice](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8aefbe4086691014bcc4feeef292c19d.html)

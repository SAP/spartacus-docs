---
title: Storefinder
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

Customers are able to view all physical stores on the map, and find the nearest ones based on their current location.

There are following ways to navigate store list:

- use my location
- view all stores
- find a store

If customer click "use my location" and allow device to get location coordinates, list with nearest locations display sorted by distance in kilometers. Each of stores in a list is clickable and contains the details like: location address, phone number, opening hours and features.

Alternative way to find a store is "view all stores" option, which displays grid with countries and if customer select his preference all stores from such country will appear.

Last option is using search bar, customer needs to put his location (full address, city or zip-code) into search input, next click a "find a store" button. Backend server automatically resolve his coordinates based on text provided and return list of nearest stores.

## Configuration

Storefinder has a following configuration in `default-store-finder-config.ts`

```typescript
  googleMaps: {
    apiUrl: 'https://maps.googleapis.com/maps/api/js',
    apiKey: 'GOOGLE_MAPS_API_KEY',
    scale: 5,
    selectedMarkerScale: 17
}
```

`apiUrl (string)` - url to Google Maps
`apiKey (string)` - unique store owner Google Maps API key
`scale (number)` - initial zoom at which to display the map
`selectedMarkerScale (number)` - zoom at which to display selected location on a map

## Enabling Storefinder

Storefinder is enabled as default. It can be disabled by turning off "Find a store" header link and Storefinder page in a backend.

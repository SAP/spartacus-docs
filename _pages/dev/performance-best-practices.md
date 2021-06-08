---
title: Performance Best Practices
---

This page describes a series of recommendations to improve the Lighthouse scoring of Spartacus, and subsequently get better numbers on the Google Core web vitals (which focus on loading speed, interactivity and visual stability)

## Performance

The keys for to achieve a high performance report are the following:

1. The page has to load as fast as possible. This includes resources (css and js scripts), assets (fonts, images, media) and synchronous and asynchronous data (xhr requests).
1. Users should be able to interact with the page as fast as possible.
1. Visible elements on the page should move as least as possible as the page load progresses.

Recommendations:

- Minimize the number of HTTP requests as much as possible (both synchronous and asynchronous).
- Verify that the size of your assets is the correct one. For example, do not display very big images on a page that requires small images.
- When making calls to APIs (like OCC), try to request only the data than you need. OCC responses with `fields=FULL` contain a lot of data that you might not need. The bigger the response, the longer it takes to get it and process it. Same applies for APIs that support pagination.
- Have a second level (L2) cache for all of the site assets and also for the http requests that can be cached (for example, you might not want to cache user-specific data).
- Make sure you have an appropriate cache policy for the Browser. Browser caching saves a lot of bandwidth and time when it is properly tuned.

## SEO

- Server Side Rendering must be enabled since it guarantees that all of your pages will be properly indexed.
- Have a valid and consistent Robots.txt file to allow robots to crawl your website.
- Make sure your Meta attributes and tags are appropriately set across your pages.

More information about how to optimize the SSR engine [here] (https://sap.github.io/spartacus-docs/server-side-rendering-optimization)

More information about our SEO capabilities [here](https://sap.github.io/spartacus-docs/seo-capabilities)

## Accessibility

- There are a few components / elements across Spartacus that are not 100% compliant with accessibility (fixes are on the way). A workaround for this is overriding such components. This will allow you to add missing `aria attributes` or rename elements to improve accessibility scoring.

## PWA

- Spartacus is a Progressive Web Application right out of the box. Have a look at out [pwa documentation](https://sap.github.io/spartacus-docs/pwa-home)
- Use the service worker to cache data that does not change often in the browser. This will allow you to speed up page loads. Also, it can enable your SPA to work offline.

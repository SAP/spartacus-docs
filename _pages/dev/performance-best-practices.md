---
title: Performance Best Practices
---

This page describes a series of recommendations to improve Spartacus performance, with the goal of having good scores on Google Lighthouse scoring, and subsequently on the Google Core web vitals (which focus on loading speed, interactivity and visual stability of your website).

## Performance

The keys for to achieve a grade A performance report are the following:

1. The page has to load as fast as possible. This includes resources (css and js scripts), assets (fonts, images, media) and synchronous and asynchronous data (xhr requests).
1. Users should be able to interact with the page as fast as possible.
1. Visible elements on the page should move as least as possible as the page load progresses.

### Recommendations

#### General

- Minimize the number of HTTP requests as much as possible (both synchronous and asynchronous).
- Use HTTP compression whenever possible to improve transfer speed and optimize bandwidth.
- Use `async` or `defer` when loading third party scripts so that the browser's main thread does not get blocked.
- Verify that the size of your assets matches with what you want to display. For example, do not display big images on a viewport that requires small images.
- When making calls to APIs (like OCC), try to request only the data than you need. OCC responses with `fields=FULL` contain a lot of data that you might not need. The bigger the response, the longer it takes to get it and process it. Same applies for APIs that support pagination.
- Only load the CSS and Javascript that you need on each page.

#### Caching

- Have a second level (L2) cache for all of the site assets and also for the http requests that can be cached (such as OCC calls for anonymous users that won't change very often).
- Make sure you have an appropriate browser cache policy for all of the assets of the page. Browser caching saves a lot of bandwidth and improves page load time (both initial and subsequent) when it is properly set and tuned.

#### Other

- Take advantage of Lazy loading to load only the javascript chunks you need for each page. Spartacus already does this with several libraries out of the box. That said, we recommend to use lazy loading techniques for your customized modules as well. Last but not least, we recommend to fully understand how lazy loading works in Spartacus, so that customizations don't break out of the box lazy loading.
- Take advantage of the SSR Transfer state mechanism to avoid duplicated XHR calls. Reference [here](https://sap.github.io/spartacus-docs/configurable-state-persistence-and-rehydration/#ssr-transfer-state)

Lazy loading documentation [here](https://sap.github.io/spartacus-docs/lazy-loading-guide)

## SEO

- Server Side Rendering must be enabled since it guarantees that all of your pages will be properly indexed.
- Have a valid and consistent Robots.txt file to allow robots to crawl your website.
- Make sure your Meta attributes and tags are appropriately set across your pages.

More information about how to optimize the SSR engine [here](https://sap.github.io/spartacus-docs/server-side-rendering-optimization)

More information about our SEO capabilities [here](https://sap.github.io/spartacus-docs/seo-capabilities)

## Accessibility

- There are a few components / elements across Spartacus that are not 100% compliant with accessibility (fixes are on the way). A workaround for this is overriding such components. This will allow you to add missing `aria attributes` or rename elements to improve accessibility scoring.

## PWA

- Spartacus is a Progressive Web Application right out of the box. Have a look at out [pwa documentation](https://sap.github.io/spartacus-docs/pwa-home)
- Use the service worker to cache resources that do not change often. This will allow you to speed up subsequent page loads. Also, it can enable your SPA to work offline.

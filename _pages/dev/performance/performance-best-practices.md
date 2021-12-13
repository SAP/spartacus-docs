---
title: Performance Best Practices
---

There are a number of best practices that you can follow to improve the performance of your Spartacus storefront, and which will also help improve your [Google Lighthouse score](https://developers.google.com/web/tools/lighthouse). By following these recommendations, you can also improve the results of your Google [Core Web Vitals](https://web.dev/vitals/) report, which focuses on page loading speed, page interactivity speed, and the visual stability of your website.

The keys for achieving a "Grade A" performance report are the following:

- Each page loads as fast as possible, including:
  - Web resources (CSS and JS files)
  - Assets (fonts, images, and media)
  - Asynchronous data (Ajax calls)
- Users can interact with the page as quickly as possible
- There is no layout shifting (visible elements on the page shift or move as little as possible during page load)

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## General Recommendations

The following best practices are highly recommended for improving the performance of your storefront application:

- Minimize the number of synchronous and asynchronous HTTP requests as much as possible.
- Use HTTP compression whenever possible to improve transfer speed and to optimize bandwidth.
- When loading third party scripts, use `async` or `defer` so that the browser's main thread does not get blocked.
- Verify that the size of your assets is appropriate for the size of the user's screen. For example, you do not want to display desktop-size images on a viewport that requires mobile-size images.
- When making calls to APIs, such as OCC, try requesting only the data that you need. OCC responses with `fields=FULL` contain a lot of data that you might not need. The bigger the response, the longer it takes to retrieve it and process it. The same practice applies to APIs that support pagination.
- Only load the CSS and Javascript that you need on each page.
- Use [{% assign linkedpage = site.pages | where: "name", "above-the-fold.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/performance/above-the-fold.md %}) when possible.

## Caching Recommendations

You can improve the performance of your storefront application with the following caching best practices:

- Maintain a second level (L2) cache for all of the site assets, and also for the HTTP requests that can be cached, such as OCC calls for anonymous users that do not change very often.
- Ensure you have an appropriate browser cache policy for all of the assets of the page. Browser caching saves a lot of bandwidth and improves page load time (both initial and subsequent) when it is properly set and tuned.

## Additional Recommendations

The following recommendations can improve the performance of your Spartacus storefront app significantly:

- Split your JavaScript code into multiple chunks (a technique known as lazy loading) to load only the JavaScript chunks that you need for each page. Spartacus has implemented lazy loading for a number of its own libraries, but you can further improve the performance of your storefront by using lazy loading techniques in your customized modules as well. Before implementing lazy loading in your customized modules, it is important to be aware of how lazy loading works in Spartacus. For more information, see [{% assign linkedpage = site.pages | where: "name", "lazy-loading-guide.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/lazy-loading-guide.md %}).
- Take advantage of the SSR transfer state mechanism to avoid duplicated XHR calls. For more information, see [{% assign linkedpage = site.pages | where: "name", "ssr-transfer-state.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/state_management/ssr-transfer-state.md %}).
- Use inline fonts and CSS instead of loading them asynchronously.

## SEO

You can improve the SEO of your storefront with the following best practices:

- Enable server-side rendering to ensure that all of your pages are properly indexed.
- Have a valid and consistent `robots.txt` file to allow robots to crawl your website.
- Ensure your meta attributes and tags are appropriately set across your pages.

For more information, see [{% assign linkedpage = site.pages | where: "name", "server-side-rendering-optimization.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/ssr/server-side-rendering-optimization.md %}) and [{% assign linkedpage = site.pages | where: "name", "seo-capabilities.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/seo/seo-capabilities.md %}).

## Accessibility

There are a few components and elements in Spartacus that are not yet fully compliant with accessibility. Where necessary, you can override these components and elements, which allows you to add missing `aria attributes`. It also allows you to rename elements to improve accessibility scoring.

## PWA

Spartacus is a Progressive Web Application out of the box. As a result, you can configure your service worker to cache resources that do not change often (such as resources, assets, and HXR requests), which will speed up subsequent page loads. You can also enable your storefront app to work offline.

For more information, see [{% assign linkedpage = site.pages | where: "name", "pwa-home.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/pwa/pwa-home.md %}).

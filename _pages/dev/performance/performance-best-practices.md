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

- Minimize the number of synchronous HTTP requests as much as possible.
- Whenever possible, use HTTP compression, such as Brotli or Zstd, to improve transfer speed and to optimize bandwidth.
- When loading third party scripts, use `async` or `defer` so that the browser's main thread does not get blocked.
- Verify that the size of your assets is appropriate for the size of the user's screen. For example, you do not want to display desktop-size images on a viewport that requires mobile-size images.
- When making calls to APIs, such as OCC, try requesting only the data that you need. OCC responses with `fields=FULL` contain a lot of data that you might not need. The bigger the response, the longer it takes to retrieve it and process it. The same practice applies to APIs that support pagination.
- Only load the CSS and Javascript that you need on each page.
- Use [{% assign linkedpage = site.pages | where: "name", "above-the-fold.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/performance/above-the-fold.md %}) when possible.

## Caching Recommendations

You can improve the performance of your storefront application with the following caching best practices:

- Maintain a second level (L2) cache for all of the site assets, and also for the HTTP requests that can be cached, such as OCC calls for anonymous users that do not change very often.
- Ensure you have an appropriate browser cache policy for all of the assets of the page. Browser caching saves a lot of bandwidth and improves page load time (both initial and subsequent) when it is properly set and tuned.

## Image Format Recommendations

You can improve the performance of your storefront application with the following image format best practices:

- Use WebP or AVIF (AV1 Image File Format) to reduce the size of your images, which can improve the performance of your storefront application.
  - Check browser support for WebP and AVIF formats before using them.
  - Provide fallback options for browsers that don't support WebP or AVIF formats.
- Select the correct compression level for your images to balance image quality and file size.
  - Use lossy compression for photographs and images with gradients.
  - Use lossless compression for images with text, sharp edges, or when quality can't be compromised.
- Use content delivery network (CDN) services that support WebP and AVIF formats to deliver images to users.
- Use vector graphics (SVG) for simple images and icons, which can be scaled without losing quality and have smaller file sizes compared to raster images.
- Use CSS techniques to create simple shapes and icons instead of using images. This can reduce the number of image files needed and improve loading time.

For more information, see the following:

- [WebP Image Format](https://developer.chrome.com/docs/lighthouse/performance/uses-webp-images)
- [Image CDN](https://web.dev/learn/images/cdn)
- [Brotli Compression](https://web.dev/articles/codelab-text-compression-brotli)
- [Network Payload Compression](https://web.dev/articles/codelab-text-compression)
- [Image Optimization](https://web.dev/articles/compress-images)

## CDN Recommendations

Using a content delivery network (CDN) can significantly improve the performance of your storefront application by distributing your content across multiple servers located around the world, allowing you to serve content closer to your end users, no matter where they are located. The following are best practices for using a CDN:

- Choose a reliable CDN provider: Select a CDN provider that offers good performance, reliability, and coverage in the regions where your users are located.
- Cache static assets and dynamic prerendered routes: Configure your CDN to cache static assets, including images, CSS, JavaScript files, fonts, and prerendered routes. This reduces the load on your origin server and accelerates content delivery to users, which can improve Core Web Vital metrics such as LCP.
- Use HTTP/2 or HTTP/3 if possible: Make sure your CDN supports the latest versions of HTTP, which can improve the performance of your storefront by reducing latency and improving the efficiency of data transfer.
- Rely on the CDN to optimize images, if possible: Some CDN providers can automatically optimize images by converting them to modern formats like WebP or AVIF, resizing them, and applying compression. This can significantly reduce the size of image files and improve loading times.
- Enable Brotli compression: Configure your CDN to compress content using Brotli compression to reduce the size of files transferred over the network.
- Use a secure connection: Ensure that your CDN supports HTTPS to encrypt data in transit and to protect user privacy.
- Monitor performance: Monitor the performance of your CDN using available tools to identify bottlenecks and optimize content delivery.
- Optimize cache settings: Configure cache settings on your CDN to ensure that content is cached for an appropriate duration and that cache invalidation is handled correctly.
- Use a Multi CDN strategy: Consider using multiple CDNs to improve redundancy, reduce latency, and optimize content delivery for users in different regions.
- Implement a CDN failover strategy: Plan for CDN outages by implementing a failover strategy that redirects traffic to an alternate CDN or origin server in case of downtime.
- Leverage CDN capabilities: Use CDN features like `stale-while-revalidate` and `stale-if-error` to serve stale content while fetching updates or handling errors.
- Implement Subresource Integrity: Subresource Integrity (SRI) is a security feature that ensures the integrity of resources fetched from a CDN. By using SRI, you can verify that the resources have not been tampered with, thus protecting against supply chain attacks.

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

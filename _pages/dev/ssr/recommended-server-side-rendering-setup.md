---
title: Recommended Setup for Server-Side Rendering
---

There are a number of recommendations and best practices you can consider when using server-side rendering with Spartacus. Although there will always be exceptions, these recommendations should cover the most common implementation scenarios.

The following diagram focuses only on the SSR aspect of a SAP Commerce Cloud setup, and illustrates the typical, high-level flow from a user's request at one end, all the way to the OCC API server at the other end.

<img src="{{ site.baseurl }}/assets/images/ssr-setup-diagram.png" alt="SSR Setup Diagram" width="400" border="1px" />

The details of this flow are described as follows:

- The starting point is the user's request, which is typically issued from a browser.

- The request should hit a caching layer (such as a CDN), which might contain an application that is already server-side rendered application. In such cases, the response is very quick because the server returns the HTML that has already been rendered on the server side.

   The CDN typically stores the server-side rendered content for a certain period of time, depending on the business requirements. After the given period, the cache is invalidated. To ensure the invalidation is carried out smoothly, the CDN should ask for a fresh server-side render of the content before the cache is evicted, and to continue serving the existing cache while the new render is being performed.

   If this is not possible in the CDN you are using, the alternative would be to consider using some kind of a cache warm-up mechanism. There are tools that exist that can be used to perform the following actions:

  - When the cache is about to expire, the tool proactively triggers the SSR rendering
  - Upon receiving the successful rendering result, the CDN's APIs are used to invalidate the existing cache
  - The new (updated) SSR render is then sent to the CDN for caching

- If the CDN does not have a cached SSR render, it forwards the request to a reverse proxy, such as a load balancer.

- The reverse proxy decides which SSR node (in a cluster of nodes) it should forward the request to.

- An SSR node receives the request and starts the render. The node issues OCC calls to the OCC API.

   It is not recommended to expose the SSR servers or nodes directly to users, because the rendering is slow and will not meet the expected response times.

- The OCC API caching layer is responsible for caching the OCC API responses from the OCC API server. Usually, this means caching the responses of the GET and HEAD requests. If the OCC API caching layer already has the response in its cache, the response is returned immediately to the SSR node, without the request needing to reach the actual OCC API server. This allows the SSR node to perform a render very quickly.

   It is recommended that you set up some kind of a caching layer for the OCC API server, because processing request on the OCC API server is the most time-intensive aspect of server-side rendering.

- If the OCC API caching layer does not contain a cached response for the given request, the caching layer forwards the request to the OCC server for processing.

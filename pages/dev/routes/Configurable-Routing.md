---
title: Configurable Routing (DRAFT)
permalink: /Configurable-Routing/
---

## Introduction

Navigation in a web application is mostly done through URLs. Spartacus allows you to customize these URLs, which can be used to deep-link into a specific application state, and can contribute to the usability and SEO capabilities of the application.

In a Single Page Application, URLs are intercepted by the application logic so that the view(s) can be updated seamlessly. This requires routing logic, which, in the case of Spartacus, is provided by the Angular Router.

While the Angular Router contains a rich set of features and configuration options, Spartacus contains components that are intended to run without any configuration by default.

This is where configurable routes come in to play: every route in Spartacus is configurable.

For more information, see the following:

- [Adding and Customizing Routes]({{ site.baseurl }}{% link pages/dev/routes/Adding-and-Customizing-Routes.md %})
- [Route Configuration]({{ site.baseurl }}{% link pages/dev/routes/Route-Configuration.md %})
- [Configurable Router Links]({{ site.baseurl }}{% link pages/dev/routes/Configurable-Router-Links.md %})
- [Disabling Standard Routes]({{ site.baseurl }}{% link pages/dev/routes/Disabling-Standard-Routes.md %})
- [Additional Route Parameters]({{ site.baseurl }}{% link pages/dev/routes/Additional-Route-Parameters.md %})
- [Route Aliases]({{ site.baseurl }}{% link pages/dev/routes/Route-Aliases.md %})

## Limitations

- Translation of routes in many languages is not currently supported
- Configuration of lazy-loaded routes is not currently supported
- Routing based on hash ([Angular's `HashLocationStrategy`](https://angular.io/guide/router#appendix-locationstrategy-and-browser-url-styles)) is not supported.

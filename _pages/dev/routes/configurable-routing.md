---
title: Configurable Routing (DRAFT)
---

## Introduction

Navigation in a web application is mostly done through URLs. Spartacus allows you to customize these URLs, which can be used to deep-link into a specific application state, and can contribute to the usability and SEO capabilities of the application.

In a Single Page Application, URLs are intercepted by the application logic so that the view(s) can be updated seamlessly. This requires routing logic, which, in the case of Spartacus, is provided by the Angular Router.

While the Angular Router contains a rich set of features and configuration options, Spartacus contains components that are intended to run without any configuration by default.

This is where configurable routes come in to play: every route in Spartacus is configurable.

For more information, see the following:

- [Adding and Customizing Routes]({{ site.baseurl }}{% link _pages/dev/routes/adding-and-customizing-routes.md %})
- [Route Configuration]({{ site.baseurl }}{% link _pages/dev/routes/route-configuration.md %})
- [Configurable Router Links]({{ site.baseurl }}{% link _pages/dev/routes/configurable-router-links.md %})
- [Disabling Standard Routes]({{ site.baseurl }}{% link _pages/dev/routes/disabling-standard-routes.md %})
- [Additional Route Parameters]({{ site.baseurl }}{% link _pages/dev/routes/additional-route-parameters.md %})
- [Route Aliases]({{ site.baseurl }}{% link _pages/dev/routes/route-aliases.md %})
- [External Routes]({{ site.baseurl }}{% link _pages/dev/routes/external-routes.md %})
- [Early Login]({{ site.baseurl }}{% link _pages/dev/routes/early-login.md %})

## Limitations

- Translation of routes in many languages is not currently supported
- Configuration of lazy-loaded routes is not currently supported
- Routing based on hash ([Angular's `HashLocationStrategy`](https://angular.io/guide/router#appendix-locationstrategy-and-browser-url-styles)) is not supported
- [Secondary routes (and named router outlets)](https://angular.io/guide/router#secondary-routes) are not currently supported

---
title: Configurable Routing
---

In a single-page application, you control what the user sees by showing different views of the app. Spartacus uses the Angular Router to take care of navigating from one view to another. The Router does this by treating each URL as an instruction to present a specific view.

Spartacus allows you to customize these URLs, giving you more control over SEO and storefront usability. Spartacus includes default routes for accessing the different views, which you can use without any configuration, but you also have the option to customize any route that you want in Spartacus.

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

- Translation of routes in many languages is currently not supported.
- Configuration of lazy-loaded routes is currently not supported.
- Routing based on [Angular's `HashLocationStrategy`](https://angular.io/guide/router#locationstrategy-and-browser-url-styles) is not supported.
- [Secondary routes and named router outlets](https://angular.io/guide/router-tutorial-toh#secondary-routes) are currently not supported.

---
title: Multi-Site Configuration
---

Every site that is defined in the CMS has its own context, which includes a base site ID, language properties, and currency properties. The context also defines how these attributes are persisted in the URL.

You can configure your application by defining static `context` properties, as described in [Static Multi-Site Configuration]({{ site.baseurl }}{% link _pages/dev/context/static-context-configuration.md %}). However, the recommended approach is to not configure the `context` property, and instead to allow Spartacus to automatically determine the context based on the URL patterns of your sites, as defined in the CMS. For more information, see [Automatic Multi-Site Configuration]({{ site.baseurl }}{% link _pages/dev/context/automatic-context-configuration.md %})

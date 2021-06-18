---
title: Performance Optimizations
---

This is a landing page for performance-related topics. This includes the following topics:

- [{% assign linkedpage = site.pages | where: "name", "above-the-fold.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/performance/above-the-fold.md %})
- [{% assign linkedpage = site.pages | where: "name", "deferred-loading.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/performance/deferred-loading.md %})
- [{% assign linkedpage = site.pages | where: "name", "performance-best-practices.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/performance/performance-best-practices.md %})

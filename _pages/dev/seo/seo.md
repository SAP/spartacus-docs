---
title: Search Engine Optimization
feature:
- name: SEO
  spa_version: 1.0
  cx_version: n/a
---

This is a landing page for grouping together the Search Engine Optimization (SEO) topics. The SEO topics include the following:

- [{% assign linkedpage = site.pages | where: "name", "seo-capabilities.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/seo/seo-capabilities.md %})
- [{% assign linkedpage = site.pages | where: "name", "html-tags.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/seo/html-tags.md %})
- [{% assign linkedpage = site.pages | where: "name", "structured-data.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/seo/structured-data.md %})

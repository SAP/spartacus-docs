---
title: Best practises
---

This is a landing page for developers best practises topics. It includes the following:

- [{% assign linkedpage = site.pages | where: "name", "layout-best-practices.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/best-practises/layout-best-practices.md %})
- [{% assign linkedpage = site.pages | where: "name", "i18n-best-practices.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/best-practises/i18n-best-practices.md %})
- [{% assign linkedpage = site.pages | where: "name", "structure-best-practices.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/best-practises/structure-best-practices.md %})
- [{% assign linkedpage = site.pages | where: "name", "extending-best-practices.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/best-practises/extending-best-practices.md %})
- [{% assign linkedpage = site.pages | where: "name", "styles-best-practices.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/best-practises/styles-best-practices.md %})

All of the above instructions are only suggestions on how to use Spartacus from the core team members.

---
title: State Management
---

This is a landing page for grouping together State Management topics. The State Management topics include the following:

- [{% assign linkedpage = site.pages | where: "name", "loader-meta-reducer.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/state_management/loader-meta-reducer.md %})
- [{% assign linkedpage = site.pages | where: "name", "state-persistence.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/state_management/state-persistence.md %})
- [{% assign linkedpage = site.pages | where: "name", "ssr-transfer-state.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/state_management/ssr-transfer-state.md %})

---
title: Split View Component
feature:
- name: Split View Component
  spa_version: 3.0
  cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The split view component manages the presentation of hierarchical content on a page. A split view consists of a multi-column interface that shows two or more views in parallel. Split views are useful for navigating multiple levels of content hierarchy, such as traversing a list to view each item in the list.

A good example of where Spartacus uses the split view component is in B2B Commerce Organization (also known as My Company). Entities, such as business units, budgets and cost centers, are presented as lists of items that can be opened and edited. The split view component offers a convenient UI that allows you to go through the lists and edit them as needed.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Components

The split view component is itself built from two components: the `SplitViewComponent` is used as a root element for the split view, and it can host multiple `ViewComponent` elements. The following is an example:

```html
<cx-split-view>
  <cx-view></cx-view>
  <cx-view></cx-view>
</cx-split-view>
```

The actual content of both components is very flexible, and you do not have to nest `ViewComponent` elements as direct children under the `SplitViewComponent`. This is particularly useful when views are created from child routes, or from other child components. The following fragment illustrates such a DOM structure:

```html
<cx-split-view>
  <div class="wrapper">
    <cx-view></cx-view>
  </div>
  <router-outlet></router-outlet>
  <my-component>
    <cx-view></cx-view>
  </my-component>
</cx-split-view>
```

## Component Interaction

The `SplitViewComponent` does not interact directly with nested `cx-view` elements, and does not need any information about the underlying views, other than to keep track of the last visible view component number. This information is exposed by the `SplitViewService`. The `cx-view` elements interact with the `SplitViewService` to register themselves and to toggle their visible state.

The `SplitViewService` is provided to each `SplitViewComponent` so that the various views and their corresponding states can be isolated from other `SplitViewComponent` components. This allows you to have multiple, independent split views in the application.

## Styling

The split view layout is driven by CSS Flexbox. To avoid breaking the content flow of nested flex items, it is important that any elements that wrap the `cx-view` elements are removed from the Flexbox. This can be achieved by using the CSS `display` property with the `contents` value. The following is an example:

```css
.wrapper {
  display: contents;
}
```

## Split View Animation

The split view component uses an animation to show or hide view elements by sliding them in and out when their visible state is toggled. The animations are driven by CSS animations, which you can further customize.

Special behavior is introduced if a route-driven split view is closed. The split view that is part of the route is destroyed instantly by the Angular router, which would prevent an animation. To prevent destroying the element before the animation is finished, the `ViewComponent.toggle()` is triggered, while the actual router link event is delayed by 500 milliseconds.

## Configuring the Column Size

You can configure the number of active parallel views using CSS variables. The default number is set to `2`, so that a two-column layout is used. This fits nicely with the relatively small layout that comes with the Spartacus style library. However, if you prefer to use a wider layout that makes use of three columns, you can increase the maximum number of columns by changing the CSS variable. The following is an example:

```css
:root {
  --cx-max-views: 3;
}
```

Using CSS variables provides a lot of flexibility. You can specify different maximum views per screen size, as well as specific maximum view size configurations for individual split view components.

Spartacus defaults to a two-column view for tablets and larger screens, and a single-column view for mobile screens.

## Gutter

You can specify a gutter to add a margin between split view elements. The gutter is driven by a CSS variable, which provides a lot of flexibility for configuring various split views. The default gutter is set to 40px, as shown in the following example:

```css
:root {
  --cx-split-gutter: 40px;
}
```

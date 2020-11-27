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

The split view component manages the presentation of hierarchical content on a page. A split view consists of a two column (or multiple column) interface showing multiple views in parallel. Split views are useful for navigating multiple levels of content hierarchy, such as traversing a list of items to view each item.

You can see Spartacus making use of the split view component in B2B Commerce Organization (also known as My Company). Entities, such as business units, budgets and cost centers, are presented as lists of items that can be opened and edited. The split view component offers a clear layout that allows you to go through the lists and edit them as needed.

## Components

The split view component is itself built from two components: the `SplitViewComponent` is used as a root element for the split view, and it can host multiple `ViewComponent` elements. The following is an example:

```html
<cx-split-view>
  <cx-view></cx-view>
  <cx-view></cx-view>
</cx-split-view>
```

The actual content of both components is completely flexible, and you do not have to nest `ViewComponent` elements as direct children under the `SplitViewComponent`. This is particularly useful when views are created from child routes, or from other child components. The following fragment illustrates such a DOM structure:

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

The `SplitViewComponent` does not interact directly with nested `cx-view` elements. The component does not have any knowledge about the underlying views, other then keeping track of the last _visible_ view component number. This information is exposed by the `SplitViewService`. The `cx-view` elements interact with the `SplitViewService` to register themselves and to toggle their visible state.

The `SplitViewService` is provided to each `SplitViewComponent` so that the various views and their corresponding states are isolated from other `SplitViewComponent` components. This allows you to have multiple, independent split views in the application.

## Styling

The split view layout is driven by CSS flexbox. To not break the content flow of nested flex items, it is important that any elements wrapping the cx-view elements are removed from the flexbox. This can be achieved by using the CSS `display` property, with the `content` value:

```css
.wrapper {
  display: contents;
}
```

## Split view animation

The split view component uses an animation to slide view elements in and out, when their visible state is toggled. The animations are driven by CSS animations, which you can further customize.

Special behavior is introduced in case a route driven split view is closed. The split view that is part of the route will be destroyed instantly by the Angular router, which would prevent an animation. To prevent destroying the element before the animation is done, the `ViewComponent.toggle()` is triggered, while the actual router link event is delayed with 500 millisecond.

## Column size configuration

The number of active parallel views is configurable by CSS variables. The default number is set to `2`, so that a two-column layout is used. This fits nicely with the relatively small layout that comes with the Spartacus style library. However, if you like to use a wider layout, and benefit from a three column layout, you can increase the max number of columns by changing the CSS variable:

```css
:root {
  --cx-max-views: 2;
}
```

Using CSS variables allows for maximum flexibility. You can specify different max views per screen size, as well as specific max view size configuration for individual split view components.

Spartacus defaults to a two-column view for tablet and larger screens, and single-column view for mobile screens.

## Gutter

A gutter can be specified to add a margin between split view elements. The gutter is drive by a CSS variable, to provide maximum configurability of various split views. The default gutter is set to 40px:

```css
:root {
  --cx-split-gutter: 40px;
}
```

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


The split view component manages the presentation of hierarchical content on a page. A split view consists of a two (or multiple) column interface showing multiple views in parallel. Split views are useful for navigating multiple levels of content hierarchy, like traversing a list of items to view each item.

The split view component is introduced with the "B2B Commerce Organization", also know as my company. This is a self service adminstration, that requires managing various entities such as business units, budgets, cost centers, etc. All those entities are presented as a list of items that can be opened and edited. The split view component gives a very comfortable layout to go through the list of items and edit them accordingly.

## Components

The split view component is build out of two components. The `SplitViewComponent` is used as a root element for the split view and can host multiple `ViewComponent` elements.

```html
<cx-split-view>
  <cx-view></cx-view>
  <cx-view></cx-view>
</cx-split-view>
```

The actual content of both components is completely flexible and it is not required to nest `ViewComponent` as direct children under the `SplitViewComponent`. This is particular useful when views are created form child routes, or by other child components. The following fragment illustrates such a DOM structure:

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

# Component interaction

The `SplitViewComponent` does not interact directly with nested `cx-view` elements. The component does not need any knowledge about the underlying views, other then keeping track of the last _visible_ view component number. This information is exposed by the `SplitViewService`. The `cx-view` elements interact with the `SplitViewService` to register itself and toggle it's visible state.

The `SplitViewService` is provided to each `SplitViewComponent`, so that the various views and their state is isolated to the `SplitViewComponent`. This allows to use multiple isolated split views in the application.

# Styling

The split view layout is driven by CSS Flexbox. To not break the content flow of nested flex items, it is important that any elements wrapping the cx-view elements are removed from the flexbox. This can be achieved by using the CSS `display` property, with the `content` value:

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

## mics

---

The `lastVisibleView` is bind to the host elements `active-view` attribute and `--cx-active-view` CSS variable.

. This component hosts one or multiple `ViewComponent`

A common example of such a requirement is when you manage a list of things, and want to view or edit a list item or manage related entities. This is a common pattern in the self service
organization adminstration

, an optional supplementary column, and a secondary pane of content. Changes in the primary column drive changes in the optional supplementary column, which affect the content itself. Split views are useful for navigating multiple levels of content hierarchy, like traversing the mailboxes and messages in Mail to view each message.

The split-view component is used to create a split view experience. A split view is a common UX pattern that displays multiple "view" side by side. It is designed for using two (or multiple) views on a single page. This is useful in a situation where you may need to continuously reference information from both views at the same time.

each one or move information from one to the other.

, where multiple related views are

The Split View displays multiple "views" side by side. It is designed for using tow (or multiple) views at the same time in a situation where you may need to continuously reference each one or move information from one to the other.

The split-view component supports an unlimited number of nested views. Nested views are visually rendered next to each other. The views can be rendered next to each other, but the max number of visible views can be limited as well. This is configurable in the CSS layer, so that the max number of views per split-view can be different for each component.

The basic structure of the split-view component is shown below:

`<cx-split-view> </cx-split-view>`
The UX pattern used for the split-view is driven by an initial view, which gets split into more views as soon as the user starts interacting with the initial and subsequent views. The views can be driven by routes, which means that you can navigate through the split views by using the browser history as well as share or bookmark split views.

The UI is implemented in the style layer, with only a few generic style rules. Most of the split view style is driven by CSS properties, so that alternative split-view styles can be introduced per page or component.

The max number of views per split-view on mobile is limited to 1 by default, where as on tablet (and higher) it is set to 2. Spartacus has a pretty narrow layout, which is why 2 is maximum, but customers could alter the layout to bring in more views in the same split-view at the time.

/\*\*

- The split-view component supports an unlimited number of nested views. The component
- is a host to those view components and doesn't add any restrictions to it's content;
- content is projected as-is.
-
- ```html

  ```

- <cx-split-view>
- <cx-view></cx-view>
- <cx-view></cx-view>
- <any-wrapper>
-     <cx-view></cx-view>
- </any-wrapper>
- </cx-split-view>
- ```

  ```

-
- The split view component is only concerned with tracking the underlying _visible_
- view components, so that the `lastVisibleView` can be updated accordingly. The actual
- visibility of views is controlled by CSS. To allow for maximum flexibility, the CSS
- implementation is using CSS variables. The `lastVisibleView` is bind to the
- `--cx-active-view` on the host, so that all descendants views will inherit the
- property conveniently.
  \*/

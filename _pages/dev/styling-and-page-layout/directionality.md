---
title: Directionality
feature:
- name: Directionality
  spa_version: 2.1
  cx_version: 1905
---

{% capture version_note %}
{{ site.version_note_part1 }} 2.1 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The directionality feature provides support for bidirectional text and layout. You can configure Spartacus to use a left-to-right (LTR) orientation, or a right-to-left (RTL) orientation.

Directionality is driven by language. Many languages are read from left to right, but some languages, such as Arabic and Hebrew, are read from right to left.

In Spartacus, the direction of the UI reflects the active language, so that directionality can work in a bidirectional experience. If your storefront contains both LTR and RTL languages, the active language is used to detect the direction automatically.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Breaking Changes

The changes made to the DOM and CSS are considered breaking changes, so the directionality feature can only be used if you enable it with the 2.1 feature flag and the 2.1 CSS version. For more information about the CSS version, see [Style Versioning]({{ site.baseurl }}/css-architecture/#style-versioning) in CSS Architecture.

## Configuring Directionality

You can configure directionality with the properties from the `DirectionConfig` interface. The default configuration contains the following properties:

```typescript
const defaultDirectionConfig: DirectionConfig = {
  direction: {
    detect: true,
    default: DirectionMode.LTR,
    rtlLanguages: ["he", "ar"],
  },
};
```

With the default configuration, all languages are mapped to the LTR direction, except for Hebrew (he) and Arabic (ar). Additional RTL languages can be added with configuration.

The default configuration should be suitable for most projects, but if you implement a storefront with an RTL orientation, you might consider changing the default direction to RTL and introducing some explicit LTR languages. The following is an example:

```typescript
ConfigModule.withConfig({
    direction: {
        default: DirectionMode.RTL,
        ltrLanguages: ['en'],
    },
} as DirectionConfig),
```

For more information on configuration, see [{% assign linkedpage = site.pages | where: "name", "global-configuration-in-spartacus.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/global-configuration-in-spartacus.md %}).

## Implementation Details

The implementation for directionality is based on the the HTML5 `dir` attribute that is added to the `html` element, as follows:

```html
<html dir="ltr">
  ...
</html>
```

The `dir` attribute can be added to multiple elements, but in Spartacus, only one direction is added, and that is to the `html` element. The HTML `dir` attribute then cascades the direction to all descendent elements, as well as to the CSS.

The actual text and layout direction is driven by CSS. Modern CSS patterns and techniques are designed to work in a bidirectional setup. A good example is Flexbox, which uses logical locations for the layout, such as "start" and "end". Spatial locations, such as "left" and "right", should be avoided because they do not support bidirectional layouts.

To control margins and padding, the style layer is build with logical properties. Instead of writing spatially-oriented margins and padding, logical properties allow you to write CSS rules that depend on the direction. The following shows an example of such properties:

```css
.sample-1 {
  /* add a margin to the start of an element */
  margin-inline-start: 10px;
}
.sample-2 {
  /* add a padding to the end of an element */
  padding-inline-end: 10px;
}
```

For more information on logical properties, see [CSS Logical Properties and Values](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Logical_Properties) in the MDN Web Docs.

## Icons

Icons require special attention for RTL languages. While most icons are universal, regardless of the direction, some icons actually must be flipped. Those icons that _express a direction_ would typically require flipping. A good example is icons for navigating through a carousel of products. As soon as the direction flips, these icons should flip as well.

You can provide a list of icon types that should be flipped for a certain direction by using the `flipDirection` configuration. The default configuration takes care of flipping those icons that should be flipped, as follows:

```typescript
export const defaultIconConfig: IconConfig = {
  icon: {
    flipDirection: {
      CARET_RIGHT: DirectionMode.RTL,
      CARET_LEFT: DirectionMode.RTL,
    },
  },
};
```

The `flipDirection` configuration can be extended to match any non-Spartacus icons.

The flip direction is mapped to an icon CSS class (`flip-at-ltr` and `flip-at-rtl`). A CSS flip rule is added for all icons that should be flipped.

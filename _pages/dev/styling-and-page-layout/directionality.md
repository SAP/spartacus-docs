---
title: Directionality
---

{% capture version_note %}
{{ site.version_note_part1 }} 2.1 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Spartacus supports bi-directional text and layout from version 2.1 onwards. The Left to Right (ltr) orientation has been extended with Right to Left (rtl) direction.

Directionality is driven by language. Most languages are ltr oriented, well known examples of rtl direction are Arabic and Hebrew.

The direction in Spartacus reflects the active language, so that directionality works in a multi-directional experience. If your storefront contains both ltr and rtl languages, the active language is used to detect the direction automatically.

## Breaking changes

The changes made to the DOM and CSS are considered a breaking change. Therefor, directionality can only be enabled by using the 2.1 feature flag and 2.1 CSS version.

## Direction Configuration

Directionality is [configurable](https://sap.github.io/spartacus-docs/global-configuration-in-spartacus/) with the properties from the `DirectionConfig` interface. The default configuration contains the following properties:

```typescript
const defaultDirectionConfig: DirectionConfig = {
  direction: {
    detect: true,
    default: DirectionMode.LTR,
    rtlLanguages: ["he", "ar"],
  },
};
```

With the default configuration, all languages are mapped to ltr direction, expect for Hebrew (he) and Arabic (ar). Additional rtl languages can be added with configuration.

The default configuration will be fine for most projects, but if you implement a rtl oriented storefront, you could consider to change the default direction and introduce some explicit ltr languages.

```typescript
ConfigModule.withConfig({
    direction: {
        default: DirectionMode.RTL,
        ltrLanguages: ['en'],
    },
} as DirectionConfig),
```

## Implementation details

The directionality implementation is based on the the html5 "dir" attribute, that is added to the `html` element:

```html
<html dir="ltr">
  ...
</html>
```

The dir attribute can be added to multiple elements, but in Spartacus is only one direction begin added to the `html` element.

The HTML dir attribute cascades the direction to all descendent elements, as well as to the CSS.

The actual text and layout direction is driven by CSS. Modern CSS patterns and techniques are designed to work in a bi-directional setup. A good example is Flexbox, which uses logical locations for the layout, such as "start" and "end". Physical locations, such as "left" and "right" should be avoided as they do not support bi-directional layouts.

To control margins and paddings, the style layer is build with [logical properties](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Logical_Properties). Instead of writing physical oriented margins and padding, logical properties allow to write css rules that depend on the direction. The following shows an example of such properties:

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

## Icons

Icons require special attention for rtl languages. While most icons are universal regardless of the direction, some icons actually must be flipped. Those icons that _express an direction_ are typically candidate to be flipped. A good example are icons to navigate through a carousel of products. As soon as the direction flips, these icons should flip simultaneously.

A configuration is added to introduce a list of icon types that should be flipped for a certain direction. The default configuration takes care of flipping those icons that should be flipped:

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

The `flipDirection` configuration can be extended to match any non-spartacus icons.

The flip direction is mapped to an icon CSS class (`flip-at-ltr` and `flip-at-rtl`). A CSS flip rule is added for all icons that should be flipped.

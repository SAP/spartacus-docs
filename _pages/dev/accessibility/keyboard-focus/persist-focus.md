---
title: Persist Focus
---

{% capture version_note %}
{{ site.version_note_part1 }} 2.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The `cxFocus` directive provides persistence of the focused state. This is useful when a group of focusable elements get refocused, or even recreated. This happens often when the DOM is constructed with an `*ngIf` or `*ngFor`. Whenever the data is changed, the focus is naturally lost. To overcome this issue, the persisted focus is provided.

The focus state is based on a configured key. The key is used to store the focus state. The focus state can be part of an optional focus group, so that the state is shared and remembered for the given group.

To detect the persistence for a given element, the persistence key is stored on the element in the `data-cx-focus` data attribute. The following is an example:

```html
  <button data-cx-focus="myKey"></button>
```

Other keyboard focus directives can read and query this key to understand whether the element should retrieve focus.

The persisted focus is used when an element is created, and it is explicitly used by the auto focus feature.

### Extensibility

The persisted focus logic is driven by the `PersistFocusService`. This service can be customized.

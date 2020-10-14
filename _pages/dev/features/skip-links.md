---
title: Skip Links
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.5 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

Skip links allow users to quickly navigate to important areas of a page using the keyboard. You activate skip links by pressing the tab key when a page is loaded, and before any other user interaction takes place.

When a user presses the tab key, a button appears at the top of the page, with the label "Skip to _section_". Each time the user presses the tab key, the text updates to indicate the next available section to skip to. The user can then select a section to skip to by pressing the return key. When all sections have been skipped through, pressing the tab key again closes the skip link button. Users can navigate forward and backward through the available skip links by using the tab key and shift+tab key combination, respectively.

With skip links, users can access important content on a page without needing to tab through every element on a page to reach the specific element they wish to interact with.

## Configuring Skip Links

You can configure skip links with the `SkipLinkConfig`, which is defined in `skip-link-config.ts`. The `SkipLinkConfig` contains the following properties:

- `key: string` identifies the CMS component or slot.
- `i18nKey: string` is the title of the section that is being skipped to.
- `target?: HTMLElement` indicates the target element to be skipped to. Note, this property is not required in the `SkipLinkConfig` because the target is identified automatically by the `key` property.
- `position?: SkipLinkScrollPosition` indicates a position to skip to that is either before or after the target element.

The following is an example configuration:

```ts
const exampleSkipLinkConfig: SkipLinkConfig = {
  skipLinks: [
    {
      key: 'SiteContext',
      i18nKey: 'skipLink.labels.header',
    },
    {
      key: 'BottomHeaderSlot',
      position: SkipLinkScrollPosition.AFTER,
      i18nKey: 'skipLink.labels.main',
    },
    { 
      key: 'Footer',
      i18nKey: 'skipLink.labels.footer'
    },
  ]
};
```

## Adding a Configuration to the Storefront

Skip links can be configured by adding the configuration to the `skipLinks` setting in a config module. The following is an example:

```ts
ExampleConfigModule.withConfig(<CmsConfig>{
  ...
  skipLinks: exampleSkipLinkConfig
  ...
});
```

**Note:** To deactivate all skip links, pass an empty array to the `skipLinks` setting, as follows:

```ts
skipLinks: []
```

## Default Skip Link Configuration

Spartacus provides a default skip link configuration in `default-skip-link-config.ts`. You can override the defaults by setting `skipLinks` in the config module in `app.module.ts`.

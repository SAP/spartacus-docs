---
title: Skip Links
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.4 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

Skip Links allow users to quickly navigate to important areas of a page using the keyboard.

Skip links are activated by pressing the tab key when a page is loaded, and before any other user interaction takes place. When a user presses the tab key, a button appears at the top of the page, with the label "Skip to _section_". Each time the user presses the tab key, the text updates to indicate the next available location to skip to. The user can then select a section to skip to by pressing the return key. When all sections have been skipped through, pressing the tab key again closes the skip link button. Users can navigate forward and backward through the available skip links by using the tab key and shift+tab key combination, respectively.

With skip links, users can access important content on a page without needing to tab through every element on a page to reach the specific element they wish to interact with.

### Configuring Skip Links

The `SkipLinkConfig` is how Spartacus configures skip links.

`key: string` - Identifier of the CMS Component or Slot.

`i18nKey: string` - Title of the section being skipped to.

`position?: SkipLinkScrollPosition` - Skip to position before or after target element.

`target?: HTMLElement` - Target element to be skipped to (not necessary in config as target is identified automatically by `key`).

### Example Configuration

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

### Adding Configuration to Storefront

Skip links can be configured by adding the configuration to the `skipLinks` setting in a Config Module.

```ts
ExampleConfigModule.withConfig(<CmsConfig>{
  ...
  skipLinks: exampleSkipLinkConfig
  ...
});
```

Note: To deactivate all skip links, pass an empty array to the `skipLinks` setting (ie. `skipLinks: []`).

## Default Skip Link Configuration

Spartacus ships with a default skip link configuration that adds skip links for these sections:

`Header`

`Main Content`

`Footer`

`Product Facets`

`Product List`

These can be overridden by setting `skipLinks` in the Config Module.

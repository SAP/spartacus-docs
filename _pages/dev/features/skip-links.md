---
title: Skip Links (DRAFT)
---

## Overview

Skip Links allow users to quickly navigate to important areas of a page via the keyboard.

## Usage

Skip links are activated by pressing the `tab` key on page load and before any other user-interaction. They appear as a button with "Skip to `section`" text to indicate the content that the user will navigate to upon pressing the `return` key. The user can navigate through skip links with the `tab` and `shift+tab` keys respectively.

With Skip Links, the user can access important content on the page without needing to press the `tab` key as many times to navigate to the exact element they want to interact with.

### Skip Link Config

The `SkipLinkConfig` is how Spartacus configures skip links.

`key: string` - Identifier of the CMS Component or Slot.

`i18nKey: string` - Title of the section being skipped to.

`position?: SkipLinkScrollPosition` - Skip to position before or after target element.

`target?: HTMLElement` - Target element to be skipped to (not necessary in config as target is identified automatically by `key`).

### Example Configuration

```
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

```
ExampleConfigModule.withConfig(<CmsConfig>{
  ...
  skipLinks: exampleSkipLinkConfig
  ...
});
```

Note: To deactivate all skip lnks, pass an empty array to the `skipLinks` setting (ie. `skipLinks: []`).

## Default Skip Link Configuration

Spartacus ships with a default skip link configuration that adds skip links for these sections:

`Header`

`Main Content`

`Footer`

`Product Facets`

`Product List`

These can be overridden by setting `skipLinks` in the Config Module.
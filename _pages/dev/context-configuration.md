---
title: Context Configuration (DRAFT)
---

The `context` parameter allows for the configuration of the application by appending attribute values to the Storefront URL.
In addition to this, it provides the flexibility of being able to change these values dynamically.

**Ex**: Assume a `language` attribute is used and its value is set to English.
When the application is loaded, the Storefront URL will contain this property and the translations provided will be in English.

`context` can be found in the `app.module.ts` and looks as such:

```typescript
  context: {
    baseSite: [
      'electronics-spa',
      'electronics',
      'apparel-de',
      'apparel-uk',
    ],
    urlParameters: ['baseSite', 'language', 'currency'],
  },
 ...
```

For a better understanding of how these properties work, each one will be explained.

### Context Parameters

The context parameters take a list of attributes and their defined values.

The definition for `language` is provided below:

```typescript
 context: {
   language: ['en', 'de', 'ja', 'zh'],
   ...
```

Values are list of potential values that can be used by the application.
This property provides the capability of switching between values when required.

In the case above, the languages available are `en (English), de (German), ja (Japanese), and zh (Chinese)`.

**Note**: The default value will be the first argument in the list which is `en (English)` in this case.

#### urlParameters

`urlParameters` will take a list of arguments that will be used to produce the context. The context is then appended to the Storefront
URL.

Assume that the Storefront URL is `https://localhost:4200`.

Assume the configuration is as follows:

```typescript
  context: {
    baseSite: [
      'electronics-spa', //Selected by default as it is the first argument in the list
      'electronics',
    ],
    language: [
      'en'
    ],
    currency: [
      'USD'
    ],
    urlParameters: ['baseSite', 'language', 'currency'],
  },
 ...
```

The result of this will be `https://localhost:4200/electronics-spa/en/USD`.

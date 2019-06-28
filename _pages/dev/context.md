---
title: Context Configuration
---

`context` allows for the configuration of the application by appending attribute values to the base URL.

**Ex**: Assume a `language` attribute is being used and its value is set to English.
When the website is now loaded, the site URL will contain this property and the translations provided will be in English.

In addition to this, it provides the flexibility of being able to change these values dynamically.

`context` can be found in the `app.module.ts` and looks as such:

```typescript
  context: {
      parameters: {
        baseSite: {
          values: [
            'electronics-spa',
            'electronics',
            'apparel-de',
            'apparel-uk',
          ],
          persistence: 'route',
        },
      },
    urlEncodingParameters: ['baseSite', 'language', 'currency'],
  },
 ...
```

For a better understanding of how this works, every property will be explained.

### Parameters

The `parameters` property will take a list of attributes and their defined values.
The definition for `language` is provided below:

```typescript
 parameters: {
        [language]: {
          values: ['en', 'de', 'ja', 'zh'],
          default: 'en',
          persistence: 'route',
        },
        ...
```

#### Values

`values` will take a list of potential values that can be used.

In the case above, the languages available are `en (English), de (German), ja (Japanese), and zh (Chinese)`.
Storing this list allows for the ability to easily switch between languages when required.

**Note**: If there is no `default` value provided, the default value will be the first argument in the list which is `en (English)` in this case.

#### Default

`default` selects the specific option for the application when it is first loaded.

In the case above, the default language is `en (English)`.

**Note**: The `default` must be in the list of `values` provided.

#### Persistence

`persistence` determines when the context attributes will be applied.
When `route` is used, these arguments will be used throughout the entire application.
In the case above, the value is set to `route` and therefore it is applied site-wide.

#### urlEncodingParameters

`urlEncodingParamters` will take a list of arguments that will be used to produce the context. The context is then appended to the application's 
URL.

Assume that the Storefront URL is `localhost:4200`.

Assume the configuration is as follows:

```typescript
  context: {
      parameters: {
        baseSite: {
          values: [
            'electronics-spa', //Selected by default as it is the first argument in the list
            'electronics',
          ],
          persistence: 'route',
        },
        language: {
          values: [
            'en'
          ],
          persistence: 'route',
        },
        currency: {
          values: [
            'USD'
          ],
          persistence: 'route',
        },
      },
    urlEncodingParameters: ['baseSite', 'language', 'currency'],
  },
 ...
```

The result of this will be `localhost:4200/electronics-spa/en/USD`.

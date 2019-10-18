---
title: Context Configuration
---

You can configure your application by defining `context` properties, such as base site, language, and currency. The values of these properties are appended to the storefront URL, and the application is configured according to these values when you load the URL.

For example, when you access `https://localhost:4200/electronics-spa/en/USD`, the application loads the `electronics-spa` base site, sets the site language to English (`en`), and sets the currency to US dollars (`USD`).

## Context Properties

The `context` properties are located in `app.module.ts`.

The `baseSite`, `language`, and `currency` properties are arrays that take the first element in the array as the default value.

For example, the `language` property is defined as follows:

```typescript
 context: {
   language: ['en', 'de', 'ja', 'zh'],
   ...
```

In this case, the first element is `en`, so English is set as the default language for the application. The other elements in the array indicate the potential values that can be used by the application.

The `urlParameters` property takes the values of the other `context` properties to create the structure of the context that is appended to the storefront URL.

For example, if your storefront URL is `https://localhost:4200`, then it becomes `https://localhost:4200/electronics-spa/en/USD` with the following `context` configuration:

```typescript
  context: {
    baseSite: [
      'electronics-spa', //Selected by default because it is the first element in the list
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

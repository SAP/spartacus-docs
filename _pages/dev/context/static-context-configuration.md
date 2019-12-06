---
title: Static Multi-Site Configuration
---

You can configure your application by defining `context` properties, such as base site, language, and currency. When you append the values of these properties to the storefront URL, the storefront is configured based on these values.

For example, when you access `https://localhost:4200/electronics-spa/en/USD/`, the application loads the `electronics-spa` base site, sets the site language to English (`en`), and sets the currency to US dollars (`USD`).

The `context` properties also set the default values for the language and currency drop-down lists, which you can use to change the context of the storefront dynamically.

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

For example, if your storefront URL is `https://localhost:4200`, then it becomes `https://localhost:4200/electronics-spa/en/USD/` with the following `context` configuration:

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
    urlParameters: ['baseSite', 'language', 'currency']
  },
 ...
```

**Note:** You can change the structure of the context in the URL by changing the order of the elements in the `urlParameters` property. For example, if you change the `urlParameters` property to `urlParameters: ['currency', 'language', 'baseSite']`, then the URL becomes `https://localhost:4200/USD/en/electronics-spa/`.

## Enabling Context in the Storefront URL

By default, context does not appear in the Spartacus storefront URL.

You may wish to have context appear in the storefront URL as a way of optimizing SEO, or for maintaining URL compatibility with a previous storefront. For example, you might want search bots to classify different versions of a storefront based on the language and currency in the URL. Or you may be migrating to Spartacus from another storefront that includes context in the storefront URL, and you wish to maintain previously established page rankings.

To include the context in the URL, add the `urlParameters` property to the `context` property in `app.modules.ts`. The following is an example:

```ts
  context: {
    baseSite: ['electronics-spa'],
    urlParameters: ['baseSite', 'language', 'currency']
  },
```

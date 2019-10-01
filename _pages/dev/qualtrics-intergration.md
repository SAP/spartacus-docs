---
title: Qualtrics Integration (DRAFT)
---

Qualtrics is integratable to Spartacus. Users can set-up their qualtrics seamlessly and we facilate the usage on a Single-Page Application (SPA).

## How to enable Qualtrics

We have Qualtrics disabled by default. To enable Qualtrics, you simply need to add the following statement to the features config in app.modules.ts.

- `qualtrics` flag: Allows you to enable or disable qualtrics.

```ts
B2cStorefrontModule.withConfig({
  [...]
  features: {
    [...]
    qualtrics: true
  }
})
```

## Using Qualtrics to enable surveys

[...]
continuation...

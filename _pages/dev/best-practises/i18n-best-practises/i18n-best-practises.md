---
title: I18n Best Practices
---

Spartacus project has default translations. It is obvious that in each project we will need to add our own translations.

The best place to do it is to create file `i18n.ts` in `src/app/spartacus/configurations` folder and export it as `I18nConfig`. We sincerely suggest to add only global translations here and to add all the rest related to individual modules translations in those modules (describe in modules-best-practices).

For global translations use create `i18n-assets` inside `assets` and than create seperate folder for each language, example: `en`, `de`, etc.

`i18n.ts` example:

```
export const customI18nConfig: I18nConfig = {
    i18n: {
        backend: {
            loadPath: 'assets/i18n-assets/{{lng}}/{{ns}}.json',
        },
        chunks: {
            common: ['custom_common_chunk',],
            errors: ['custom_error_chunk'],
        },
        fallbackLang: 'en',
    },
}),
```

Once we will create the file and provide our own customization we have to provide it in `src/app/spartacus/spartacus-configuration.module.ts`:

```
@NgModule({
    ...
    providers: [
        provideConfig(customI18nConfig),
    ...

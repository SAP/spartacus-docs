---
title: Technical Changes in Spartacus 2211.19
---

The Spartacus migration schematics scan your codebase and inject code comments whenever you use a reference to a Spartacus class or function that has changed its behavior in version 2211.19, or where your class or function has been replaced by a different class or function, or where the API has changed (for example, where a required parameter has been added or removed). After the migration schematics have finished running, inspect your code for comments that begin with `// TODO:Spartacus` to see the areas of your code that have been identified as possibly needing further work to complete your migration.

**Note:** If you happen to have in your codebase a custom function or class that has the same name as a function or class that has changed or been removed in the Spartacus public API, there is a chance that the migration script could identify your custom function or class as needing to be updated. In this case, you can ignore and remove the comment.

## Replacing the <img> tag with the <picture> tag

The media component is now designed to display images using the `<picture>` element. This enables responsive image selection for modern browsers that have support for `srcset` and media queries. The media component falls back to using the `<img>` tag for legacy browsers, when `srcset` is not provided, or when you explicitly declare in the `SpartacusConfigurationModule` to use `<img>` instead of `<picture>`. This approach improves page load performance and user experience by ensuring that the most appropriate image is loaded, based on the viewport or display conditions.

### Configuration

To enable the legacy approach of using `<img>` tags by default, you need to provide `MediaConfig` in the `SpartacusConfigurationModule` and set `useLegacyMediaComponent` to `true`. The following is an example:

```ts
provideConfig(<MediaConfig>{
    useLegacyMediaComponent: true,
})
```

The `<img>` tag will then be used instead of `<picture>`. When `useLegacyMediaComponent` is not provided in the config, the `<picture>` tag will always be used, as long as browser support is available and the `srcset` for the given component is provided by the back end.

### MediaSourcesPipe

The `MediaSourcesPipe` is designed to parse a string containing multiple image sources and their associated widths, and convert these into an array of objects. Each object represents a media condition (`media`) and the corresponding image source set (`srcset`) for that condition. This array can then be used to render `<source>` elements within a `<picture>` tag, allowing browsers to select the most appropriate image source based on the current viewport width.

## New Default for cacheSize in Server-Side Rendering Optimization

The default `cacheSize` is now set to `3000` entries. Before version 2211.19 of Spartacus, no default value was set, which could result in unlimited cached pages for those pages that fell back to CSR due to timeout. This could potentially lead to a memory leak.

The default value is based on a few known values and a few assumptions. In SAP Commerce Cloud, the minimum pod size is 3 GB. To avoid processes from restarting, as a result of exceeding the default upper limit of 60% for memory usage, a safer, lower limit of 50% is set. Consequently, the usable memory that is available by default is calculated to be 3 GB multiplied by 50%, with a result of 1.5 GB. The next calculation considers a typical HTML page to have a size of approximately 350 KB. However, you may have even larger rendered HTML pages in your project. As a precaution, it is assumed that HTML pages could be up to 150% larger, resulting in a maximum page size of 525 KB. Accordingly, the calculation for the default `cacheSize` is 1.5 GB divided by 525 KB, leading to a result of 3070. This value is rounded down to provide the final `cacheSize` default of `3000` entries.

## New Default Logger for Standardized SSR Logging

Standardized SSR logging is now enabled by default. It uses the `DefaultExpressServerLogger`, which is the Spartacus default implementation of `ExpressServerLogger`. The `DefaultExpressServerLogger` takes care of proper formatting, and recognizes whether the output should be human-readable, or read by monitoring tools. The logger not only logs the messages, it also provides information about the related request that initiated the rendering process. The `logger` property is optional, and you can use it to provide your own implementation of `ExpressServerLogger`.

For more information, see [Standardized SSR Logging](https://help.sap.com/docs/SAP_COMMERCE_COMPOSABLE_STOREFRONT/eaef8c61b6d9477daf75bff9ac1b7eb4/a54ac5aff3f6434aa1ed08a68e25084b.html?locale=en-US&version=6.8) and [Server-Side Rendering Optimization](https://help.sap.com/docs/SAP_COMMERCE_COMPOSABLE_STOREFRONT/eaef8c61b6d9477daf75bff9ac1b7eb4/c48860c28fbf443d906c682a2aed23b2.html?locale=en-US&version=6.8).

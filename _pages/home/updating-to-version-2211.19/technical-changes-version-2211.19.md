---
title: Technical Changes in Spartacus 2211.19
---

The Spartacus migration schematics scan your codebase and inject code comments whenever you use a reference to a Spartacus class or function that has changed its behavior in version 2211.19, or where your class or function has been replaced by a different class or function, or where the API has changed (for example, where a required parameter has been added or removed). After the migration schematics have finished running, inspect your code for comments that begin with `// TODO:Spartacus` to see the areas of your code that have been identified as possibly needing further work to complete your migration.

**Note:** If you happen to have in your codebase a custom function or class that has the same name as a function or class that has changed or been removed in the Spartacus public API, there is a chance that the migration script could identify your custom function or class as needing to be updated. In this case, you can ignore and remove the comment.

## New Default for cacheSize in Server-Side Rendering Optimization

The default `cacheSize` is now set to `3000` entries. Before version 2211.19 of Spartacus, no default value was set, which could result in unlimited cached pages for those pages that fell back to CSR due to timeout. This could potentially lead to a memory leak.

The default value is based on a few known values and a few assumptions. In SAP Commerce Cloud, the minimum pod size is 3 GB. To avoid processes from restarting, as a result of exceeding the default upper limit of 60% for memory usage, a safer, lower limit of 50% is set. Consequently, the usable memory that is available by default is calculated to be 3 GB multiplied by 50%, with a result of 1.5 GB. The next calculation considers a typical HTML page to have a size of approximately 350 KB. However, you may have even larger rendered HTML pages in your project. As a precaution, it is assumed that HTML pages could be up to 150% larger, resulting in a maximum page size of 525 KB. Accordingly, the calculation for the default `cacheSize` is 1.5 GB divided by 525 KB, leading to a result of 3070. This value is rounded down to provide the final `cacheSize` default of `3000` entries.

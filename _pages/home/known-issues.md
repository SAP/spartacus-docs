---
title: Known Issues
---

Updated March 18th, 2022

## An update in the hamburgers npm package causes build failure in Spartacus

The latest update to the hamburgers npm package (version 1.2.1) causes builds of Spartacus SASS files to fail. This update to the hamburgers library uses a function that is not supported by the version of SASS (1.29) that was used by older versions of Spartacus 3.4 and 4.3. This has been addressed in the most recent patch releases for Spartacus (`3.4.8` and `4.3.1`), but if you are unable to migrate to these patches, the suggested workaround is to manually downgrade your version of the hamburgers library.

In `package.json`, you can either set `"hamburgers": "~1.1.3"`, or you can use resolutions in `package.json` to force hamburgers 1.1.3, as follows:

```json
"resolutions": {
    "hamburgers": "1.1.3"
  },
```

**Note:** It is important to commit `yarn.lock` to your repo.

For further information, see [Spartacus GitHub Issue 15389](https://github.com/SAP/spartacus/issues/15389).

---
title: Configuring the Base URL
---

You can configure the base URL with a special HTML `meta` tag, instead of hard coding it with `provideConfig()` in the Spartacus configuration. This allows you to deploy to different environments with only one compiled JavaScript application, because you only need to modify the `meta` tag of the `index.html` file for each environment.

The following example shows how the `meta` tag can be configured in the `index.html` file:

```html
<meta name="occ-backend-base-url" content="https://my-custom-backend-url:8080" />
```

**Note**: The value of the `backend.occ.baseUrl` from the `provideConfig()` in `app.module.ts` takes precedence over the value from the `meta` tag, so if you want the base URL to be driven dynamically by the meta tag, do not define the `baseUrl` in the `provideConfig()`.

**Note**: The `content` attribute of the `meta` tag is ignored in the following cases:

- When it is an empty string, such as in the following example:

  ```text
  <meta name="occ-backend-base-url" content="" />
  ```

- When it contains a special placeholder, such as in the following example:

  ```text
  <meta name="occ-backend-base-url" content="OCC_BACKEND_BASE_URL_VALUE" />
  ```

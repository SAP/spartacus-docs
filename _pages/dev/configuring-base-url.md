---
title: Configuring the Base URL
---

You can configure the base URL with a special HTML `meta` tag, instead of hard coding it in the `withConfig` method of the B2cStorefrontModule. This allows you to deploy to different environments with only one compiled JavaScript application, because you only need to modify the `meta` tag of the `index.html` file for each environment.

The following example shows how the `meta` tag can be configured in the `index.html` file:

```html
<meta name="occ-backend-base-url" content="https://my-custom-backend-url:8080" />
```

The corresponding `app.module.ts` file appears as follows:

```typescript
  imports: [
    BrowserModule, B2cStorefrontModule.withConfig({
      backend: {
        occ: {
          baseUrl: 'https://electronics.local:9002', // This value is overridden by the value from the meta tag.
          prefix: '/rest/v2/'
        }
      }
    })
  ],
```

**Note**: The value of the `backend.occ.baseUrl` from the `withConfig` method takes precedence over the value from the `meta` tag.

**Note**: The `content` attribute of the `meta` tag is ignored in the following cases:

* When it's an empty string, such as in the following example:

  ```
  <meta name="occ-backend-base-url" content="" />
  ```
* When it contains a special placeholder, such as in the following example:

  ```
  <meta name="occ-backend-base-url" content="OCC_BACKEND_BASE_URL_VALUE" />
  ```

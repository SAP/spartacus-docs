---
title: Adding the Spartacus App to the Home Screen
---

The Add to Home Screen feature allows Spartacus to display a banner prompt that lets users install the progressive Spartacus app on their mobile or desktop devices.

By default, the PWA configuration for Spartacus is the following:

```typescript
export const defaultPWAModuleConfig: PWAModuleConfig = {
  pwa: {
    enabled: false,
    addToHomeScreen: false,
  },
};
```

To enable the Add to Home Screen feature, provide the configuration above in your app.module.ts file with both `pwa` parameters set to `true`, as follows:

```typescript
  pwa: {
    enabled: true,
    addToHomeScreen: true,
  },
```

Once you provide the configuration above and recompile your app, you should see the following:

![add to home]({{ site.baseurl }}/assets/images/add_to_home.png)

Make sure your shell app is running in PWA mode.

---
title: Add to home for PWA (Draft)
---

The add to home feature will allow Spartacus to display a banner prompt to allow users
to install the progressive Spartacus app to their mobile or desktop devices.

By default, default PWA configuration for Spartacus is the following:

```
export const defaultPWAModuleConfig: PWAModuleConfig = {
  pwa: {
    enabled: false,
    addToHomeScreen: false,
  },
};
```

To enable the add to home feature, provide the configuration above in your app.module.ts file with both pwa parameters set to `true`.

```
  pwa: {
    enabled: true,
    addToHomeScreen: true,
  },
```

Once you provide the configuration above and recompile your app, you should see the following:

![add to home]({{ site.baseurl }}/assets/images/add_to_home.png)

Make sure your shell app is running in PWA mode.

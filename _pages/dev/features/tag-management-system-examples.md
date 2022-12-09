---
title: Tag Management System Examples
---

There are a number of popular solutions that you can integrate with the Spartacus tag management system (TMS). The following sections provide examples of how to set up Spartacus with some of most common TMS solutions, such as Google Tag Manager (GTM), Google Analytics (GA), and Adobe Experience Platform Launch (AEPL).

As mentioned in the "Setup" section of the main [{% assign linkedpage = site.pages | where: "name", "tag-management-system.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/tag-management-system.md %}) documentation, if you are using GTM or AEPL, Spartacus can handle the script "injection" to the DOM for you. However, if you prefer to have more control over the process, or if you have a complex use case, you can use the examples in the following sections to implement the setup according to your needs.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Google Tag Manager

GTM requires an *immediately invoked function expression* (IIFE) to be included in the DOM, which you can do by adding a script to your `index.html`. The following is an example:

```html
<!-- Google Tag Manager -->
<script>
  (function (w, d, s, l, i) {
    w[l] = w[l] || [];
    w[l].push({ "gtm.start": new Date().getTime(), event: "gtm.js" });
    var f = d.getElementsByTagName(s)[0],
      j = d.createElement(s),
      dl = l != "dataLayer" ? "&l=" + l : "";
    j.async = true;
    j.src = "https://www.googletagmanager.com/gtm.js?id=" + i + dl;
    f.parentNode.insertBefore(j, f);
  })(window, document, "script", "dataLayer", "GTM-XXXX");
</script>
<!-- End Google Tag Manager -->
```

For more information, see the [Google Tag Manager documentation](https://developers.google.com/tag-manager/quickstart).

## Google Analytics

Google Analytics observes the same `dataLayer` as GTM, so you can set up GA in Spartacus the same way you set up GTM. In this case, you include a GA-specific script in your `index.html`. The following is an example:

```html
<!-- Global site tag (gtag.js) - Google Analytics -->
<script
  async
  src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"
></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag() {
    dataLayer.push(arguments);
  }
  gtag("js", new Date());

  gtag("config", "GA_MEASUREMENT_ID");
</script>
```

For more information, see the [Google Analytics documentation](https://developers.google.com/analytics/devguides/collection/gtagjs).

## Google Tag Manager and Google Analytics

Running both GTM and GA *at the same time* is possible in Spartacus, although you should be aware of the potential clashes that may arise. This section only focuses on enabling both solutions in Spartacus. Any description of potential issues when running GMT and GA at the same time is out-of-scope for this document.

The following procedure describes how to set up GTM and GA to run in Spartacus at the same time.

1. Set up GMT, as described in the [Google Tag Manager](#google-tag-manager) section, above.

2. Set up GA, as described in the [Google Analytics](#google-analytics) section, above.

3. Create a new collector service, such as `ga-collector.service`.

    The logic should be similar to the logic in the Spartacus `GtmCollectorService`, so you can simply extend `GtmCollectorService`, as shown in the following example:

    ```typescript
    import { Injectable } from "@angular/core";
    import { GtmCollectorService } from "@spartacus/tracking/tms/gtm";

    @Injectable({ providedIn: "root" })
    export class GaCollectorService extends GtmCollectorService {}
    ```

4. Configure the `GaCollectorService` with the other TMS solutions, as shown in the following example:

    ```typescript
    import { NgModule } from '@angular/core';
    import {
      CartAddEntrySuccessEvent,
      CartRemoveEntrySuccessEvent,
      provideConfig,
    } from '@spartacus/core';
    import { TmsConfig } from '@spartacus/tracking/tms/core';
    import { GaCollectorService } from './ga-collector.service';

    @NgModule({
      imports: [
        ...,
      ],
      providers: [
        ...,
        provideConfig({
          tagManager: {
            ...,
            ga: {
              collector: GaCollectorService,
              events: [...],
            },
          },
        } as TmsConfig),
      ],
    })
    export class AppModule {}
    ```

    You should now be able to run both GTM and GA in Spartacus at the same time.

## Adobe Experience Platform Launch (AEPL)

AEPL requires you to include a code snippet provided by AEPL, which you can add to your `index.html`. The code snippet should look something like the following example:

```html
<script
  src="//assets.adobedtm.com/xxxxxxx/yyyyyyy/launch-zzzzzzz-development.min.js"
  async
></script>
```

For more information, see the [Adobe Experience Platform Launch documentation](https://experienceleague.adobe.com/docs/launch/using/get-started/quick-start.html?lang=en#libraries-and-builds).

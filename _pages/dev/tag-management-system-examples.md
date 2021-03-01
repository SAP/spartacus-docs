# Tag Management System Examples

This doc will briefly explain how to setup some of the most useful TMS solution on the market. For more details on the configuration and extensibility part, please check the main [TMS docs](tag-management-system.md).

## Google Tag Manager (GTM)

Spartacus offers an out of the box support for GTM, and in order to configure it you need to first include a code snippet provided by GTM to your `index.html`. The code snippet will look something like this:

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

For more details on this, please check the [official docs](https://developers.google.com/tag-manager/quickstart).

## Google Analytics (GA)

As both GA and GTM observe the same `dataLayer`, you can leverage Spartacus' out-of-the-box support for GTM. You just need to include a different code snippet to your `index.html`.

As per the [official GA docs](https://developers.google.com/analytics/devguides/collection/gtagjs), the code snippet should looks something like:

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

## GTM and GA

Running both GTM and GA _at the same time_ is possible if you have a need for such a use case, although you should be aware of all the potential clashes of doing so.
We won't go in the details on this topic, and we will focus on enabling both in Spartacus.

As Spartacus offers an out-of-the-box support for GTM, you can just refer to [this section](#Google-Tag-Manager-GTM).

Enabling GA will requires you to do this [step](#Google-Analytics-GA), plus some coding.
First, you can create a new collector service, e.g. `ga-collector.service`. Because the logic is similar to Spartacus' `GtmCollectorService` (from `@spartacus/tracking/tms/gtm`), you can just extend it:

```typescript
import { Injectable } from "@angular/core";
import { GtmCollectorService } from "@spartacus/tracking/tms/gtm";

@Injectable({ providedIn: "root" })
export class GaCollectorService extends GtmCollectorService {}
```

Then, configure it with the other TMS solutions, like so:

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

## Adobe Experience Launch Platform (AELP)

Spartacus offers an out of the box support for AELP, and in order to configure it you need to first include a code snippet provided by AELP to your `index.html`. The code snippet will look something like this:

```html
<script
  src="//assets.adobedtm.com/xxxxxxx/yyyyyyy/launch-zzzzzzz-development.min.js"
  async
></script>
```

For more details on this, please check the [official docs](https://experienceleague.adobe.com/docs/launch/using/get-started/quick-start.html?lang=en#libraries-and-builds).

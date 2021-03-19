---
title: Tag Management System
feature:
- name: Tag Management System
  spa_version: 3.2
  cx_version: n/a
---


{% capture version_note %}
{{ site.version_note_part1 }} 3.2 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Overview

The Spartacus tag management system (TMS) allows you to set up a tag manager, and to specify which Spartacus events should be passed to the configured TMS. Both Google Tag Manager (GTM) and Adobe Experience Launch Platform (AELP) are supported by Spartacus out-of-the-box, while other tag managers can easily be plugged in.

Spartacus supports running multiple tag manager integrations in parallel, and you can decide which events should be collected by each of the supported tag management solutions.

**Note:** To work with the Spartacus tag management system, you should also be familiar with the Spartacus events service, which the TMS relies on. For more information, see [Events Service]({{ site.baseurl }}{% link _pages/dev/event-service.md %}).

## Setup

If you are working with Google Tag Manager, you can provide the GTM ID through the `gtmId` configuration property. Spartacus runs the _immediately invoked function expression_ (IIFE) that is provided by GTM, and this "injects" the GTM script into the DOM. For more details, see the [Configuration](#configuration) section, below.

If you are working with Adobe Experience Launch Platform, you can provide the script URL through the `scriptUrl` configuration property, and Spartacus will use this URL to "inject" the script into the DOM. For more details, see the [Configuration](#configuration) section, below.

If you do not provide any configuration properties, Spartacus assumes that you want to have control over the "injected" scripts, in which case, Spartacus simply starts collecting events and populating the data layer.

Although it is not possible to cover the set up instructions for every existing tag management solution, in many cases, the process requires you to specify a certain `<script>` tag in your `index.html`, which loads and bootstraps the TMS. For instance, the following is an example of how GTM is configured:

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
  })(window, document, "script", "dataLayer", "GTM-XXXXXXX");
</script>
<!-- End Google Tag Manager -->
```

For see additional setup examples with Google Analytics and AELP, see [Tag Management System Examples]({{ site.baseurl }}{% link _pages/dev/tag-management-system-examples.md %}).

## Configuration

The following TMS configuration options are available:

- `debug` is a boolean that enables the console log. It should only be enabled in development mode.
- `dataLayerProperty` is a string that names the data layer object. You only need to provide the `dataLayerProperty` if you are not using the default name for the default data layer data structure. In the case of GTM, the default data structure for the data layer is an array-like object, and in the case of AELP, it is an empty object.
- `events` is an `AbstractType<CxEvent>[]` that lists all the event classes that are to be collected and pushed to the data layer.
- `collector` is a `Type<TmsCollector>`, and is the custom collector service implementation.
- `gtmId` is only available for GTM. When you provide `gtmId`, Spartacus handles the script "injection" and bootstrapping for you.
- `scriptUrl` is only available for AELP. When you provide `scriptUrl`, Spartacus handles the script "injection" and bootstrapping for you.

To start collecting events, you need to import the `BaseTmsModule.forRoot()`, and provide a configuration. Optionally, you can import the `AepModule` or `GtmModule` to leverage default configuration in Spartacus.

The following is an example of a full configuration:

```typescript
import { NgModule } from '@angular/core';
import {
  CartAddEntrySuccessEvent,
  CartRemoveEntrySuccessEvent,
  provideConfig,
} from '@spartacus/core';
import { NavigationEvent } from '@spartacus/storefront';
import { AepModule } from '@spartacus/tracking/tms/aep';
import { BaseTmsModule, TmsConfig } from '@spartacus/tracking/tms/core';
import { GtmModule } from '@spartacus/tracking/tms/gtm';

@NgModule({
  imports: [
    ...,
    BaseTmsModule.forRoot(),
    GtmModule,
    AepModule,
    ...
  ],
  providers: [
    ...,
    provideConfig({
      tagManager: {
        gtm: {
          gtmId: 'GTM-XXXXXXX',
          events: [NavigationEvent, CartAddEntrySuccessEvent],
        },
        aep: {
          scriptUrl: '//assets.adobedtm.com/xxxxxxx/yyyyyyy/launch-zzzzzzz-development.min.js',
          events: [NavigationEvent, CartRemoveEntrySuccessEvent],
        },
      },
    } as TmsConfig),
  ],
})
export class AppModule {}
```

In this example, Spartacus is only indicating which events should be collected by each of the configured TMS solutions. In this case, both GTM and AELP are enabled to run in parallel.

## Customizations

In the example above, we are leveraging Spartacus' default configuration for both GTM and AELP TMS solutions, and providing only the minimal custom configuration.
There are various customizations available in order to tweak how Spartacus interacts with the events and the data layer:

### Data Layer

Spartacus uses the standard data layer object names and types for each of the supported TMS:

- [GTM](https://developers.google.com/tag-manager/devguide#datalayer) - `dataLayer: any[]`
- [AELP](https://experienceleague.adobe.com/docs/analytics/implementation/prepare/data-layer.html?lang=en#setting-data-layer-values) - `digitalData: {[eventName: string]: any}`

If you use a custom data layer object (with the standard data structure), you can configure it using the `dataLayerProperty` configuration property.

If you are using a different data layer structure than the standard, you can write your own collector like this:

```typescript
import { Injectable } from "@angular/core";
import { CxEvent } from "@spartacus/core";
import {
  TmsCollector,
  TmsCollectorConfig,
  WindowObject,
} from "@spartacus/tracking/tms/core";

@Injectable({ providedIn: "root" })
export class MyCollectorService implements TmsCollector {
  init(config: TmsCollectorConfig, window: WindowObject): void {
    window.myDataLayer = window.myDataLayer ?? [];
  }

  pushEvent<T extends CxEvent>(
    config: TmsCollectorConfig,
    window: WindowObject,
    event: T | any
  ): void {
    window.myDataLayer.push(event);
  }
}
```

and configure it like this:

```typescript
BaseTmsModule.forRoot({
  tagManager: {
    gtm: {
      collector: MyCollectorService,
      events: [NavigationEvent, CartAddEntrySuccessEvent],
    },
    ...
  },
}),
```

### Events Payload

As the required event's payloads can quite vary between clients, we can't cover every possible use case. With that in mind, we've made sure that the events have some sensible payloads, and we've made it easy to adjust (re-map) the payloads in more than one way:

#### Creating a Custom Mapper

To create a custom mapper per a TMS solution, you can build on top of the [example above](#Data-layer) (by creating a custom collector), and implement the `map` method like so:

```typescript
import { Injectable } from "@angular/core";
import { CxEvent } from "@spartacus/core";
import {
  TmsCollector,
  TmsCollectorConfig,
  WindowObject,
} from "@spartacus/tracking/tms/core";

@Injectable({ providedIn: "root" })
export class MyCollectorService implements TmsCollector {
  ...

  map?<T extends CxEvent>(event: T): T | object {
    // TODO: custom mapping logic goes here...
  }
}
```

In the `map` method you can use `instanceof` check to differentiate which event should you re-map. As this logic can get quite complex, you have the ability to inject other services to your `MyCollectorService`.

#### Creating Custom Events

Creating custom events in Spartacus and re-mapping the data to fit your data structure requirements is just the matter of registering a [new event source](/_pages/dev/event-service.md#Registering-Event-Sources)

```typescript
const eventSource = this.eventService.get(NavigationEvent).pipe(
  map((navigationEvent) =>
    createFrom(CustomNavigationEvent, {
      // just an example logic, it's not necessarily the actual page name and type
      pageName: navigationEvent.context.id,
      pageType: navigationEvent.context.type,
    })
  )
);

eventService.register(CustomEvent, eventSource);
```

In the case above, we are re-mapping Spartacus' `NavigationEvent` to `CustomNavigationEvent`. If you need to pull additional data, please see the "Pulling Additional Data From Facades" chapter in the [Events Service docs](./event-service#Pulling-Additional-Data-From-Facades).

Note that you need to inject your `CustomNavigationEventBuilder` builder somewhere, in order to bootstrap the logic - e.g. to a dummy module that's being imported to e.g. `AppModule`.

If you use this approach, you need to pass your `CustomNavigationEvent` to the `tms.adobeLaunch.events` config array, instead of the default `NavigationEvent`.

#### Overriding the TMS service's `mapEvents()`

In case you just want enrich all Spartacus events with some common data, overriding the `TmsService`'s `mapEvents()` is a good place to do it.

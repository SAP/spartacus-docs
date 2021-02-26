# Tag Management System

Spartacus introduced the Tag Management System (TMS) integration in version 3.2.
Before you continue reading this page, it's highly recommended to first get yourself familiar with the [Events Service](./event-service.md), as TMS relies on it.

The TMS integration allows you to specify which Spartacus' events should be passed to the configured TMS. Google Tag Manager (GTM) and Adobe Experience Launch Platform (AELP) systems are supported out of the box, while the other tag managers can easily be plugged in.

Spartacus supports running TMS integrations in parallel, and you can decide which events should be collected by each of the supported Tag Management solutions.

## Setup

Each Tag Management solution might require a different setup instruction, and it's not possible to cover every system here.
However, the process _usually_ requires you to specify a certain `<script>` tag in your `index.html` which will load and bootstrap the TMS. For example, this is how GTM is configured:

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

After this is done, we can move on to the [configuration](#configuration) section.

For more example, please check our [TMS examples doc](tag-management-system-examples.md).

## Configuration

The following TMS configuration options are available for each TMS:

- `debug?: boolean` - Should be enabled in development mode only. Enables console logs.
- `dataLayerProperty?: string` - The name for the data layer object. Provide only if you are using a different name than the default one with the default data-layer data structure (e.g. for `gtm` it's an array-like, while for `aelp` it's an empty object).
- `events?: AbstractType<CxEvent>[]` - List all the event classes which are to be collected and pushed to the data layer.
- `collector?: Type<TmsCollector>` - The custom collector service implementation.

To use start collecting events, you need to import the `BaseTmsModule.forRoot()`, and provide a configuration.
Optionally, you can import the `AepModule` or `GtmModule` to leverage Spartacus' default configuration.

The following is how a full configuration might look like:

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
          events: [NavigationEvent, CartAddEntrySuccessEvent],
        },
        aep: {
          events: [NavigationEvent, CartRemoveEntrySuccessEvent],
        },
      },
    } as TmsConfig),
  ],
})
export class AppModule {}
```

In the example above, we are just providing which events should be collected by each of the configured TMS solutions.
We are also enabling both GTM and AELP to run in parallel.

### Customizations

In the example above, we are leveraging Spartacus' default configuration for both GTM and AELP TMS solutions, and providing only the minimal custom configuration.
There are various customizations available in order to tweak how Spartacus interacts with the events and the data layer:

#### Data layer

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

#### Events payload

As the required event's payloads can quite vary between clients, we can't cover every possible use case. With that in mind, we've made sure that the events have some sensible payloads, and we've made it easy to adjust (re-map) the payloads in more than one way:

##### Creating a custom mapper

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

##### Creating custom events

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

##### Overriding the TMS service's `mapEvents()`

In case you just want enrich all Spartacus events with some common data, overriding the `TmsService`'s `mapEvents()` is a good place to do it.

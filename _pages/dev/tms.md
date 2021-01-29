# Tag Management System

Spartacus introduced the Tag Management System (TMS) integration in version 3.1.
As TMS is highly dependent on the events in Spartacus, it's highly recommended to get yourself familiar with the [Events Service](./event-service) first.

The TMS integration allows you to specify which Spartacus' events should be passed to the configured TMS. Only Google Tag Manager (GTM) and Adobe Launch systems are covered at this moment.

Spartacus supports running multiple TMS in parallel, and you can decide which events should be collected by each of the supported TMS systems.

## Setup

Each TMS system might require a different setup instruction, and it's not possible to cover every system here.
However, the process _usually_ requires you to specify a certain `<script>` tag in your `index.html` which will load and bootstrap the TMS.

After this is done, we can move on to the [configuration](#configuration) section.

## Configuration

In your `app.module.ts` you can import the module that corresponds to the chosen TMS solution:

```typescript
import { NgModule } from '@angular/core';
import { CartAddEntrySuccessEvent, LoginEvent } from '@spartacus/core';
import { NavigationEvent } from '@spartacus/storefront';
import { AdobeLaunchModule } from '@spartacus/tms/adobe-launch';
import { GoogleTagManagerModule } from '@spartacus/tms/gtm';
import { environment } from '../environments/environment';

@NgModule({
  imports: [
    ...
    GoogleTagManagerModule.forRoot({
      tms: {
        gtm: {
          events: [NavigationEvent, LoginEvent],
        },
      },
    }),
    AdobeLaunchModule.forRoot({
      tms: {
        adobeLaunch: {
          debug: !environment.production,
          events: [NavigationEvent, CartAddEntrySuccessEvent],
        },
      },
    }),
    ...
  ],
  ...
})
export class AppModule {...}
```

In the example above, we have configured both GTM and Adobe Launch TMS solutions.

In `GoogleTagManagerModule`, we are passing Spartacus events that will be collected _only_ by GTM. Similar is for the `AdobeLaunchModule`. Notice that we are also enabling the `debug` config in development mode, which can be useful to see console.logs of the collected events.

### Customizations

There are various customizations available in order to tweak how Spartacus interacts with the events and the data layer.

#### Data layer

Spartacus uses the standard data layer object names and types for each of the supported TMS:

- [GTM](https://developers.google.com/tag-manager/devguide#datalayer) - `dataLayer: any[]`
- [Adobe Launch](https://experienceleague.adobe.com/docs/analytics/implementation/prepare/data-layer.html?lang=en#setting-data-layer-values) - `digitalData: {[eventName: string]: any}`

If you use a custom data layer object, you can extend the corresponding Spartacus service:

- GTM - `GoogleTagManagerService` from `@spartacus/tms/gtm`
- Adobe Launch - `AdobeLaunchService` from `@spartacus/tms/adobe-launch`

Let's take a look at a custom Adobe Launch service:

```typescript
import { Inject, Injectable, PLATFORM_ID } from "@angular/core";
import { CxEvent, EventService, WindowRef } from "@spartacus/core";
import { AdobeLaunchService } from "@spartacus/tms/adobe-launch";
import { TmsConfig } from "@spartacus/tms/core";

// define your data layer object here
interface CustomAdobeLaunchWindow extends Window {
  _trackData?: (data: any, linkObject?: any, eventObject?: any) => void;
}

@Injectable({ providedIn: "root" })
export class CustomAdobeLaunchService extends AdobeLaunchService {
  constructor(
    protected eventsService: EventService,
    protected windowRef: WindowRef,
    protected tmsConfig: TmsConfig,
    @Inject(PLATFORM_ID) protected platformId: any
  ) {
    super(eventsService, windowRef, tmsConfig, platformId);
  }

  // add a type safety for your data layer
  get window(): CustomAdobeLaunchWindow | undefined {
    return this.windowRef.nativeWindow;
  }

  // define how your data layer is being initialized
  protected prepareDataLayer(): void {
    if (this.window) {
      this.window._trackData =
        this.window._trackData ??
        function (_data: any, _linkObject?: any, _eventObject?: any): void {};
    }
  }

  // specify how your events are being pushed to the data layer
  protected push<T extends CxEvent>(event: T): void {
    if (this.window) {
      if (this.tmsConfig.tms?.adobeLaunch?.debug) {
        console.log(
          `🎭  CUSTOM Adobe Launch received data: ${JSON.stringify(event)}`
        );
      }
      this.window._trackData(event);
    }
  }
}
```

You can then provide the custom service like so:

```typescript
@NgModule({
  imports: [
    ...
    AdobeLaunchModule.forRoot({...}),
    ...
  ],
  ...
  providers: [
    ...
    { provide: AdobeLaunchService, useClass: CustomAdobeLaunchService }
  ]
})
export class AppModule {...}
```

#### Events payload

As the required event's payloads can quite vary between clients, we can't cover every possible use case. With that in mind, we've made sure that the events have some sensible payloads, and we've made it easy to adjust (re-map) the payloads in more than one way:

- by creating custom events

Creating custom events in Spartacus and re-mapping the data to fit your data structure requirements is straightforward:

```typescript
import { Injectable } from "@angular/core";
import { createFrom, EventService } from "@spartacus/core";
import { NavigationEvent } from "@spartacus/storefront";
import { Observable } from "rxjs";
import { map } from "rxjs/operators";

export class CustomNavigationEvent {
  pageType: string;
  pageName: string;
}

@Injectable({
  providedIn: "root",
})
export class CustomNavigationEventBuilder {
  constructor(protected eventService: EventService) {
    this.buildNavigationEvent();
  }

  private buildNavigationEvent(): Observable<CustomNavigationEvent> {
    return this.eventService.get(NavigationEvent).pipe(
      map((navigationEvent) =>
        createFrom(CustomNavigationEvent, {
          // just an example logic, it's not necessarily the actual page name and type
          pageName: navigationEvent.context.id,
          pageType: navigationEvent.context.type,
        })
      )
    );
  }
}
```

In the case above, we are re-mapping Spartacus' `NavigationEvent` to `CustomNavigationEvent`. If you need to pull additional data, please see the "Pulling Additional Data From Facades" chapter in the [Events Service docs](./event-service#Pulling-Additional-Data-From-Facades).

Note that you need to inject your `CustomNavigationEventBuilder` builder somewhere in order to bootstrap the logic - e.g. to a dummy module that's being imported to e.g. `AppModule`.

If you use this approach, you need to pass your `CustomNavigationEvent` to the `tms.adobeLaunch.events` config array, instead of the default `NavigationEvent`.

- by overriding the TMS service's `mapEvents()`

In case you just want enrich all Spartacus events with some common data, overriding the `AdobeLaunchService`'s `mapEvents()` is a good place to do it:

```typescript
@Injectable({ providedIn: "root" })
export class CustomAdobeLaunchService extends AdobeLaunchService {
  constructor(
    protected eventsService: EventService,
    protected windowRef: WindowRef,
    protected tmsConfig: TmsConfig,
    @Inject(PLATFORM_ID) protected platformId: any
  ) {
    super(eventsService, windowRef, tmsConfig, platformId);
  }

  ...

  protected mapEvents<T extends CxEvent>(
    events: Observable<T>[]
  ): Observable<T> {
    // your mapping logic here
  }
}
```

The principle is the same for other supported TMS solutions.

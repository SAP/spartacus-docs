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

The Spartacus tag management system (TMS) allows you to set up a tag manager, and to specify which Spartacus events should be passed to the configured TMS. Both Google Tag Manager (GTM) and Adobe Experience Platform Launch (AEPL) are supported by Spartacus out-of-the-box, while other tag managers can easily be plugged in.

Spartacus supports running multiple tag manager integrations in parallel, and you can decide which events should be collected by each of the supported tag management solutions.

**Note:** To work with the Spartacus tag management system, you should also be familiar with the Spartacus events service, which the TMS relies on. For more information, see [{% assign linkedpage = site.pages | where: "name", "event-service.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/event-service.md %}).

**Disclaimer**

*The use of tag managers implies the execution of third-party scripts in real time within Spartacus. These scripts may contain malicious payloads. As a result, SAP cannot be held liable or responsible for the content or side effects that may be caused by the execution of third-party scripts within Spartacus. Development teams that are involved in the implementation of tag managers for Spartacus storefronts should consult with business stakeholders to confirm compliance with local privacy and security laws, such as GDPR.*

*For more information about third-party script security risks, see the [Third Party JavaScript Management Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Third_Party_Javascript_Management_Cheat_Sheet.html) in the OWASP Cheat Sheet Series.*

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Setup

If you are working with Google Tag Manager, you can provide the GTM ID through the `gtmId` configuration property. Spartacus runs the _immediately invoked function expression_ (IIFE) that is provided by GTM, and this "injects" the GTM script into the DOM. For more details, see the [Configuration](#configuration) section, below.

If you are working with Adobe Experience Platform Launch, you can provide the script URL through the `scriptUrl` configuration property, and Spartacus will use this URL to "inject" the script into the DOM. For more details, see the [Configuration](#configuration) section, below.

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

For see additional setup examples with Google Analytics and AEPL, see [{% assign linkedpage = site.pages | where: "name", "tag-management-system-examples.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/features/tag-management-system-examples.md %}).

## Configuration

The following TMS configuration options are available:

- `debug` is a boolean that enables the console log. It should only be enabled in development mode.
- `dataLayerProperty` is a string that names the data layer object. You only need to provide the `dataLayerProperty` if you are not using the default name for the data layer.
- `events` is an `AbstractType<CxEvent>[]` that lists all the event classes that are to be collected and pushed to the data layer.
- `collector` is a `Type<TmsCollector>`, and is the custom collector service implementation.
- `gtmId` is only available for GTM. When you provide `gtmId`, Spartacus handles the script "injection" and bootstrapping for you.
- `scriptUrl` is only available for AEPL. When you provide `scriptUrl`, Spartacus handles the script "injection" and bootstrapping for you.

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

In this example, Spartacus is only indicating which events should be collected by each of the configured TMS solutions. In this case, both GTM and AEPL are enabled to run in parallel.

## Customization

The example in the previous section makes use of the default configuration for integrating with both GTM and AEPL, and only includes a minimal amount of custom configuration. However, it is possible to adjust how Spartacus interacts with the data layer, as well as with events, as described in the following sections.

### Data Layer

Spartacus uses the standard data layer object names and types for both of the supported tag management system solutions, as follows:

- `dataLayer: any[]` for GTM
- `digitalData: {[eventName: string]: any}` for AEPL

For more information on these standard data layer objects, see the relevant [GTM](https://developers.google.com/tag-manager/devguide#datalayer) and [AEPL](https://experienceleague.adobe.com/docs/analytics/implementation/prepare/data-layer.html?lang=en#setting-data-layer-values) documentation.

If you use a custom data layer object with the standard data structure, you can configure it using the `dataLayerProperty` configuration property.

If you are using a different data layer structure than the standard one, you can write your own collector. The following is an example:

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

After you have written your collector, you configure it, as shown in the following example:

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

Depending on which TMS client you are working with, the requirements for an event's payload can vary a lot. The default event payloads in Spartacus are intended to match the requirements for the most typical use cases. However, if the defaults do not meet your needs, you can re-map or adjust the payloads in a few different ways, as described in the following sections.

#### Creating a Custom Mapper

To create a custom mapper for a specific TMS solution, you can create a custom collector (as shown in the [Data Layer](#data-layer) section, above), and then implement the `map` method, as shown in the following example:

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

In the `map` method, you can use the `instanceof` check to indicate which events should be re-mapped. If you find this logic becoming too complex, you can inject other services to your `MyCollectorService`, as needed.

#### Creating Custom Events

You can create a custom event in Spartacus and re-map the data to fit your data structure requirements simply by registering a new event source, as described in [Registering Event Sources]({{ site.baseurl }}/event-service/#registering-event-sources). The following is an example:

```typescript
const eventSource = this.eventService.get(NavigationEvent).pipe(
  map((navigationEvent) =>
    createFrom(CustomNavigationEvent, {
      // the next lines are example logic, not necessarily the actual page name and type
      pageName: navigationEvent.context.id,
      pageType: navigationEvent.context.type,
    })
  )
);

eventService.register(CustomEvent, eventSource);
```

In the example above, the Spartacus `NavigationEvent` is re-mapped to a `CustomNavigationEvent`. If you need to pull additional data, see [Pulling Additional Data From Facades]({{ site.baseurl }}/event-service/#pulling-additional-data-from-facades) for more information.

**Note:** To bootstrap the logic, you need to inject your `CustomNavigationEventBuilder` somewhere, such as in a dummy module that is being imported, for example, to the `AppModule`.

If you use this approach, you need to pass your `CustomNavigationEvent` to the relevant config array (such as `tagManager.gtm.events` or `tagManager.aep.events`), instead of the default `NavigationEvent`.

#### Overriding mapEvents() in the TMS Service

If you wish to enrich all Spartacus events with some common data, you can do so by overriding `mapEvents()` in the `TmsService`.

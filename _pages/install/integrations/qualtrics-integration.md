---
title: Qualtrics Integration
feature:
  - name: Qualtrics Integration
    spa_version: 1.3
    cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.3 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The Qualtrics integration in Spartacus allows you to set up Qualtrics to work seamlessly in a single-page application. This integration is based on a JavaScript API that intercepts events in the storefront. The API is called Qualtrics Site Intercept (QSI), and is provided by Qualtrics. To import and use the API, Qualtrics provides a simple deployment code for your Qualtrics project, which you can integrate in Spartacus.

**Note:** When using Qualtrics, it is important to be aware that users will be tracked while interacting with the survey, in terms of page views, impressions, and clicks. The consent management feature in SAP Commerce Cloud can be configured to create a specific consent for Qualtrics. Additionally, the SAP Qualtrics Integration Module provides a standard integration to incorporate consent into Qualtrics.

Visitors to your Qualtrics-enabled website must have their Ad-Blocker disabled to view surveys.

For more information about Qualtrics, see [Getting Started with Website Feedback](https://www.qualtrics.com/support/website-app-feedback/getting-started-with-website-app-feedback/getting-started-with-website-feedback) in the Qualtrics documentation, and [SAP Qualtrics Integration Module](https://help.sap.com/viewer/50c996852b32456c96d3161a95544cdb/latest/en-US/8a849c5254db460e8eea4d7b9af39bff.html) on the SAP Help Portal.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Installing the Qualtrics Library

To integrate Qualtrics with your Spartacus storefront, you need to first install the `@spartacus/qualtrics` feature library. For more information, see [Installing Additional Spartacus Libraries]({{ site.baseurl }}/schematics/#installing-additional-spartacus-libraries).

## Qualtrics Projects

Qualtrics recommends a single project for each application or page. Since Spartacus runs as a single-page application, it is recommended to use a single Qualtrics project in Spartacus. This might not be ideal, but the Qualtrics JavaScript API is not equipped to handle multiple projects. For example, the `QSI.API.unload` and `QSI.API.run` APIs have the side effect of applying across all projects at once. If you need to run multiple projects side by side, you should be prepared for side effects that will result from calling the `unload` API.

Although the Qualtrics deployment script has the notion of a project ID, this is no longer needed. The Spartacus integration therefore only depends on the deployment code that is provided for each Qualtrics project.

## Deployment Code

For each Qualtrics project, there is a deployment code for client-side integration. The deployment code contains a `script` tag and a DIV with the project code. The integration with Spartacus only requires the script content, without the script element. It is recommended that you save the deployment code in a file in your project asset folder (for example, in `assets/qualtrics.js`).

The deployment code takes care of loading the qualtrics API. The deployment script loads the qualtrics API based on the window load event. If you load the integration dynamically (which is our default strategy), this event does not happen because we are in a single-page application experience. In this case, you need to adjust the script so that it calls the `go()` method instead of the `start()` method.

The following is an example of how your deployment code should look after making this change:

```javascript
(function () {
  var g = function (e, h, f, g) {

  // left out most of the script for readability

  try {
    new g(
      100,
      "r",
      "QSI_S_[project ID]",
      "https://[environment].siteintercept.qualtrics.com/SIE/?Q_ZID=[project ID]"
    ).go(); // this is where you change from start() to go()
  } catch
```

## Integration Strategies

There are various ways to integrate the Qualtrics deployment code in Spartacus:

- dynamic integration using a CMS component (this is the default strategy)
- static integration in `index.html`
- custom integration by using the `QualtricsLoaderService`

The different strategies are discussed in the following sections.

### Dynamic Integration Using a CMS Component

The default integration is based on the use of a CMS component. The advantage of using a CMS component is that the integration uses lazy loading. For example, if the component is loaded on a specific page (such as the cart page), the integration and the required QSI API are only loaded for users who enter this page.

The Qualtrics CMS component is mapped to a component with type `QualtricsComponent`. The following snippet provides an import script (ImpEx) to install the component in the CMS of SAP Commerce Cloud. Additionally, you must add the component to a global slot (such as the footer), or to a specific page slot.

```ts
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;QualtricsComponent;A Qualtrics Component;QualtricsComponent
```

If the component is loaded on a recurring page (such as the Product Details Page), the `QualtricsLoaderService` avoids reloading the deployment script and API.

The Qualtrics integration adds the deployment code from the script you have captured from the Qualtrics platform. You must configure Spartacus with a reference to this file path, using the `provideConfig`. The following is an example:

```typescript
import {
  QUALTRICS_FEATURE,
} from '@spartacus/qualtrics/root';
import { provideConfig } from '@spartacus/core';

...

provideConfig(<QualtricsConfig>{
  [QUALTRICS_FEATURE]: {
    scriptSource: "assets/qualtrics.js",
  },
})
```

The configuration is limited for multi-site applications, where each site requires a separate Qualtrics project.

### Static Integration

The deployment code can be added to the `index.html` of your Spartacus application. This should be stored in the header or footer, as discussed in the [Qualtrics documentation](https://www.qualtrics.com/support/website-app-feedback/common-use-cases/single-page-application/).

Static integration is the strategy that is documented by Qualtrics, but it is not necessarily the best practice for Spartacus. The disadvantage of the static integration strategy is that the Qualtrics API is always loaded, even if it is not used on a page that the user visits. Additionally, the static integration starts loading immediately, before the Spartacus application has been bootstrapped, and before any dependent data is available. This might block you from using the static integration.

### Custom Integration with the QualtricsLoaderService

You can also integrate the Qualtrics deployment code dynamically by leveraging the `QualtricsLoaderService`. This service can be used to add the deployment script. The rest of the integration is still taken care of automatically, but you can further customize the integration if you wish.

There are different scenarios for creating a custom integration. For example, you could load alternative deployment codes for each site.

## Loading Additional Data Before Loading Qualtrics

Data is loaded asynchronously in Spartacus. If your Qualtrics logic depends on specific data (for example, cart data), you need to further customize the `QualtricsLoaderService`. The service provides the `isDataLoaded()` hook to load additional data.

The `isDataLoaded()` is taken into account before loading the deployment code. This method can return an observable stream, which means you can preload any data that you require.

The following example demonstrates the loading of cart data before the deployment script is loaded:

```ts
import { Injectable, RendererFactory2 } from "@angular/core";
import { ActiveCartService, WindowRef } from "@spartacus/core";
import { QualtricsLoaderService } from "@spartacus/qualtrics/components";
import { Observable } from "rxjs";
import { map } from "rxjs/operators";

@Injectable({ providedIn: "root" })
export class DemoQualtricsLoaderService extends QualtricsLoaderService {
  constructor(
    winRef: WindowRef,
    rendererFactory: RendererFactory2,
    private cartService: ActiveCartService
  ) {
    super(winRef, rendererFactory);
  }

  isDataLoaded(): Observable<boolean> {
    return this.cartService
      .getEntries()
      .pipe(map((entries) => entries.length === 1));
  }
}
```

## Spartacus Support for Qualtrics Embedded Feedback

{% capture version_note %}
{{ site.version_note_part1 }} 3.1 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The Qualtrics Embedded Feedback feature relies on CSS selectors to display the Embedded Feedback component in a page. For more information, see [Embedded Feedback](https://www.qualtrics.com/support/website-app-feedback/creatives-tab/creative-types/embedded-feedback/) in the Qualtrics documentation.

You can use this feature in Spartacus either by pointing to an appropriate selector on a page, or by using a dedicated CMS component that allows you to place the feature in a slot for a specific page. The following is an example of assigning the Embedded Feedback feature to a page slot using a CMS component:

```ts
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;QualtricsEmbeddedFeedbackComponent;Qualtrics Embedded Feedback Component;QualtricsEmbeddedFeedbackComponent

INSERT_UPDATE ContentSlot;$contentCV[unique=true];uid[unique=true];cmsComponents(uid,$contentCV)
;;ProductSummarySlot;ProductImagesComponent,ProductIntroComponent,QualtricsEmbeddedFeedbackComponent,ProductSummaryComponent,VariantSelector,AddToCart,ConfigureProductComponent,AddToWishListComponent,StockNotificationComponent
```

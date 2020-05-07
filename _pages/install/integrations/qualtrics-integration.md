---
title: Qualtrics Integration
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.3 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Qualtrics integration to Spartacus enables users to set-up their Qualtrics seamlessly while we facilitate the usage on a Single-Page Application (SPA). For more information on Qualtrics you can read [the documenation](https://www.qualtrics.com/support/website-app-feedback/getting-started-with-website-app-feedback/getting-started-with-website-feedback). This documentation is only related to the integratino in Spartacus.

The integration is based on a JavaScript API that intercepts events in the storefront. The API is called `QSI` (_Qualtrics Site Intercept_) and is provided by Qualtrics. To import and use the API, Qualtrics provides a simple _deployment code_ for your Qualtrics project that you can integrated in Spartacus.

## Projects

Qualtrics recommends a single project per given application or page. Given that Spartacus runs as a Single Page Application, it is recommended to use a single Qualtrics project in Spartacus. This might be unfortunate, but the Qualtrics JavaScript API is simply not equiped to handle multiple projects; the `QSI.API.unload` and `QSI.API.run` APIs have the side effect of applying across all projects at once. In case you need to run multiple projects side by side, you should be prepared for side effects coming from calling the `unload` API.

Although the Qualtrics deployment script has the notion of the project ID, this is no longer needed. The Spartacus integration therefor only depends on the _deployment code_ provided per Qualtrics project.

## Deployment code

Each Qualtrics project is prepared with a deployment code for a client-side integration. The deployment code contains a `script` tag and a DIV with the project code. The integration with Spartacus only requires the script content, without the script element. It is recommended to save the deployment code in a file in your project asset folder (i.e. `assets/qualtrics.js`).

The deployment code will take care of loading the qualtrics API (QSI). The deployment script loads the qualtrics API based on the window load event. In case you load the integration dynamically (which is our default approach), this event is not happening, as we're in a Single Page Application experience. In this case you need to ammend the script so that it will call the `go()` method instead of the `start()` method. You deployment code should look like this after the change

```javascript
(function () {
  var g = function (e, h, f, g) {

  // left out most of the script for readibility

  try {
    new g(
      100,
      "r",
      "QSI_S_[project ID]",
      "https://[environment].siteintercept.qualtrics.com/SIE/?Q_ZID=[project ID]"
    ).go(); // this is where you change from start() to go()
  } catch
```

After saving the deployment code, you must modify one piece of statement. The script calls the `.start()` function, where it is encapsulated in a `try` statement, to `.go()`. It is a crucial step in enabling Qualtrics in Spartacus.

## Integration approaches

There are various ways to integrate the Qualtrics deployment code in Spartacus:

1. Dynamic integration through CMS component
2. Static integration in `index.html`
3. Custom integration by using the `QualtricsLoaderService`

The different approaches are discussed below.

### Approach 1 (default): Dynamic integration through CMS component

The default integration is based on the use of a CMS component. The advantage of using a CMS component, is that the integration is lazily loaded. For example, if the component is loaded on a specific page (i.e. cart page), the integration and the required QSI API are only loaded for users who enter this page.

The Qualtrics CMS component is mapped to a component with type `QualtricsComponent`. The following snippet provides an import script (ImpEx) to install the component in the CMS of SAP Commerce Cloud. Additinally, you must add the component to a global (i.e. footer) or specific page slot.

```ts
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;QualtricsComponent;A Qualtrics Component;QualtricsComponent
```

In case the component is loaded on a reocurring page (i.e. the Product Detail Page), the `QualtricsLoaderService` avoids reloading the deployment script and API.

The qualtrics integration will add the deployment code from the script you've captured from the Qualtrics platform. You must configure Spartacus with a reference to this file path, using the `ConfigModule`:

```typescript
ConfigModule.withConfig({
  qualtrics: {
    scriptSource: "assets/qualtrics.js",
  },
} as QualtricsConfig);
```

### Approach 2: Static integration

The deployment code can be added to the `index.html` of your Spartacus application. As discussed in the [Qualtrics documentation](https://www.qualtrics.com/support/website-app-feedback/common-use-cases/single-page-application/), this should be stored in the header or footer.

The disadvantage of this approach is that all users will always load the qualtrics integration, even if it's not used on the page that the user visits.

### Approach 3: ustom integration by using the `QualtricsLoaderService`,

You can also integrate the qualtrics deployment code dynamically by leveraging the `QualtricsLoaderService`. This service can be used to add the deployement script. The rest of the integation would still be taken care of automaticallyk, although you can futher customize the integration if you like to.

There are different scenario's for creating custom integration. One scenario would be to load alternative deployment code per site. The current integation is limited to a single deloyment script per application. In case you run Spartacus for multiple sites, this might be limited.

## Load additional data before loading Qualtrics

Data is loaded asynchronize in Spartacus. If your Qualtrics logic depends on specific data, such as cart data, you would need to further customize the `QualtricsLoaderService`. The service provides a hook (`isDataLoaded()`) to load additional data.

The `isDataLoaded()` is taken into account before loading the deployment code. This method can return an observable stream, which means you can pre-load any data that you require.

The example below demonstrats loading of cart data before the deployment script is loaded.

```ts
import { Injectable } from "@angular/core";
import { CartService, WindowRef } from "@spartacus/core";
import { QualtricsConfig, QualtricsLoaderService } from "@spartacus/storefront";
import { Observable } from "rxjs";
import { map } from "rxjs/operators";

@Injectable({ providedIn: "root" })
export class DemoQualtricsLoaderService extends QualtricsLoaderService {
  constructor(
    winRef: WindowRef,
    config: QualtricsConfig,
    private cartService: CartService
  ) {
    super(winRef, config);
  }

  isDataLoaded(): Observable<boolean> {
    return this.cartService
      .getEntries()
      .pipe(map((entries) => entries.length === 1));
  }
}
```

## Important Note

By utilizing Qualtrics, you should know that users will be tracked in terms of page views, impressions, and clicks while interacting with the survey.

Visitors in your website with Qualtrics enabled must have their Ad-Blocker disabled to view surveys.

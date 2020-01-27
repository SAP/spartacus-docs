---
title: Qualtrics Integration (DRAFT)
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.3 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Qualtrics integration to Spartacus enables users to set-up their Qualtrics seamlessly while we facilitate the usage on a Single-Page Application (SPA).

## Important Note

By utilizing Qualtrics, you should know that users will be tracked in terms of page views, impressions, and clicks while interacting with the survey.

Visitors in your website with Qualtrics enabled must have their Ad-Blocker disabled to view surveys.

## Using Qualtrics to enable surveys

Please familiarize yourself with Qualtrics using the following link https://www.qualtrics.com/support/website-app-feedback/getting-started-with-website-app-feedback/getting-started-with-website-feedback/.

## Where to find the projectId from your Qualtrics portal?

Step 1: Click the project from which you want to use for enablement.

Step 2: Click settings.

Step 3: Click the dropdown 'Manage Project' and select Project IDs.

Step 4: Copy paste the project id to the `app.modules.ts` as shown above.

## Enabling Qualtrics in Spartacus

To enable Qualtrics, you simply need to append a Qualtrics config to the app.module.ts

- `projectId` property: Allows you to enable Qualtrics with the given projectId from your provided Qualtrics deployment code.

```ts
B2cStorefrontModule.withConfig({
  [...]
  qualtrics: {
    projectId: 'placeholder123'
  }
})
```

Moreover, after acquiring the deployment code from your Qualtrics platform, please create a file under the assets folder and name it `qualtricsIntegration.js`. You need to copy paste everything within the `<script></script>` and place it into the `qualtricsIntegration.js` file. Do not include the `<script></script>` tag in the file. Make sure only the contents within the tag is there. Modify one piece of statement, where it calls the `.start()` function, where it is encapsulated in a `try` statement, to `.go()`. It is a crucial step in enabling Qualtrics in Spartacus.

After setting up Qualtrics in Spartacus, you need to create a CMXFlexComponent.
Make sure the component uid and flexType are called QualtricsComponent as shown below.
Spartacus will render this component on the given page to enable Qualtrics.

```ts
INSERT_UPDATE CMSFlexComponent;$contentCV[unique=true];uid[unique=true];name;flexType
;;QualtricsComponent;A Qualtrics Component;QualtricsComponent
```

**Note**: It is important to note that it is a must to insert the QualtricsComponent to a page. Please make sure, you add the component to a content slot of a page, which gets removed once you navigate elsewhere, but it should only exist for one page at a time. For example, if you want Qualtrics enabled in the 'Product Details Page', then it would be best to put the CMSFlexComponent to the UpSellingSlot, or if you want it in the 'Product Listing Page', then you would need to put it in ProductLeftRefinements slot. You should not have two or more QualtricsComponent existing in a page.

## Enable Qualtrics to work with page data in Spartacus

You can add your custom logic to listen to a data stream in order to enable Qualtrics.

You are able to extend the `QualtricsLoaderService` in order to enable Qualtrics. This is configurable and you are able to add as many data stream you need to listen to.

An example of extending the `QualtricsLoaderService` shows that we want to only enable Qualtrics when the cart has only one entry, therefore we know the page data has already been loaded.

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

  /**
   * This logic exist in order to let the user add their own logic to wait for any kind of page data
   * Example: a user wants to wait for the page data and is listening to a data stream
   * where it returns Observable(true) when there is 1 item in the cart
   */
  isDataLoaded(): Observable<boolean> {
    return this.cartService
      .getEntries()
      .pipe(map(entries => entries.length === 1));
  }
}
```

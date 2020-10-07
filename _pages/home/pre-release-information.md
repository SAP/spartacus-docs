---
title: Pre-Release Information
---

This document describes what is included in the latest pre-release of Spartacus libraries, such as `next` and `rc` libraries.

_Last updated September 30, 2020 by Bill Marcotte, Senior Product Manager, Spartacus_

For an overview of what is included in a specific release, see [Release Information]({{ site.baseurl }}{% link _pages/home/release-information.md %}). For detailed release notes, see the Spartacus repository [Releases page](https://github.com/SAP/spartacus/releases).

## Release 3.0.0-next.1 - September 17th, 2020

This pre-release moves Spartacus to Angular 10.

Setup instructions are very similar to [Building the Spartacus Storefront using 2.x Libraries]({{ site.baseurl }}{% link _pages/install/building-the-spartacus-storefront-from-libraries.md %}), except that you specify `@next` when adding schematics.

1. Make sure Angular 10 is installed, either globally or as your local framework.
2. Create a new Angular app  with `ng new mystore --style=scss`.
3. Then `cd mystore`. The `package.json` file should contain Angular 10 libraries.
4. Run `ng add @spartacus/schematics@next`. The `package.json` should contain Spartacus `3.0.0-next.1` libraries.
5. Run `yarn install`.
6. Run `yarn start`.

A reminder that, by default, `app.module.ts` is pointing to `localhost` and uses `/rest/v2/`.

See [Updating to Angular version 10](https://angular.io/guide/updating-to-version-10) for information on what's new in Angular 10.

## Release 3.0.0-next.0 - September 11th, 2020

We're proud to announce that our first `next` release for 3.0 has been published! It contains the B2B Checkout feature.

To set up a server for use with Spartacus B2B, do the following:

- Download the latest `spartacussampledataaddon.2005.zip` from the Spartacus release page (for example, [here](https://github.com/SAP/spartacus/releases/download/storefront-3.0.0-next.2/spartacussampledataaddon.2005.zip)).
- Build a back end according to the instructions in [Installing SAP Commerce Cloud for use with Spartacus]({{ site.baseurl }}{% link _pages/install/backend/installing-sap-commerce-cloud.md %}).

You can try out the new Spartacus `3.0.0-next` libraries by following these steps:

1. Create a new Angular app (using Angular 9) with `ng new mystore --style=scss`.
1. Then `cd mystore`.
1. Run `ng add @spartacus/schematics@next`.
1. Run `yarn install`.
1. In `src/app/app.module.ts`, replace `B2cStorefrontModule` with `B2bStorefrontModule` (there are two instances that need replacing).
1. In the same file, change `"/rest/v2/"` to `"/occ/v2/"`.
1. In the same file, update the context definition to include powertools, for example: `context: {urlParameters: ['baseSite', 'language', 'currency'], baseSite: ['powertools-spa'], language: ['en'], currency: ['USD']},`
1. Run `yarn start`.

**Note:** If you have Angular 10 installed globally, you can install Angular 9 locally with `npm install @angular/cli@^9.0.0` in a new folder, then follow the instructions above.

## 2.1 Pre-Release Libraries

Release 2.1 has been published! See [Release Information]({{ site.baseurl }}{% link _pages/home/release-information.md %}) for more information on release 2.1.

## Customer Data Cloud Pre-Release

The **Customer Data Cloud** (CDC, previously known as Gigya) integration library remains in pre-release and will likely be final alongside the 3.0 release. This new library provides authentication and consent management through CDC instead of what’s out-of-the-box SAP Commerce Cloud. For more information, see the [documentation]({{ site.baseurl }}{% link _pages/install/integrations/cdc-integration.md %}).


## Pre-Release Libraries for 2.0 and earlier

Pre-release libraries are no longer actively updated for versions 2.0 and earlier, as the final release of these libraries was already published. Pre-release libraries are still available but the final versions should be used.

## Questions

If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU). Feedback welcome!

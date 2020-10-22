---
title: About Spartacus
---

## What is Spartacus?

If you are working with an older version of the Spartacus libraries, you can find the full suite of corresponding documentation in our
[Documentation Archive]({{ site.baseurl }}{% link _pages/home/docs-archive.md %}).

Spartacus is a lean, Angular-based JavaScript storefront for SAP Commerce Cloud. Spartacus talks to SAP Commerce Cloud exclusively through the Commerce REST API.

See the following introductory videos for a quick overview of Spartacus:

- [Introduction to Spartacus](https://enable.cx.sap.com/media/Introduction+to+Spartacus+-+SAP+Commerce+Cloud/1_6dln57h9)
- [Spartacus in 60 seconds](https://enable.cx.sap.com/media/Spartacus+in+60+Seconds+-+SAP+Commerce+Cloud/1_hwaie89l)
- [All videos](https://enable.cx.sap.com/tag/tagid/spartacus)

If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront).
For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-i36rvrqe-kNA9RutaT0W17A_jh0Hygg). Feedback welcome!

### Extensible

Spartacus is designed to be upgradable while maintaining full extendability. You'll be able to adopt new versions of Spartacus by updating the Spartacus libraries that we will regularly enhance.

### Progressive

Spartacus is on a journey to be fully compliant with the Progressive Web Application (PWA) checklist. We aim to add support for all major features of a PWA-enabled storefront, to offer the best possible customer experience regardless of device or location.

### Open Source

Spartacus is open source. It will be continually developed by the SAP Commerce Cloud team, but we are very keen to welcome contributors and to foster an inclusive, active development community for Spartacus.

See [Contributing to the Spartacus Storefront]({{ site.baseurl }}{% link _pages/contributing/contributing-to-the-spartacus-storefront.md %}) for more information.

### Technology

The Spartacus storefront is part of our exciting new journey towards a customizable-yet-upgradable technology for SAP Commerce Cloud installations.

See [SAP Customer Experience](https://www.sap.com/products/crm/e-commerce-platforms.html) for more information about SAP Commerce Cloud.

### Storefront Features

Spartacus provides core storefront features such as:

- home page
- search
- categories
- product details
- cart page
- adding to cart
- checkout
- order history

## Requirements

{% include docs/frontend_requirements.html %}

For the back end, SAP Commerce Cloud version 1905 or higher is required.

## Download and Installation

To get up and running with Spartacus, the recommended approach is to build your storefront application from ready-made libraries. You can also clone and build from source, but upgrading is not as simple.

Spartacus currently can only be used with a SAP Commerce Cloud instance through Commerce APIs.

For complete setup instructions, see the [Building the Spartacus Storefront from
Libraries]({{ site.baseurl }}{% link _pages/install/building-the-spartacus-storefront-from-libraries.md %}) guide.

## Customizing and Extending Spartacus

To maintain our promise of upgradability, the design pattern for Spartacus is for non-core features to be built as feature libraries that add to or change the provided functionality.

When using Spartacus, you build an app that pulls in the Spartacus libraries, which contain the core resources needed to work with SAP Commerce. You then build new features that contain any custom functionality and pages.

Content for Spartacus pages is fetched from the SAP Commerce Cloud CMS (Content Management System), such as logos, links, banners and static pages. We recommend that new content-driven features follow the same pattern to enable Content Managers to modify page content through the CMS tools.

The documentation for customizing and extending Spartacus is still under development and is being released as it becomes available.

## Limitations

With the release of 1.0.0, it is recommended to use SAP Commerce 1905. Spartacus works with Release 1808 and 1811 of SAP Commerce Cloud, with some limitations.

Spartacus is also being updated so that it works well with upcoming releases of SAP Commerce Cloud. This means that certain features of
Spartacus may only work with unreleased future editions of SAP Commerce Cloud. This will be noted as we release new versions of Spartacus.

## Known Issues

Known issues are documented in the GitHub issue tracking system.

## How to Obtain Support

Spartacus is provided "as-is" with no official lines of support.

To get help from the Spartacus community:

- For more general questions, post a question in the Help chat of our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-i36rvrqe-kNA9RutaT0W17A_jh0Hygg).
- For developer questions, post a question to [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront) with the `spartacus-storefront` tag.

## Contributing

Team Spartacus welcomes feedback, ideas, requests, and especially code contributions.

- Post comments to our feedback channel in our [Slack](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-i36rvrqe-kNA9RutaT0W17A_jh0Hygg) workspace.
- Read [Contributing to the Spartacus Storefront]({{ site.baseurl }}{% link _pages/contributing/contributing-to-the-spartacus-storefront.md %}) to learn how to:
  - Help others
  - Report an issue
  - Contribute code to Spartacus

## Public Instance of Spartacus {#publicInstance}

To view our public instance, see [Spartacus](https://spartacus-demo.eastus.cloudapp.azure.com/electronics-spa/en/USD/)

We are running this on our SAP Commerce Cloud (CCv2). We may have our latest version on the link above, however, we hope in the future to always update our deployments frequently.

## To Do

Many improvements are coming! All tasks will be posted to our GitHub issue tracking system. As mentioned, some of the improvements will mean breaking changes. While we strive to avoid doing so, we cannot guarantee this will not happen before the first release.

## License

Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved. This file is licensed under the Apache Software License, v. 2 except as noted otherwise in the [LICENSE](https://github.com/SAP/spartacus/blob/develop/LICENSE) file.

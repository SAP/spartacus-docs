---
title: About Spartacus
---

Spartacus is a lean, Angular-based JavaScript storefront for SAP Commerce Cloud. Spartacus talks to SAP Commerce Cloud exclusively through the Commerce REST API.

Spartacus is also an open source project. You can view the Spartacus source code in this [GitHub repository](https://github.com/SAP/spartacus).

See the following introductory videos for a quick overview of Spartacus:

- [Introduction to Spartacus](https://microlearning.opensap.com/media/Introduction+to+Spartacus+-+SAP+Commerce+Cloud/1_6dln57h9/178316081)
- [Spartacus in 60 seconds](https://microlearning.opensap.com/media/Spartacus+in+60+Seconds+-+SAP+Commerce+Cloud/1_hwaie89l/178316081)
- [All videos](https://microlearning.opensap.com/category/Spartacus/178316081)

If you have technical questions, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ). Feedback welcome!

**Note:** If you are working with an older version of the Spartacus libraries, you can find the full suite of corresponding documentation in our [Documentation Archive.](https://sap.github.io/spartacus-docs/docs-archive/)

## Extensible

Spartacus is designed to be upgradable while maintaining full extendability. You'll be able to adopt new versions of Spartacus by updating the Spartacus libraries that we regularly enhance.

## Progressive

Spartacus is on a journey to be fully compliant with the Progressive Web Application (PWA) checklist. We aim to add support for all major features of a PWA-enabled storefront, to offer the best possible customer experience regardless of device or location.

## Open Source

Spartacus is open source. It will be continually developed by the SAP Commerce Cloud team, but we are very keen to welcome contributors and to foster an inclusive, active development community for Spartacus.

See [Contributing to the Spartacus Storefront]({{ site.baseurl }}{% link _pages/contributing/contributing-to-the-spartacus-storefront.md %}) for more information.

## Technology

The Spartacus storefront is part of our exciting new journey towards a customizable-yet-upgradable technology for SAP Commerce Cloud installations.

See [SAP Customer Experience](https://www.sap.com/products/crm/e-commerce-platforms.html) for more information about SAP Commerce Cloud.

## Storefront Features

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

Your Angular development environment should include the following:

- [Angular CLI:](https://angular.io/) Version **14.2.3** or newer.
- [Node.js:](https://nodejs.org/) Version **14.15** or newer (but **less than** version 15), or **16.10** or newer.
- [Yarn:](https://classic.yarnpkg.com/) Version **1.15** or newer.

For the back end, SAP Commerce Cloud version 2105 or higher is required.

**Note:** Some Spartacus features require API endpoints that are only available in newer versions of SAP Commerce Cloud. For more information, see [Feature Compatibility]({{ site.baseurl }}{% link _pages/home/feature-release-versions.md %}).

## Download and Installation

To get up and running with Spartacus, the recommended approach is to build your storefront application from ready-made libraries. You can also clone and build from source, but upgrading is not as simple.

Spartacus currently can only be used with a SAP Commerce Cloud instance through Commerce APIs.

For complete setup instructions, see the [Building the Spartacus Storefront from Libraries]({{ site.baseurl }}{% link _pages/install/frontend/building-the-spartacus-storefront-from-libraries.md %}) guide.

## Customizing and Extending Spartacus

To maintain our promise of upgradability, the design pattern for Spartacus is for non-core features to be built as feature libraries that add to or change the provided functionality.

When using Spartacus, you build an app that pulls in the Spartacus libraries, which contain the core resources needed to work with SAP Commerce Cloud. You then build new features that contain any custom functionality and pages.

Content for Spartacus pages is fetched from the SAP Commerce Cloud CMS (Content Management System), such as logos, links, banners and static pages. We recommend that new content-driven features follow the same pattern to enable Content Managers to modify page content through the CMS tools.

## How to Obtain Support

You can get support for Spartacus in the following ways:

- Get answers from our developers and the Spartacus community by asking a question on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront).
- Problem or bug? If you have a SAP Commerce Cloud license, create a [customer support ticket](https://launchpad.support.sap.com/#incident/create).
- For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ).

## Contributing

Team Spartacus welcomes feedback, ideas, requests, and especially code contributions.

- Post comments to our feedback channel in our [Slack](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ) workspace.
- Read [Contributing to the Spartacus Storefront]({{ site.baseurl }}{% link _pages/contributing/contributing-to-the-spartacus-storefront.md %}) to learn how to:
  - Help others
  - Report an issue
  - Contribute code to Spartacus

## Public Instance of Spartacus

This [public instance of Spartacus](https://spartacus-demo.eastus.cloudapp.azure.com/electronics-spa/en/USD/) is running on SAP Commerce Cloud (CCv2).

## License

Copyright (c) 2022 SAP SE or an SAP affiliate company. All rights reserved. This file is licensed under the Apache Software License, v.2 except as noted otherwise in the [LICENSE](https://github.com/SAP/spartacus/blob/develop/LICENSE.txt) file.

[![Deploys by Netlify](https://www.netlify.com/img/global/badges/netlify-color-bg.svg)](https://www.netlify.com)
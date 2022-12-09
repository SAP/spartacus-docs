---
title: Spartacus FAQ
---

If you have technical questions not answered in this FAQ, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ). Feedback welcome!

- [Questions Related to Spartacus as a Product](#questions-related-to-spartacus-as-a-product)
  - [What is Spartacus?](#what-is-spartacus)
  - [Does Spartacus require SAP Commerce Cloud?](#does-spartacus-require-sap-commerce-cloud)
  - [How does Spartacus integrate with SAP Commerce Cloud?](#how-does-spartacus-integrate-with-sap-commerce-cloud)
  - [Do I need to have a particular version of SAP Commerce Cloud in order to work with Spartacus?](#do-i-need-to-have-a-particular-version-of-sap-commerce-cloud-in-order-to-work-with-spartacus)
  - [Does Spartacus integrate with any other SAP products?](#does-spartacus-integrate-with-any-other-sap-products)
  - [Which browsers does Spartacus support?](#which-browsers-does-spartacus-support)
  - [How does Spartacus compare to the SAP Commerce Cloud Accelerators?](#how-does-spartacus-compare-to-the-sap-commerce-cloud-accelerators)
  - [Are there features that are missing in Spartacus that exist in the SAP Commerce Cloud Accelerators?](#are-there-features-that-are-missing-in-spartacus-that-exist-in-the-sap-commerce-cloud-accelerators)
  - [Can I run Spartacus and an Accelerator storefront at the same time?](#can-i-run-spartacus-and-an-accelerator-storefront-at-the-same-time)
  - [Does this mean the Accelerators will be deprecated?](#does-this-mean-the-accelerators-will-be-deprecated)
  - [If I’m currently using an SAP Commerce Cloud Accelerator, how do I migrate to a Spartacus-based storefront?](#if-im-currently-using-an-sap-commerce-cloud-accelerator-how-do-i-migrate-to-a-spartacus-based-storefront)
  - [How long does it take to get a Spartacus-based storefront up and running?](#how-long-does-it-take-to-get-a-spartacus-based-storefront-up-and-running)
  - [Is there a demo of a Spartacus-based storefront available?](#is-there-a-demo-of-a-spartacus-based-storefront-available)
  - [What enablement options exist for helping me understand how to use Spartacus? Is training available?](#what-enablement-options-exist-for-helping-me-understand-how-to-use-spartacus-is-training-available)
  - [Can I customize Spartacus?](#can-i-customize-spartacus)
  - [What is the release cycle for Spartacus?](#what-is-the-release-cycle-for-spartacus)
  - [What technologies does Spartacus use?](#what-technologies-does-spartacus-use)
  - [Does Spartacus implement Responsive Design?](#does-spartacus-implement-responsive-design)
  - [Is there going to be a version of Spartacus available to develop native iOS and/or Android apps?](#is-there-going-to-be-a-version-of-spartacus-available-to-develop-native-ios-andor-android-apps)
  - [Do I need to host my Spartacus JavaScript storefront? What is required?](#do-i-need-to-host-my-spartacus-javascript-storefront-what-is-required)
  - [What about SEO? I heard that single page storefronts result in lower SEO ranking and make it difficult to share pages on social media. Is this an issue with Spartacus?](#what-about-seo-i-heard-that-single-page-storefronts-result-in-lower-seo-ranking-and-make-it-difficult-to-share-pages-on-social-media-is-this-an-issue-with-spartacus)
  - [Does Spartacus scale? How?](#does-spartacus-scale-how)
  - [How do I get support when I run into issues with Spartacus?](#how-do-i-get-support-when-i-run-into-issues-with-spartacus)
  - [Is it possible to contribute to this open source project? How?](#is-it-possible-to-contribute-to-this-open-source-project-how)
  - [Will Spartacus work with Intelligent Selling Services for SAP Commerce Cloud?](#will-spartacus-work-with-intelligent-selling-services-for-sap-commerce-cloud)
- [Questions Related to Commercialization](#questions-related-to-commercialization)
  - [How much will Spartacus cost?](#how-much-will-spartacus-cost)
  - [Do I need to sign a contract to obtain a license?](#do-i-need-to-sign-a-contract-to-obtain-a-license)
  - [Are there any restrictions for using Spartacus? Can I sell a customized version of a Spartacus-based storefront?](#are-there-any-restrictions-for-using-spartacus-can-i-sell-a-customized-version-of-a-spartacus-based-storefront)
  - [More Questions?](#more-questions)

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Questions Related to Spartacus as a Product

### What is Spartacus?

Spartacus is an open-source JavaScript web application that allows you to quickly create your own branded JavaScript-based storefront for SAP Commerce Cloud. Spartacus is written using Angular and published as libraries. The recommended approach to using Spartacus is to build your own JavaScript web app and import the libraries. Without modification, the storefront works out of the box, but Spartacus has been designed to be upgradable, customizable, and extensible, to suit all your branding and functionality requirements.

You can view the Spartacus source code in this [GitHub repository](https://github.com/SAP/spartacus).

### Does Spartacus require SAP Commerce Cloud?

Spartacus is designed to work with SAP Commerce Cloud, although it is possible to use Spartacus with other systems. For more information, see [{% assign linkedpage = site.pages | where: "name", "connecting-to-other-systems.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/backend_communication/connecting-to-other-systems.md %}).

Having said that, Spartacus relies on SAP Commerce Cloud APIs and CMS content to function out-of-the-box. However, if you’re using SAP Commerce Cloud, you are not required to use Spartacus. You can create your own JavaScript web application or you can use Accelerator templates.  

### How does Spartacus integrate with SAP Commerce Cloud?

Spartacus is 100% API-driven; in this case, the SAP Commerce Cloud instance is run in a headless fashion.  The Spartacus storefront makes the necessary calls to SAP Commerce Cloud via the RESTful APIs that are part of the [Omni Commerce Connect extensions](https://help.sap.com/viewer/e5d7cec9064f453b84235dc582b886da/latest/en-US/8c19ab00866910148f87bf32d4a60d38.html). This decoupling allows you to separate front end and back end development, permitting independent update cycles.

### Do I need to have a particular version of SAP Commerce Cloud in order to work with Spartacus?

SAP Commerce Cloud 2105 or newer is required.

### Does Spartacus integrate with any other SAP products?

Yes. For more information, see [{% assign linkedpage = site.pages | where: "name", "integrations.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/integrations/integrations.md %}).

### Which browsers does Spartacus support?

Spartacus actively supports evergreen web browsers. Non-evergreen browsers that support the same standards as evergreen browsers will typically work as well. For older browsers that do not support these standards, you can add the necessary support with custom implementations. For more information, see [{% assign linkedpage = site.pages | where: "name", "browser-support.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/browser-support.md %}).

### How does Spartacus compare to the SAP Commerce Cloud Accelerators?

[Accelerator templates](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/8adca7a186691014bd31f1d2d96624f5.html) were introduced in SAP Commerce v4.4 to provide a ready-to-use starter implementation; they allowed partners to quickly develop an omni-channel experience by changing an example storefront. While extensible, the templates were not easily upgradable, they were JSP-based, and the storefronts were coupled tightly with the platform. Spartacus is a set of libraries that help you create a decoupled, modern, JavaScript-based storefront that is similarly extensible but vastly more upgradable. Spartacus is the strategic way forward for maintaining a customizable storefront with SAP Commerce Cloud. Please see the article [Choosing Which Storefront to Use for Your SAP Commerce Cloud Solution](https://www.sap.com/cxworks/article/435949087/choosing_which_storefront_to_use_for_your_sap_commerce_cloud_solution) for more information on this topic.

### Are there features that are missing in Spartacus that exist in the SAP Commerce Cloud Accelerators?

At the 1.0 release, Spartacus will not have feature parity when compared with all the Accelerators available in SAP Commerce Cloud. The focus to begin with is to achieve feature parity with the B2C accelerator. Feature parity with B2B, China and Industry Accelerators will come in the future. Feature parity will be documented.

### Can I run Spartacus and an Accelerator storefront at the same time?

Yes. Spartacus-based storefronts are decoupled from SAP Commerce Cloud, so you can run both your Accelerator template-based store and Spartacus storefront. In SAP Commerce Cloud, this would be a matter of configuring your code, aspects, and endpoints correctly. For more information, see [{% assign linkedpage = site.pages | where: "name", "external-routes.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/dev/routes/external-routes.md %}) and [Backwards Compatibility with Accelerators]({{ site.baseurl }}/adding-and-customizing-routes/#backwards-compatibility-with-accelerators).

### Does this mean the Accelerators will be deprecated?

Eventually. We will announce deprecation and removal plans at a later date. Our goal is to move all customers to Spartacus, or at least JavaScript-based storefronts. All current development efforts are focused on improving Spartacus. For the moment, Accelerator templates are receiving critical and blocker bug or security fixes only. At the very least, Accelerator templates won’t be deprecated until Spartacus achieves feature parity. Spartacus is the strategic way forward for maintaining a customizable storefront with SAP Commerce Cloud. Please see the article [Choosing Which Storefront to Use for Your SAP Commerce Cloud Solution](https://www.sap.com/cxworks/article/435949087/choosing_which_storefront_to_use_for_your_sap_commerce_cloud_solution) for more information on this topic.

### If I’m currently using an SAP Commerce Cloud Accelerator, how do I migrate to a Spartacus-based storefront?

Spartacus is a complete paradigm shift from the Accelerators in terms of technologies and architecture (libraries vs. template, headless vs. embedded, Angular vs JSP). As such, there is no direct way to migrate from an Accelerator-based storefront to one that uses the Spartacus libraries. Given that it would take time to move an Accelerator-based storefront to Spartacus, we recommend a piece-by-piece approach, where parts of Spartacus functionality are used alongside Accelerator-based storefront, with seamless switching between the two. Another consideration is that custom functionality requires APIs for Spartacus. On the other hand, developing a JavaScript-based front end is a much faster process than with Accelerator.

### How long does it take to get a Spartacus-based storefront up and running?

Assuming a vanilla SAP Commerce Cloud B2C back end is up and running and configured to accept OCC API calls, a developer can get create a Spartacus-based storefront within 10 minutes. See [{% assign linkedpage = site.pages | where: "name", "building-the-spartacus-storefront-from-libraries.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/frontend/building-the-spartacus-storefront-from-libraries.md %}).

### Is there a demo of a Spartacus-based storefront available?

Yes! You can try out our demo [here](https://spartacus-demo.eastus.cloudapp.azure.com/electronics-spa/en/USD/).

### What enablement options exist for helping me understand how to use Spartacus? Is training available?

Documentation is available from the Spartacus GitHub Pages [documentation site](https://sap.github.io/spartacus-docs/). We are starting a collection of [helpful how-to videos](https://microlearning.opensap.com/category/Spartacus/178316081). Official training via SAP Education is not planned for launch but may be made available in the future.  

### Can I customize Spartacus?

Spartacus is a set of libraries that contain core libraries, components and styling. You can choose which versions of the libraries you would like to use in your application, and these can be used to fully configure and customize your storefront. However, customization is not done in the same way as with Accelerator; you never customize Spartacus code directly – rather, you override or replace styling and code. This approach allows ease of upgradability.

### What is the release cycle for Spartacus?

Spartacus releases are independent of the release cycle of SAP Commerce Cloud. Generally, new Spartacus libraries will be released every 2 weeks.

### What technologies does Spartacus use?

Spartacus uses a combination of languages, technologies and libraries, including Angular, TypeScript, RxJS, NgRx, SASS, and Bootstrap. The final output is pure JavaScript. Angular is currently used as our development framework, though the goal is to allow usage of other frameworks. Please see [{% assign linkedpage = site.pages | where: "name", "building-the-spartacus-storefront-from-libraries.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/frontend/building-the-spartacus-storefront-from-libraries.md %}) for the correct versions required.

### Does Spartacus implement Responsive Design?

Yes. Out-of-the-box, Spartacus supports mobile, tablet, desktop, and wide-desktop breakpoints, and you can configure your own.

### Is there going to be a version of Spartacus available to develop native iOS and/or Android apps?

There are no plans for native mobile apps. Spartacus implements Responsive Design (so that the storefront layout looks correct in mobile devices) and is also a Progressive Web App (PWA) (so that the storefront behaves similar to a native app, although this feature is not complete yet). Capabilities are being added that will allow your storefront to act more like a traditional native mobile application, with great performance and reliability, and mobile-native features.

### Do I need to host my Spartacus JavaScript storefront? What is required?

You can host, or we can. SAP Commerce Cloud in the Public Cloud includes support for building and deploying [JavaScript storefronts](https://help.sap.com/viewer/b2f400d4c0414461a4bb7e115dccd779/latest/en-US/d1a3de28d67c4a418eabbba532238f9b.html). If you’re hosting an on-premise version of SAP Commerce, then you will need to determine where to best build and deploy your storefront, as well as when/how to best scale it.

### What about SEO? I heard that single page storefronts result in lower SEO ranking and make it difficult to share pages on social media. Is this an issue with Spartacus?

Not an issue. No storefront would work without SEO. Spartacus is indeed a “SPA” (Single-Page Application), which improves performance and flexibility while only loading one page. In order to support SEO, Spartacus also supports Server-Side Rendering (SSR), which builds entire pages on the server side before providing content to the client. SSR provides web crawlers with access to individual pages for search indexing purposes. SSR also allows users to share a link to a page on social media, for example, and Spartacus also allows configuration of social media meta tags. Usage of SSR has the added benefit of greatly speeding up first time-to-view.

Your server must also support SSR functionality. For more information, see [Enabling Server-Side Rendering](https://help.sap.com/viewer/b2f400d4c0414461a4bb7e115dccd779/latest/en-US/cd5b94c25a68456ba5840f942f33f68b.html) on the SAP Help Portal.

### Does Spartacus scale? How?

Spartacus storefronts are JavaScript web applications that communicate to the back end through REST APIs. This means that Spartacus storefronts (or any JavaScript-based storefronts) are decoupled from the back end SAP Commerce Cloud instance; so its nodes can be scaled separately. Other scaling considerations such as a Content Delivery Network (CDN) can also be leveraged to help decrease load. Additionally, with PWA cache-first networking capabilities, you will have the option to cache resources locally on the user’s device.

### How do I get support when I run into issues with Spartacus?

You can get support for Spartacus in the following ways:

- Get answers from our developers and the Spartacus community by asking a question on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront).
- Problem or bug? If you have a SAP Commerce Cloud license, create a [customer support ticket](https://launchpad.support.sap.com/#incident/create).
- For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ).

### Is it possible to contribute to this open source project? How?

Yes. We welcome feedback, ideas, requests, and especially code contributions. If you have something to share, post comments to our [feedback](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ) channel in the Spartacus Slack space, or read the [{% assign linkedpage = site.pages | where: "name", "contributors-guide.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/contributing/landing-page/contributors-guide.md %}) and learn how to help others, report an issue, or contribute code to Spartacus.

### Will Spartacus work with Intelligent Selling Services for SAP Commerce Cloud?

Yes. For more information, see [{% assign linkedpage = site.pages | where: "name", "cds-integration.md" %}{{ linkedpage[0].title }}]({{ site.baseurl }}{% link _pages/install/integrations/cds-integration.md %}).

------

## Questions Related to Commercialization

### How much will Spartacus cost?

Spartacus is free, whether you are using the libraries or forking the source code (though forking is not recommended for upgradability reasons). Spartacus does come with a [license](https://github.com/SAP/spartacus/blob/develop/LICENSE.txt), which is based off the Apache Software License, v2.

### Do I need to sign a contract to obtain a license?

No. The [license](https://github.com/SAP/spartacus/blob/develop/LICENSE.txt) is embedded in the libraries and code you use from the open source project.

### Are there any restrictions for using Spartacus? Can I sell a customized version of a Spartacus-based storefront?

See the [license](https://github.com/SAP/spartacus/blob/develop/LICENSE.txt). Generally, however, the Apache license is permissive and allows you to sell new works based off of Spartacus. See [this article](https://resources.whitesourcesoftware.com/blog-whitesource/top-10-apache-license-questions-answered) for more background information. (These answers do not constitute official legal advice.)

------

### More Questions?

Join our [Spartacus Slack channel](https://join.slack.com/t/spartacus-storefront/shared_invite/zt-jekftqo0-HP6xt6IF~ffVB2cGG66fcQ) and ask a question.

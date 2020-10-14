---
title: Spartacus FAQ
---

If you have technical questions not answered in this FAQ, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU). Feedback welcome!

- [Questions Related to Spartacus as a Product](#questions-related-to-spartacus-as-a-product)
- [Questions Related to Commercialization](#questions-related-to-commercialization)

## Questions Related to Spartacus as a Product

### What is SAP Commerce Cloud (Project Spartacus)? (referred to as just “Spartacus”)

Spartacus is an open-source JavaScript web application hosted [here](https://github.com/SAP/cloud-commerce-spartacus-storefront) that allows you to quickly create your own branded JavaScript-based storefront for SAP Commerce Cloud. Spartacus is written using Angular and published as libraries. The recommended approach to using JavaScript is to build your own JavaScript web app and import the libraries. Without modification, the storefront works out of the box, but Spartacus has been designed to be upgradable, customizable, and extendable, to suit all your branding and functionality requirements.

### Does Spartacus require SAP Commerce Cloud?

Spartacus is designed to work with SAP Commerce Cloud platform only. Spartacus relies on SAP Commerce Cloud APIs and CMS content to function. However, if you’re using SAP Commerce Cloud, you are not required to use Spartacus. You can create your own JavaScript web application or you can use Accelerator templates.  

### How does Spartacus integrate with SAP Commerce Cloud?

Spartacus is 100% API-driven; in this case, the SAP Commerce Cloud instance is run in a headless fashion.  The Spartacus storefront makes the necessary calls to SAP Commerce Cloud via the RESTful APIs that are part of the Omni-Commerce Connect extensions (link). This decoupling allows you to separate front-end and back-end development, permitting independent update cycles.

### Do I need to have a particular version of SAP Commerce Cloud in order to work with Spartacus?

SAP Commerce Cloud 1905 is strongly recommended due to required changes to APIs that are included in that release. Spartacus does partially work with 1811 and 1808 as well as 6.7, but due to API improvements since then, and adoption of new CMS components, some features will not work. For example, SmartEdit and extendable checkout only work in 1905. Spartacus won’t work with anything before 6.7 because Spartacus is CMS-based, and the CMS OCC API was first introduced in 6.7.

### Does Spartacus integrate with any other SAP products?

Spartacus libraries will be integrated with SAP Cloud Platform Extension Factory and SAP Commerce Cloud Context Driven Services (Q4 2019 expectation), among other products. These differences will be described in the Spartacus documentation and/or by their respective product documentation.

### Which browsers does Spartacus support?

Spartacus is built using the Angular framework, which has its own [browser support](https://angular.io/guide/browser-support) page. Note that Spartacus only provides library code, so the application that you build with the Spartacus libraries can affect which browsers are supported. For example, your application settings will dictate the supported version of JavaScript and the CSS build (PostCSS). You can also use certain polyfills to add missing browser features.

On the desktop, Spartacus supports Chrome with automated tests, and in general, Spartacus supports evergreen browsers. By default, Spartacus does not support IE11 because IE11 is missing certain modern browser features, such as support for CSS variables.

Spartacus supports browsers on mobile and tablet platforms as follows:

- On iOS-based devices, Spartacus is tested with Safari and Chrome. Although other browsers are not tested, Spartacus should work with any iOS browser, because all iOS browsers use the Webkit-based iOS browser engine.
- On Android-based devices, Spartacus is tested with Chrome, which is based on Chromium and the Blink layout engine. Any Android browser that uses the same engine will likely work with Spartacus. Other browsers using different browser engines are not tested, but those browsers that use Webkit should work as well.

### How does Spartacus compare to the SAP Commerce Cloud Accelerators?

Accelerators templates (link) were introduced in SAP Commerce v4.4 to provide a ready-to-use starter implementation; they allowed partners to quickly develop an omni-channel experience by changing an example storefront. While extendable, the templates were not easily upgradable, they were JSP-based, and the storefronts were coupled tightly with the platform. Spartacus is a set of libraries that help you create a decoupled, modern, JavaScript-based storefront that is similarly extendable but vastly more upgradable. Spartacus is the strategic way forward for maintaining a customizable storefront with SAP Commerce Cloud. Please see the article “Choosing Which Storefront to Use for Your SAP Commerce Cloud Solution” for more information on this topic. 

### Are there features that are missing in Spartacus that exist in the SAP Commerce Cloud Accelerators?

At the 1.0 release, Spartacus will not have feature parity when compared with all the Accelerators available in SAP Commerce Cloud. The focus to start is to achieve feature parity with the B2C accelerator. Feature parity with B2B, China and Industry accelerators will come in the future. Feature parity will be documented. 

### Can I run Spartacus and an Accelerator storefront at the same time?

Yes. Spartacus-based storefronts are decoupled from SAP Commerce Cloud, so you can run both your Accelerator template-based store and Spartacus storefront. In SAP Commerce Cloud, this would be a matter of configuring your code, aspects, and endpoints configured correctly. See the product documentation here and here for more. 

### Does this mean the Accelerators will be deprecated?

Eventually. We will announce deprecation and removal plans at a later date. Our goal is to move all customers to Spartacus, or at least JavaScript-based storefronts. All current development efforts are focused on improving Spartacus. For the moment, Accelerator templates are receiving critical and blocker bug or security fixes only. At the very least, Accelerator templates won’t be deprecated until Spartacus achieves feature parity. Spartacus is the strategic way forward for maintaining a customizable storefront with SAP Commerce Cloud. Please see the article “Choosing Which Storefront to Use for Your SAP Commerce Cloud Solution” for more information on this topic. 

### If I’m currently using an SAP Commerce Cloud Accelerator, how do I migrate to a Spartacus-based storefront?

Spartacus is a complete paradigm shift from the Accelerators in terms of technologies and architecture (template vs. libraries, headless vs. embedded, JSP vs Angular). As such there is no direct way to migrate from an Accelerator-based storefront to one that uses the Spartacus libraries. Given that it would take time to move an Accelerator-based storefront to Spartacus, we recommend a piece-by-piece approach, where parts of Spartacus functionality are used alongside Accelerator-based storefront, with seamless switching between the two. Another consideration is that custom functionality requires APIs for Spartacus. On the other hand, developing a JavaScript-based front-end is a much faster process than with Accelerator. 

### How long does it take to get a Spartacus-based storefront up and running?

Assuming a vanilla SAP Commerce Cloud B2C backend is up and running and configured to accept OCC API calls, a developer can get create a Spartacus-based storefront within 10 minutes. See [Building the Spartacus Storefront from Libraries]({{ site.baseurl }}{% link _pages/install/building-the-spartacus-storefront-from-libraries.md %}).

### Is there a demo of a Spartacus-based storefront available?

Try out our continuous-integration server [here](https://sap.github.io/cloud-commerce-spartacus-storefront).

### What enablement options exist for helping me understand how to use Spartacus? Is training available?

Documentation is available from the Spartacus GitHub Pages [documentation site](https://sap.github.io/cloud-commerce-spartacus-storefront-docs/). We are starting a collection of [helpful how-to videos](https://enable.cx.sap.com/tag/tagid/spartacus). Official training via SAP Education is not planned for launch but may be made available in the future.  

### Can I customize Spartacus?

Spartacus is a set of libraries that contain core libraries, components and styling. You can choose which versions of the libraries you would like to use in your application, and these can be used to fully configure and customize your storefront. However, customization is not done in the same way as with Accelerator; you never customize Spartacus code directly – rather, you overwride or replace styling and code. This approach allows ease of upgradability. 

### What is the release cycle for Spartacus?

Spartacus releases are independent of the release cycle of SAP Commerce Cloud. Generally, new Spartacus libraries will be released every 2 weeks.

### What technologies does Spartacus use?

Spartacus uses a combination of languages, technologies and libraries, including Angular, TypeScript, RxJS, NgRx, SASS, and Bootstrap. The final output is pure JavaScript. Angular is currently used as our development framework, though the goal is to allow usage of other frameworks. Please see [Building the Spartacus Storefront from Libraries]({{ site.baseurl }}{% link _pages/install/building-the-spartacus-storefront-from-libraries.md %}) for the correct versions required.

### Does Spartacus implement Responsive Design?

Yes. Out-of-the-box, Spartacus supports mobile, tablet, desktop, and wide-desktop breakpoints, and you can configure your own. 

### Is there going to be a version of Spartacus available to develop native iOS and/or Android apps?

There are no plans for native mobile apps. Spartacus implements Responsive Design (so that the storefront layout looks correct in mobile devices) and is also a Progressive Web App (PWA) (so that the storefront behaves similar to a native app, although this feature is not complete yet). Capabilities are being added that will allow your storefront to act more like a traditional native mobile application, with great performance and reliability, and mobile-native features.

### Do I need to host my Spartacus JavaScript storefront? What is required?

You can host, or we can. SAP Commerce Cloud in the public cloud includes support for building and deploying JavaScript storefronts (link). If you’re hosting an on-premise version of SAP Commerce, then you will need to determine where to best build and deploy your storefront, as well as when/how to best scale it.

### What about SEO? I heard that single page storefronts result in lower SEO ranking and make it difficult to share pages on social media. Is this an issue with Spartacus?

Not an issue. No storefront would work with SEO. Spartacus is indeed a “SPA” (Single-Page Application), which benefits performance and flexibility while only loading one page. In order to support SEO, Spartacus also supports Server-Side Rendering (SSR), which builds entire pages on the server side before providing to the client. SSR provides web crawlers with access to individual pages for search indexing purposes. SSR also allows users to share a link to a page on things like social media, and Spartacus also allows configuration of social media meta tags. Usage of SSR has the added benefit of greatly speeding up first time-to-view.

Your server must also support SSR functionality. Support for SSR will be added to SAP Commerce Cloud hosting services Q3 2019. 

### Does Spartacus scale? How?

Spartacus storefronts are JavaScript web applications that communicate to the back end through REST APIs. This means that Spartacus storefronts (or any JavaScript-based storefronts) are decoupled from the back end SAP Commerce Cloud instance; so its nodes can be scaled separately. Other scaling considerations such as a Content Delivery Network (CDN) can also be leveraged to help decrease load. Additionally, with PWA cache-first networking capabilities, you will have the option to cache resources locally on the user’s device.

### How do I get support when I run into issues with Spartacus?

Spartacus is provided "as-is" with no official lines of support. To get help from the Spartacus community, you can get in touch with us on [Stack Overflow](https://stackoverflow.com/questions/tagged/spartacus-storefront). For non-technical questions, you can reach us on our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU). 

### Is it possible to contribute to this open source project? How?

Yes. We welcome feedback, ideas, requests, and especially code contributions. If you have something to share, post comments to our Feedback chat in the Slack channel, or read the Contributing document and learn how to help others, report an issue, or contribute code to Spartacus. 

### Is Spartacus the same as SAP Cloud Platform Extension Factory (Kyma)?

No they are different. SAP Cloud Platform Extension Factory is the key extensibility layer for the SAP C/4HANA suite. It leverages the concepts and innovations from [project "Kyma" Field] to use scalable microservices. Spartacus storefronts can easily access these API-based services so that you can quickly add new functionality to your storefront.

### Will Spartacus work with SAP Commerce Cloud, Context Driven Services?

Yes. Support for contextual journey tracking will be added to Spartacus, scheduled for Q3 2019.

------

## Questions Related to Commercialization

### How much will Spartacus cost?

Spartacus is free to use as libraries and to fork the source code (though forking is not recommended for upgradability reasons). It does come with a license, which is based off the Apache Software License, v2 – see the [license file](https://github.com/SAP/cloud-commerce-spartacus-storefront/blob/master/LICENSE).  

### Do I need to sign a contract to obtain a license?

No. The license (link) is embedded in the libraries and code you use from the open source project. 

### Are there any restrictions for using Spartacus? Can I sell a customized version of a Spartacus-based storefront?

See the license ([link](https://github.com/SAP/cloud-commerce-spartacus-storefront/blob/develop/LICENSE.txt)). Generally, however, the Apache license is permissive and allows you to sell new works based off of Spartacus. See [this article](https://resources.whitesourcesoftware.com/blog-whitesource/top-10-apache-license-questions-answered) for more background information. (These answers do not constitute legal official advice.) 

------

### More Questions?

Join our [Spartacus Slack channel](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTg1NGVjZmFkZjQzODc1MzFhMjc3OTZmMzIzYzg0YjMwODJiY2YxYjA5MTE5NjVmN2E5NjMxNjEzMGNlMDRjMjU) and ask a question.



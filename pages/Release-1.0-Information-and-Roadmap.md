# Spartacus Roadmap

*aka the P.O.'s soapbox*

*Last updated April 25, 2019 by Bill Marcotte, Senior Product Manager, Spartacus*

This document describes what we expect to be included in the first release of Spartacus libraries and what is planned post-release.

If you have any questions, use the 'help' channel of our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTRiNTFkMDJlZjRmYTBlY2QzZTM3YWNlYzJkYmEwZDY2MjM0MmIyYzdhYmQwZDMwZjg2YTAwOGFjNDBhZDYyNzE). Feedback welcome!



### *Disclaimer - Forward-Looking Statements*

*This document contains forward-looking statements. All forward-looking statements are subject to various risks and uncertainties that could cause actual results to differ materially from expectations. Readers are cautioned not to place undue reliance on these forward-looking statements, which speak only as of their dates, and they should not be relied upon in making purchasing decisions. Any information is subject to change for any reason without notice. The information in this document is not a commitment, promise or legal obligation to deliver any material, code or functionality.  This document is provided without a warranty of any kind, either express or implied, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. This document is for informational purposes and may not be incorporated into a contract. SAP assumes no responsibility for errors or omissions in this document, except if such damages were caused by SAP’s intentional or gross negligence.*



### Release 1.0.0 - aiming for Q2 2019 / Mid-June

As of this writing

- Spartacus is currently in 'alpha' status - this means we are still adding features
- We plan to go to 'beta' in late May, exact date to be determined, probably May 22; when we move to beta, it means that we are no longer adding features or making architectural changes that will cause upgrade issues
- The first release (1.0) is planned towards mid-June, a few weeks after the scheduled release-to-customers of SAP Commerce Cloud 1905
- To be able to use all functionality in Spartacus 1.0, SAP Commerce Cloud 1905 is required; most of Spartacus can work with 1811 and previous releases, with no guarantees the farther back you go. Specifically, the following features require 1905:
  - SmartEdit support
  - Any usage of  new CmsFlexComponents or SiteContextComponent (although you can use other components such as JspComponent)
  - Forgot password / reset
- We usually release new libraries every 2 weeks (hosted on npmjs.com)



### High-level list of features to be included in 1.0

*Note: Items with a \* are planned but not yet complete and released, as of date of update of this document.*

Customer-facing storefront features:

| Page/Area                  | Notes                                                        |
| -------------------------- | ------------------------------------------------------------ |
| Header                     | Displays language and currency selection, shortcut links to storefinder, help and sample information pages, logo, search box, cart icon, category bar, and breadcrumbs |
| Footer                     | Displays company links and copyright notice                  |
| Home                       | Driven by CMS page layout and slots                          |
| Search                     | Search box in header displays search and product suggestions; search results include facets provided by backend |
| Categories                 | Category menus in header display up to 2 levels; category results include facets provided by backend |
| Product details            | Displays product title, images, price, quantity selection, add to cart, stock, and summary; supplementary information area includes details, specifications, reviews, and shipping information |
| Added-to-cart modal        | Displays confirmation that a product was added to the cart; can change quantity in the modal |
| Authentication             | Registration, login, and forgot password                     |
| Cart page                  | Displays list of items in the cart and purchase summary; allows change of quantity and removal of items |
| Checkout                   | Typical step-by-step checkout allowing customer to enter shipping and payment details, choose shipping method, and then review before submitting order; new shipping addresses and payment methods are saved automatically; customers can choose from saved shipping addresses and payment methods; confirmation displayed after successful order submission; can replace entire checkout process or is extendable on a step-by-step basis\* |
| Order History              | Displays list of orders and details for a specific order; orders are listed by consignment |
| Address Management         | Displays list of saved shipping addresses; customers can add new shipping addresses, edit and delete shipping addresses, and make set a shipping address as the default |
| Payment  Method Management | Displays list of saved payment methods; customers can delete payment methods, and make a payment method the default |
| Account Settings           | Displays and allows customers to edit their name, email address, password and consent preferences\*; also allows the customer to request account closure |
| Storefinder                | Displays list of stores and allows customer to search for a store based on location |
| Add to Home                | Allows the customer to add the storefront web app to their device Home or Launch screen, as if the storefront were a native app (search for "PWA Add to Home" for more information) |

Architectural and foundational features:

| Topic/Area                       | Notes                                                        |
| -------------------------------- | ------------------------------------------------------------ |
| Decoupled                        | Communicates through API's only; uses SAP Commerce Cloud APIs ootb but can connect to microservices or other API-based Internet sources |
| Upgradable libraries             | Semantic versioning used; recommendation is to use the libraries (don't fork the source code) |
| Extendable architecture          | Replace existing components with custom components; add custom components before or after existing components; customize component-specific business logic; re-use public internal services |
| Customizable Styling             | Global variables for ease of branding; precise selectors for fine-tuning styling; also useful for certain simple positioning changes |
| Responsive Design                | Layouts display properly on devices of different sizes; ootb viewports include mobile, tablet, desktop, wide desktop; configurable |
| CMS                              | Driven almost completely by CMS provided by SAP Commerce backend; can be used for marketing content and also as placeholders for injecting functionality; can use third-party systems |
| SmartEdit                        | SmartEdit supported; same functionality seen in Accelerator (requires SAP Commerce 1905) |
| Routing                          | Allows configuration of all site URLs (e.g. /products/shoes); configurable in Spartacus application but also controlled by CMS routing configuration defined in the backend (thus editable by SmartEdit); includes default configurations so no customization necessary to get Spartacus working |
| SSR                              | SSR (Server-Side Rendering) supported, where HTML page is rendered on the server instead of on the client; required to for SEO / search site indexing; also improves performance of first time-to-view |
| SEO                              | Stateful URLs for every part of the storefront; search engine indexing supported by way of SSR; configurable routing; page meta resolvers including title, description, image (og:image), and robots |
| Cache-first networking           | Caching of shell app                                         |
| Localization                     | All texts localizable (texts that are part of the storefront code only; some texts come from backend CMS components, translated in backend) |
| Customer behavior tracking       | Track user behavior for use with Context-Driven Services\*; require user consent before clickstream is tracked for the purpose of personalization (either anonymous or through registration preference) |
| Cloud Platform Extension Factory | Connectivity supported\*                                      |
| Builds with CCv2                 | JavaScript appiclications such as Spartacus-based storefronts can be built alongside SAP Commerce using Commerce Cloud v2 |



### How Spartacus is Versioned

Spartacus is following semantic versioning (Major.Minor.Patch).

- A new patch release (1.2.3 > 1.2.4 for example) means we added fixes or small improvements but no new features.
- A new minor release (1.2.4 > 1.3.0 for example)  means we added a new feature and possibly fixes and improvements.

For both patch and minor releases, upgrading to the new libraries should not cause any compatibility problems with your storefront app. If anything, a new feature might have to be turned off because you don't wish to use it. We hope you will upgrade frequently.

- A new major release (1.3.2 > 2.0.0 for example) means that, besides adding new features and improvements, we made changes that will likely cause compatibility issues. Your app likely needs updating when moving to a new major release. These effects, reasons, and benefits will be documented.

We don't plan to introduce a new major release for at least six months (end of 2019) if not later. The release of Angular Ivy (after Angular 8) is one factor in our eventual decision to do so.



### What's Coming after 1.0

We plan to release updates to the Spartacus libraries every 2 weeks.

Besides bug fixes and continuous improvement to user experience and performance, the following features are part of our roadmap *(with obligatory reminder about forward-looking statements and plans change over time)*. Feedback always welcome - contact Bill through our [Slack workspace](https://join.slack.com/t/spartacus-storefront/shared_invite/enQtNDM1OTI3OTMwNjU5LTRiNTFkMDJlZjRmYTBlY2QzZTM3YWNlYzJkYmEwZDY2MjM0MmIyYzdhYmQwZDMwZjg2YTAwOGFjNDBhZDYyNzE). 

End of Q3 2019:
- Buy online, pickup in store
- Guest checkout
- ASM - support for direct cart and checkout assistance 
- Coupons and promotions
- Consignment tracking
- Captcha
- Partial usage of Spartacus storefront libraries

Planned for Q4 2019 and beyond:
- Saved carts and wish lists
- Accessibility features
- Performance improvements through implementation of more cache-first networking
- Rest of ASM functionality
- B2B features such as My Company, approvals, scheduled replenishment
- Mobile device notifications
- Schema.org support
- Offline awareness
- Payments API
- Credentials API
- Other features that make up part of the PWA Checklist
- Feature parity with Accelerator
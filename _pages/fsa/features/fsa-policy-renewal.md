---
title: FSA Policy Renewal
---

**Note**: This feature is introduced with version 4.0 of the FSA Spartacus libraries.

The Policy Renewal process enables insurance carriers to provide their customers with the possibility to renew their policies online. 


***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Overview

The insurance company typically invites the policyholder to renew the policy near the end of its term.
Customers receive an Inbox message when their policy is up for renewal, and they are guided to a compare view of offered renewal options. 
In the Financial Services Accelerator's default implementation, the policy renewal process is triggered 31 days before the expiry of the current policy. 
This period is configurable from the back-end side through `FSPolicyRenewalCronJob`. 

The renewal process has been implemented for Auto, Life and Event Insurance, but can be applied to other categories and products. 
For more information, see Policy Renewal feature documentation on the [SAP Help Portal](https://help.sap.com/viewer/6ac05cfc1e2a41dca9cfa29de18cd01a/latest/en-US/3a9cfcf9213e42fd84092ea69519fa3b.html).

## Back-End Requirements

For more details on the back-end implementation, see Policy Renewal documentation on the [SAP Help Portal](https://help.sap.com/viewer/a7d0f0c5faa44002bf81e1a9a91c77e2/latest/en-US/06822db0248747e08464ab82501c9879.html).   

## Components

The renewal process relies heavily on the FSA Spartacus' Quote Comparison feature. For more detailed information, see [Quote Comparison]({{ site.baseurl }}{% link _pages/fsa/features/fsa-quote-comparison.md %}). 

## User Journey

When a policy is up for renewal, the policyholder receives a notification about it in the Inbox.

![Renewal Notifications in the Inbox]({{ site.baseurl }}/assets/images/fsa/policy-renewal/inbox-notification-unread.png)

The Inbox message contains a link that leads the customer directly to renewal options. 

![Renewal Notification Text]({{ site.baseurl }}/assets/images/fsa/policy-renewal/inbox-notification-text.png)

Following the link from the message, the customer lands on a quote comparison page, where the renewal offers are presented in a tabular view. 
If there is more than one offer, the customer can examine and compare the different product plans and choose the one that best fits their needs. 

In a typical scenario, the customer can choose to renew the policy with the existing product plan (highlighted with the star icon) or with an upgraded plan. 

![Renewal Quotes Comparison View - Auto Insurance]({{ site.baseurl }}/assets/images/fsa/policy-renewal/comparison-table-view-auto.png)

When there is a single renewal offer (for example, the customer already subscribed to the Life Premium product plan, so there is no upgrade), the purpose of this page is for the customer to preview the renewal offer before deciding whether to renew their policy or not.

![Renewal Quotes Comparison View - Life Insurance]({{ site.baseurl }}/assets/images/fsa/policy-renewal/comparison-table-view-life-selectQuoteButton.png)

Apart from the Inbox message, the customer can enter the renewal process from the **Quotes and Applications** page. 
Assuming there is more than one renewal offer for the relevant policy, the customer can select the offered quotes from this page and compare them.
Renewal quotes carry the relevant flag both on the back end (renewal flag is set to true on InsuranceQuoteModel) as on the UI, to differentiate them from regular quotes.

On the **Quotes and Applications** page, the user can single out renewal quotes can be using the filter. 

![Filtering Renewal Quotes on Quotes and Applications page]({{ site.baseurl }}/assets/images/fsa/policy-renewal/renewal-quotes-filter.png)

After that, the user can then easily select renewal quotes to compare them. 
The quote marked with the star is the one made based on the existing policy, while the other quote offers an upgraded plan. 
By clicking the **COMPARE QUOTES** button, the user is redirected to the Quote Comparison page.

![Comparing Renewal Quotes from Quotes and Applications page]({{ site.baseurl }}/assets/images/fsa/policy-renewal/quotes-and-applications-renewal-with-toast-message.png)

On the Quote Comparison page, the renewal offer made based on the existing policy is still highlighted with the star icon and has the existing policy number in the comparison table. 

![Highlighted Quote Based on Existing Policy]({{ site.baseurl }}/assets/images/fsa/policy-renewal/comparison-table-view-auto-highlighted-offer.png)

After examining the renewal offers, the customer opts for one of the offers by clicking the **SELECT QUOTE** button.

![Select Quote Button]({{ site.baseurl }}/assets/images/fsa/policy-renewal/comparison-view-auto-selectQuoteButton.png)

The customer then continues with the regular checkout steps, choosing the payment method and finalizing the purchase. 
Soon after the purchase, the customer receives two new notifications: one to confirm the renewal, and another to confirm the new policy purchase. 
The new policy can be seen on the **Policies** page of the **My Account** area, next to the current policy. 
The start day of the new policy is the end date of the current one.
Accepting one offer triggers creation of a new policy based on that offer and deletion of the second (discarded) quote.






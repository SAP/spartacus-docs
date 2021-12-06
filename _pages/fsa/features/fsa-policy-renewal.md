---
title: FSA Policy Renewal
---

**Note**: This feature is introduced with version 4.0 of the FSA Spartacus libraries.

The Policy Renewal process enables insurance carriers to provide their customers with the possibility to renew their policies online. 
Customers are notified via Inbox message when their policy is up for renewal, and they are guided to a compare view of offered renewal options. 
For more information, see Policy Renewal documentation on the [SAP Help Portal](https://help.sap.com/viewer/a7d0f0c5faa44002bf81e1a9a91c77e2/latest/en-US/3a9cfcf9213e42fd84092ea69519fa3b.html).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Overview

The insurance company typically invites the policyholder to renew the policy near the end of its term.
In the Financial Services Accelerator's default implementation, the policy renewal process is triggered 31 days before the expiry of the current policy. 
This period is, however, configurable.

The renewal process has been implemented for Auto, Life and Event Insurance, but can be applied to other categories and products.  

## User Journey

When a policy is up for renewal, the policyholder receives a notification about it in the Inbox.

![Renewal Notifications in the Inbox]({{ site.baseurl }}/assets/images/fsa/policy-renewal/inbox-notification-unread.png)

Besides the appropriate text, the Inbox message contains the link that leads the customer directly to renewal options. 

![Renewal Notification Text]({{ site.baseurl }}/assets/images/fsa/policy-renewal/inbox-notification-text.png)

Following the link from the message, the customer lands on a quote comparison page, where the renewal offers are presented in a tabular view. 
If there is more than one offer, the customer can examine and compare the different product plans and choose the one that best fits their needs. 

In a typical scenario, the customer can choose to renew the policy with the existing product plan (which is highlighted in the UI) or with an upgraded plan. 


![Renewal Quotes Comparison View - Auto Insurance]({{ site.baseurl }}/assets/images/fsa/policy-renewal/comparison-table-view-auto.png)

When there is a single renewal offer (for example, the customer already subscribed to the Life Premium product plan, so there is no upgrade), the purpose of this page is for the customer to preview the renewal offer before deciding whether to renew their policy or not.

Apart from the Inbox message, the customer can enter the renewal process from the **Quotes and Applications** page. 
Assuming there is more than one renewal offer for the relevant policy, the customer can select the offered quotes from this page and compare them.
Renewal quotes are marked with the relevant flag on the back end and the UI to differentiate them from regular quotes.

![Comparing Renewal Quotes from Quotes and Applications page]({{ site.baseurl }}/assets/images/fsa/policy-renewal/quotes-and-applications-select-and-compare.png)

After examining the renewal offers, the customer opts for one of the offered options by clicking the **SELECT QUOTE** button.

![Select Quote Button]({{ site.baseurl }}/assets/images/fsa/policy-renewal/comparison-view-auto-selectQuoteButton.png)

The customer then continues with the regular checkout steps, choosing the payment method and finalizing the purchase. 
Soon after the purchase, the customer receives two new notifications: one to confirm the renewal, and another to confirm the new policy purchase. 
The new policy can be seen on the **Policies** page of the **My Account** area, next to the current policy. The start day of the new policy is the end date of the current one.


## Implementation

The renewal process relies heavily on the Quote Comparison table. For more detailed information, see [Quote Comparison]. 



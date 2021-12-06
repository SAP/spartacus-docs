---
title: FSA Policy Renewal
---

**Note**: This feature is introduced with version 4.0 of the FSA Spartacus libraries.

The Policy Renewal process enables insurance carriers to provide their customers with the possibility to renew their policies online. Customers are notified via Inbox message when their policy is up for renewal, and they are guided to a compare view of offered renewal options. For more information, see Policy Renewal documentation on the [SAP Help Portal](https://help.sap.com/viewer/a7d0f0c5faa44002bf81e1a9a91c77e2/latest/en-US/3a9cfcf9213e42fd84092ea69519fa3b.html).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Initiating Policy Renewal Process 

The policy renewal process starts a certain time before the existing policy expires. This is called the *renewal period*. 

In the default implementation, the renewal process is triggered **31 days** before the expiry of the current policy. This period is, however, configurable.

**Note**: The policy renewal process is implemented on the Auto, Life and Event Insurance, but can be applied to other categories and products.  

## User Journey

When a policy is up for renewal, the policyholder receives a notification about it. When the customer logs into the portal, they can see the message in the Inbox.

![Renewal Notifications in the Inbox]({{ site.baseurl }}/assets/images/fsa/policy-renewal/inbox-notification-unread.png)


![Renewal Notification Text]({{ site.baseurl }}/assets/images/fsa/policy-renewal/inbox-notification-text.png)

Following the link from the message, the customer lands directly to a quote comparison page. The customer can see the renewal offers presented in a tabular view. If there is more than one offer, the customer can examine and compare the different product features and choose the plan that best fits their needs.

![Renewal Quotes Comparison View - Auto Insurance]({{ site.baseurl }}/assets/images/fsa/policy-renewal/comparison-table-view-auto.png)

When there is a single renewal offer, for example, the customer is already subscribed to the best insurance plan. the purpose of this page is for the customer to preview the renewal offer before deciding whether to renew their policy or not.

Besides the Inbox message, the customer can enter the renewal process from the Quotes and Applications page. After the renewal process is initiated and there is more than one renewal quote for the relevant policy, the customer can select the offered quotes and compare them. Usually, the customer can choose to continue with the existing product plan (which is highlighted in the UI) or renew their policy with an upgraded plan. The renewal quotes are marked with the relevant renewal flag so that they can be differentiated from regular quotes.

SCREENSHOT

After examining the renewal options, the customer opts for one of the offered options by clicking the **SELECT QUOTE** button.

![Select Quote Button]({{ site.baseurl }}/assets/images/fsa/policy-renewal/comparison-view-auto-selectQuoteButton.png)

What follows are the regular checkout steps, where the customer chooses the payment method and confirms the purchase. Soon after, the customer receives two new notifications: one to confirm the renewal and the regular notification to confirm the new policy purchase. The new policy can be seen on the Policies page, next to the current policy. The start day of the new policy is the end date of the current one.


## Implementation and Configuration 

The renewal process relies heavily on the Quote Comparison table. For more detailed information, see [Quote Comparison] 



---
title: Contract Renewals
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.0 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

To increase retention and customer loyalty, Operators or Service Providers offer eligible customers the ability to renew their contract (subscriptions) to avail benefit of special and discounted prices. Eligible customers are typically incentivized to renew with special promotional offers and price discounts.

A customer can renew eligible subscriptions resulting from a standalone product offering purchase based on the [Customer Product Inventory (CPI)](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/latest/en-US/612f26c3d5f14248965ad908cf5952f6.html?q=customer%20product%20inventory). If the eligibility policy is fulfilled, the customer sees an advertisement banner to renew subscription for a selected term, which may result in discounted prices. The customer can select one of the subscription terms and choose to renew, upon which the customer will be redirected to the cart that includes a cart entry for the selected subscribed product, together with information about the renewal terms.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Business Need

The feature enables the customers to renew their existing and eligible subscriptions online and update their product inventory.

## Business Use Case

A customer wants to renew an existing subscription that is eligible for renewal. The following procedure describes customer's subscription renewal journey:

1. Log in to the TUA Spartacus.

    **Note:** The banner is displayed only if your subscription is eligible for renewal as per the [eligibility](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/latest/en-US/602fadbbb42c40a68750d0dac7deba8a.html) rule.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/renew-subscription-button.png" alt="Renew Subscription Button"></p>

1. Navigate to **Account** -> **Subscriptions**. All subscriptions of the logged in customer are displayed.
1. Click on the header of the subscription that you want to renew. For example, *internet_22341 (Fiber Internet)*. The banner shows the default 12 months monthly billing subscription.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/my-subscriptions.png" alt="My Subscriptions"></p>

1. Select the monthly billing cycle from the drop-down to renew your subscription. For example, 18 months - monthly billing. The monthly renewal price and the discount offer is displayed.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/renew-banner.png" alt="Renew Banner"></p>

1. Click **Renew Subscription** on the banner to renew your subscription. The cart shows your subscription renewal information. For example, *Renew 18 months - monthly billing*.
1. Click **View Cart**. The cart displays all relevant information about your new subscription, such as the new monthly billing cycle, product offering, and the price details.
1. Click **Proceed to Checkout**. The *Shipping Address* screen is displayed. Confirm your shipping address, or you can even add a new shipping address.
1. Click **Continue**. The *Delivery Mode* screen is displayed. Select the shipping method from the options.
1. Click **Continue**. The *Payment Details* screen is displayed. Check the payment details. 
1. Click **Continue**. The *Review Order* screen is displayed. Review the order details, including the subscription renewal details.

    **Tip:** To edit or update your order details, click the pencil icon.

1. Click the **terms and conditions** checkbox and then click **Place Order**. Your order is successfully placed.
1. Navigate to **Account** -> **Order History** screen to view the order details with new  contract details.

## Feature Enablement

This feature is enabled on the banner using the **RenewSubscriptionComponent**. For more information, see [Components](#components).

The banner shows the contractual terms with prices and discount offers. After selecting subscription renewal billing cycle, click **Renew Subscription** to renew your subscription.

**Note** The [eligibility](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/latest/en-US/602fadbbb42c40a68750d0dac7deba8a.html) rules automatically determine if you are eligible for a renewal of one or more of your existing subscriptions. If you are not eligible, the banner does not display as depicted in the following figure:

 <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/No-renewal-eligibility.png" alt="No Renewal Eligibility"></p>

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 1.x, 1.2x, < 3.0                                          	|
| Telco & Utilities Accelerator	             	| Version 2102 (latest patch - 21.02)            	|
| SAP Commerce Cloud 	| Version 2011 (latest patch) 	|

## Configuring and Enabling Contract Renewals

For detailed information about configuring and enabling the feature, see [Eligibility](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/latest/en-US/602fadbbb42c40a68750d0dac7deba8a.html).

## Components

| Component   Name                 	| Status  	| Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 	|
|----------------------------------	|---------	|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
| RenewSubscriptionComponent       	| New     	| The component displays the Renewal button with the renewal banner component, which is used to add to cart entries with Retention process type. The text of the button is   controlled by the Hybris component "TmaRenewSubscriptionBannerComponent".                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        	|
| RenewSubscriptionBannerComponent 	| New     	| The component displays the renewal banner, eligible subscription terms and its relevant applicable prices for retention if the customer is eligible for the rentention journey. The component is mapped with the "TmaRenewSubscriptionBannerComponent" of Hybris.            The banner is displayed if the following conditions are fulfilled:           1.Subscription base is eligible for retention      2.Standalone price for retention      3.Subscribed product is not part of any bundle.            The banner displays the following:           1.The media attached with web component      2.All eligible terms for retention process type in drop down      3.When a particular subscription term is selected, the highest priority price is displayed.       4.The "Renew Now" button is displayed (see "RenewSubscriptionComponent" for more information). 	|
| SubscriptionDetailComponent      	| New     	| The component displays all subscribed products and their details. The Angular web component is mapped to the "AccountSubscriptionDetailsComponent" of Hybris.       The component displays:      1. Renew Banner (See "RenewSubscriptionBannerComponent" for more information)  2. All subscribed products are displayed as play cards (See "TmfProductComponent" for more information). |
| TmfProductComponent              	| Updated 	| The component displays the subscribed product details as play card on the frontend. |

## Further Reading

For further reading, see the following topics in the TUA Help portal.

- [Eligibility](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/latest/en-US/602fadbbb42c40a68750d0dac7deba8a.html)
- [Customer Product Inventory and Cart](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/latest/en-US/552515309dd545e7b7878eb081b56453.html)

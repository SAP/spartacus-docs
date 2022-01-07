---
title: Contract Termination (Without Assurance)
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.0 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

A contract termination is described as a contract being brought to an early end for any number of reasons. The effect of termination is to bring the contract to an end at a certain point and absolve parties of the majority of all ongoing obligations. The Contact Termination feature enables a customer to initiate a contract termination based on rules defined in the accelerator.

With the Contract Termination feature, while browsing TUA Spartacus, eligible customers can  terminate their existing active subscriptions resulting from a standalone purchase as per the configured The [eligibility](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/2102/en-US/602fadbbb42c40a68750d0dac7deba8a.html) policies, without any penalties. The eligible customers see the **Terminate** button on the header of the subscription, below the banner to terminate the subscription one day before the expiry of the subscription. When the customer clicks the **Terminate** button, an order is placed on behalf of the customer in the backend to complete the subscription termination.

**Note:** The **Terminate** button does not display below the subscription if the subscription is not active, and the expiry duration of the subscription is more than one day, as well as if the subscription is not a result of a standalone SPO purchase.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Business Need

This feature enables the eligible customers to terminate their existing, eligible, and active subscriptions online that resulted from a standalone purchase, and update their product inventory.

## Business Use Case

An eligible customer wants to terminate an existing and active subscription. The following procedure describes customer's subscription termination journey:

1. Log in to the TUA Spartacus.

    **Note:** Your active subscription below the banner is displayed only if your subscription is eligible for termination as per the [eligibility](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/latest/en-US/602fadbbb42c40a68750d0dac7deba8a.html) rules.

1. Navigate to **Account** -> **Subscriptions**. All subscriptions of the logged in customer are displayed.
1. Click on the header of the active subscription that you want to terminate. For example, *internet_22341 (Fiber Internet)*. The details of the subscription are displayed below the banner with the **Terminate** button.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/1banner-termination-button.png" alt="Banner Termination Button"></p>

-  Click **Terminate** to terminate your active subscription. A confirmation message, *Are you sure you want to terminate your subscription?* is displayed.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/confirmation-message.png" alt="Confirmation Message"></p>

- Click **Yes**. The cart screen displays the Order Number, date on which termination was initiated, and the status of termination.

## Feature Enablement

This feature is enabled on the banner using the **TerminationButtonComponent**. For more information, see [Components](#components).

If you are eligible as per the configured The [eligibility](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/2102/en-US/602fadbbb42c40a68750d0dac7deba8a.html) policies, the banner shows the subscription shows the **Terminate** button to terminate the subscription.

**Note** The [eligibility](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/2102/en-US/602fadbbb42c40a68750d0dac7deba8a.html) rules automatically determine if you are eligible to terminate one or more of your active and existing subscriptions. If you are not eligible, the **Terminate** button does not display as depicted in the following figure:

 <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/No-renewal-eligibility.png" alt="No Renewal Eligibility"></p>

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 3.0.0                                          	|
| Telco & Utilities Accelerator	             	| Version 2102 (latest patch)            	|
| SAP Commerce Cloud 	| Version 2011 (latest patch) 	|

## Configuring and Enabling Contract Termination

For detailed information about configuring and enabling the feature, see [Eligibility](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/latest/en-US/602fadbbb42c40a68750d0dac7deba8a.html).

## Components

| Component   Name                 	| Status  	| Description                                                                                                                                                                                                         	|
|----------------------------------	|---------	|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
| TerminationButtonComponent       	| New     	| The component provides an option to the user to terminate the subscribed product if it is eligible for termination. When you click the **Termination** button, the terminated subscribed is added to cart.               	|
| TmfProductComponent              	| Updated 	| The component is updated to include the **Termination** button component (see "TerminationButtonComponent")if the subscribed product is eligible for termination.                                                       	|
| TmaCartItemComponent             	| Updated 	| The component is updated to show action type with which a cart entry is added to the cart.                                                                                                                          	|
| RenewSubscriptionBannerComponent 	| Updated 	| The component is updated to check the retention eligibility only when a subscription contains an active product, so that if the subscribed product is in pending termination, the option of renewal is not visible.

## Further Reading

For further reading, see the following topics in the TUA Help portal.

- [Eligibility](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/latest/en-US/602fadbbb42c40a68750d0dac7deba8a.html)
- [Customer Product Inventory and Cart](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/latest/en-US/552515309dd545e7b7878eb081b56453.html)
- [Termination Process](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2105/en-US/055c4059f8794d158e60bfdccb10424b.html)

---
title: Sales Flow - Cross-Selling
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.2 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The purpose of cross-selling is to make existing subscribers aware and sell complementary products and services that would add value to their existing subscribed services.

In the subscription business, this means identifying an opportunity to offer customers products and services that complement their subscription or offering a second subscription that ties into their interests. 

In TUA, the cross-selling feature allows customers to purchase additional product offerings to a previously purchased bundled product offering (BPO).  Cross-selling is enabled within **My Subscriptions** or **Self-Care**. When applicable, a “GET MORE” button to purchase additional products and services will be displayed to the customer.  

Upon selection, the customer is redirected to the configurable guided selling journey for the original bundled product offering previously purchased. The customer will be able to browse through the bundled product offering and add further products and services to their cart and place the order. Existing selections that the customer owns cannot be changed. 

It is important to note that customers subscribed to a simple product offering (not a BPO) will not be able to add more products using the **Get More** cross-selling option.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Business Need

The purpose of cross-selling is to make existing subscribers aware and sell complementary products and services that would add value to their existing subscribed services.

## Business Use Case

An existing customer is subscribed to a Quad-Play offering that includes internet, a mobile device, a mobile rate plan, and television. The customer would like to add some additional services. The customer accesses the account and views the subscriptions. For the Quad-Play offering, the customer is eligible to continue the cross-selling journey and add additional products and services. 

The following procedure describes how to add more products to the subscription base:

1. Log in to the TUA Spartacus.

1. Navigate to **Account** -> **Subscriptions**. All subscriptions of the logged in customer are displayed.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/navigation-subscriptions-menu.png"></p>
    
1. Click the **1040123333333** subscription. 

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/subscription-list.png"></p>

1.  This is the Quad-Play subscription that includes the **Internet** and **Premium Unlimited** Plan. As the selected product is part of a bundle, the customer has the option to add more products and services to the subscription base. Click **GET MORE**.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/get-more.png"></p>

1.  The customer is redirected to the configurable guided selling journey.  The two previously purchased product offerings already appear in the cart and are preselected. 

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/cgs-two-prod-added.png"></p>

1. Click **Mobile plans**. The **Premium Unlimited plan** cannot be removed as it is part of the existing subscription plan. 

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/mobile-plans.png"></p>

1. Click **Mobile devices**.

1. Select **Apple iPhone 6**. The phone appears on the cart to the right with the price.

1. When all selections are done, click **Add to Cart**.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/add-to-cart.png"></p>

1. Click **View Cart** to view the details of the cart.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/view-to-cart.png"></p>

1.  Behind the scenes, the **Premium Unlimited Plan** and **Internet** have the retention or “keep” indicator so that the downstream systems understand that nothing is changing with the current subscription. For the **Apple iPhone 6**, behind the scenes, it will have a “add” indicator. Click **Proceed to Checkout**.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/view-cart-details.png"></p>
 
1. Continue through the checkout process. Select the **Terms & Conditions** check box. Click **Place Order** after reviewing the details of the selected order. 

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/place-order.png"></p>

1. The order confirmation page with details of the order placed is displayed.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/order-confirmation-page.png"></p>

## Feature Enablement

This feature is enabled through SPA 3.x on top of the Telco and Utilities Accelerator 2102 release. The cart is constructed for retention purchase flows and will maintain “add” and “keep” values for the cross-selling scenario.

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 3.2.0                                          	|
| Telco & Utilities Accelerator	             	| Version 2102 (latest patch - 21.02)            	|
| SAP Commerce Cloud 	| Version 2011 (latest patch) 	|

## Supported Backend Functionality

To support cross-selling, the Customer Product Inventory (CPI) is used to display current subscriptions. The cart and order are constructed as described in the following diagram.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/cart-order-construction-flow.png"></p>

The above flowchart displays all steps that a customer will encounter while doing a Cross Sell Flow for additional product offerings (POs) as part of an existing Subscription Base (corresponding to a BPO).


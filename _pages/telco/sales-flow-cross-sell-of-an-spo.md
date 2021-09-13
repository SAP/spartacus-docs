---
title: Sales Flow - Cross-Sell of an SPO
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.2 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The Cross-Sell feature allows customers to purchase additional product offerings (POs) as part of an existing Subscription Base (corresponding to a BPO). When a customer purchases POs, as part of a Bundled Product Offering (BPO), an option to add additional POs is displayed for the customer.

On selecting the option to add additional POs, the customer is redirected to a Guided Selling journey (CGS), which contains preselected POs for the ones that the customer already owns, which the customer will not be able to "unselect". The customer will be able to browse through the CGS and add further POs to their cart and place the order.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Business Need

The feature is required as it allows customers to update their CPI by purchasing additional product offerings (POs). It allows customers to purchase additional POs as part of an existing Subscription Base that corresponds to a BPO.

## Business Use Case

The following is an example of how a customer places an order for an existing Subscription Base with additional POs.

A customer accesses the subscription base that has a BPO. As part of the customer’s purchase, the Quad Play BPO includes the **Internet** and **Premium Unlimited Plan**.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/quad-play-plans.png"></p>

The customer wants to add more product offerings to the existing subscription base. The following procedure describes how to add more products to the subscription base:

1. Log in to the TUA Spartacus.

1. Navigate to **Account** -> **Subscriptions**. All subscriptions of the logged in customer are displayed.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/navigation-subscriptions-menu.png"></p>

    **Note:** The customer will not be able to add more products using the Get More cross-selling option if the selected product has only a single SPO.

1. Click the **1040123333333** subscription. 

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/subscription-list.png"></p>

1. As the selected product is part of the BPO, the customer now has the option to add more products to the subscription base.

1. Click **GET MORE**.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/get-more.png"></p>

1. The Configurable Guided Selling page displays the two products that were added. The **Quad Play** is now added with the **Premium Unlimited Plan** and **Internet** plan.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/cgs-two-prod-added.png"></p>

1. Click **Mobile plans**. Here, the **Premium Unlimited plan** cannot be removed as it is part of the existing subscription plan. 

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/mobile-plans.png"></p>

To add a mobile device:

1. Click **Mobile devices**.

1. Select **Apple iPhone 6**. The subscription now has the updated retention flow. All three products are part of the retention flow. Premium Unlimited Plan and Internet are part of the keep action type and Apple iPhone 6 is part of the add action type.

1. Click **Add to Cart**.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/add-to-cart.png"></p>

1. Click **View Cart** to view the details of all products.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/view-to-cart.png"></p>

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/view-cart-details.png"></p>

    The **Premium Unlimited Plan** and **Internet** have the retention tag with the subscription details. In case of **Apple iPhone 6**, since it is a new product, no subscription details are displayed for it.

1. Click **Proceed To Checkout**.

1. Click **Continue** to proceed with the default shipping address.

1. Click **Continue** to proceed with the selected shipping method.

1. Click **Continue** to proceed with the selected payment method.

1. Select the **Terms & Conditions** check box.

1. Click **Place Order** after reviewing the details of the selected order.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/place-order.png"></p>

1. The order confirmation page with details of the order placed is displayed.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/order-confirmation-page.png"></p>

## Feature Enablement

This feature is enabled through SPA 3.2 on top of Telco 2102. The cart is constructed for the RETENTION purchase flow, where everyone is eligible for it, that has cart actions as "KEEP" for existing subscribed products and "ADD" for the new subscribed products.

In the CGS and on the cart, the customer will not be able to remove cart entries that contains a link to the subscribed products, unless the entire BPO is removed.

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 1.x, 1.2x, < 3.0                                          	|
| Telco & Utilities Accelerator	             	| Version 2102 (latest patch - 21.02)            	|
| SAP Commerce Cloud 	| Version 2011 (latest patch) 	|

## Supported Backend Functionality

To support Cross Sell Flow, the Customer Product Inventory (CPI) is used as available in TUA. The Cart and Order is constructed as in the following flow diagram.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/cart-order-construction-flow.png"></p>

The above flowchart displays all steps that a customer will encounter while doing a Cross Sell Flow for additional product offerings (POs) as part of an existing Subscription Base (corresponding to a BPO).


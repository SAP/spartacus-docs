---
title: Media Storefront
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.1.0 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The Media Storefront feature enables customers browsing the Media SPA Store to see the product offerings and pricing details of the offerings that are defined by Business Administrators in the Backoffice. The product offerings are purchased from a dedicated product catalog.

To see a working example of the Media Storefront, see our [public instance](https://jsapps.cy8u-telcoacce1-s5-public.model-t.cc.commerce.ondemand.com/mediaspa/en/USD/).

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Business Need

The feature is required as it allows customers to browse the Media SPA and purchase product offerings from a dedicated product catalog. Customers will be able to view all available product offerings and prices for each of the product offerings that are configured by Business Administrators in the Backoffice.

## Business Use Case

As part of this feature, the customer can:
-   Browse media products in a dedicated store 
-   Register new account and login to existing account
-   View details in the Account section
-   Add a product offering to cart
-   Update and / or remove a cart entry
-   Complete the checkout flow
-   Purchase a BPO through a guided selling
-   View prices and discounts for the product offerings
-   Search product offerings
-   Place an order
-   View order list or details of the existing order
-   View existing subscriptions and subscription usage details of the existing subscriptions

**Media SPA Storefront Homepage**

1. Log in to TUA Spartacus. The Media SPA storefront homepage displays the following sections:
-   Upper: Navigation bar that includes **WATCH TV**, **MOVIES**, **MERCHANDISE**, and **SUBSCRIPTION PACKAGES**.
-   Middle: Includes two banners
-   Lower: Includes information related to **ACCELERATOR**, **HYBRIS**, **POLICIES**, and **FOLLOW US**.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/media-spa-hmepg.png" alt="Media SPA Storefront Homepage"></p>

**View Account Section – Order History**

1. Click the **Account** dropdown to view different sections that are listed.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/account-dropdown.png" alt="Account"></p>

2. Select **Order History** to view the details of an existing order.
3. Select the required Order number from the list of orders displayed. The **Shipped** section displays detailed information of the selected order.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/order-history-shipped-1.png" alt="Order History: Shipped"></p>

**View Account Section – Address Book**

1. Select **Address Book** to view the list of address that are already added.
1. Click **Add New Address** to add a new address.
1. Click **Edit** to update the existing address.
1. Click **Delete** to delete the existing address.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/address-book.png" alt="Address Book"></p>

**View Account Section – Payment Details**

1. Select **Payment Details** to view if any payment related details are saved.
1. Payment details such as card details are saved during the checkout flow when the customer places an order.
1. Click **Delete** if the saved details need to be removed from this section.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/payment-details.png" alt="Payment Details"></p>

**View Account Section – Personal Details, Password, Email Address**

1. Select **Personal Details** to update name-related details.
1. Select **Password** to add a new password.
1. Select **Email Address** to add and request for new email address.

**View Account Section – Consent Management**

1. Select **Consent Management** to provide consent to store data and receive e-mails for marketing campaigns.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/consent-management.png" alt="Consent Management"></p>

**View Account Section – Close Account**

1. Select **Close Account** to close the account permanently.

**View Account Section – Subscription and Usage Details**

1. Select **Subscriptions** to view the available subscriptions.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/subscription.png" alt="Subscription"></p>

1. Click the required subscription to view details of the active plan such as contract start and end date, order number, contract duration, and order prices.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/subscription-details.png" alt="Subscription Details"></p>

1. Click **Go Back To Subscriptions** to go to the actual page from where the order was placed.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/subscription-order-details.png" alt="Subscription Order Details></p>

1. Click **Usage Details** for the required subscriptions in the **MY SUBSCRIPTIONS** page. 
1. The corresponding page displays usage related details in a pie chart format. 

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/subscription-usage-details.png" alt="Subscription Usage Details"></p>

**Cart Product Offering - Add. Update, Remove**

To add a product offering to the cart:
1. Click the top banner to view the price details. 
1. Click **Add To Cart**.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/underworld-banner.png" alt="Underworld Banner"></p>

1. Add or remove the quantity, if required.
1. Click **View Cart**.
1. Click **Proceed to checkout**.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/proceed-to-checkout.png" alt="Proceed to Checkout"></p>

**Checkout Flow and Order Placement**

The checkout flow starts from here, and it is similar to the Telco SPA and the Utilities SPA.

-   Shipping Address
-   Delivery Mode
-   Payment Details
-   Review Order

The Shipping Address is selected by default. If required, you can add a new address.

1. Click **Continue**.
1. Select the required **Delivery Mode** from the **Shipping Method** section.
1. Click **Continue**.
1. In the **Payment Details** section. the payment method is selected by default. Either continue with the selected card or click **Add New Payment** to add a new card.
1. Click **Continue**.
1. Review the order details before placing the order.
1. Select the check box in the **ORDER SUMMARY** section.
1. Click **Place Order**. 

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/review-and-place-order.png" alt="Review and Place Order"></p>

**Order Confirmation – Order List and Order Details**

The order is placed and a confirmation page with the order details is displayed.

   <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/order-list-and-order-details-of-placed-order.png" alt="Order List and Order Details of Placed Order"></p>

**Purchase a BPO via a Guided Selling**

1. Go to Homepage and click the second banner. The configured guided selling page is displayed where the **Tricast Channels** pack is configured. 

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/tricast-channel-page.png" alt="Tricast Channel Page"></p>

1. Click **Select** to add the **YTV Channel** to the channel.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/added-ytv-channel.png" alt="Added YTV Channel"></p>

1. Click **Tricast Channels Plans**.
1. Click **Select** to add the **Tv Starter** to the channel plan.
1. Click **Add To Cart**.
1. Click **View Cart** to view the cart details.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/cgs-cart-details.png" alt="CGS Cart Details"></p>

    These details can either be modified or deleted.
1. Click **Proceed To Checkout**.
1. Go to the CGS checkout flow tabs by clicking **Continue**.
1. In the **Review Order** tab, select the check box in the **ORDER SUMMARY** section.
1. Click **Place Order**.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/cgs-place-order.png" alt="CGS Place Order"></p>

The order is placed and a confirmation page with the order details is displayed.

   <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/cgs-order-confirmation.png" alt="CGS Order Confirmation"></p>

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 1.x, 1.2x, < 3.0                                          	|
| Telco & Utilities Accelerator	             	| Version 2102 (latest patch - 21.02)            	|
| SAP Commerce Cloud 	| Version 2011 (latest patch) 	|

## Configuring Media SPA

The client application allows customers to configure certain variables that are exposed through  `TmaB2cStorefrontModule` so that the application is flexible.

Configure the values in app.module.ts in the imports section under `TmaB2cStorefrontModule.withConfig({ ... })` config.

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
.tg .tg-pcvp{border-color:inherit;text-align:left;vertical-align:top}
</style>
<table class="tg">
<thead>
  <tr>
    <th class="tg-0pky"><span style="font-weight:bold">Configurable   Variables</span></th>
    <th class="tg-0pky"><span style="font-weight:bold">Description</span></th>
    <th class="tg-0pky"><span style="font-weight:bold">Syntax</span></th>
    <th class="tg-0pky"><span style="font-weight:bold">Default   Values</span></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-pcvp">billingFrequency</td>
    <td class="tg-pcvp">List of billing frequency and their value in months.<br>Used for converting billing frequency string into their value in months.</td>
    <td class="tg-pcvp">Billing Frequency<br>
    billingFrequency: [<br>
        {<br>
            key:<br>
    <string>,<br>
            value:<br>
    <number>,<br>
    },<br>
    ...<br>
        {<br>
            key:<br>
    <string>,<br>
            value:<br>
    <number>,<br>
    }<br>
    ], 
    <td class="tg-pcvp">billingFrequency<br>billingFrequency: [<br>
    {<br>
            key:<br>
    'yearly',<br>
            value: 12,<br>
    },<br>
    {<br>
            key:<br>
    'year',<br>
            value: 12,<br>
    },<br>
    {<br>
            key:<br>
    'annually',<br>
            value: 12,<br>
    },<br>
    {<br>
            key:<br>
    'annual',<br>
            value: 12,<br>
    },<br>
    {<br>
            key:<br>
    'monthly',<br>
            value: 1,<br>
    },<br>
    {<br>
            key:<br>
    'month',<br>
            value: 1,<br>
    },<br>
    {<br>
            key:<br>
    'quarterly',<br>
            value: 3,<br>
    },<br>
    {<br>
            key:<br>
    'quarter',<br>
            value: 3,<br>
    },<br>
],
</td>




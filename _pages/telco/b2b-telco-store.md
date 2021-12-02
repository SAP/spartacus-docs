---
title: B2B Telco Store
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.2.0 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Customers use the B2B Telco SPA Store feature to view the product offerings and pricing details that are dedicated to them, and that are as defined by Business Administrators in the Backoffice.

Following is the structure of the B2B Telco Store:
-   **Product Catalog**: Includes Product Offerings with SPOs such as GSM Plans, Phones, Accessories, Addons, Satellite services, and Internet plans, and BPOs such as BPO for satellite services    
-   **Content Catalog**: Pages and components such as category page, home page, shopping cart page, and checkout page
-   **Languages**: Supports English language
-   **Currencies**: Supports USD and EURO

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Business Need

The feature enables customers, browsing the B2B Telco SPA Store, to view product offerings that are configured by the Business Administrators in the Backoffice.

## Business Use Case

**Homepage**

The following image is the homepage of the B2B functionality that includes multiple banners, and it is similar to the B2C homepage. The **Navigation** section includes the following options:

-   Satellite Offers
-	Internet
-	Voice
-	Wireless
-	Special Offers: Includes banners that directs customers to the purchase journey over BPO, and each banner is specific to a BPO

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/homepage.png" alt="Homepage"></p>

**Category Page and Content Page**

Navigate to the **INTERNET** section to view the category page. The category page displays all  filtering options on the left side and the sorting options at the top of search results section.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/category-page.png" alt="Category Page"></p>

Navigate to the **SATELLITE OFFERS** section and select **Satellite Services** to view the content page. The content page is displayed if the services are related to BPO. The following screenshot of the content page includes two banners. When the customer clicks the first banner, the purchase journey of a BPO page is displayed, and for the second banner, the category page of terminals is displayed.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/content-page.png" alt="Content Page"></p>

**Purchase Process - Purchase Journey for a BPO**

In the purchase journey for a BPO, in this case, the customer needs to select from different configurable characteristics.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/bpo-satellite-service.png" alt="BPO Satellite Service"></p>


Apart from the **Connectivity services**, which is the main plan, there are other options that the customer needs to select from such as **Speed plans**, **Terminals**, and **Addons**.

-   **Speed plans**: Monthly speed plan

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/speed-plan.png" alt="Speed Plan"></p>

-   **Terminals**: Not a mandatory option

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/terminals.png" alt="Terminals"></p>

-   **Addons** 

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/addons.png" alt="Addons"></p>

When the customer selects all the required items and clicks **Add To Cart** and **View Cart**, the list of all selected items are displayed in a popup window.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/view-cart.png" alt="View Cart"></p>

The main difference in the purchase journey is that the customer needs to select the configurable characteristics values, which is mandatory, and it is displayed in the cart.

**Purchase Process - Purchase Journey from the Product Details Page**

Similarly, for a purchase journey from the product details page, the customer needs to select the characteristics values for SPO. 

The customer navigates to the **WIRELESS** option and selects the required addon.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/individual-country-addons.png" alt="Individual Country Addons"></p>

Here, the only difference is that to purchase the selected Single Product Offering (SPO), without selecting others, the customer needs to select the configurable characteristic value and then add it to the cart. In this case, the configurable characteristic refers to the country that the customer needs to select from.

In the **Shopping Cart** page the customer performs the same actions that the B2C customer also performs such add, edit, or remove the cart items.

To continue updating the shopping cart, the customer navigates to the **SATELLITE OFFERS** and **WIRELESS** sections and adds the required items to the cart.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/proceed-to-checkout-cartitems.png" alt="Proceed to checkout Cartitems"></p>

The current B2B checkout page is different when compared to the earlier. The **Payment method** now includes the following options:
-   Credit Card
-   Account

While purchasing an order within a company, select to pay with debit from your account or company account or with a credit card. In this case, the **Credit Card** option is selected to proceed with checkout of selected items.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/b2b-checkout-page.png" alt="B2B Checkout Page"></p>

As part of next steps, the customer updates the **Shipping Address**, **Delivery Mode**, and **Payment Details** sections and then places the order. 

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/placeorder.png" alt="Place Order"></p>

The **Order Confirmation** page displays the details of the order placed.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/orderconfirmation.png" alt="Order Confirmation"></p>

## Feature Enablement

This feature is enabled through the B2B Telco SPA Store. It is implemented on top of TM Forum and OCC APIs of the SAP Telco & Utilities Accelerator (2105 version).

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 3.2.0                                          	|
| Telco & Utilities Accelerator	             	| Version 2108 (latest patch)            	|
| SAP Commerce Cloud 	| Version 2011 (latest patch) 	|


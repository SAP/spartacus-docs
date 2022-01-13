---
title: B2B Telco Store
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.2.0 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

The B2B Telco SPA Store provides the ability for B2B customers to view a customer-specific product catalog with dedicated products and services and customer-specific prices. B2B dedicated catalog and pricing are defined by Business Administrators in the Backoffice.

Following is the structure of the B2B Telco Store:
-   **Product Catalog**: Inclusive of product and service offerings such as GSM Plans, Phones, Accessories, Add-ons, Satellite services, and Internet plans; as well as bundled product offerings which is a grouping of products and services (that is, Satellite services)    
-   **Content Catalog**: Pages and components such as category page, home page, shopping cart page, and checkout page
-   **Languages**: Supports the English language
-   **Currencies**: Supports USD and EURO

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Business Need

It is a common practice in B2B selling to offer individual or groups of B2B customers a set of products and pricing. Product and service offerings can be restricted for purchase by certain customers. The same product and service offerings can vary in price according to who is buying them. Individual or groups of customers can have their own specific pricing sheets. It is important to maintain this information because you will need to ensure that the right prices show online for the right customers.

## Business Use Case

**Homepage**

The following image is the B2B Telco homepage which has a similar structure to that of the B2C Telco homepage. The navigation section includes the following options:

-   Satellite Offers
-	Internet
-	Voice
-	Wireless
-	Special Offers
    -   Special note: Special offers includes banners that re-direct customers to the configurable guided selling purchase journey. Each banner is mapped to a bundled product offering.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/homepage.png" alt="Homepage"></p>

**Category Page and Content Page**

To view a category page, click **INTERNET** in the navigation section. The category page is display with all the filtering options on the left side and the sorting options at the top of search results section.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/category-page.png" alt="Category Page"></p>

To view the content page, select Satellite Services from the SATELLITE OFFERS option. The content page is displayed if the services are related to the bundled product offering (BPO). The following content page has two banners. The first banner takes the customer to the purchase journey of a BPO while the second banner takes the customer to the category page of terminals. 

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/content-page.png" alt="Content Page"></p>

**Purchase Process**

In the purchase journey for a BPO, in this case, the customer needs to select from different configurable characteristics.

<p align="center"><img src="{{ site.baseurl }}/assets/images/telco/bpo-satellite-service.png" alt="BPO Satellite Service"></p>


Apart from the **Connectivity services**, which is the main plan, there are other options such as **Speed plans**, **Terminals**, and **Addons**.

1.  **Speed plans**: Select the required monthly speed plan

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/speed-plan.png" alt="Speed Plan"></p>

1.  **Terminals**: Select only if required. It is not a mandatory option.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/terminals.png" alt="Terminals"></p>

1.  **Addons**: Select the required addon. 

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/addons.png" alt="Addons"></p>

1.  Click **Add to Cart** after selecting all the required items. The popup window displays the list of all selected items.

1.  Click **View Cart**.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/view-cart.png" alt="View Cart"></p>

1.  The main difference in the purchase journey is that the customer needs to select the configurable characteristics values, which is mandatory, and it is displayed in the cart.

    Similarly, for a purchase journey from the product details page, the customer needs to select the characteristics values for SPO. 

1.  Click **WIRELESS** > **ADDONS**.

1.  Select **Individual LATAM Country Add-ons**.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/individual-country-addons.png" alt="Individual Country Addons"></p>

    Here, the only difference is that to purchase the selected Single Product Offering (SPO), without selecting others, the customer needs to select the configurable characteristic value and then add it to the cart. In this case, the configurable characteristic refers to the country that the customer needs to select from.

1.  Select the required country from **Countries** and click **Add to Cart**.

1.  In the Shopping Cart page, the customer performs the same actions that B2C customer does such add, edit, or remove the cart items.

1.  Click **SATELLITE OFFERS** > **Terminals**.
1.  Select **Connect 50**.
1.  Click **Add To Cart**.
1.  Click **View Cart** to view the details.
1.  Click **WIRELESS** > **Phones**.
1.  Select **Apple iphone 12 128Gb**.
1.  Click **Add To Cart**.
1.  Click **View Cart**. 
1.  Click **Proceed To Checkout**.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/proceed-to-checkout-cartitems.png" alt="Proceed to checkout Cartitems"></p>

    The B2B checkout page is different compared to earlier as now the **Payment method** has the following two options:
    -   Credit Card
    -   Account

    While purchasing an order within a company, select to pay with debit from your account or company account or with a credit card.

1.  Select **Credit Card**.
1.  Click **Continue**.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/b2b-checkout-page.png" alt="B2B Checkout Page"></p>

1.  Complete the **Shipping Address** details. 
1.  Click **Continue**.
1.  Select the required **Shipping Method**.
1.  Click **Continue**.
1.  Complete the **Payment Details**.
1.	Click **Continue**. The new B2B review order page includes options such as Auto Replenish Order and when the order needs to be delivered.
1.  Click **Place Order**. 

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/placeorder.png" alt="Place Order"></p>

1.  The **Order Confirmation** page displays the details of the order placed.

    <p align="center"><img src="{{ site.baseurl }}/assets/images/telco/orderconfirmation.png" alt="Order Confirmation"></p>

## Feature Enablement

This feature is enabled through the B2B Telco SPA Store. It is implemented on top of TM Forum and OCC APIs of the SAP Telco & Utilities Accelerator (2108 version).

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Spartacus                                     	| 3.2.0                                          	|
| Telco & Utilities Accelerator	             	| Version 2108 (latest patch)            	|
| SAP Commerce Cloud 	| Version 2011 (latest patch) 	|


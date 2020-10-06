---
title: Journey Management - MSISDN
---

**Note:** This feature is introduced in version 1.1.0 of the TUA Spartacus libraries.

## Contents

- [Overview](#overview)
- [Prerequisite](#prerequisite)
- [Business Use Case](#business-use-case)
- [End-to-end Journey](#end-to-end-journey)
- [Frontend Requirements and Dependencies](#frontend-requirements-and-dependencies)
- [Supported Backend Functionality](#supported-backend-functionality)
- [Configuring and Enabling MSISDN](#configuring-and-enabling-msisdn)
- [TM Forum APIs](#tm-forum-apis)
- [Components](#components)
- [Further Reading](#further-reading)

## Overview

Some product offerings require specific MSISDNs or the phone numbers to be reserved by the customers before placing an order for the product or the service offering. An `MSISDN (Mobile Station International Subscriber Directory Number)` is a phone number used to identify a mobile phone number internationally from the available phone numbers. This number includes a country code and a National Destination Code, which identifies the subscriber's operator.

The `Journey Management - MSISDN` feature enables the customers who are browsing the TUA for SPA Storefront, to select a desired phone number (MSISDN) before adding the selected product or the service to the cart.

**Note:** The `Journey Management - MSISDN` feature applies to the product offerings or service plans for which a checklist policy for `MSISDN Reference` is configured at the backend by the Product Manager. For more information, see [Configuring and Enabling MSISDN](#configuring-and-enabling-msisdn).

## Prerequisite

To setup soapUI to test the MSISDN feature, follow the steps:

1. Download [soapUI, version 5.6.0](https://www.soapui.org/downloads/latest-release/) as per your installed Operating System.
2. Navigate to the [TUA Spartacus git repository](https://github.com/SAP/spartacus-tua/releases/tag/1.1.0) and download the `mock_services` ZIP.
3. Extract the `mock_services` ZIP. The content of the ZIP when extracted is the `Resource_Pool_Management_API.xml` file.
4. Click **Import** icon on the soapUI toolbar. The `Select soapUI Project` File dialog box opens. Import the  `Resource_Pool_Management_API.xml` file into the soapUI.
5. Right-click **MSISDN** and then click **Start Minimized**. When the mock service is up, you can see that the MSISDN mock service is also up and running.

## Business Use Case

A customer wants to purchase a service plan, for example, `Do More with Less`. Before adding the service plan to the cart, the `Select your desired Phone Number` screen is displayed, based on the checklist policy configured for MSISDN at the backend by the Product Manager. The customer is required to select a phone number from the available phone numbers.

## End-to-end Journey

1. Log in to the TUA SPA Storefront.

    <!--<p align="center"><img src="/assets/images/telco/Screenshot_2020-09-02 Login.png"></p>-->

2. Search and select the desired product offering or the service plan, for example, `Do More with Less`.

    <!--<p align="center"><img src="/assets/images/telco/1MSISDN_Add_to_Cart.png"></p>-->

3. Click **Add to Cart**. The `Select your desired Phone Number` screen is displayed, based on the checklist policy configured for MSISDN at the backend by the Product Manager.

4. Select the desired phone number from the available phone numbers.

    **Note:** Top six available phone numbers are displayed.

    <!--<p align="center"><img src="/assets/images/telco/2MSISDN_Select_Desired_Phone.png"></p>-->

5. Click **CONTINUE**. The selected phone number is added and displayed in the `Item(s) added to your cart` screen.

    <!--<p align="center"><img src="/assets/images/telco/3MSISDN_Items_Added-to_Cart.png"></p>-->

6. Click **View Cart**. The cart displays all relevant details of the `Do More with Less` service plan with the phone number.

    <!--<p align="center"><img src="/assets/images/telco/4MSISDN_Proceed_to_Checkout.png"></p>-->

7. Click the pencil icon to update the phone number. The `Select your desired Phone Number` screen is displayed. 

    **Notes:** The **UPDATE** button is disabled until you select a new phone number from the available phone numbers.

8. Select a new phone number and click **UPDATE**. The cart page displays the updated phone number.

    <!--<p align="center"><img src="/assets/images/telco/5Updated_Appointment.png"></p>-->

9. Click **Proceed to Checkout** to place an order for the service plan.

10. Click **Account > Order History**.

11. Click the order number to confirm the phone number and other relevant details.

## Frontend Requirements and Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Recipe                                     	| b2c_telco_spa                                          	|
| Minimum version of backend TUA             	| TUA Release 2003 (latest patch is required)           	|
| Minimum   version of core commerce backend 	| SAP Commerce release 1905 (latest patch is recommended) 	|

## Supported Backend Functionality

The checklist policy is configured by the Product Manager in the Backoffice to have the `Select your Phone number` screen is displayed to the customers to select a suitable appointment, before adding the product or the service offering to the cart. For more information, see [Journey Checklist Policy Configurations](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/c3d274fb74074c70bec9cd6e9686d5a1.html).

## Configuring and Enabling MSISDN

To configure and enable MSISDN reference from the Backoffice, follow the steps:

1. Log in to the **Backoffice**.
2. Navigate to **Catalog > Conditional Policies > Policy Statement > Checklist Action Statement > Configurable Psc Checklist Action Statement**. The `Checklist action type` component is displayed.
3. Click **Checklist action type**. The details are displayed in the following pane.
4. In the **PROPERTIES** tab:
    - In the **Checklist action type**, select `MSISDN`.
    - In the **Product Specification Characteristic**, select either the staged or online catalog.
5. In the **Product Offering**, select the product offering for configuring the MSISDN.

<!--For more information, see.-->

<!--The checklist policy is configured by the Product Manager in the Backoffice to have the `Select your desired Phone Number` screen is displayed to the customers to select the desired phone number, before adding the product or the service offering to the cart. For more information, see [Configuring and Enabling MSISDN](#configuring-and-enabling-msisdn).-->

## TM Forum APIs

| API Name                       | API Endpoint                                        | Description                                                                                                  |
|--------------------------------------|-------------------------------------------------|--------------------------------------------------------------------------------------------------------------|
| Tmf Resources#TMF-ChecklistActionAPI | /checklistAction                                | Shows applicable list of checklist policies for the product offerings                                        |
| TMF-685                              | POST /resourcePoolManagement/AvailabilityCheck  | Retrieves available resource entities (MSISDN)                                                               |
| TMF-685                              | POST /resourcePoolManagement/Reservation        | Creates a reservation instance                                                                               |
| TMF-685                              | PATCH /resourcePoolManagement/Reservation/{id}  | Updates a reservation instance                                                                               |
| TMF-685                              | GET /resourcePoolManagement/reservation/        | Retrieves a list of reservations. Additional filters can also be applied   to get the relevant search result |

For more information, see [TM Forum APIs
](https://help.sap.com/viewer/f59b0ac006d746caaa5fb599b4270151/2007/en-US/d46b30b30eca4d4d8ddd20ad833d77f9.html).

## Components

The following table lists the newly developed components:

| Component Name                           | Description                                                                                                                                  |
|------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| LogicalResourceComponent                 | Displays the logical resource details on   the order, order history, cart summary, and cart popup pages                                       |
| JourneyChecklistLogicalResourceComponent | Displays the available logical resource details to the customer.   Customers can select the desired logical resource from the available list |
| JourneyChecklistStepComponent            | Displays a stepper component that renders the checklist components   one-by-one                                                                       |

## Further Reading

For further reading, see the following topics in the TUA Help portal.

- [Checklist Policy](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/b685dbb837ca4ad7b6c86d0bbd8a7fd7.html).
- [Making Components Visible](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/2005/en-US/1cea3b2cb3334fc085dda9cc070ad6ac.html).
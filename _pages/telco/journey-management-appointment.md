---
title: Journey Management - Appointment Reference
---

**Note:** This feature is introduced in version 1.1.0 of the TUA Spartacus libraries.

## Contents

- [Overview](#overview)
- [Business Requirement](#business-requirement)
- [Key Personas](#key-personas)
- [Business Use Case](#business-use-case)
- [Navigation Flow](#navigation-flow)
- [Requirements and Dependencies](#requirements-and-dependencies)
- [Configuring and Enabling the Appointment Reference](#configuring-and-enabling-the-appointment-reference)
- [Handling Error Messages](#handling-error-messages)
- [Further Reading](#further-reading)

## Overview

Some product offerings, specifically, the service plans require onsite installation by a service technician. Therefore, an appointment is required to be scheduled with the customer to complete the onsite installation. Using the appointment time, the service technician can coordinate with the customer and complete the onsite installation of the service purchased by the customer.

## Business Requirement

The `Journey Management - Appointment Reference` feature enables the customers browsing the TUA Spartacus storefront to browse the contents of a product or service offering and schedule an appointment. For example, a customer purchases a service plan that involves onsite installation by a service technician. Before adding the service plan to the cart, the customer selects a suitable appointment from the available time slots, based on the availability of the service technician to complete the onsite installation of the service.

**Note:** The `Journey Management - Appointment Reference` feature is applicable to the product and service offerings for which a checklist policy for `Appointment Reference` is configured in the Backoffice by the Product Manager.

## Key Personas

- Customers
- Product Managers

## Business Use Case

A customer wants to purchase a plan for a service, which involves onsite installation by a service technician. Before adding the service plan to the cart, the `Select a suitable time for an appointment` screen is displayed, based on the `Appointment Reference` checklist policy configured at the backend by the Product Manager. The customer can select a suitable appointment from the available time slots, or can select `call to schedule` option to arrange a call back to schedule an appointment.

The business use case includes the following steps:

1. A customer searches and selects a product offering; for example, `Fiberlink 100`, and clicks **Add to Cart** to add the product offering to the cart.
2. The `Select a suitable time for an appointment` screen is displayed, based on the `Appointment Reference` checklist policy configured at the backend by the Product Manager. The `Select a suitable time for an appointment` screen displays:
    - **Call to Schedule:** A customer can select this option if a call back is required to schedule the appointment. 
    - **Select a Suitable Appointment:** A customer can select a suitable appointment from the available time slots (appointments).
3. The selected product offering with the appointment is added and displayed on the cart.
4. A customer can update the existing appointment before proceeding to checkout the product offering.
5. A customer places an order for the product offering.
6. A customer can view the appointment and the order details from **Account >** `Order History` screen.

## Navigation Flow

1. Log in to the TUA SPA Storefront.

    <p align="center"><img src="/assets/images/telco/Screenshot_2020-09-02 Login.png"></p>

2. Search and select a product offering. For example, `Fiber Link 100 mbps`.

    <p align="center"><img src="/assets/images/telco/1Product_Offering.png"></p>

3. Click **Add to Cart**. The `Select a suitable time for an appointment` screen is displayed.  

4. Click a suitable appointment from the available appointments.

    **Note:** The `Please Call to Schedule` option is preselected.

    <p align="center"><img src="/assets/images/telco/2Select_Suitable_Appointment.png"></p>

5. Click **CONTINUE**. The appointment is displayed in the `Item(s) added to your cart` screen.

    <p align="center"><img src="/assets/images/telco/3Add_to_Cart.png"></p>

6. Click **View Cart**. The cart displays all relevant details of `Fiber Link 100 mbps` with the selected appointment.

    <p align="center"><img src="/assets/images/telco/4View_Cart.png"></p>

7. Click the pencil icon to update the appointment. The `Select a suitable time for an appointment` screen is displayed.

    <p align="center"><img src="/assets/images/telco/5Edit_Cart.png"></p>

    **Notes:** 
    - The earlier appointment is displayed by default and the **UPDATE** button is disabled, until you select a new time slot from the available appointments.
    - Top six available time slots are displayed with `Please call to Schedule` preselected option.
    - For each cart entry, you can book only one appointment, or choose the default `Call to Schedule` option.

8. Select a suitable appointment and click **Update**. The cart screen displays the new appointment.

    <p align="center"><img src="/assets/images/telco/6Updated_Appointment.png"></p>

9. Click **Proceed to Checkout** to place an order for `Fiber Link 100 mbps`.

10. Click **Account > Order History**.

11. Click the order number to confirm the appointment and other relevant details.

## Requirements and Dependencies

### Frontend Requirements and Dependencies

Your Angular development environment should include the following:

The `Ngx-spinner` library, version 8.03 for Angular CLI 8.0. The `Ngx-spinner` library is available:

Using npm:

     ```bash
     $ npm install ngx-spinner --save
     ```

Using yarn:

     ```bash
     $ yarn add ngx-spinner
     ```

### Backend Requirements and Dependencies

The checklist policy is configured by the Product Manager in the Backoffice to have the `Select a suitable time for an appointment` screen is displayed to the customers to select a suitable appointment, before adding the product or the service offering to the cart. For more information, see [Configuring and Enabling the Appointment Reference](#configuring-and-enabling-the-appointment-reference).

### Supported Backed Functionality

- [Product Catalog](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/552515309dd545e7b7878eb081b56453.html).
- [TUA Data Model for entities exposed Via TMF and OCC APIs](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/552515309dd545e7b7878eb081b56453.html).
- [TUA Checklist](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/552515309dd545e7b7878eb081b56453.html).

| Entity   Exposed for Journey Checklist | TMF or OCC APIs | Description | Request/Response |
|-|-|-|-|
| Tmf   Resources#TMF-ChecklistActionAPI | /checklistAction | Shows applicable list of   checklist policies for product offerings | None |
| TMF-646 (version 2.0.0) | /checklistAction | Shows applicable list of   checklist policies for product offerings | Request:     <br>     {<br>     "requestedTimeSlot": [<br>     {<br>     "validFor": {<br>     "startDateTime": "2018-08:28T00:00:00.000Z",<br>     "endDateTime": "2018-08-31T00:00:00.000Z"<br>     }<br>     }<br>     ]<br>     }<br>     <br>     Response (201 Created):     {<br>     "id": "99",<br>     "href":   "https://host:port/appointment/searchTimeSlot/99",<br>     "status": "created",<br>     "searchDate": "2018-08-28T00:00:00.000Z",<br>     "searchResult": "success",<br>     "requestedTimeSlot": [{<br>     "validFor": {<br>     "startDateTime": "2020-08-28T00:00:00.000Z",<br>     "endDateTime": "2018-08-31T00:00:00.000Z"<br>     }<br>     }],<br>     "availableTimeSlot": [{<br>     "id": "365",<br>     "href":   "https://host:port/appointment/searchtimeslot/99/availableTimeSlot/365",<br>     "validFor": {<br>     "startDateTime": "2020-08-28T14:00:00.000Z",<br>     "endDateTime": "2020-08-28T16:00:00.000Z"<br>     },<br>     "relatedParty": {<br>     "id": "56",<br>     "href": "https://host:port/partyManagement/individual/56",<br>     "name": "John Doe",<br>     "role": "technician",<br>     "@referredType": "Individual"<br>     }<br>     },<br>     {<br>     "id": "921",<br>     "href":   "https://host:port/appointment/searchtimeslot/99/availableTimeSlot/921",<br>     "validFor": {<br>     "startDateTime": "2020-08-28T16:30:00.000Z",<br>     "endDateTime": "2018-08-28T18:00:00.000Z"<br>     },<br>     "relatedParty": {<br>     "id": "56",<br>     "href":   "https://host:port/partyManagement/individual/56",<br>     "name": "John Doe",<br>     "role": "technician",<br>     "@referredType": "Individual"<br>     }<br>     },<br>     {<br>     "id": "325",<br>     "href": "https://host:port/appointment/searchtimeslot/99/availableTimeSlot/325",<br>     "validFor": {<br>     "startDateTime": "2020-08-28T18:30:00.000Z",<br>     "endDateTime": "2020-08-28T19:00:00.000Z"<br>     },<br>     "relatedParty": {<br>     "id": "58",<br>     "href":   "https://host:port/partyManagement/individual/58",<br>     "name": "Adam Smith",<br>     "role": "technician",<br>     "@referredType": "Individual"<br>     }<br>     }<br>     ]<br>     } |
| TMF-646 (version 2.0.0) | POST /appointment | Enables the customers to create   an appointment | Request:     {<br>     "validFor": {<br>     "startDateTime": "2020-08-28T14:00:00.000Z",<br>     "endDateTime": "2020-08-28T16:00:00.000Z"<br>     }<br>     }<br>     <br>     Response ( 201 Created)     <br>     "validFor": {<br>     "startDateTime": "2020-08-28T14:00:00.000Z",<br>     "endDateTime": "2020-08-28T16:00:00.000Z"<br>     },<br>     "id": "appointment-test-1",<br>     "href":   "https://localhost:8080/tmf-api/appointment/v4/appointment/appointment-test-1",<br>     "lastUpdate": "2020-08-06T11:41:59.054Z",<br>     "@schemaLocation": "https://localhost:8080/docs/#/",<br>     "@type": "Appointment",<br>     "@baseType": "Appointment",<br>     "creationDate": "2020-08-06T11:41:59.054Z",<br>     "status": "initialized"<br>     } |
| TMF-646 (version 2.0.0) | GET /appointment/{id} | Retrieves the appointment details of a customer | Response :   (200 OK)     {<br>     "validFor": {<br>     "startDateTime": "2020-08-28T14:00:00.000Z",<br>     "endDateTime": "2020-08-28T16:00:00.000Z"<br>     },<br>     "id": "appointment-test-1",<br>     "href":   "https://localhost:8080/tmf-api/appointment/v4/appointment/appointment-test-1",<br>     "lastUpdate": "2019-08-21T12:11:13.683Z",<br>     "@schemaLocation": "https://api-appointment-v4-0-0.mybluemix.net/docs/#/",<br>     "@type": "Appointment",<br>     "@baseType": "Appointment",<br>     "creationDate": "2019-08-21T12:11:13.683Z",<br>     "status": "initialized"<br>     } |
| TMF-646 (version 2.0.0) | PATCH /appointment/{id} | Updatew the appointment details of a customer | Request:     {<br>     "validFor": {<br>     "startDateTime": "2020-08-28T16:00:00.000Z",<br>     "endDateTime": "2020-08-28T18:00:00.000Z"<br>     }<br>     }<br>     <br>     Response (200 OK)     <br>     {<br>     "validFor": {<br>     "startDateTime": "2020-08-28T16:00:00.000Z",<br>     "endDateTime": "2020-08-28T18:00:00.000Z"<br>     },<br>     "id": "appointment-test-1",<br>     "href":   "https://localhost:8080/tmf-api/appointment/v4/appointment/appointment-test-1",<br>     "lastUpdate": "2020-08-06T11:41:59.054Z",<br>     "@schemaLocation": "https://localhost:8080/docs/#/",<br>     "@type": "Appointment",<br>     "@baseType": "Appointment",<br>     "creationDate": "2020-08-06T11:41:59.054Z",<br>     "status": "initialized"<br>     } |

## Configuring and Enabling the Appointment Reference

To configure and enable the appointment reference from the Backoffice, follow the steps:

1. Log in to the **Backoffice**.
2. Navigate to **Catalog > Conditional Policies > Policy Statement > Checklist Action Statement > Configurable Psc Checklist Action Statement**. The `Checklist action type` screen is displayed.
3. Click **Checklist action type**. The details are displayed in the following pane.
4. In the **PROPERTIES** tab:
    - In the **Checklist action type**, select `Appointment`.
    - In the **Product Specification Characteristic**, select either the staged or online catalog.
5. In the **Product Offering**, select the product offering for configuring the appointment.

When the product offering is successfully configured for the `Appointment Reference` feature, the `Select a suitable time for an appointment` screen is displayed before adding the product offering to the cart.

### Components

| Angular Component   Name             | Status  | Description                                                                                                                        |
|--------------------------------------|---------|------------------------------------------------------------------------------------------------------------------------------------|
| JourneyChecklistStepComponent        | New     | A stepper component that renders the checklist components                                                                          |
| JourneyChecklistAppointmentComponent | New     | Displays the available time slots  to customers                                                                                    |
| AppointmentComponent                 | New     | Displays the appointment details in the Order, Order History, Cart   Summary and Cart popup                                        |
| TmaAddToCartComponent                | Updated | Displays the **Add to cart** button that is enhanced with the checklist   call and opening checklist action stepper if applicable  |
| TmaCartTotalsComponent               | Updated | Displays cart total, and the **Proceed to checkout** button, which is   disabled in case of appointment errors or cancelled state  |
| TmaPlaceOrderComponent               | New     | Displays the **Place order** button, which is disabled in case of   appointment errors or cancelled state                          |

<!--### Sample Data

In progress.-->

## Handling Error Messages

The following table lists the common error messages:

| Error   Message                                                                                                           	| Description                                                                                                                                                                                                                                                                                                                               	|
|---------------------------------------------------------------------------------------------------------------------------	|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
| Something went wrong. Could not add item to the shopping cart                                                             	| A   server error message that is displayed on the Product   Offering Details screen. This error message is   displayed when a customer selects the desired appointment and clicks CONTINUE. As a result of this error   message, booking of the appointment does not happen, and the selected product   offering is not added to the cart 	|
| Your appointment cannot be displayed. Please remove the cart   entry to proceed                                            	| A   server error message that is displayed on the Cart screen. As a result of this error message, the appointment   does not display and the Proceed to Checkout button is disabled; hence, the customer cannot proceed to   checkout the product offering                                                                                	|
| There is a problem with appointment. Please remove this entry   from the cart to checkout                                 	| A   server error message that is displayed on the Cart screen. This error message is displayed when the appointment   is cancelled. As a result of this error message, the Proceed to Checkout button is   disabled; hence, the customer cannot proceed to checkout the product offering                                                  	|
| There is a problem in fetching appointment details. Please try   again later                                              	| A   server error message that is displayed on the Cart screen. This error message is displayed when the customer   clicks the UPDATE   (Pencil icon)  on the Cart screen to update the existing   appointment                                                                                                                            	|
| Could not update the appointment at this time. Select "Call   to Schedule" option to have an appointment booked for you.  	| A   server error message that is displayed on the Cart screen. This error message is displayed when the customer   tries to update the existing appointment                                                                                                                                                                               	|
| There is a problem in fetching appointment details. Please try   again later                                              	| A   server error message that is displayed on the Shipping   Address screen. This error message is displayed   when the customer clicks Proceed to Checkout button on the Cart screen. As a result of this error message, the Place Order button is disabled;   hence, a customer cannot place an order                                   	|
| Your appointment cannot be displayed. Please remove the cart   entry to proceed                                           	| This   error message is displayed on the Review Order screen when the customer tries to place an order for the   selected product offering. This error message is displayed because the phone   number is cancelled. As a result of this error message, the Place Order button is disabled                                                	|
| There is a problem in fetching appointment details. Please try   again later                                              	| This   error message is displayed on the Order Confirmation screen when the customer places an order for the selected   product offering                                                                                                                                                                                                  	|
| There is a problem in fetching appointment details. Please try   again later                                              	| This   error message is displayed on the Order History screen when the customer places an order for the selected   product offering and wants to confirm the order details from the Order History screen                                                                                                                                  	|

## Further Reading

For further reading, see the following topics in the TUA Help portal.

- [Checklist Policy](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/b685dbb837ca4ad7b6c86d0bbd8a7fd7.html).
- [Customer Inventory and Cart](https://help.sap.com/viewer/c762d9007c5c4f38bafbe4788446983e/2007/en-US/6d4fed0352f04fb8ba10846024854ea6.html).

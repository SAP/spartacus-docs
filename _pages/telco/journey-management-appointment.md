---
title: Journey Management - Appointment Reference
---

**Note:** This feature is introduced in version 1.1.0 of the TUA Spartacus libraries.

## Contents

- [Overview](#overview)
- [Prerequisite](#prerequisite)
- [Business Use Cases](#business-use-cases)
- [End-to-end Journey](#end-to-end-journey)
- [Frontend and Backend Dependencies](#frontend-and-backend-dependencies)
- [Configuring and Enabling the Appointment Reference](#configuring-and-enabling-the-appointment-reference)
- [TM Forum APIs](#tm-forum-apis)
- [Components](#components)
- [Further Reading](#further-reading)

## Overview

Some product offerings or specifications require booking an appointment with a service technician for installation before placing an order. When the appointment is confirmed and order is placed, the service technician can contact the customer to confirm the address to visit and complete the installation.

The `Journey Management - Appointment Reference` feature enables the customers browsing the TUA Spartacus storefront to browse the contents of a product or service offering and schedule an appointment. For example, a customer wants to purchase a service plan `Fiberlink 100`, which involves onsite installation by a service technician. Before adding the service plan to the cart, the `Select a suitable time for an appointment` screen is displayed, based on the `Appointment Reference` checklist policy configured at the backend by the Product Manager. The customer can select a suitable appointment from the available time slots, or can select `call to schedule` option to arrange a call back to schedule an appointment.

This feature also enables the TUA SPA Storefront to showcase the end-to-end integration with the appointment system for the products while placing an order in the Acquisition flow.

**Note:** The `Journey Management - Appointment Reference` feature is enabled in the TUA SPA Storefront by configuring the checklist policies for Appointment for single product offerings by the Product Manager in the Backoffice.

## Prerequisite 

To setup soapUI to test Appointment reference feature, follow the steps:

1. Download [soapUI, version 5.6.0](https://www.soapui.org/downloads/latest-release/) as per your installed Operating System.
2. Navigate to the [TUA Spartacus git repository](https://github.com/SAP/spartacus-tua/releases/tag/1.1.0) and download the `mock_services` ZIP.
3. Extract the `mock_services` ZIP. The content of the ZIP when extracted is the `AppointmentRestAPIMock-soapui-project.xml` file.
4. Click **Import** icon on the soapUI toolbar. The `Select soapUI Project` File dialog box opens. Import the  `AppointmentRestAPIMock-soapui-project.xml` file into the soapUI.
5. Right-click **Appointment** and then click **Start Minimized**. When the mock service is up, you can see that the Appointment mock service is also up and running.

## Business Use Cases

The following business use cases are covered:

1. Booking an appointment for services, which require installation by service technicians.
2. Cancelling an appointment from the Appointment system on the Cart screen. For example, the customer has not acted in a specific time duration after which the Appointment system cannot block the service technicians, hence, cancels the appointment. Or, the service technicians are no more available, hence, the appointment system cancels the appointment.
3. Displaying errors from the Appointment systems integration during checkout process.

## End-to-end Journey

1. Log in to the TUA SPA Storefront.
2. Search and select a product offering. For example, `Fiber Link 100 mbps`.
3. Click **Add to Cart**. The `Select a suitable time for an appointment` screen is displayed. 
4. Click a suitable appointment from the available appointments.

    **Note:** The `Please Call to Schedule` option is preselected.    

5. Click **CONTINUE**. The appointment is displayed in the `Item(s) added to your cart` screen.
6. Click **View Cart**. The cart displays all relevant details of `Fiber Link 100 mbps` with the selected appointment.
7. Click the pencil icon to update the appointment. The `Select a suitable time for an appointment` screen is displayed.

    **Notes:** 
    - The earlier appointment is displayed by default and the **UPDATE** button is disabled, until you select a new time slot from the available appointments.
    - Top six available time slots are displayed with `Please call to Schedule` preselected option.
    - For each cart entry, you can book only one appointment, or choose the default `Call to Schedule` option.

8. Select a suitable appointment and click **Update**. The cart screen displays the new appointment.
9. Click **Proceed to Checkout** to place an order for `Fiber Link 100 mbps`.
10. Click **Account > Order History**.
11. Click the order number to confirm the appointment and other relevant details.

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Recipe                                     	| b2c_telco_spa                                          	|
| Minimum version of backend TUA             	| TUA Release 2003 (latest patch is required)           	|
| Minimum   version of core commerce backend 	| SAP Commerce release 1905 (latest patch is recommended) 	|

## Configuring and Enabling the Appointment Reference

The checklist policy is configured by the Product Manager in the Backoffice to have the `Select a suitable time for an appointment` screen is displayed to the customers to select a suitable appointment, before adding the product or the service offering to the cart.

To configure and enable the Appointment reference from the Backoffice, see [Journey Checklist Policy Configurations](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/c3d274fb74074c70bec9cd6e9686d5a1.html).

## TM Forum APIs

| API Name          	| API Endpoint                         	| Description                                                                                                                                                                                	|
|--------------------------------------	|----------------------------------	|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
| Tmf Resources#TMF-ChecklistActionAPI 	| /checklistAction                 	| Shows applicable list of checklist policies   for product offering                                                                                                                         	|
| TMF-646   (version 2.0.0)            	| POST appointment/searchTimeSlot  	| This operation creates a search time slot   entity. According to a set of criteria, it is used to retrieve available time   slots that are used after to book or reschedule an appointment 	|
| TMF-646   (version 2.0.0)            	| POST /appointment                	| Creates appointment for the customer                                                                                                                                                       	|
| TMF-646   (version 2.0.0)            	| GET /appointment/{id}            	| Fetches the  appointment details of a   customer                                                                                                                                           	|
| TMF-646   (version 2.0.0)            	| PATCH /appointment/{id}          	| Updates the appointment details of a customer                                                                                                                                              	|

For more information, see [TM Forum APIs
](https://help.sap.com/viewer/f59b0ac006d746caaa5fb599b4270151/2007/en-US/d46b30b30eca4d4d8ddd20ad833d77f9.html).

## Components

Following are the new and updates Angular components:

| Angular Component   Name             | Status  | Description                                                                                                                        |
|--------------------------------------|---------|------------------------------------------------------------------------------------------------------------------------------------|
| JourneyChecklistStepComponent        | New     | A stepper component that renders the checklist components                                                                          |
| JourneyChecklistAppointmentComponent | New     | Displays the available time slots  to customers                                                                                    |
| AppointmentComponent                 | New     | Displays the appointment details in the Order, Order History, Cart   Summary and Cart popup                                        |
| TmaAddToCartComponent                | Updated | Displays the **Add to cart** button that is enhanced with the checklist   call and opening checklist action stepper if applicable  |
| TmaCartTotalsComponent               | Updated | Displays cart total, and the **Proceed to checkout** button, which is   disabled in case of appointment errors or cancelled state  |
| TmaPlaceOrderComponent               | New     | Displays the **Place order** button, which is disabled in case of   appointment errors or cancelled state                          |

## Further Reading

For further reading, see the following topics in the TUA Help portal.

- [Checklist Policy](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/b685dbb837ca4ad7b6c86d0bbd8a7fd7.html).
- [Making Components Visible](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/2005/en-US/1cea3b2cb3334fc085dda9cc070ad6ac.html).
---
title: Journey Management - Appointment
---

{% capture version_note %}
{{ site.version_note_part1 }} 1.1 {{ site.version_note_forTUA }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

## Contents

- [Overview](#overview)
- [Prerequisite](#prerequisite)
- [Business Use Case](#business-use-case)
- [Frontend and Backend Dependencies](#frontend-and-backend-dependencies)
- [Configuring and Enabling the Appointment in TUA](#configuring-and-enabling-the-appointment-in-tua)
- [Components](#components)
- [TM Forum APIs](#tm-forum-apis)
- [Further Reading](#further-reading)

## Overview

As a result of Journey Management configuration, a product offerings may be defined with the requirement of an appointment to be scheduled. This means that an appointment reservation is required before the order can be successfully placed. The Journey Management appointment feature enables customers to make this reservation during the "Add to Cart" process.

Appointment selection and reservation in a productive system requires third-party integration to the appropriate backend system. This feature can be adapted to work with a customer-specific business process flow.

This feature applies to product offerings that have a checklist policy for Appointment Reference configured. For more information, see [Configuring and Enabling the Appointment in TUA](#configuring-and-enabling-the-appointment-in-tua).

## Prerequisite

To test this feature using a mockup service, follow the instructions to set-up soapUI. Ensure that the Appointment system is always up and running.

**Note:** The mockup service is not recommended for the production environments as it is intended only for demonstration purpose.

1. Download [soapUI, version 5.6.0](https://www.soapui.org/downloads/latest-release/) as per your installed Operating System.
2. Navigate to the [TUA Spartacus git repository](https://github.com/SAP/spartacus-tua/releases/tag/1.1.0) and download the `mock_services.zip` file.
3. Extract the `mock_services.zip` file. The content of the ZIP when extracted is the `Resource_Pool_Management_API.xml` file.
4. Click the **Import** icon on the soapUI toolbar. The `Select soapUI Project` file dialog box opens. Import the  `Resource_Pool_Management_API.xml` file into the soapUI.
5. Right-click **Appointment** and then click **Start Minimized**. When the mock service is up, you can see that the Appointment mock service is also up and running.

## Business Use Case

A customer wants to purchase a product offering that requires installation service. During the "Add to "Cart" process, the customer is prompted to make an appointment reservation.

In the cart, a customer has a product offering with a selected appointment reservation. The customer does not immediately place the order, but instead, either waits until the next day, or completely abandons the cart. After a defined period of time, the cart times-out and the appointment is automatically cancelled, and the slot can be made available for another customer.  

## Frontend and Backend Dependencies

| Dependency                                	| Detail                                                 	|
|--------------------------------------------	|--------------------------------------------------------	|
| Recipe                                     	| b2c_telco_spa                                          	|
| Minimum version of backend TUA             	| TUA Release 2003 (latest patch is required)           	|
| Minimum   version of core commerce backend 	| SAP Commerce release 1905 (latest patch is recommended) 	|

## Configuring and Enabling the Appointment in TUA

The Appointment-Reference checklist policy for a selected product offering is configured in the Backoffice by a Product Manager.  For more information, see [Journey Checklist Policy Configurations](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/c3d274fb74074c70bec9cd6e9686d5a1.html).

## Components

The following new and updated components must be enabled in the TUA backoffice to appear on the Spartacus TUA storefront:

| Angular Component   Name             | Status  | Description                                                                                                                        |
|--------------------------------------|---------|------------------------------------------------------------------------------------------------------------------------------------|
| JourneyChecklistStepComponent        | New     | A stepper component that renders the checklist components                                                                          |
| JourneyChecklistAppointmentComponent | New     | Displays the available time slots  to customers                                                                                    |
| AppointmentComponent                 | New     | Displays the appointment details in the Order, Order History, Cart   Summary and Cart popup                                        |
| TmaAddToCartComponent                | Updated | Displays the **Add to cart** button that is enhanced with the checklist   call and opening checklist action stepper if applicable  |
| TmaCartTotalsComponent               | Updated | Displays cart total, and the **Proceed to checkout** button, which is   disabled in case of appointment errors or cancelled state  |
| TmaPlaceOrderComponent               | New     | Displays the **Place order** button, which is disabled in case of   appointment errors or cancelled state                          |

## TM Forum APIs

| API Name          	| API Endpoint                         	| Description                                                                                                                                                                                	|
|--------------------------------------	|----------------------------------	|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
| Tmf Resources#TMF-ChecklistActionAPI 	| /checklistAction                 	| Shows applicable list of checklist policies   for product offering                                                                                                                         	|
| TMF-646   (version 2.0.0)            	| POST appointment/searchTimeSlot  	| This operation creates a search time slot   entity. According to a set of criteria, it is used to retrieve available time   slots that are used after to book or reschedule an appointment 	|
| TMF-646   (version 2.0.0)            	| POST /appointment                	| Creates appointment for the customer                                                                                                                                                       	|
| TMF-646   (version 2.0.0)            	| GET /appointment/{id}            	| Fetches the  appointment details of a   customer                                                                                                                                           	|
| TMF-646   (version 2.0.0)            	| PATCH /appointment/{id}          	| Updates the appointment details of a customer                                                                                                                                              	|

For more information, see [TM Forum APIs](https://help.sap.com/viewer/f59b0ac006d746caaa5fb599b4270151/2007/en-US/d46b30b30eca4d4d8ddd20ad833d77f9.html).

## Further Reading

For further reading, see the following topics in the TUA Help portal.

- [Checklist Policy](https://help.sap.com/viewer/32f0086927f44c9ab1199f1dab8833cd/2007/en-US/b685dbb837ca4ad7b6c86d0bbd8a7fd7.html).
- [Making Components Visible](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/2005/en-US/1cea3b2cb3334fc085dda9cc070ad6ac.html).